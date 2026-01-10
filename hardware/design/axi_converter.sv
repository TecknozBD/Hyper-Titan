/*
SRC ##############################################
-   src        type_1  SRC_IW SRC_AW SRC_UW SRC_DW
CDC_FIFO / FIFO ##################################
-   n_1        type_1  SRC_IW SRC_AW SRC_UW SRC_DW
ID WIDTH CONVERTER / PASS THROUGH ################
-   n_2        type_2  DST_IW SRC_AW SRC_UW SRC_DW
ADDR & USER WIDTH CONVERTER / PASS THROUGH #######
-   n_3        type_3  DST_IW DST_AW DST_UW SRC_DW
DATA WIDTH CONVERTER / PASS THROUGH ##############
-   n_4        type_4  DST_IW DST_AW DST_UW DST_DW
CDC_FIFO / FIFO ##################################
-   dst        type_4  DST_IW DST_AW DST_UW DST_DW
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

  // Top-level: AXI width/ID/user converters and optional CDC/FIFO
  // - Converts between source and destination AXI interface widths
  // - Optionally inserts CDC or FIFO stages depending on clock domains
  // - Supports ID and data-width conversion paths

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // LOCAL PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Calculated bit-widths for AW/ID/USER/DATA fields derived from
  // the provided typed request/response interfaces. Generation flags
  // indicate which converter/CDC modules need to be instantiated.

  localparam int SRC_IW = $bits(src_req_i.aw.id);
  localparam int SRC_AW = $bits(src_req_i.aw.addr);
  localparam int SRC_UW = $bits(src_req_i.aw.user);
  localparam int SRC_DW = $bits(src_req_i.w.data);

  localparam int DST_IW = $bits(dst_req_o.aw.id);
  localparam int DST_AW = $bits(dst_req_o.aw.addr);
  localparam int DST_UW = $bits(dst_req_o.aw.user);
  localparam int DST_DW = $bits(dst_req_o.w.data);

  localparam int GEN_IWC = (SRC_IW > DST_IW);
  localparam int GEN_DWC = (SRC_DW != DST_DW);

  localparam int GEN_SRC_CDC = (enable_cdc && !faster_src);
  localparam int GEN_DST_CDC = (enable_cdc && faster_src);

`ifndef SYSTHESIS
  initial begin
    string msg;
    $sformat(msg, "\nAXI Converter Configuration : %m\n");
    $sformat(msg, "%s ID Width Conversion        : %s\n", msg, GEN_IWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Data Width Conversion      : %s\n", msg, GEN_DWC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Source Clock CDC           : %s\n", msg, GEN_SRC_CDC ? "Enabled" : "Bypassed");
    $sformat(msg, "%s Destination Clock CDC      : %s\n", msg, GEN_DST_CDC ? "Enabled" : "Bypassed");
    $display("%s", msg);
  end
`endif

  // Synthesis-time debug: prints chosen converter/CDC configuration
  // when simulation starts (disabled for synthesis builds).

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // TYPE DEFINITIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Macros below expand typed AXI channel structures for the
  // various combinations of source/destination widths.
  // verilog_format: off
  `AXI_TYPEDEF_ALL(type_1, logic [SRC_AW-1:0], logic [SRC_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [SRC_UW-1:0])
  `AXI_TYPEDEF_ALL(type_2, logic [SRC_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [SRC_UW-1:0])
  `AXI_TYPEDEF_ALL(type_3, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [SRC_DW-1:0], logic [SRC_DW/8-1:0], logic [DST_UW-1:0])
  `AXI_TYPEDEF_ALL(type_4, logic [DST_AW-1:0], logic [DST_IW-1:0], logic [DST_DW-1:0], logic [DST_DW/8-1:0], logic [DST_UW-1:0])
  // verilog_format: on

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SIGNAL DECLARATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Internal typed channel signals used between conversion stages.
  // `internal_clk` selects which clock domain is used for internal
  // FIFOs/converters (source or destination depending on faster_src).

  logic internal_clk;

  type_1_req_t n_1_req;
  type_1_resp_t n_1_resp;

  type_2_req_t n_2_req;
  type_2_resp_t n_2_resp;

  type_3_req_t n_3_req;
  type_3_resp_t n_3_resp;

  type_4_req_t n_4_req;
  type_4_resp_t n_4_resp;

  assign internal_clk = faster_src ? src_clk_i : dst_clk_i;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MODULE INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Instantiate CDC or FIFO for source-side crossing depending on
  // `GEN_SRC_CDC`. This isolates the source clock domain from the
  // rest of the conversion pipeline when required.

  if (GEN_SRC_CDC) begin
    axi_cdc #(
        .LogDepth  (2),
        .SyncStages(2),
        .aw_chan_t (type_1_aw_chan_t),
        .w_chan_t  (type_1_w_chan_t),
        .b_chan_t  (type_1_b_chan_t),
        .ar_chan_t (type_1_ar_chan_t),
        .r_chan_t  (type_1_r_chan_t),
        .axi_req_t (type_1_req_t),
        .axi_resp_t(type_1_resp_t)
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
        .aw_chan_t  (type_1_aw_chan_t),
        .w_chan_t   (type_1_w_chan_t),
        .b_chan_t   (type_1_b_chan_t),
        .ar_chan_t  (type_1_ar_chan_t),
        .r_chan_t   (type_1_r_chan_t),
        .axi_req_t  (type_1_req_t),
        .axi_resp_t (type_1_resp_t)
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

  if (GEN_IWC) begin
    // ID Width Converter: collapses/expands transaction IDs from
    // source ID width to destination ID width while preserving
    // ordering and outstanding transaction limits.
    axi_iw_converter #(
        .AxiSlvPortIdWidth     (SRC_IW),
        .AxiMstPortIdWidth     (DST_IW),
        .AxiSlvPortMaxUniqIds  (2 ** SRC_IW),
        .AxiSlvPortMaxTxnsPerId(1),
        .AxiSlvPortMaxTxns     (2 ** SRC_IW),
        .AxiMstPortMaxUniqIds  (2 ** DST_IW),
        .AxiMstPortMaxTxnsPerId(1),
        .AxiAddrWidth          (SRC_AW),
        .AxiDataWidth          (SRC_DW),
        .AxiUserWidth          (SRC_UW),
        .slv_req_t             (type_1_req_t),
        .slv_resp_t            (type_1_resp_t),
        .mst_req_t             (type_2_req_t),
        .mst_resp_t            (type_2_resp_t)
    ) u_iwc (
        .clk_i     (internal_clk),
        .rst_ni    (arst_ni),
        .slv_req_i (n_1_req),
        .slv_resp_o(n_1_resp),
        .mst_req_o (n_2_req),
        .mst_resp_i(n_2_resp)
    );
  end else begin
    assign n_2_req  = n_1_req;
    assign n_1_resp = n_2_resp;
  end

  // Address/User width pass-through: pad or truncate fields so the
  // downstream data-width converter always sees the destination
  // address/user widths expected by the DWC block.
  always_comb begin
    n_3_req.aw.id     = {'0, n_2_req.aw.id};
    n_3_req.aw.addr   = {'0, n_2_req.aw.addr};
    n_3_req.aw.len    = {'0, n_2_req.aw.len};
    n_3_req.aw.size   = {'0, n_2_req.aw.size};
    n_3_req.aw.burst  = {'0, n_2_req.aw.burst};
    n_3_req.aw.lock   = {'0, n_2_req.aw.lock};
    n_3_req.aw.cache  = {'0, n_2_req.aw.cache};
    n_3_req.aw.prot   = {'0, n_2_req.aw.prot};
    n_3_req.aw.qos    = {'0, n_2_req.aw.qos};
    n_3_req.aw.region = {'0, n_2_req.aw.region};
    n_3_req.aw.user   = {'0, n_2_req.aw.user};
    n_3_req.aw.atop   = {'0, n_2_req.aw.user};
    n_3_req.aw_valid  = {'0, n_2_req.aw_valid};
    n_2_resp.aw_ready = {'0, n_3_resp.aw_ready};

    n_3_req.w.data    = {'0, n_2_req.w.data};
    n_3_req.w.strb    = {'0, n_2_req.w.strb};
    n_3_req.w.last    = {'0, n_2_req.w.last};
    n_3_req.w.user    = {'0, n_2_req.w.user};
    n_3_req.w_valid   = {'0, n_2_req.w_valid};
    n_2_resp.w_ready  = {'0, n_3_resp.w_ready};

    n_2_resp.b.id     = {'0, n_3_resp.b.id};
    n_2_resp.b.resp   = {'0, n_3_resp.b.resp};
    n_2_resp.b.user   = {'0, n_3_resp.b.user};
    n_2_resp.b_valid  = {'0, n_3_resp.b_valid};
    n_3_req.b_ready   = {'0, n_2_req.b_ready};

    n_3_req.ar.id     = {'0, n_2_req.ar.id};
    n_3_req.ar.addr   = {'0, n_2_req.ar.addr};
    n_3_req.ar.len    = {'0, n_2_req.ar.len};
    n_3_req.ar.size   = {'0, n_2_req.ar.size};
    n_3_req.ar.burst  = {'0, n_2_req.ar.burst};
    n_3_req.ar.lock   = {'0, n_2_req.ar.lock};
    n_3_req.ar.cache  = {'0, n_2_req.ar.cache};
    n_3_req.ar.prot   = {'0, n_2_req.ar.prot};
    n_3_req.ar.qos    = {'0, n_2_req.ar.qos};
    n_3_req.ar.region = {'0, n_2_req.ar.region};
    n_3_req.ar.user   = {'0, n_2_req.ar.user};
    n_3_req.ar_valid  = {'0, n_2_req.ar_valid};
    n_2_resp.ar_ready = {'0, n_3_resp.ar_ready};

    n_2_resp.r.id     = {'0, n_3_resp.r.id};
    n_2_resp.r.data   = {'0, n_3_resp.r.data};
    n_2_resp.r.resp   = {'0, n_3_resp.r.resp};
    n_2_resp.r.last   = {'0, n_3_resp.r.last};
    n_2_resp.r.user   = {'0, n_3_resp.r.user};
    n_2_resp.r_valid  = {'0, n_3_resp.r_valid};
    n_3_req.r_ready   = {'0, n_2_req.r_ready};

  end

  if (GEN_DWC) begin
    // Data Width Converter: handles widening/narrowing of the
    // data channel between SRC_DW and DST_DW, including beats,
    // byte-strobes, and read/write reassembly as required.
    axi_dw_converter #(
        .AxiMaxReads        (1),
        .AxiSlvPortDataWidth(SRC_DW),
        .AxiMstPortDataWidth(DST_DW),
        .AxiAddrWidth       (DST_AW),
        .AxiIdWidth         (DST_IW),
        .aw_chan_t          (type_4_aw_chan_t),
        .mst_w_chan_t       (type_4_w_chan_t),
        .slv_w_chan_t       (type_3_w_chan_t),
        .b_chan_t           (type_4_b_chan_t),
        .ar_chan_t          (type_4_ar_chan_t),
        .mst_r_chan_t       (type_4_r_chan_t),
        .slv_r_chan_t       (type_3_r_chan_t),
        .axi_mst_req_t      (type_4_req_t),
        .axi_mst_resp_t     (type_4_resp_t),
        .axi_slv_req_t      (type_3_req_t),
        .axi_slv_resp_t     (type_3_resp_t)
    ) u_dwc (
        .clk_i     (internal_clk),
        .rst_ni    (arst_ni),
        .slv_req_i (n_3_req),
        .slv_resp_o(n_3_resp),
        .mst_req_o (n_4_req),
        .mst_resp_i(n_4_resp)
    );
  end else begin
    assign n_4_req  = n_3_req;
    assign n_3_resp = n_4_resp;
  end

  if (GEN_DST_CDC) begin
    // Destination-side CDC: isolates the final converter output into
    // the destination clock domain when required, or otherwise a
    // FIFO is used to cross into the destination domain.
    axi_cdc #(
        .LogDepth  (2),
        .SyncStages(2),
        .aw_chan_t (type_3_aw_chan_t),
        .w_chan_t  (type_3_w_chan_t),
        .b_chan_t  (type_3_b_chan_t),
        .ar_chan_t (type_3_ar_chan_t),
        .r_chan_t  (type_3_r_chan_t),
        .axi_req_t (type_4_req_t),
        .axi_resp_t(type_4_resp_t)
    ) u_cdc_int (
        .src_clk_i (src_clk_i),
        .src_rst_ni(arst_ni),
        .dst_clk_i (dst_clk_i),
        .dst_rst_ni(arst_ni),
        .src_req_i (n_4_req),
        .src_resp_o(n_4_resp),
        .dst_req_o (dst_req_o),
        .dst_resp_i(dst_resp_i)
    );
  end else begin
    axi_fifo #(
        .Depth      (4),
        .FallThrough(0),
        .aw_chan_t  (type_3_aw_chan_t),
        .w_chan_t   (type_3_w_chan_t),
        .b_chan_t   (type_3_b_chan_t),
        .ar_chan_t  (type_3_ar_chan_t),
        .r_chan_t   (type_3_r_chan_t),
        .axi_req_t  (type_4_req_t),
        .axi_resp_t (type_4_resp_t)
    ) u_fifo_int (
        .clk_i     (internal_clk),
        .rst_ni    (arst_ni),
        .test_i    ('0),
        .slv_req_i (n_4_req),
        .slv_resp_o(n_4_resp),
        .mst_req_o (dst_req_o),
        .mst_resp_i(dst_resp_i)
    );
  end

endmodule
