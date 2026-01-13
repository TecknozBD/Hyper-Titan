`include "axi/typedef.svh"

// Simple adapter from AXI-Lite request/response channels to a
// memory interface. This module unwraps AXI-Lite transactions and
// drives a simple memory read/write handshake with address, data,
// and response signals. It's intended for use with small TCM/BRAM
// blocks where full AXI is not required.
module axil_to_memif #(
    parameter type         req_t    = logic,
    parameter type         resp_t   = logic,
    parameter logic [63:0] MEM_BASE = '0,
    parameter int          MEM_SIZE = 32
) (
    input  logic  arst_ni,
    input  logic  clk_i,
    input  req_t  req_i,
    output resp_t resp_o,

    output logic                           mem_we_o,
    output logic [           MEM_SIZE-1:0] mem_waddr_o,
    output logic [$bits(req_i.w.data)-1:0] mem_wdata_o,
    output logic [$bits(req_i.w.strb)-1:0] mem_wstrb_o,
    input  logic [                    1:0] mem_wresp_i,

    output logic                           mem_re_o,
    output logic [           MEM_SIZE-1:0] mem_raddr_o,
    input  logic [$bits(req_i.w.data)-1:0] mem_rdata_i,
    input  logic [                    1:0] mem_rresp_i
);

    // Derived widths from the typed AXI-Lite interface
    localparam int AW = $bits(req_i.aw.addr);
    localparam int DW = $bits(req_i.w.data);

    // Generate typed AXI-Lite channel structs for local wiring
    `AXI_LITE_TYPEDEF_ALL(axil, logic [AW-1:0], logic [DW-1:0], logic [DW/8-1:0])

    // Local FIFO output typed channels (slave side of FIFO)
    axil_req_t  l_req_fo;
    axil_resp_t l_resp_fo;

  axi_fifo #(
      .Depth      (4),
      .FallThrough('0),
      .aw_chan_t  (axil_aw_chan_t),
      .w_chan_t   (axil_w_chan_t),
      .b_chan_t   (axil_b_chan_t),
      .ar_chan_t  (axil_ar_chan_t),
      .r_chan_t   (axil_r_chan_t),
      .axi_req_t  (axil_req_t),
      .axi_resp_t (axil_resp_t)
  ) u_axi_fifo (
      .clk_i     (clk_i),
      .rst_ni    (arst_ni),
      .test_i    ('0),
      .slv_req_i (req_i),
      .slv_resp_o(resp_o),
      .mst_req_o (l_req_fo),
      .mst_resp_i(l_resp_fo)
  );

    // FIFO stage: decouples the AXI-Lite host from the memory
    // interface so that simple handshake logic below can operate
    // in `clk_i` without blocking the requester.

    // --- Write path ---
    // mem_we_o is asserted when an AW and W are both valid and the
    // AXI-Lite b-channel handshake is ready to accept the response.
    always_comb mem_we_o = l_req_fo.aw_valid & l_req_fo.w_valid & l_req_fo.b_ready;

    // Propagate ready/valid signals back into the AXI-Lite domain
    // so the upstream master sees the expected flow-control.
    always_comb l_resp_fo.aw_ready = mem_we_o;
    always_comb l_resp_fo.w_ready  = mem_we_o;
    always_comb l_resp_fo.b_valid  = mem_we_o;

    // Memory write outputs: subtract MEM_BASE to produce a local
    // memory-relative address. Assumes caller ensures addresses lie
    // within the configured `MEM_BASE`/`MEM_SIZE` region.
    always_comb mem_waddr_o = (l_req_fo.aw.addr - MEM_BASE);
    always_comb mem_wdata_o = l_req_fo.w.data;
    always_comb mem_wstrb_o = l_req_fo.w.strb;

    // Pass-through of memory write response into AXI-Lite b.resp
    always_comb l_resp_fo.b.resp = mem_wresp_i;

    // --- Read path ---
    // mem_re_o is asserted when a valid AR is present and the AXI-Lite
    // r-channel is ready to accept data.
    always_comb mem_re_o = l_req_fo.ar_valid & l_req_fo.r_ready;
    always_comb l_resp_fo.ar_ready = mem_re_o;
    always_comb l_resp_fo.r_valid  = mem_re_o;

    // Memory read outputs: subtract MEM_BASE to produce a local
    // memory-relative address. Read data and response are passed
    // back into the AXI-Lite r-channel.
    always_comb mem_raddr_o = (l_req_fo.ar.addr - MEM_BASE);
    always_comb l_resp_fo.r.data = mem_rdata_i;
    always_comb l_resp_fo.r.resp = mem_rresp_i;

endmodule
