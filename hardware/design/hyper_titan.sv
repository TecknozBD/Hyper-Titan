// Hyper Titan top-level wrapper: wires cores, memory, and peripherals together.
module hyper_titan
  import axi_pkg::xbar_rule_32_t;
  import hyper_titan_pkg::*;
  import RvvAxiPkg::*;
(
    // Global reference clock and async reset
    input logic ref_clk_i,
    input logic glob_arst_ni,

    // APB system control/config interface
    input  logic      apb_clk_i,
    input  logic      apb_arst_ni,
    input  apb_req_t  apb_req_i,
    output apb_resp_t apb_resp_o,

    // SPI flash interface
    output logic       spi_cs_no,
    output logic       spi_sck_o,
    inout  wire  [3:0] spi_sd_io,

    // UART console
    output logic uart_tx_o,
    input  logic uart_rx_i,

    // DDR3 PHY interface
    output logic        ddr3_ck_p_o,
    output logic        ddr3_ck_n_o,
    output logic        ddr3_cke_o,
    output logic        ddr3_reset_n_o,
    output logic        ddr3_ras_n_o,
    output logic        ddr3_cas_n_o,
    output logic        ddr3_we_n_o,
    output logic        ddr3_cs_n_o,
    output logic [ 2:0] ddr3_ba_o,
    output logic [13:0] ddr3_addr_o,
    output logic        ddr3_odt_o,
    output logic [ 1:0] ddr3_dm_o,
    inout  wire  [ 1:0] ddr3_dqs_p_io,
    inout  wire  [ 1:0] ddr3_dqs_n_io,
    inout  wire  [15:0] ddr3_dq_io
);

  // Async resets per clock domain (driven by clk_rst_gen)
  logic                    arst_e_core_n;
  logic                    arst_p_core_n;
  logic                    arst_cl_n;
  logic                    arst_sl_n;
  logic                    arst_pl_n;

  // Clock nets per domain
  logic                    clk_e_core;
  logic                    clk_p_core;
  logic                    clk_cl;
  logic                    clk_sl;
  logic                    clk_pl;

  // Additional clocking sources
  logic                    clk_src_cl;
  logic                    rtc;

  // PLL configuration and status for each domain
  logic             [ 3:0] pll_ref_div_e_core;
  logic             [11:0] pll_fb_div_e_core;
  logic                    pll_locked_e_core;
  logic             [ 3:0] pll_ref_div_p_core;
  logic             [11:0] pll_fb_div_p_core;
  logic                    pll_locked_p_core;
  logic             [ 3:0] pll_ref_div_sys_link;
  logic             [11:0] pll_fb_div_sys_link;
  logic                    pll_locked_sys_link;

  // Resets and clock enables commanded by system controller
  logic                    e_core_rst_n;
  logic                    p_core_rst_n;
  logic                    core_link_rst_n;
  logic                    sys_link_rst_n;
  logic                    periph_link_rst_n;

  logic                    e_core_clk_en;
  logic                    p_core_clk_en;
  logic                    core_link_clk_en;
  logic                    sys_link_clk_en;
  logic                    periph_link_clk_en;

  // Boot strap info per core
  logic             [31:0] boot_addr_e_core;
  logic             [31:0] boot_addr_p_core;
  logic             [31:0] boot_hartid_e_core;
  logic             [31:0] boot_hartid_p_core;

  // AXI-Lite interface to System Link
  axil_req_t               axil_req;
  axil_resp_t              axil_resp;

  // Core link: E-core master to CL slave; CL master back to E-core slave
  ec_cl_s_req_t            ec_cl_s_req;
  ec_cl_s_resp_t           ec_cl_s_resp;
  cl_ec_d_req_t            cl_ec_d_req;
  cl_ec_d_resp_t           cl_ec_d_resp;

  // Core link: P-core master to CL slave; CL master back to P-core slave
  pc_cl_s_req_t            pc_cl_s_req;
  pc_cl_s_resp_t           pc_cl_s_resp;
  cl_pc_d_req_t            cl_pc_d_req;
  cl_pc_d_resp_t           cl_pc_d_resp;

  // Duplicated naming for converter instances (src/dst views)
  ec_cl_d_req_t            ec_cl_d_req;
  ec_cl_d_resp_t           ec_cl_d_resp;
  cl_ec_s_req_t            cl_ec_s_req;
  cl_ec_s_resp_t           cl_ec_s_resp;
  pc_cl_d_req_t            pc_cl_d_req;
  pc_cl_d_resp_t           pc_cl_d_resp;
  cl_pc_s_req_t            cl_pc_s_req;
  cl_pc_s_resp_t           cl_pc_s_resp;

  // System link between core link and system interconnect
  cl_sl_s_req_t            cl_sl_s_req;
  cl_sl_s_resp_t           cl_sl_s_resp;
  sl_cl_d_req_t            sl_cl_d_req;
  sl_cl_d_resp_t           sl_cl_d_resp;
  cl_sl_d_req_t            cl_sl_d_req;
  cl_sl_d_resp_t           cl_sl_d_resp;
  sl_cl_s_req_t            sl_cl_s_req;
  sl_cl_s_resp_t           sl_cl_s_resp;

  // ROM/RAM attachment on system link
  sl_rom_req_t             sl_rom_req;
  sl_rom_resp_t            sl_rom_resp;
  sl_ram_req_t             sl_ram_req;
  sl_ram_resp_t            sl_ram_resp;

  // APB bridge into system link
  ap_sl_req_t              ap_sl_req;
  ap_sl_resp_t             ap_sl_resp;

  // Peripheral link (AXI-Lite) attachment from system link
  sl_pl_s_req_t            sl_pl_s_req;
  sl_pl_s_resp_t           sl_pl_s_resp;
  sl_pl_d_req_t            sl_pl_d_req;
  sl_pl_d_resp_t           sl_pl_d_resp;
  sl_pl_axil_req_t         sl_pl_axil_req;
  sl_pl_axil_resp_t        sl_pl_axil_resp;

  // Peripheral devices hanging off AXI-Lite link
  pl_sc_req_t              pl_sc_req;
  pl_sc_resp_t             pl_sc_resp;
  pl_sh_req_t              pl_sh_req;
  pl_sh_resp_t             pl_sh_resp;
  pl_ur_req_t              pl_ur_req;
  pl_ur_resp_t             pl_ur_resp;
  pl_cli_req_t             pl_cli_req;
  pl_cli_resp_t            pl_cli_resp;
  pl_pli_req_t             pl_pli_req;
  pl_pli_resp_t            pl_pli_resp;

  // E-core subsystem connected to core link (CL)
  e_core_ss u_e_core_ss (
      .clk_i       (clk_e_core),
      .arst_ni     (arst_e_core_n),
      .boot_addr_i (boot_addr_e_core),
      .hart_id_i   (boot_hartid_e_core),
      .m_axi_req_o (ec_cl_s_req),
      .m_axi_resp_i(ec_cl_s_resp),
      .s_axi_req_i (cl_ec_d_req),
      .s_axi_resp_o(cl_ec_d_resp),
      .io_debug_out(),                    // TODO
      .slog_debug  (),                    // TODO
      .io_irq      (),                    // TODO
      .io_te       (),                    // TODO
      .io_halted   (),                    // TODO
      .io_fault    (),                    // TODO
      .io_wfi      (),                    // TODO
      .io_debug_en ()                     // TODO
  );

  // P-core subsystem connected to core link (CL)
  p_core_ss u_p_core_ss (
      .clk_i          (clk_p_core),
      .arst_ni        (arst_p_core_n),
      .boot_addr_i    (boot_addr_p_core),
      .hart_id_i      (boot_hartid_p_core),
      .irq_i          (),                    // TODO
      .ipi_i          (),                    // TODO
      .time_irq_i     (),                    // TODO
      .debug_req_i    (),                    // TODO
      .rs_m_axi_req_o (pc_cl_s_req),
      .rs_m_axi_resp_i(pc_cl_s_resp),
      .rs_s_axi_req_i (cl_pc_d_req),
      .rs_s_axi_resp_o(cl_pc_d_resp)
  );

  // Core link AXI crossbar: arbitrates core masters toward shared slaves
  axi_xbar #(
      .Cfg          (cl_link_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(cl_s_axi_aw_chan_t),
      .mst_aw_chan_t(cl_m_axi_aw_chan_t),
      .w_chan_t     (cl_m_axi_w_chan_t),
      .slv_b_chan_t (cl_s_axi_b_chan_t),
      .mst_b_chan_t (cl_m_axi_b_chan_t),
      .slv_ar_chan_t(cl_s_axi_ar_chan_t),
      .mst_ar_chan_t(cl_m_axi_ar_chan_t),
      .slv_r_chan_t (cl_s_axi_r_chan_t),
      .mst_r_chan_t (cl_m_axi_r_chan_t),
      .slv_req_t    (cl_s_axi_req_t),
      .slv_resp_t   (cl_s_axi_resp_t),
      .mst_req_t    (cl_m_axi_req_t),
      .mst_resp_t   (cl_m_axi_resp_t),
      .rule_t       (xbar_rule_32_t)
  ) u_core_link (
      .clk_i                (clk_cl),
      .rst_ni               (arst_cl_n),
      .test_i               ('0),
      .slv_ports_req_i      ({sl_cl_d_req, pc_cl_d_req, ec_cl_d_req}),
      .slv_ports_resp_o     ({sl_cl_d_resp, pc_cl_d_resp, ec_cl_d_resp}),
      .mst_ports_req_o      ({cl_sl_s_req, cl_pc_s_req, cl_ec_s_req}),
      .mst_ports_resp_i     ({cl_sl_s_resp, cl_pc_s_resp, cl_ec_s_resp}),
      .addr_map_i           (cl_rules),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('b101010)
  );

  // System link AXI crossbar: bridges core link and system memories/PL
  axi_xbar #(
      .Cfg          (sl_link_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(sl_s_axi_aw_chan_t),
      .mst_aw_chan_t(sl_m_axi_aw_chan_t),
      .w_chan_t     (sl_m_axi_w_chan_t),
      .slv_b_chan_t (sl_s_axi_b_chan_t),
      .mst_b_chan_t (sl_m_axi_b_chan_t),
      .slv_ar_chan_t(sl_s_axi_ar_chan_t),
      .mst_ar_chan_t(sl_m_axi_ar_chan_t),
      .slv_r_chan_t (sl_s_axi_r_chan_t),
      .mst_r_chan_t (sl_m_axi_r_chan_t),
      .slv_req_t    (sl_s_axi_req_t),
      .slv_resp_t   (sl_s_axi_resp_t),
      .mst_req_t    (sl_m_axi_req_t),
      .mst_resp_t   (sl_m_axi_resp_t),
      .rule_t       (xbar_rule_32_t)
  ) u_system_link (
      .clk_i                (clk_sl),
      .rst_ni               (arst_sl_n),
      .test_i               ('0),
      .slv_ports_req_i      ({ap_sl_req, cl_sl_d_req}),
      .slv_ports_resp_o     ({ap_sl_resp, cl_sl_d_resp}),
      .mst_ports_req_o      ({sl_pl_s_req, sl_ram_req, sl_rom_req, cl_sl_d_req}),
      .mst_ports_resp_i     ({sl_pl_s_resp, sl_ram_resp, sl_rom_resp, cl_sl_d_resp}),
      .addr_map_i           (sl_rules),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('b1010)
  );

  // Peripheral link AXI-Lite crossbar for low-speed peripherals
  axi_lite_xbar #(
      .Cfg       (pl_link_cfg),
      .aw_chan_t (pl_s_axil_aw_chan_t),
      .w_chan_t  (pl_s_axil_w_chan_t),
      .b_chan_t  (pl_s_axil_b_chan_t),
      .ar_chan_t (pl_s_axil_ar_chan_t),
      .r_chan_t  (pl_s_axil_r_chan_t),
      .axi_req_t (pl_s_axil_req_t),
      .axi_resp_t(pl_s_axil_resp_t),
      .rule_t    (xbar_rule_32_t)
  ) u_peripheral_link (
      .clk_i(clk_pl),
      .rst_ni(arst_pl_n),
      .test_i('0),
      .slv_ports_req_i(sl_pl_axil_req),
      .slv_ports_resp_o(sl_pl_axil_resp),
      .mst_ports_req_o({pl_sh_req, pl_ur_req, pl_pli_req, pl_cli_req, pl_sc_req}),
      .mst_ports_resp_i({pl_sh_resp, pl_ur_resp, pl_pli_resp, pl_cli_resp, pl_sc_resp}),
      .addr_map_i(pl_rules),
      .en_default_mst_port_i('1),
      .default_mst_port_i('b100)
  );

  // TODO: MEM SS

  always_comb begin
    ap_sl_req = '0;
    axil_resp = '0;
    ap_sl_req.aw.addr = axil_req.aw.addr;
    ap_sl_req.aw.size = 2;
    ap_sl_req.aw.burst = 1;
    ap_sl_req.aw.prot = axil_req.aw.prot;
    ap_sl_req.aw_valid = axil_req.aw_valid;
    axil_req.aw_ready = ap_sl_req.aw_ready;
    ap_sl_req.w.data = axil_req.w.data;
    ap_sl_req.w.strb = axil_req.w.strb;
    ap_sl_req.w_valid = axil_req.w_valid;
    axil_req.w_ready = ap_sl_req.w_ready;
    axil_resp.b.resp = ap_sl_req.b.resp;
    axil_resp.b_valid = ap_sl_req.b_valid;
    ap_sl_req.b_ready = axil_resp.b_ready;
    ap_sl_req.ar.addr = axil_req.ar.addr;
    ap_sl_req.ar.size = 2;
    ap_sl_req.ar.burst = 1;
    ap_sl_req.ar.prot = axil_req.ar.prot;
    ap_sl_req.ar_valid = axil_req.ar_valid;
    axil_req.ar_ready = ap_sl_req.ar_ready;
    axil_resp.r.data = ap_sl_req.r.data;
    axil_resp.r.resp = ap_sl_req.r.resp;
    axil_resp.r_valid = ap_sl_req.r_valid;
    ap_sl_req.r_ready = axil_resp.r_ready;
  end

  apb_2_axil #(
      .ADDR_WIDTH(32),
      .DATA_WIDTH(32),
      .apb_req_t (apb_req_t),
      .apb_resp_t(apb_resp_t),
      .aw_chan_t (axil_aw_chan_t),
      .w_chan_t  (axil_w_chan_t),
      .b_chan_t  (axil_b_chan_t),
      .ar_chan_t (axil_ar_chan_t),
      .r_chan_t  (axil_r_chan_t),
      .axi_req_t (axil_req_t),
      .axi_resp_t(axil_resp_t)
  ) u_apb_2_axil (
      .apb_clk_i  (apb_clk_i),
      .apb_arst_ni(apb_arst_ni),
      .apb_req_i  (apb_req_i),
      .apb_resp_o (apb_resp_o),
      .axi_clk_i  (clk_sl),
      .axi_arst_ni(arst_sl_n),
      .axi_req_o  (axil_req),
      .axi_resp_i (axil_resp)
  );

  axi_to_axi_lite #(
      .AxiAddrWidth   (32),
      .AxiDataWidth   (32),
      .AxiIdWidth     (4),
      .AxiUserWidth   (8),
      .AxiMaxWriteTxns(2),
      .AxiMaxReadTxns (2),
      .FullBW         ('0),
      .FallThrough    ('0),
      .full_req_t     (sl_pl_d_req_t),
      .full_resp_t    (sl_pl_d_resp_t),
      .lite_req_t     (sl_pl_axil_req_t),
      .lite_resp_t    (sl_pl_axil_resp_t)
  ) u_axi_to_axi_lite (
      .clk_i(clk_pl),
      .rst_ni(arst_pl_n),
      .test_i('0),
      .slv_req_i(sl_pl_d_req),
      .slv_resp_o(sl_pl_d_resp),
      .mst_req_o(sl_pl_axil_req),
      .mst_resp_i(sl_pl_axil_resp)
  );

  // TODO: IO SS

  // System controller: manages clocking, resets, and boot configuration
  sys_ctrl #(
      .req_t   (),
      .resp_t  (),
      .MEM_BASE('h0000_2000),
      .MEM_SIZE(12)
  ) u_sys_ctrl (
      .arst_ni               (arst_sl_n),
      .clk_i                 (clk_sl),
      .req_i                 (pl_sc_req),
      .resp_o                (pl_sc_resp),
      .e_core_clk_en_o       (e_core_clk_en),
      .e_core_rst_no         (e_core_rst_n),
      .p_core_clk_en_o       (p_core_clk_en),
      .p_core_rst_no         (p_core_rst_n),
      .core_link_clk_en_o    (core_link_clk_en),
      .core_link_rst_no      (core_link_rst_n),
      .core_link_clk_src_i   (clk_src_cl),
      .sys_link_clk_en_o     (sys_link_clk_en),
      .sys_link_rst_no       (sys_link_rst_n),
      .periph_link_clk_en_o  (periph_link_clk_en),
      .periph_link_rst_no    (periph_link_rst_n),
      .boot_addr_e_core_o    (boot_addr_e_core),
      .boot_addr_p_core_o    (boot_addr_p_core),
      .boot_hartid_e_core_o  (boot_hartid_e_core),
      .boot_hartid_p_core_o  (boot_hartid_p_core),
      .pll_ref_div_e_core_o  (pll_ref_div_e_core),
      .pll_fb_div_e_core_o   (pll_fb_div_e_core),
      .pll_locked_e_core_i   (pll_locked_e_core),
      .pll_ref_div_p_core_o  (pll_ref_div_p_core),
      .pll_fb_div_p_core_o   (pll_fb_div_p_core),
      .pll_locked_p_core_i   (pll_locked_p_core),
      .pll_ref_div_sys_link_o(pll_ref_div_sys_link),
      .pll_fb_div_sys_link_o (pll_fb_div_sys_link),
      .pll_locked_sys_link_i (pll_locked_sys_link)
  );

  // Clock/reset generator: derives all domains and exposes PLL status
  clk_rst_gen u_clk_rst_gen (
      .ref_clk_i           (ref_clk_i),
      .glob_arst_ni        (glob_arst_ni),
      .rtc_o               (rtc),
      .pll_ref_div_e_core_i(pll_ref_div_e_core),
      .pll_fb_div_e_core_i (pll_fb_div_e_core),
      .pll_locked_e_core_o (pll_locked_e_core),
      .pll_ref_div_p_core_i(pll_ref_div_p_core),
      .pll_fb_div_p_core_i (pll_fb_div_p_core),
      .pll_locked_p_core_o (pll_locked_p_core),
      .pll_ref_div_sl_i    (pll_ref_div_sys_link),
      .pll_fb_div_sl_i     (pll_fb_div_sys_link),
      .pll_locked_sl_o     (pll_locked_sys_link),
      .clk_en_e_core_i     (e_core_clk_en),
      .arst_e_core_ni      (e_core_rst_n),
      .clk_e_core_o        (clk_e_core),
      .arst_e_core_no      (arst_e_core_n),
      .clk_en_p_core_i     (p_core_clk_en),
      .arst_p_core_ni      (p_core_rst_n),
      .clk_p_core_o        (clk_p_core),
      .arst_p_core_no      (arst_p_core_n),
      .clk_en_cl_i         (core_link_clk_en),
      .arst_cl_ni          (core_link_rst_n),
      .clk_cl_o            (clk_cl),
      .arst_cl_no          (arst_cl_n),
      .clk_src_cl_o        (clk_src_cl),
      .clk_en_sl_i         (sys_link_clk_en),
      .arst_sl_ni          (sys_link_rst_n),
      .clk_sl_o            (clk_sl),
      .arst_sl_no          (arst_sl_n),
      .clk_en_pl_i         (periph_link_clk_en),
      .arst_pl_ni          (periph_link_rst_n),
      .clk_pl_o            (clk_pl),
      .arst_pl_no          (arst_pl_n)
  );

  // CDC: E-core master side into core link
  axi_converter #(
      .src_req_t (ec_cl_s_req_t),
      .src_resp_t(ec_cl_s_resp_t),
      .dst_req_t (ec_cl_d_req_t),
      .dst_resp_t(ec_cl_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d0)
  ) u___e_core_ss___cl (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_e_core),
      .src_req_i (ec_cl_s_req),
      .src_resp_o(ec_cl_s_resp),
      .dst_clk_i (clk_cl),
      .dst_req_o (ec_cl_d_req),
      .dst_resp_i(ec_cl_d_resp)
  );

  // CDC: core link master back into E-core
  axi_converter #(
      .src_req_t (cl_ec_s_req_t),
      .src_resp_t(cl_ec_s_resp_t),
      .dst_req_t (cl_ec_d_req_t),
      .dst_resp_t(cl_ec_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) u___cl___e_core_ss (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_cl),
      .src_req_i (cl_ec_s_req),
      .src_resp_o(cl_ec_s_resp),
      .dst_clk_i (clk_e_core),
      .dst_req_o (cl_ec_d_req),
      .dst_resp_i(cl_ec_d_resp)
  );

  // CDC: P-core master side into core link
  axi_converter #(
      .src_req_t (pc_cl_s_req_t),
      .src_resp_t(pc_cl_s_resp_t),
      .dst_req_t (pc_cl_d_req_t),
      .dst_resp_t(pc_cl_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d0)
  ) u___p_core_ss___cl (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_p_core),
      .src_req_i (pc_cl_s_req),
      .src_resp_o(pc_cl_s_resp),
      .dst_clk_i (clk_cl),
      .dst_req_o (pc_cl_d_req),
      .dst_resp_i(pc_cl_d_resp)
  );

  // CDC: core link master back into P-core
  axi_converter #(
      .src_req_t (cl_pc_s_req_t),
      .src_resp_t(cl_pc_s_resp_t),
      .dst_req_t (cl_pc_d_req_t),
      .dst_resp_t(cl_pc_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) u___cl___p_core_ss (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_cl),
      .src_req_i (cl_pc_s_req),
      .src_resp_o(cl_pc_s_resp),
      .dst_clk_i (clk_p_core),
      .dst_req_o (cl_pc_d_req),
      .dst_resp_i(cl_pc_d_resp)
  );

  // CDC: core link into system link
  axi_converter #(
      .src_req_t (cl_sl_s_req_t),
      .src_resp_t(cl_sl_s_resp_t),
      .dst_req_t (cl_sl_d_req_t),
      .dst_resp_t(cl_sl_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) u___cl___sl (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_cl),
      .src_req_i (cl_sl_s_req),
      .src_resp_o(cl_sl_s_resp),
      .dst_clk_i (clk_sl),
      .dst_req_o (cl_sl_d_req),
      .dst_resp_i(cl_sl_d_resp)
  );

  // CDC: system link back into core link
  axi_converter #(
      .src_req_t (sl_cl_s_req_t),
      .src_resp_t(sl_cl_s_resp_t),
      .dst_req_t (sl_cl_d_req_t),
      .dst_resp_t(sl_cl_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d0)
  ) u___sl___cl (
      .arst_ni   (arst_cl_n),
      .src_clk_i (clk_sl),
      .src_req_i (sl_cl_s_req),
      .src_resp_o(sl_cl_s_resp),
      .dst_clk_i (clk_cl),
      .dst_req_o (sl_cl_d_req),
      .dst_resp_i(sl_cl_d_resp)
  );

  // CDC: system link into peripheral link (AXI-Lite)
  axi_converter #(
      .src_req_t (sl_pl_s_req_t),
      .src_resp_t(sl_pl_s_resp_t),
      .dst_req_t (sl_pl_d_req_t),
      .dst_resp_t(sl_pl_d_resp_t),
      .enable_cdc('d1),
      .faster_src('d1)
  ) u___sl___pl (
      .arst_ni   (arst_sl_n),
      .src_clk_i (clk_sl),
      .src_req_i (sl_pl_s_req),
      .src_resp_o(sl_pl_s_resp),
      .dst_clk_i (clk_pl),
      .dst_req_o (sl_pl_d_req),
      .dst_resp_i(sl_pl_d_resp)
  );

endmodule
