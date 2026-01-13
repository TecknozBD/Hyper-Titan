`include "axi/typedef.svh"
`include "simple_axi_m_driver.svh"

module ddr3_tb;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////


  `define GEN_CLK(__NAME__, __PERIOD__, __QUATER_LAG__) \
    logic __NAME__ = '0;                                \
    initial begin                                       \
      #300ns;                                           \
      repeat (__QUATER_LAG__) #(__PERIOD__ / 4);        \
      forever #(__PERIOD__ / 2) __NAME__ <= ~__NAME__;  \
    end                                                 \
  
  // verilog_format: off
  `GEN_CLK(clk, 10ns, 0)  // 100 MHz
  `GEN_CLK(clk_ddr, 2.5ns, 0)  // 400 MHz
  `GEN_CLK(clk_ddr_dqs, 2.5ns, 1)  // 400 MHz (phase 90)
  `GEN_CLK(clk_ref, 5ns, 0)  // 200 MHz
  // verilog_format: on

  logic rst;

  ////////////////////////////////////////////////
  // AXI
  ////////////////////////////////////////////////

  `AXI_TYPEDEF_ALL(axi, logic [31:0], logic [3:0], logic [31:0], logic [3:0], logic)

  axi_req_t         axi_req;
  axi_resp_t        axi_resp;

  wire              inport_awvalid;
  wire       [31:0] inport_awaddr;
  wire       [ 3:0] inport_awid;
  wire       [ 7:0] inport_awlen;
  wire       [ 1:0] inport_awburst;
  wire              inport_wvalid;
  wire       [31:0] inport_wdata;
  wire       [ 3:0] inport_wstrb;
  wire              inport_wlast;
  wire              inport_bready;
  wire              inport_arvalid;
  wire       [31:0] inport_araddr;
  wire       [ 3:0] inport_arid;
  wire       [ 7:0] inport_arlen;
  wire       [ 1:0] inport_arburst;
  wire              inport_rready;
  wire              inport_awready;
  wire              inport_wready;
  wire              inport_bvalid;
  wire       [ 1:0] inport_bresp;
  wire       [ 3:0] inport_bid;
  wire              inport_arready;
  wire              inport_rvalid;
  wire       [31:0] inport_rdata;
  wire       [ 1:0] inport_rresp;
  wire       [ 3:0] inport_rid;
  wire              inport_rlast;

  ////////////////////////////////////////////////
  // PHY CONFIG
  ////////////////////////////////////////////////

  wire              cfg_valid;
  wire       [31:0] cfg;

  ////////////////////////////////////////////////
  // DFI
  ////////////////////////////////////////////////

  wire       [14:0] dfi_address;
  wire       [ 2:0] dfi_bank;
  wire              dfi_cas_n;
  wire              dfi_cke;
  wire              dfi_cs_n;
  wire              dfi_odt;
  wire              dfi_ras_n;
  wire              dfi_reset_n;
  wire              dfi_we_n;
  wire       [31:0] dfi_wrdata;
  wire              dfi_wrdata_en;
  wire       [ 3:0] dfi_wrdata_mask;
  wire              dfi_rddata_en;
  wire       [31:0] dfi_rddata;
  wire              dfi_rddata_valid;
  wire       [ 1:0] dfi_rddata_dnv;

  ////////////////////////////////////////////////
  // DDR3
  ////////////////////////////////////////////////

  wire              ddr3_reset_n_w;
  wire              ddr3_ck_p_w;
  wire              ddr3_ck_n_w;
  wire              ddr3_cke_w;
  wire              ddr3_cs_n_w;
  wire              ddr3_ras_n_w;
  wire              ddr3_cas_n_w;
  wire              ddr3_we_n_w;
  wire       [ 1:0] ddr3_dm_w;
  wire       [ 2:0] ddr3_ba_w;
  wire       [13:0] ddr3_addr_w;
  wire       [15:0] ddr3_dq_w;
  wire       [ 1:0] ddr3_dqs_p_w;
  wire       [ 1:0] ddr3_dqs_n_w;
  wire       [ 1:0] ddr3_tdqs_n_w;
  wire              ddr3_odt_w;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////
  // CONTROLLER
  ////////////////////////////////////////////////

  ddr3_axi #(
      .DDR_MHZ          (100),
      .DDR_WRITE_LATENCY(4),
      .DDR_READ_LATENCY (4)
  ) u_ddr3_axi (
      .clk_i             (clk),
      .rst_i             (rst),
      .inport_awvalid_i  (inport_awvalid),
      .inport_awaddr_i   (inport_awaddr),
      .inport_awid_i     (inport_awid),
      .inport_awlen_i    (inport_awlen),
      .inport_awburst_i  (inport_awburst),
      .inport_wvalid_i   (inport_wvalid),
      .inport_wdata_i    (inport_wdata),
      .inport_wstrb_i    (inport_wstrb),
      .inport_wlast_i    (inport_wlast),
      .inport_bready_i   (inport_bready),
      .inport_arvalid_i  (inport_arvalid),
      .inport_araddr_i   (inport_araddr),
      .inport_arid_i     (inport_arid),
      .inport_arlen_i    (inport_arlen),
      .inport_arburst_i  (inport_arburst),
      .inport_rready_i   (inport_rready),
      .inport_awready_o  (inport_awready),
      .inport_wready_o   (inport_wready),
      .inport_bvalid_o   (inport_bvalid),
      .inport_bresp_o    (inport_bresp),
      .inport_bid_o      (inport_bid),
      .inport_arready_o  (inport_arready),
      .inport_rvalid_o   (inport_rvalid),
      .inport_rdata_o    (inport_rdata),
      .inport_rresp_o    (inport_rresp),
      .inport_rid_o      (inport_rid),
      .inport_rlast_o    (inport_rlast),
      .dfi_address_o     (dfi_address),
      .dfi_bank_o        (dfi_bank),
      .dfi_cas_n_o       (dfi_cas_n),
      .dfi_cke_o         (dfi_cke),
      .dfi_cs_n_o        (dfi_cs_n),
      .dfi_odt_o         (dfi_odt),
      .dfi_ras_n_o       (dfi_ras_n),
      .dfi_reset_n_o     (dfi_reset_n),
      .dfi_we_n_o        (dfi_we_n),
      .dfi_wrdata_o      (dfi_wrdata),
      .dfi_wrdata_en_o   (dfi_wrdata_en),
      .dfi_wrdata_mask_o (dfi_wrdata_mask),
      .dfi_rddata_en_o   (dfi_rddata_en),
      .dfi_rddata_i      (dfi_rddata),
      .dfi_rddata_valid_i(dfi_rddata_valid),
      .dfi_rddata_dnv_i  (dfi_rddata_dnv)
  );

  ////////////////////////////////////////////////
  // PHY
  ////////////////////////////////////////////////

  ddr3_dfi_phy #(
      .DQS_TAP_DELAY_INIT(27),
      .DQ_TAP_DELAY_INIT(0),
      .TPHY_RDLAT(5)
  ) u_phy (
      .clk_i             (clk),
      .clk_ddr_i         (clk_ddr),
      .clk_ddr90_i       (clk_ddr_dqs),
      .clk_ref_i         (clk_ref),
      .rst_i             (rst),
      .cfg_valid_i       (cfg_valid),
      .cfg_i             (cfg),
      .dfi_address_i     (dfi_address),
      .dfi_bank_i        (dfi_bank),
      .dfi_cas_n_i       (dfi_cas_n),
      .dfi_cke_i         (dfi_cke),
      .dfi_cs_n_i        (dfi_cs_n),
      .dfi_odt_i         (dfi_odt),
      .dfi_ras_n_i       (dfi_ras_n),
      .dfi_reset_n_i     (dfi_reset_n),
      .dfi_we_n_i        (dfi_we_n),
      .dfi_wrdata_i      (dfi_wrdata),
      .dfi_wrdata_en_i   (dfi_wrdata_en),
      .dfi_wrdata_mask_i (dfi_wrdata_mask),
      .dfi_rddata_en_i   (dfi_rddata_en),
      .dfi_rddata_o      (dfi_rddata),
      .dfi_rddata_valid_o(dfi_rddata_valid),
      .dfi_rddata_dnv_o  (dfi_rddata_dnv),
      .ddr3_ck_p_o       (ddr3_ck_p_w),
      .ddr3_ck_n_o       (ddr3_ck_n_w),
      .ddr3_cke_o        (ddr3_cke_w),
      .ddr3_reset_n_o    (ddr3_reset_n_w),
      .ddr3_ras_n_o      (ddr3_ras_n_w),
      .ddr3_cas_n_o      (ddr3_cas_n_w),
      .ddr3_we_n_o       (ddr3_we_n_w),
      .ddr3_cs_n_o       (ddr3_cs_n_w),
      .ddr3_ba_o         (ddr3_ba_w),
      .ddr3_addr_o       (ddr3_addr_w),
      .ddr3_odt_o        (ddr3_odt_w),
      .ddr3_dm_o         (ddr3_dm_w),
      .ddr3_dqs_p_io     (ddr3_dqs_p_w),
      .ddr3_dqs_n_io     (ddr3_dqs_n_w),
      .ddr3_dq_io        (ddr3_dq_w)
  );

  ////////////////////////////////////////////////
  // MEMORY
  ////////////////////////////////////////////////

  ddr3 u_ram (
      .rst_n  (ddr3_reset_n_w),
      .ck     (ddr3_ck_p_w),
      .ck_n   (ddr3_ck_n_w),
      .cke    (ddr3_cke_w),
      .cs_n   (ddr3_cs_n_w),
      .ras_n  (ddr3_ras_n_w),
      .cas_n  (ddr3_cas_n_w),
      .we_n   (ddr3_we_n_w),
      .dm_tdqs(ddr3_dm_w),
      .ba     (ddr3_ba_w),
      .addr   (ddr3_addr_w),
      .dq     (ddr3_dq_w),
      .dqs    (ddr3_dqs_p_w),
      .dqs_n  (ddr3_dqs_n_w),
      .tdqs_n (ddr3_tdqs_n_w),
      .odt    (ddr3_odt_w)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // COMBINATIONAL LOGIC
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_comb begin
    axi_resp          = '0;
    axi_resp.aw_ready = inport_awready;
    axi_resp.w_ready  = inport_wready;
    axi_resp.b.id     = inport_bid;
    axi_resp.b.resp   = inport_bresp;
    axi_resp.b_valid  = inport_bvalid;
    axi_resp.ar_ready = inport_arready;
    axi_resp.r.id     = inport_rid;
    axi_resp.r.data   = inport_rdata;
    axi_resp.r.resp   = inport_rresp;
    axi_resp.r.last   = inport_rlast;
    axi_resp.r_valid  = inport_rvalid;
  end

  assign inport_awaddr  = axi_req.aw.addr;
  assign inport_awid    = axi_req.aw.id;
  assign inport_awlen   = axi_req.aw.len;
  assign inport_awburst = axi_req.aw.burst;
  assign inport_awvalid = axi_req.aw_valid;
  assign inport_wdata   = axi_req.w.data;
  assign inport_wstrb   = axi_req.w.strb;
  assign inport_wlast   = axi_req.w.last;
  assign inport_wvalid  = axi_req.w_valid;
  assign inport_bready  = axi_req.b_ready;
  assign inport_araddr  = axi_req.ar.addr;
  assign inport_arid    = axi_req.ar.id;
  assign inport_arlen   = axi_req.ar.len;
  assign inport_arburst = axi_req.ar.burst;
  assign inport_arvalid = axi_req.ar_valid;
  assign inport_rready  = axi_req.r_ready;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MEMORY DRIVER
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // task automatic axi_read_8(addr, data, resp);
  // task automatic axi_write_8(addr, data, resp);
  // task automatic axi_read_16(addr, data, resp);
  // task automatic axi_write_16(addr, data, resp);
  // task automatic axi_read_32(addr, data, resp);
  // task automatic axi_write_32(addr, data, resp);
  // task automatic axi_read_64(addr, data, resp);
  // task automatic axi_write_64(addr, data, resp);
  `SIMPLE_AXI_M_DRIVER(axi, clk, ~rst, axi_req, axi_resp)

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MAIN TESTBENCH LOGIC
  //////////////////////////////////////////////////////////////////////////////////////////////////

  initial begin
    logic [31:0] data_dummy;
    logic [ 1:0] resp_dummy;

    $dumpfile("ddr3_tb.vcd");
    $dumpvars(0, ddr3_tb);

    // repeat (10) @(posedge clk);
    rst <= 1'b0;
    repeat (10) @(posedge clk);
    axi_req <= '0;
    rst <= 1'b1;
    repeat (10) @(posedge clk);
    rst <= 1'b0;

    @(posedge clk);

    repeat (2) begin
      data_dummy = 32'hA5A5A5A5;
      axi_write_32(128, data_dummy, resp_dummy);
      data_dummy = 32'h00000000;
      axi_read_32(128, data_dummy, resp_dummy);
      $display("\033[1;32mREAD DATA: %h\033[0m", data_dummy);
    end

    repeat (10) @(posedge clk);

    $finish;
  end

endmodule
