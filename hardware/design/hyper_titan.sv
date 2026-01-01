module hyper_titan (
    input  logic        ref_clk_i,
    input  logic        glob_arst_ni,
);

  import axi_pkg::xbar_rule_32_t;
  import hyper_titan_pkg::*;
  import RvvAxiPkg::*;

  logic arst_e_core_n;
  logic arst_p_core_n;
  logic arst_cl_n;
  logic arst_sl_n;
  logic arst_pl_n;

  logic clk_e_core;
  logic clk_p_core;
  logic clk_cl;
  logic clk_sl;
  logic clk_pl;

  logic rtc;  

  e_core_ss u_e_core_ss (
      // input logic [31:0] boot_addr_i,
      // input logic [31:0] hart_id_i,
      // output rvv_axi_req_t  m_axi_req_o,
      // input  rvv_axi_resp_t m_axi_resp_i,
      // input  rvv_axi_req_t  s_axi_req_i,
      // output rvv_axi_resp_t s_axi_resp_o,
      // output io_debug_out_t io_debug_out,
      // output slog_debug_t   slog_debug,
      // input  logic       io_irq,
      // input  logic       io_te,
      // output logic       io_halted,
      // output logic       io_fault,
      // output logic       io_wfi,
      // output logic [3:0] io_debug_en
      .clk_i(clk_e_core),
      .arst_ni(arst_e_core_n),
      .boot_addr_i(),
      .hart_id_i(),
      .m_axi_req_o(),
      .m_axi_resp_i(),
      .s_axi_req_i(),
      .s_axi_resp_o(),
      .io_debug_out(),
      .slog_debug(),
      .io_irq(),
      .io_te(),
      .io_halted(),
      .io_fault(),
      .io_wfi(),
      .io_debug_en()
  );

  p_core_ss u_p_core_ss (
      // input logic [31:0] boot_addr_i,
      // input logic [31:0] hart_id_i,
      // input logic [1:0] irq_i,
      // input logic       ipi_i,
      // input logic time_irq_i,
      // input logic debug_req_i,
      // output rs_m_axi_req_t  rs_m_axi_req_o,
      // input  rs_m_axi_resp_t rs_m_axi_resp_i,
      // input  rs_s_axi_req_t  rs_s_axi_req_i,
      // output rs_s_axi_resp_t rs_s_axi_resp_o
      .clk_i(clk_p_core),
      .arst_ni(arst_p_core_n),
      .boot_addr_i(),
      .hart_id_i(),
      .irq_i(),
      .ipi_i(),
      .time_irq_i(),
      .debug_req_i(),
      .rs_m_axi_req_o(),
      .rs_m_axi_resp_i(),
      .rs_s_axi_req_i(),
      .rs_s_axi_resp_o()
  );

  axi_xbar #(
      .Cfg          (),
      .ATOPs        (),
      .Connectivity (),
      .slv_aw_chan_t(),
      .mst_aw_chan_t(),
      .w_chan_t     (),
      .slv_b_chan_t (),
      .mst_b_chan_t (),
      .slv_ar_chan_t(),
      .mst_ar_chan_t(),
      .slv_r_chan_t (),
      .mst_r_chan_t (),
      .slv_req_t    (),
      .slv_resp_t   (),
      .mst_req_t    (),
      .mst_resp_t   (),
      .rule_t       ()
  ) u_core_link (
      .clk_i                (clk_cl),
      .rst_ni               (arst_cl_n),
      .test_i               ('0),
      .slv_ports_req_i      (),
      .slv_ports_resp_o     (),
      .mst_ports_req_o      (),
      .mst_ports_resp_i     (),
      .addr_map_i           (),
      .en_default_mst_port_i(),
      .default_mst_port_i   ()
  );

  axi_xbar #(
      .Cfg          (),
      .ATOPs        (),
      .Connectivity (),
      .slv_aw_chan_t(),
      .mst_aw_chan_t(),
      .w_chan_t     (),
      .slv_b_chan_t (),
      .mst_b_chan_t (),
      .slv_ar_chan_t(),
      .mst_ar_chan_t(),
      .slv_r_chan_t (),
      .mst_r_chan_t (),
      .slv_req_t    (),
      .slv_resp_t   (),
      .mst_req_t    (),
      .mst_resp_t   (),
      .rule_t       ()
  ) u_system_link (
      .clk_i                (clk_sl),
      .rst_ni               (arst_sl_n),
      .test_i               ('0),
      .slv_ports_req_i      (),
      .slv_ports_resp_o     (),
      .mst_ports_req_o      (),
      .mst_ports_resp_i     (),
      .addr_map_i           (),
      .en_default_mst_port_i(),
      .default_mst_port_i   ()
  );

  axi_lite_xbar #(
      .Cfg       (),
      .aw_chan_t (),
      .w_chan_t  (),
      .b_chan_t  (),
      .ar_chan_t (),
      .r_chan_t  (),
      .axi_req_t (),
      .axi_resp_t(),
      .rule_t    ()
  ) u_peripheral_link (
      // input  axi_req_t  [Cfg.NoSlvPorts-1:0]              slv_ports_req_i,
      // output axi_resp_t [Cfg.NoSlvPorts-1:0]              slv_ports_resp_o,
      // output axi_req_t  [Cfg.NoMstPorts-1:0]              mst_ports_req_o,
      // input  axi_resp_t [Cfg.NoMstPorts-1:0]              mst_ports_resp_i,
      // input  rule_t [Cfg.NoAddrRules-1:0]                 addr_map_i,
      // input  logic  [Cfg.NoSlvPorts-1:0]                  en_default_mst_port_i,
      // input  logic  [Cfg.NoSlvPorts-1:0][MstIdxWidth-1:0] default_mst_port_i
      .clk_i(clk_pl),
      .rst_ni(arst_pl_n),
      .test_i('0),
      .slv_ports_req_i(),
      .slv_ports_resp_o(),
      .mst_ports_req_o(),
      .mst_ports_resp_i(),
      .addr_map_i(),
      .en_default_mst_port_i(),
      .default_mst_port_i()
  );

  // TODO: MEM SS

  // TODO: APB Bridge

  // TODO: AXI to AXIL

  // TODO: IO SS

  clk_rst_gen(
      // input  logic [ 3:0] pll_ref_div_e_core_i,
      // input  logic [11:0] pll_fb_div_e_core_i,
      // output logic        pll_locked_e_core_o,
      // input  logic [ 3:0] pll_ref_div_p_core_i,
      // input  logic [11:0] pll_fb_div_p_core_i,
      // output logic        pll_locked_p_core_o,
      // input  logic [ 3:0] pll_ref_div_sl_i,
      // input  logic [11:0] pll_fb_div_sl_i,
      // output logic        pll_locked_sl_o,
      // input  logic clk_en_e_core_i,
      // input  logic arst_e_core_ni,
      // input  logic clk_en_p_core_i,
      // input  logic arst_p_core_ni,
      // input  logic clk_en_cl_i,
      // input  logic arst_cl_ni,
      // input  logic clk_en_sl_i,
      // input  logic arst_sl_ni,
      // input  logic clk_en_pl_i,
      // input  logic arst_pl_ni,
      // output logic clk_src_cl_o,
      .ref_clk_i(ref_clk_i),
      .glob_arst_ni(glob_arst_ni),
      .rtc_o(rtc),
      .pll_ref_div_e_core_i(),
      .pll_fb_div_e_core_i(),
      .pll_locked_e_core_o(),
      .pll_ref_div_p_core_i(),
      .pll_fb_div_p_core_i(),
      .pll_locked_p_core_o(),
      .pll_ref_div_sl_i(),
      .pll_fb_div_sl_i(),
      .pll_locked_sl_o(),
      .clk_en_e_core_i(),
      .arst_e_core_ni(),
      .clk_e_core_o(),
      .arst_e_core_no(),
      .clk_en_p_core_i(),
      .arst_p_core_ni(),
      .clk_p_core_o(),
      .arst_p_core_no(),
      .clk_en_cl_i(),
      .arst_cl_ni(),
      .clk_cl_o(),
      .arst_cl_no(),
      .clk_src_cl_o(),
      .clk_en_sl_i(),
      .arst_sl_ni(),
      .clk_sl_o(),
      .arst_sl_no(),
      .clk_en_pl_i(),
      .arst_pl_ni(),
      .clk_pl_o(),
      .arst_pl_no()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___e_core_ss___cl (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___cl___e_core_ss (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___p_core_ss___cl (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___cl___p_core_ss (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___cl___pl (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___pl___cl (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

  axi_converter #(
      .src_req_t (),
      .src_resp_t(),
      .dst_req_t (),
      .dst_resp_t(),
      .enable_cdc(),
      .faster_src()
  ) u___sl___pl (
      .arst_ni   (),
      .src_clk_i (),
      .src_req_i (),
      .src_resp_o(),
      .dst_clk_i (),
      .dst_req_o (),
      .dst_resp_i()
  );

endmodule
