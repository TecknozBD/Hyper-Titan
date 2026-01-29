 ////////////////////////////////////////////////////////////////////////////////
 // File              : dma_axi_wrapper.sv
 // Description       : AXI DMA wrapper implemented using PULP AXI structs.
 //                     This wrapper cleanly separates the control and data paths:
 //                      - AXI interface for DMA CSRs (control/status)
 //                      - AXI interface for DMA data and descriptor accesses
 // Author            : Amit Sikder
 // Organization      : SoC Development
 // Developed At      : Tecknoz
 // Date              : January, 2026
 // License           : MIT License
 ////////////////////////////////////////////////////////////////////////////////

module axi_dma 
  import amba_axi_pkg::*;
  import dma_utils_pkg::*;
#(
    parameter longint CSR_BASE = 'h0000_F000,
    parameter int  DMA_ID_VAL = 0,
    parameter type mp_aw_chan_t = logic,
    parameter type mp_w_chan_t  = logic,
    parameter type mp_b_chan_t  = logic,
    parameter type mp_ar_chan_t = logic,
    parameter type mp_r_chan_t  = logic,
    parameter type sp_aw_chan_t = logic,
    parameter type sp_w_chan_t  = logic,
    parameter type sp_b_chan_t  = logic,
    parameter type sp_ar_chan_t = logic,
    parameter type sp_r_chan_t  = logic,
    parameter type mp_req_t     = logic,
    parameter type mp_resp_t    = logic,
    parameter type sp_req_t     = logic,
    parameter type sp_resp_t    = logic
)(
  // ----------------------------
  // Clock and Reset  
  // ----------------------------
  input  logic clk,
  input  logic rst_n,

  // ----------------------------
  // AXI CSR interface
  // ----------------------------
  input  mp_req_t  mp_req_i,
  output mp_resp_t mp_resp_o,

  // ----------------------------
  // AXI master interface (DMA)
  // ----------------------------
  output sp_req_t  sp_req_o,
  input  sp_resp_t sp_resp_i,

  // ----------------------------
  // IRQs
  // ----------------------------
  output logic dma_done_o,
  output logic dma_error_o
);

  // -------------------------------------------------
  // AXI-Lite Type Definitions
  // -------------------------------------------------
  `AXI_LITE_TYPEDEF_ALL(axil, logic [63:0], logic [63:0], logic [7:0])

  // -------------------------------------------------
  // DMA Structures
  // -------------------------------------------------
  s_axil_mosi_t dma_s_mosi;
  s_axil_miso_t dma_s_miso;

  s_axi_mosi_t  dma_m_mosi;
  s_axi_miso_t  dma_m_miso;

  // -------------------------------------------------
  // AXI → AXI-Lite converter (CSR access path)
  // -------------------------------------------------
  axil_req_t  csr_axil_req;
  axil_resp_t csr_axil_resp;

  // -------------------------------------------------
  // AXI to AXI-Lite converter instance
  // -------------------------------------------------
  axi_to_axi_lite #(
    .AxiAddrWidth    ( AXI_ADDR_WIDTH     ),
    .AxiDataWidth    ( AXI_DATA_WIDTH     ),
    .AxiIdWidth      ( AXI_ID_WIDTH       ),
    .AxiUserWidth    ( AXI_USER_WIDTH     ),
    .AxiMaxWriteTxns ( AXI_MAX_WRITE_TXNS ),
    .AxiMaxReadTxns  ( AXI_MAX_READ_TXNS  ),
    .full_req_t      ( mp_req_t           ),
    .full_resp_t     ( mp_resp_t          ),
    .lite_req_t      ( axil_req_t         ),
    .lite_resp_t     ( axil_resp_t        )
  ) i_axi_to_axil (
    .clk_i      ( clk     ),
    .rst_ni     ( rst_n   ),
    .test_i     ( 1'b0    ),

    // From SoC (full AXI CSR window)
    .slv_req_i  ( mp_req_i  ),
    .slv_resp_o ( mp_resp_o ),

    // To CSR block (AXI-Lite)
    .mst_req_o  ( csr_axil_req   ),
    .mst_resp_i ( csr_axil_resp  )
  );

  // -------------------------------------------------
  // AXI Signal Assignments     
  // -------------------------------------------------
  always_comb begin
    // AXI4 Lite interface
    dma_s_mosi.awaddr      = csr_axil_req.aw.addr - CSR_BASE;
    dma_s_mosi.awprot      = csr_axil_req.aw.prot;
    dma_s_mosi.awvalid     = csr_axil_req.aw_valid;
    dma_s_mosi.wdata       = csr_axil_req.w.wdata;
    dma_s_mosi.wstrb       = csr_axil_req.w.strb;
    dma_s_mosi.wvalid      = csr_axil_req.w_valid;
    dma_s_mosi.bready      = csr_axil_req.b_ready;
    dma_s_mosi.araddr      = csr_axil_req.ar.addr - CSR_BASE;
    dma_s_mosi.arprot      = csr_axil_req.ar.prot;
    dma_s_mosi.arvalid     = csr_axil_req.ar_valid;
    dma_s_mosi.rready      = csr_axil_req.r_ready;

    csr_axil_resp.aw_ready = dma_s_miso.awready;
    csr_axil_resp.w_ready  = dma_s_miso.wready;
    csr_axil_resp.b.resp   = dma_s_miso.bresp;
    csr_axil_resp.b_valid  = dma_s_miso.bvalid;
    csr_axil_resp.ar_ready = dma_s_miso.arready;
    csr_axil_resp.r.data   = dma_s_miso.rdata;
    csr_axil_resp.r.resp   = dma_s_miso.rresp;
    csr_axil_resp.r_valid  = dma_s_miso.rvalid;

    // AXI4 Master interface
    sp_req_o.aw.id      = dma_m_mosi.awid;
    sp_req_o.aw.addr    = dma_m_mosi.awaddr;
    sp_req_o.aw.len     = dma_m_mosi.awlen;
    sp_req_o.aw.size    = dma_m_mosi.awsize;
    sp_req_o.aw.burst   = dma_m_mosi.awburst;
    sp_req_o.aw.lock    = dma_m_mosi.awlock;
    sp_req_o.aw.cache   = dma_m_mosi.awcache;
    sp_req_o.aw.prot    = dma_m_mosi.awprot;
    sp_req_o.aw.qos     = dma_m_mosi.awqos;
    sp_req_o.aw.region  = dma_m_mosi.awregion;
    sp_req_o.aw.atop    = '0;
    sp_req_o.aw.user    = dma_m_mosi.awuser;
    sp_req_o.aw_valid   = dma_m_mosi.awvalid;
    sp_req_o.w.data     = dma_m_mosi.wdata;
    sp_req_o.w.strb     = dma_m_mosi.wstrb;
    sp_req_o.w.last     = dma_m_mosi.wlast;
    sp_req_o.w.user     = dma_m_mosi.wuser;
    sp_req_o.w_valid    = dma_m_mosi.wvalid;
    sp_req_o.b_ready    = dma_m_mosi.bready;
    sp_req_o.ar.id      = dma_m_mosi.arid;
    sp_req_o.ar.addr    = dma_m_mosi.araddr;
    sp_req_o.ar.len     = dma_m_mosi.arlen;
    sp_req_o.ar.size    = dma_m_mosi.arsize;
    sp_req_o.ar.burst   = dma_m_mosi.arburst;
    sp_req_o.ar.lock    = dma_m_mosi.arlock;
    sp_req_o.ar.cache   = dma_m_mosi.arcache;
    sp_req_o.ar.prot    = dma_m_mosi.arprot;
    sp_req_o.ar.qos     = dma_m_mosi.arqos;
    sp_req_o.ar.region  = dma_m_mosi.arregion;
    sp_req_o.ar.user    = dma_m_mosi.aruser;
    sp_req_o.ar_valid   = dma_m_mosi.arvalid;
    sp_req_o.r_ready    = dma_m_mosi.rready;

    dma_m_miso.awready     = sp_resp_i.aw_ready;
    dma_m_miso.wready      = sp_resp_i.w_ready;
    dma_m_miso.bid         = sp_resp_i.b.id;
    dma_m_miso.bresp       = sp_resp_i.b.resp;
    dma_m_miso.buser       = sp_resp_i.b.user;
    dma_m_miso.bvalid      = sp_resp_i.b_valid;
    dma_m_miso.arready     = sp_resp_i.ar_ready;
    dma_m_miso.rid         = sp_resp_i.r.id;
    dma_m_miso.rdata       = sp_resp_i.r.data;
    dma_m_miso.rresp       = sp_resp_i.r.resp;
    dma_m_miso.rlast       = sp_resp_i.r.last;
    dma_m_miso.ruser       = sp_resp_i.r.user;
    dma_m_miso.rvalid      = sp_resp_i.r_valid;
  end

  // -------------------------------------------------
  // DMA wrapper instance
  // -------------------------------------------------
  dma_axi_wrapper u_dma_axi_wrapper(
    .clk            (clk),
    .rst            (~rst_n),
    .dma_csr_mosi_i (dma_s_mosi),
    .dma_csr_miso_o (dma_s_miso),
    .dma_m_mosi_o   (dma_m_mosi),
    .dma_m_miso_i   (dma_m_miso),
    .dma_done_o     (dma_done_o),
    .dma_error_o    (dma_error_o)
  );

endmodule
