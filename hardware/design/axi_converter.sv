/*
SRC ##############################################
-   src        type_1  SRC_IW SRC_AW SRC_UW SRC_DW
CDC_FIFO / FIFO ##################################
-   n_1        type_1  SRC_IW SRC_AW SRC_UW SRC_DW
ID WIDTH CONVERTER / PASS THROUGH ################
-   n_2        type_2  DST_IW SRC_AW SRC_UW SRC_DW
ADDR WIDTH CONVERTER / PASS THROUGH ##############
-   n_3        type_3  DST_IW DST_AW SRC_UW SRC_DW
USER WIDTH CONVERTER / PASS THROUGH ##############
-   n_4        type_4  DST_IW DST_AW DST_UW SRC_DW
DATA WIDTH CONVERTER / PASS THROUGH ##############
-   n_5        type_5  DST_IW DST_AW DST_UW DST_DW
CDC_FIFO / FIFO ##################################
-   dst        type_5  DST_IW DST_AW DST_UW DST_DW
DST ##############################################
*/

`include "axi/typedef.svh"

module axi_converter #(
    parameter type src_req_t  = logic,
    parameter type src_resp_t = logic,
    parameter type dst_req_t  = logic,
    parameter type dst_resp_t = logic,
    parameter bit  enable_cdc = 0,
    parameter bit  faster_src = 1
) (
    input logic arst_ni,

    input  logic      src_clk_i,
    input  src_req_t  src_req_i,
    output src_resp_t src_resp_o,

    input  logic      dst_clk_i,
    output dst_req_t  dst_req_o,
    input  dst_resp_t dst_resp_i
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // LOCAL PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int SRC_IW = $bits(src_req_i.aw.id);
  localparam int SRC_AW = $bits(src_req_i.aw.addr);
  localparam int SRC_UW = $bits(src_req_i.aw.user);
  localparam int SRC_DW = $bits(src_req_i.w.data);

  localparam int DST_IW = $bits(dst_req_o.aw.id);
  localparam int DST_AW = $bits(dst_req_o.aw.addr);
  localparam int DST_UW = $bits(dst_req_o.aw.user);
  localparam int DST_DW = $bits(dst_req_o.w.data);

  localparam int GEN_IWC = (SRC_IW != DST_IW);
  localparam int GEN_AWC = (SRC_AW != DST_AW);
  localparam int GEN_UWC = (SRC_UW != DST_UW);
  localparam int GEN_DWC = (SRC_DW != DST_DW);

  localparam int GEN_SRC_CDC = (enable_cdc && !faster_src);
  localparam int GEN_DST_CDC = (enable_cdc && faster_src);

`ifndef SYSTHESIS
  initial begin
    string msg;
    $sformat(msg, "\nAXI Converter Configuration : %m\n");
    $sformat(msg, "%s ID Width Conversion       : %s\n", msg, GEN_IWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Address Width Conv        : %s\n", msg, GEN_AWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s User Width Conversion     : %s\n", msg, GEN_UWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Data Width Conversion     : %s\n", msg, GEN_DWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Source Clock CDC          : %s\n", msg, GEN_SRC_CDC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Destination Clock CDC     : %s\n", msg, GEN_DST_CDC ? "Enabled" : "Bypassed");
    $display("%s", msg);
  end
`endif

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPE DEFINITIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // verilog_format: off
  `AXI_TYPEDEF_ALL(type_1, logic [SRC_AW-1:0], logic [SRC_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [SRC_UW-1:0])
  `AXI_TYPEDEF_ALL(type_2, logic [SRC_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [SRC_UW-1:0])
  `AXI_TYPEDEF_ALL(type_3, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [SRC_UW-1:0])
  `AXI_TYPEDEF_ALL(type_4, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [DST_UW-1:0])
  `AXI_TYPEDEF_ALL(type_4, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [DST_DW-1:0], logic [DST_DW/8-1:0], logic [DST_UW-1:0])
  // verilog_format: on

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNAL DECLARATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic internal_clk;

  type_1_req_t n_1_req;
  type_1_resp_t n_1_resp;

  type_2_req_t n_2_req;
  type_2_resp_t n_2_resp;

  type_3_req_t n_3_req;
  type_3_resp_t n_3_resp;

  type_4_req_t n_4_req;
  type_4_resp_t n_4_resp;

  type_5_req_t n_5_req;
  type_5_resp_t n_5_resp;

  assign internal_clk = faster_src ? src_clk_i : dst_clk_i;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MODULE INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  if (GEN_SRC_CDC) begin
    axi_cdc #(
        .LogDepth  (2),
        .SyncStages(2),
        .aw_chan_t (n_1_aw_chan_t),
        .w_chan_t  (n_1_w_chan_t),
        .b_chan_t  (n_1_b_chan_t),
        .ar_chan_t (n_1_ar_chan_t),
        .r_chan_t  (n_1_r_chan_t),
        .axi_req_t (m_1_req_t),
        .axi_resp_t(m_1_resp_t)
    ) u_cdc_int (
        .src_clk_i (src_clk_i),
        .src_rst_ni(arst_ni),
        .dst_clk_i (dst_clk_i),
        .dst_rst_ni(arst_ni),
        .src_req_i (src_req_i),
        .src_resp_o(src_resp_o),
        .dst_req_o (n_1_req),
        .dst_resp_i(n_1_resp)
    );
  end else begin
    axi_fifo #(
        .Depth      (4),
        .FallThrough(0),
        .aw_chan_t  (n_1_aw_chan_t),
        .w_chan_t   (n_1_w_chan_t),
        .b_chan_t   (n_1_b_chan_t),
        .ar_chan_t  (n_1_ar_chan_t),
        .r_chan_t   (n_1_r_chan_t),
        .axi_req_t  (m_1_req_t),
        .axi_resp_t (m_1_resp_t)
    ) u_fifo_int (
        .clk_i     (internal_clk),
        .rst_ni    (arst_ni),
        .test_i    ('0),
        .slv_req_i (src_req_i),
        .slv_resp_o(src_resp_o),
        .mst_req_o (n_1_req),
        .mst_resp_i(n_1_resp)
    );
  end

  // TODO IW Converter

  // TODO AW Converter

  // TODO UW Converter

  // TODO DW Converter 

  if (GEN_DST_CDC) begin
    axi_cdc #(
        .LogDepth  (2),
        .SyncStages(2),
        .aw_chan_t (n_5_aw_chan_t),
        .w_chan_t  (n_5_w_chan_t),
        .b_chan_t  (n_5_b_chan_t),
        .ar_chan_t (n_5_ar_chan_t),
        .r_chan_t  (n_5_r_chan_t),
        .axi_req_t (m_5_req_t),
        .axi_resp_t(m_5_resp_t)
    ) u_cdc_int (
        .src_clk_i (src_clk_i),
        .src_rst_ni(arst_ni),
        .dst_clk_i (dst_clk_i),
        .dst_rst_ni(arst_ni),
        .src_req_i (n_5_req),
        .src_resp_o(n_5_resp),
        .dst_req_o (dst_req_o),
        .dst_resp_i(dst_resp_i)
    );
  end else begin
    axi_fifo #(
        .Depth      (4),
        .FallThrough(0),
        .aw_chan_t  (n_5_aw_chan_t),
        .w_chan_t   (n_5_w_chan_t),
        .b_chan_t   (n_5_b_chan_t),
        .ar_chan_t  (n_5_ar_chan_t),
        .r_chan_t   (n_5_r_chan_t),
        .axi_req_t  (m_5_req_t),
        .axi_resp_t (m_5_resp_t)
    ) u_fifo_int (
        .clk_i     (internal_clk),
        .rst_ni    (arst_ni),
        .test_i    ('0),
        .slv_req_i (n_5_req),
        .slv_resp_o(n_5_resp),
        .mst_req_o (dst_req_o),
        .mst_resp_i(dst_resp_i)
    );
  end

endmodule
