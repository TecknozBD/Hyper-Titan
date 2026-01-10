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
    input  logic clk_i,
    input  logic arst_ni,

    // AXI Master (DMA)
    input  mp_req_t  mp_req_i,
    output mp_resp_t mp_resp_o,

    // AXI Slave (CSR)
    output sp_req_t  sp_req_o,
    input  sp_resp_t sp_resp_i,

    output logic irq_o
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
  // CSR WRITE
  // ------------------------------------------------------------
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
      START       <= 1'b0;
      INT_EN      <= 1'b0;
      SIZE        <= 32'd0;
      SRC_ADDR_L  <= 32'd0;
      SRC_ADDR_U  <= 32'd0;
      DEST_ADDR_L <= 32'd0;
      DEST_ADDR_U <= 32'd0;
    end else if (csr_wr_en) begin
      case (wr_addr)
        32'h000: begin
          START  <= sp_resp_i.w.data[0];
          INT_EN <= sp_resp_i.w.data[1];
        end
        32'h008: SIZE <= sp_resp_i.w.data;
        32'h020: SRC_ADDR_L <= sp_resp_i.w.data;
        32'h024: SRC_ADDR_U <= sp_resp_i.w.data;
        32'h028: DEST_ADDR_L <= sp_resp_i.w.data;
        32'h02C: DEST_ADDR_U <= sp_resp_i.w.data;
        default: ;
      endcase
    end
  end

  // ------------------------------------------------------------
  // CSR READ
  // ------------------------------------------------------------
  always_comb begin
    sp_req_o.r.data = 32'd0;
    case (rd_addr)
      32'h000: sp_req_o.r.data = {30'd0, INT_EN, START};
      32'h004: sp_req_o.r.data = {30'd0, dma_error, BUSY};
      32'h008: sp_req_o.r.data = SIZE;
      32'h00C: sp_req_o.r.data = REM;
      32'h020: sp_req_o.r.data = SRC_ADDR_L;
      32'h024: sp_req_o.r.data = SRC_ADDR_U;
      32'h028: sp_req_o.r.data = DEST_ADDR_L;
      32'h02C: sp_req_o.r.data = DEST_ADDR_U;
      default: ;
    endcase
  end

  // ------------------------------------------------------------
  // CSR AXI responses
  // ------------------------------------------------------------
  always_comb begin
    sp_req_o = '0;
    sp_req_o.aw_ready = 1'b1;
    sp_req_o.w_ready  = 1'b1;
    sp_req_o.ar_ready = 1'b1;
    sp_req_o.b_valid  = csr_wr_en;
    sp_req_o.b.resp   = 2'b00;
    sp_req_o.r_valid  = csr_rd_en;
    sp_req_o.r.resp   = 2'b00;
    sp_req_o.r.last   = 1'b1;
  end

  // ------------------------------------------------------------
  // DMA FSM
  // ------------------------------------------------------------
  typedef enum logic [2:0] {
    DMA_IDLE,
    DMA_AR,
    DMA_R,
    DMA_AW,
    DMA_W
  } dma_state_e;

  dma_state_e dma_state_q, dma_state_d;

  logic [63:0] src_addr_q, dest_addr_q;
  logic [31:0] data_buf;

  logic [7:0]  burst_len_q;
  logic [7:0]  beat_cnt_q;
  logic        last_beat;

  // ------------------------------------------------------------
  // Burst length function
  // ------------------------------------------------------------
  function automatic [7:0] calc_burst_len(input [31:0] bytes);
    if (bytes >= 64)       calc_burst_len = 8'd15;
    else                   calc_burst_len = (bytes >> 2) - 1;
  endfunction

  assign last_beat = (beat_cnt_q == burst_len_q);

  // ------------------------------------------------------------
  // BUSY flag
  // ------------------------------------------------------------
  assign BUSY = (dma_state_q != DMA_IDLE);

  // ------------------------------------------------------------
  // SEQUENTIAL
  // ------------------------------------------------------------
  always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
      dma_state_q <= DMA_IDLE;
      REM         <= 32'd0;
      src_addr_q  <= 64'd0;
      dest_addr_q <= 64'd0;
      beat_cnt_q  <= 8'd0;
      dma_error   <= 1'b0;
    end else begin
      dma_state_q <= dma_state_d;

      if (dma_state_q == DMA_IDLE && START) begin
        REM         <= SIZE;
        src_addr_q  <= {SRC_ADDR_U,  SRC_ADDR_L};
        dest_addr_q <= {DEST_ADDR_U, DEST_ADDR_L};
        burst_len_q <= calc_burst_len(SIZE);
        beat_cnt_q  <= 8'd0;
      end

      if (dma_state_q == DMA_R &&
          mp_req_i.r_valid && mp_resp_o.r_ready) begin
        data_buf <= mp_req_i.r.data;
        if (mp_req_i.r.resp != 2'b00)
          dma_error <= 1'b1;
      end

      if (dma_state_q == DMA_W &&
          mp_resp_o.w_valid && mp_req_i.w_ready) begin
        REM        <= REM - 32'd4;
        src_addr_q <= src_addr_q + 64'd4;
        dest_addr_q <= dest_addr_q + 64'd4;
        beat_cnt_q <= beat_cnt_q + 1'b1;
      end

      if (dma_state_q == DMA_W &&
          mp_req_i.b_valid &&
          mp_req_i.b.resp != 2'b00)
        dma_error <= 1'b1;

      if (dma_state_q == DMA_W &&
          mp_resp_o.w_valid && mp_req_i.w_ready &&
          last_beat) begin
        beat_cnt_q <= 8'd0;
        if (REM <= 32'd64)
          START <= 1'b0;
      end

      if (csr_wr_en && wr_addr == 32'h000)
        dma_error <= 1'b0;
    end
  end

  // ------------------------------------------------------------
  // NEXT STATE
  // ------------------------------------------------------------
  always_comb begin
    dma_state_d = dma_state_q;
    if (dma_error)
      dma_state_d = DMA_IDLE;
    else begin
      case (dma_state_q)
        DMA_IDLE: if (START) dma_state_d = DMA_AR;
        DMA_AR:   if (mp_req_i.ar_ready) dma_state_d = DMA_R;
        DMA_R:    if (mp_req_i.r_valid)  dma_state_d = DMA_AW;
        DMA_AW:   if (mp_req_i.aw_ready) dma_state_d = DMA_W;
        DMA_W: begin
          if (mp_resp_o.w_valid && mp_req_i.w_ready)
            dma_state_d = last_beat ? 
                          ((REM <= 32'd64) ? DMA_IDLE : DMA_AR)
                          : DMA_W;
        end
        default: dma_state_d = DMA_IDLE;
      endcase
    end
  end

  // ------------------------------------------------------------
  // AXI MASTER OUTPUTS
  // ------------------------------------------------------------
  always_comb begin
    mp_resp_o = '0;

    if (dma_state_q == DMA_AR) begin
      mp_resp_o.ar_valid = 1'b1;
      mp_resp_o.ar.addr  = src_addr_q;
      mp_resp_o.ar.len   = burst_len_q;
      mp_resp_o.ar.size  = 3'b010;
      mp_resp_o.ar.burst = 2'b01;
    end

    if (dma_state_q == DMA_R)
      mp_resp_o.r_ready = 1'b1;

    if (dma_state_q == DMA_AW) begin
      mp_resp_o.aw_valid = 1'b1;
      mp_resp_o.aw.addr  = dest_addr_q;
      mp_resp_o.aw.len   = burst_len_q;
      mp_resp_o.aw.size  = 3'b010;
      mp_resp_o.aw.burst = 2'b01;
    end

    if (dma_state_q == DMA_W) begin
      mp_resp_o.w_valid = 1'b1;
      mp_resp_o.w.data  = data_buf;
      mp_resp_o.w.strb  = 4'hF;
      mp_resp_o.w.last  = last_beat;
      mp_resp_o.b_ready = 1'b1;
    end
  end

  // ------------------------------------------------------------
  // INTERRUPT
  // ------------------------------------------------------------
  assign irq_o = INT_EN & (dma_error | (dma_state_q == DMA_IDLE && !START));

endmodule
