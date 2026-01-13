`include "axi/typedef.svh"

// Performance core subsystem (p_core_ss)
// - Instantiates the Ariane performance core, a local DTCM (axi_ram),
//   a DMA engine, and an AXI crossbar to connect these masters/slaves
//   to the rest of the system.
// - Provides boot/ID inputs and interrupt sources to the core, and
//   exposes master/slave AXI-typed ports for integration.
module p_core_ss
  // Import typed channel definitions, address map constants, and
  // xbar rule/config types used by the instantiated modules.
  import axi_pkg::xbar_rule_32_t;
  import hyper_titan_pkg::rs_s_axi_aw_chan_t;
  import hyper_titan_pkg::rs_s_axi_w_chan_t;
  import hyper_titan_pkg::rs_s_axi_b_chan_t;
  import hyper_titan_pkg::rs_s_axi_ar_chan_t;
  import hyper_titan_pkg::rs_s_axi_r_chan_t;
  import hyper_titan_pkg::rs_s_axi_req_t;
  import hyper_titan_pkg::rs_s_axi_resp_t;
  import hyper_titan_pkg::rs_m_axi_aw_chan_t;
  import hyper_titan_pkg::rs_m_axi_w_chan_t;
  import hyper_titan_pkg::rs_m_axi_b_chan_t;
  import hyper_titan_pkg::rs_m_axi_ar_chan_t;
  import hyper_titan_pkg::rs_m_axi_r_chan_t;
  import hyper_titan_pkg::rs_m_axi_req_t;
  import hyper_titan_pkg::rs_m_axi_resp_t;
  import hyper_titan_pkg::RAM_START;
  import hyper_titan_pkg::RAM_END;
  import hyper_titan_pkg::rs_link_cfg;
  import hyper_titan_pkg::rs_rules;
(
    input logic clk_i,
    input logic arst_ni,

    input logic [31:0] boot_addr_i,
    input logic [31:0] hart_id_i,

    input logic [1:0] irq_i,
    input logic       ipi_i,

    input logic time_irq_i,
    input logic debug_req_i,

    output rs_m_axi_req_t  rs_m_axi_req_o,
    input  rs_m_axi_resp_t rs_m_axi_resp_i,

    input  rs_s_axi_req_t  rs_s_axi_req_i,
    output rs_s_axi_resp_t rs_s_axi_resp_o

);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Local arrays of typed AXI request/response channels used to
  // connect the three master/slave ports of the local crossbar.
  // Index 0: core/DTCM, 1: DMA, 2: external system connection.
  rs_m_axi_req_t  [2:0] xbar_mp_req;
  rs_m_axi_resp_t [2:0] xbar_mp_resp;
  rs_s_axi_req_t  [2:0] xbar_sp_req;
  rs_s_axi_resp_t [2:0] xbar_sp_resp;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Performance core (Ariane) instance. The core's AXI slave port is
  // connected to `xbar_sp_req[0]`/`xbar_sp_resp[0]` so the crossbar
  // can route instruction/data access to local masters (DTCM/DMA).
  ariane #(
      .DmBaseAddress(RAM_START),
      .CachedAddrBeg(RAM_START)
  ) u_core (
      .clk_i(clk_i),
      .rst_ni(arst_ni),
      .boot_addr_i({32'h0, boot_addr_i}),
      .hart_id_i({32'h0, hart_id_i}),
      .irq_i(irq_i),
      .ipi_i(ipi_i),
      .time_irq_i(time_irq_i),
      .debug_req_i(debug_req_i),
      .axi_req_o(xbar_sp_req[0]),
      .axi_resp_i(xbar_sp_resp[0])
  );

  // Local DTCM RAM attached as an AXI master port to the crossbar.
  // Provides low-latency memory for the performance core.
  axi_ram #(
      .MEM_BASE    (RAM_START),
      .MEM_SIZE    ($clog2(RAM_END - RAM_START + 1)),
      .ALLOW_WRITES('1),
      .req_t       (rs_m_axi_req_t),
      .resp_t      (rs_m_axi_resp_t)
  ) u_dtcm (
      .clk_i  (clk_i),
      .arst_ni(arst_ni),
      .req_i  (xbar_mp_req[0]),
      .resp_o (xbar_mp_resp[0])
  );


  // DMA engine: provides high-throughput memory transfers and is
  // exposed as a master on the local crossbar (mp) and as a slave
  // (sp) for configuration/control.
  axi_dma #(
      .mp_aw_chan_t(rs_m_axi_aw_chan_t),
      .mp_w_chan_t (rs_m_axi_w_chan_t),
      .mp_b_chan_t (rs_m_axi_b_chan_t),
      .mp_ar_chan_t(rs_m_axi_ar_chan_t),
      .mp_r_chan_t (rs_m_axi_r_chan_t),
      .sp_aw_chan_t(rs_s_axi_aw_chan_t),
      .sp_w_chan_t (rs_s_axi_w_chan_t),
      .sp_b_chan_t (rs_s_axi_b_chan_t),
      .sp_ar_chan_t(rs_s_axi_ar_chan_t),
      .sp_r_chan_t (rs_s_axi_r_chan_t),
      .mp_req_t    (rs_m_axi_req_t),
      .mp_resp_t   (rs_m_axi_resp_t),
      .sp_req_t    (rs_s_axi_req_t),
      .sp_resp_t   (rs_s_axi_resp_t)
  ) u_dma (
      .clk_i    (clk_i),
      .arst_ni  (arst_ni),
      .mp_req_i (xbar_mp_req[1]),
      .mp_resp_o(xbar_mp_resp[1]),
      .sp_req_o (xbar_sp_req[1]),
      .sp_resp_i(xbar_sp_resp[1])
  );

  // Local crossbar: routes slave ports from the core/DMA to master
  // ports (DTCM/DMA/external). Address mapping rules are provided by
  // `rs_rules`/`rs_link_cfg` and the `rule_t` describes matching
  // behavior for each route.
  axi_xbar #(
      .Cfg          (rs_link_cfg),
      .ATOPs        ('0),
      .Connectivity ('1),
      .slv_aw_chan_t(rs_s_axi_aw_chan_t),
      .mst_aw_chan_t(rs_m_axi_aw_chan_t),
      .w_chan_t     (rs_s_axi_w_chan_t),
      .slv_b_chan_t (rs_s_axi_b_chan_t),
      .mst_b_chan_t (rs_m_axi_b_chan_t),
      .slv_ar_chan_t(rs_s_axi_ar_chan_t),
      .mst_ar_chan_t(rs_m_axi_ar_chan_t),
      .slv_r_chan_t (rs_s_axi_r_chan_t),
      .mst_r_chan_t (rs_m_axi_r_chan_t),
      .slv_req_t    (rs_s_axi_req_t),
      .slv_resp_t   (rs_s_axi_resp_t),
      .mst_req_t    (rs_m_axi_req_t),
      .mst_resp_t   (rs_m_axi_resp_t),
      .rule_t       (xbar_rule_32_t)
  ) u_xbar (
      .clk_i                (clk_i),
      .rst_ni               (arst_ni),
      .test_i               ('0),
      .slv_ports_req_i      (xbar_sp_req),
      .slv_ports_resp_o     (xbar_sp_resp),
      .mst_ports_req_o      (xbar_mp_req),
      .mst_ports_resp_i     (xbar_mp_resp),
      .addr_map_i           (rs_rules),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('b101010)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Wire external master/slave interfaces into the local xbar port 2
  // so that the rest of the system can access the p_core resources
  // and vice-versa.
  assign rs_m_axi_req_o  = xbar_mp_req[2];
  assign xbar_mp_resp[2] = rs_m_axi_resp_i;
  assign xbar_sp_req[2]  = rs_s_axi_req_i;
  assign rs_s_axi_resp_o = xbar_sp_resp[2];

endmodule
