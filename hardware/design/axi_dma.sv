module axi_dma #(
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
) (
    // Clock and Reset
    input logic clk_i,
    input logic arst_ni,

    // Master Port Interface
    input  mp_req_t  mp_req_i,
    output mp_resp_t mp_resp_o,

    // Slave Port Interface
    output sp_req_t  sp_req_o,
    input  sp_resp_t sp_resp_i,
);

  // ------------------------------------------------------------
  // Base Address
  // ------------------------------------------------------------
  localparam logic [31:0] DMA_BASE_ADDR = 32'h0000_F000;

  // ------------------------------------------------------------
  // 0x000 : DMA_CTRL
  // ------------------------------------------------------------
  logic START;      // bit [0]
  logic INT_EN;     // bit [1]

  // ------------------------------------------------------------
  // 0x004 : DMA_STATUS
  // ------------------------------------------------------------
  logic BUSY,

  // ------------------------------------------------------------
  // 0x008 : DMA_TRANSFER_SIZE
  // ------------------------------------------------------------
  logic [31:0] SIZE;

  // ------------------------------------------------------------
  // 0x00C : DMA_TRANSFER_REMAINING
  // ------------------------------------------------------------
  logic [31:0] REM  

  // ------------------------------------------------------------
  // 0x010 : DMA_TRANSFER_SIDEBAND (DECLARED ONLY)
  // ------------------------------------------------------------
  logic [11:0]  SRC_STRIDE;   // TODO
  logic [15:12] SRC_SCHEME;   // TODO
  logic [27:16] DEST_STRIDE;  // TODO
  logic [31:28] DEST_SCHEME;  // TODO

  // ------------------------------------------------------------
  // Source / Destination Addresses
  // ------------------------------------------------------------
  logic [31:0] SRC_ADDR_L;    // 0x020
  logic [31:0] SRC_ADDR_U;    // 0x024
  logic [31:0] DEST_ADDR_L;   // 0x028
  logic [31:0] DEST_ADDR_U;   // 0x02C

  // ------------------------------------------------------------
  // AXI-lite handshakes (single beat)
  // ------------------------------------------------------------
  wire aw_fire = sp_resp_i.aw_valid && sp_req_o.aw_ready;
  wire w_fire  = sp_resp_i.w_valid  && sp_req_o.w_ready;
  wire ar_fire = sp_resp_i.ar_valid && sp_req_o.ar_ready;

  wire csr_wr_en = aw_fire && w_fire;
  wire csr_rd_en = ar_fire;

  wire [31:0] wr_addr = sp_resp_i.aw.addr - DMA_BASE_ADDR;
  wire [31:0] rd_addr = sp_resp_i.ar.addr - DMA_BASE_ADDR;

  // ------------------------------------------------------------
  // WRITE LOGIC (RW registers only)
  // ------------------------------------------------------------
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
      START        <= 1'b0;
      INT_EN       <= 1'b0;
      SIZE         <= 32'd0;

      // Sideband reset only (not implemented)
      SRC_STRIDE   <= 12'd0;
      SRC_SCHEME   <= 4'd0;
      DEST_STRIDE  <= 12'd0;
      DEST_SCHEME  <= 4'd0;

      SRC_ADDR_L   <= 32'd0;
      SRC_ADDR_U   <= 32'd0;
      DEST_ADDR_L  <= 32'd0;
      DEST_ADDR_U  <= 32'd0;
    end
    else if (csr_wr_en) begin
      case (wr_addr)

        // 0x000 : DMA_CTRL
        32'h000: begin
          START  <= sp_resp_i.w.data[0];
          INT_EN <= sp_resp_i.w.data[1];
        end

        // 0x008 : DMA_TRANSFER_SIZE
        32'h008: SIZE <= sp_resp_i.w.data;

        // 0x010 : DMA_TRANSFER_SIDEBAND
        // TODO: not implemented

        // Source Address
        32'h020: SRC_ADDR_L <= sp_resp_i.w.data;
        32'h024: SRC_ADDR_U <= sp_resp_i.w.data;

        // Destination Address
        32'h028: DEST_ADDR_L <= sp_resp_i.w.data;
        32'h02C: DEST_ADDR_U <= sp_resp_i.w.data;

        default: ;
      endcase
    end
  end

  // ------------------------------------------------------------
  // READ DATA MUX
  // ------------------------------------------------------------
  always_comb begin
    sp_req_o.r.data = 32'd0;

    case (rd_addr)
      32'h000: sp_req_o.r.data = {30'd0, INT_EN, START};
      32'h004: sp_req_o.r.data = {31'd0, BUSY};
      32'h008: sp_req_o.r.data = SIZE;
      32'h00C: sp_req_o.r.data = REM;

      // 0x010 : SIDE_BAND not implemented – read returns 0

      32'h020: sp_req_o.r.data = SRC_ADDR_L;
      32'h024: sp_req_o.r.data = SRC_ADDR_U;
      32'h028: sp_req_o.r.data = DEST_ADDR_L;
      32'h02C: sp_req_o.r.data = DEST_ADDR_U;

      default: sp_req_o.r.data = 32'd0;
    endcase
  end

  // ------------------------------------------------------------
  // SLAVE RESPONSE GENERATION
  // ------------------------------------------------------------
  always_comb begin
    // Default
    sp_req_o = '0;

    // Always ready (single-beat CSR)
    sp_req_o.aw_ready = 1'b1;
    sp_req_o.w_ready  = 1'b1;
    sp_req_o.ar_ready = 1'b1;

    // Write response
    sp_req_o.b_valid = csr_wr_en;
    sp_req_o.b.resp  = 2'b00;              // TODO

    // Read response
    sp_req_o.r_valid = csr_rd_en;
    sp_req_o.r.resp  = 2'b00;              // TODO
    sp_req_o.r.last  = 1'b1;
  end

  // ------------------------------------------------------------
  // MASTER PORT
  // ------------------------------------------------------------
  // ============================================================
  // DMA CORE (AXI MASTER)
  // ============================================================

  typedef enum logic [2:0] {
    DMA_IDLE,
    DMA_AR,
    DMA_R,
    DMA_AW,
    DMA_W
  } dma_state_e;

  dma_state_e dma_state_q, dma_state_d;

  // Internal working registers
  logic [63:0] src_addr_q;
  logic [63:0] dest_addr_q;
  logic [31:0] data_buf;

  // ------------------------------------------------------------
  // Status back to CSR
  // ------------------------------------------------------------
  assign BUSY = (dma_state_q != DMA_IDLE);

  // ------------------------------------------------------------
  // Sequential logic
  // ------------------------------------------------------------
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
      dma_state_q <= DMA_IDLE;
      REM         <= 32'd0;
      src_addr_q  <= 64'd0;
      dest_addr_q <= 64'd0;
    end else begin
      dma_state_q <= dma_state_d;

      // Latch CSR values on START
      if (dma_state_q == DMA_IDLE && START) begin
        REM         <= SIZE;
        src_addr_q  <= {SRC_ADDR_U,  SRC_ADDR_L};
        dest_addr_q <= {DEST_ADDR_U, DEST_ADDR_L};
      end

      // After each successful write (one word transferred)
      if (dma_state_q == DMA_W && mp_req_i.w_ready) begin
        REM         <= REM - 32'd4;
        src_addr_q  <= src_addr_q + 64'd4;
        dest_addr_q <= dest_addr_q + 64'd4;
      end
    end
  end

  // ------------------------------------------------------------
  // Next-state logic
  // ------------------------------------------------------------
  always_comb begin
    dma_state_d = dma_state_q;

    case (dma_state_q)
      DMA_IDLE: begin
        if (START)
          dma_state_d = DMA_AR;
      end

      DMA_AR: begin
        if (mp_req_i.ar_ready)
          dma_state_d = DMA_R;
      end

      DMA_R: begin
        if (mp_req_i.r_valid)
          dma_state_d = DMA_AW;
      end

      DMA_AW: begin
        if (mp_req_i.aw_ready)
          dma_state_d = DMA_W;
      end

      DMA_W: begin
        if (mp_req_i.w_ready)
          dma_state_d = (REM == 32'd4) ? DMA_IDLE : DMA_AR;
      end

      default: dma_state_d = DMA_IDLE;
    endcase
  end

  // ------------------------------------------------------------
  // AXI MASTER REQUESTS (mp_resp_o)
  // ------------------------------------------------------------
  always_comb begin
    mp_resp_o = '0;

    // -------------------------
    // READ ADDRESS
    // -------------------------
    if (dma_state_q == DMA_AR) begin
      mp_resp_o.ar_valid = 1'b1;
      mp_resp_o.ar.addr  = src_addr_q;
      mp_resp_o.ar.len   = 8'd0;
      mp_resp_o.ar.size  = 3'b010; // 4 bytes
      mp_resp_o.ar.burst = 2'b01;  // INCR
    end

    // -------------------------
    // READ DATA
    // -------------------------
    if (dma_state_q == DMA_R) begin
      mp_resp_o.r_ready = 1'b1;
    end

    // -------------------------
    // WRITE ADDRESS
    // -------------------------
    if (dma_state_q == DMA_AW) begin
      mp_resp_o.aw_valid = 1'b1;
      mp_resp_o.aw.addr  = dest_addr_q;
      mp_resp_o.aw.len   = 8'd0;
      mp_resp_o.aw.size  = 3'b010;
      mp_resp_o.aw.burst = 2'b01;
    end

    // -------------------------
    // WRITE DATA
    // -------------------------
    if (dma_state_q == DMA_W) begin
      mp_resp_o.w_valid = 1'b1;
      mp_resp_o.w.data  = data_buf;
      mp_resp_o.w.strb  = 4'hF;
      mp_resp_o.w.last  = 1'b1;
      mp_resp_o.b_ready = 1'b1;
    end
  end

  // ------------------------------------------------------------
  // Capture read data
  // ------------------------------------------------------------
  always_ff @(posedge clk_i) begin
    if (dma_state_q == DMA_R && mp_req_i.r_valid)
      data_buf <= mp_req_i.r.data;
  end
  
endmodule