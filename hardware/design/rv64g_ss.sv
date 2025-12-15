module rv64g_ss
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

  rs_m_axi_req_t  xbar_mp_req [3];
  rs_m_axi_resp_t xbar_mp_resp[3];
  rs_s_axi_req_t  xbar_sp_req [3];
  rs_s_axi_resp_t xbar_sp_resp[3];

  ariane #(
      .DmBaseAddress(RAM_START),
      .CachedAddrBeg(RAM_START)
  ) u_core (
      .clk_i(clk_i),
      .rst_ni(arst_ni),
      .boot_addr_i({'h0, boot_addr_i}),
      .hart_id_i({'h0, hart_id_i}),
      .irq_i(irq_i),
      .ipi_i(ipi_i),
      .time_irq_i(time_irq_i),
      .debug_req_i(debug_req_i),
      .axi_req_o(),  // TODO xbar_sp_req[0]
      .axi_resp_i()  // TODO xbar_sp_resp[0]
  );

  axi_ram #(
      .MEM_BASE    (RAM_START),
      .MEM_SIZE    ($clog2(RAM_END - RAM_START + 1)),
      .ALLOW_WRITES('1),
      .req_t       (rs_m_axi_req_t),
      .resp_t      (rs_m_axi_resp_t)
  ) u_tcdm (
      .clk_i  (clk_i),
      .arst_ni(arst_ni),
      .req_i  (xbar_mp_req[0]),
      .resp_o (xbar_mp_resp[0])
  );

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

  assign rs_m_axi_req_o  = xbar_mp_req[2];
  assign xbar_mp_resp[2] = rs_m_axi_resp_i;
  assign xbar_sp_req[2]  = rs_s_axi_req_i;
  assign rs_s_axi_resp_o = xbar_sp_resp[2];

endmodule
