module apb_2_axil #(
    parameter int  ADDR_WIDTH = 32,
    parameter int  DATA_WIDTH = 32,
    parameter type apb_req_t  = logic,
    parameter type apb_resp_t = logic,
    parameter type aw_chan_t  = logic,
    parameter type w_chan_t   = logic,
    parameter type b_chan_t   = logic,
    parameter type ar_chan_t  = logic,
    parameter type r_chan_t   = logic,
    parameter type axi_req_t  = logic,
    parameter type axi_resp_t = logic
) (

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // APB Slave Interface
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      apb_clk_i,
    input  logic      apb_arst_ni,
    input  apb_req_t  apb_req_i,
    output apb_resp_t apb_resp_o,

    ////////////////////////////////////////////////////////////////////////////////////////////////
    // AXI4-Lite Master Interface Outputs
    ////////////////////////////////////////////////////////////////////////////////////////////////

    input  logic      axi_clk_i,
    input  logic      axi_arst_ni,
    output axi_req_t  axi_req_o,
    input  axi_resp_t axi_resp_i
);

  axi_req_t intr_axi_req;
  axi_resp_t intr_axi_resp;

  logic cst_arst_n;

  axi_cdc #(
      .aw_chan_t (aw_chan_t),
      .w_chan_t  (w_chan_t),
      .b_chan_t  (b_chan_t),
      .ar_chan_t (ar_chan_t),
      .r_chan_t  (r_chan_t),
      .axi_req_t (axi_req_t),
      .axi_resp_t(axi_resp_t),
      .LogDepth  (2),
      .SyncStages(2)
  ) u_axi_cdc (
      .src_clk_i (apb_clk_i),
      .src_rst_ni(apb_arst_ni),
      .src_req_i (intr_axi_req),
      .src_resp_o(intr_axi_resp),
      .dst_clk_i (axi_clk_i),
      .dst_rst_ni(axi_arst_ni),
      .dst_req_o (axi_req_o),
      .dst_resp_i(axi_resp_i)
  );

  typedef enum int {
    IDLE,
    SETUP,
    SEND_AW,
    SEND_W,
    RECV_B,
    SEND_AR,
    RECV_R,
    ACCESS
  } state_t;

  state_t current_state;
  state_t next_state;

  logic   response_clear;
  logic   response_latch_en;

  always_ff @(posedge apb_clk_i or negedge cst_arst_n) begin
    if (~cst_arst_n) begin
      apb_resp_o.prdata  <= '0;
      apb_resp_o.pslverr <= '0;
    end else if (response_latch_en) begin
      apb_resp_o.prdata  <= apb_req_i.pwrite ? intr_axi_req.w.data : intr_axi_resp.r.data;
      apb_resp_o.pslverr <= apb_req_i.pwrite ? intr_axi_resp.b.resp[1] : intr_axi_resp.r.resp[1];
    end else if (response_clear) begin
      apb_resp_o.prdata  <= '0;
      apb_resp_o.pslverr <= '0;
    end
  end

  always_comb intr_axi_req.aw.addr = apb_req_i.paddr;
  always_comb intr_axi_req.aw.prot = '0;

  always_comb intr_axi_req.w.data = apb_req_i.pwdata;
  always_comb intr_axi_req.w.strb = apb_req_i.pstrb;

  always_comb intr_axi_req.ar.addr = apb_req_i.paddr;
  always_comb intr_axi_req.ar.prot = '0;

  always_comb begin

    next_state            = current_state;
    intr_axi_req.aw_valid = '0;
    intr_axi_req.w_valid  = '0;
    intr_axi_req.b_ready  = '0;
    intr_axi_req.ar_valid = '0;
    intr_axi_req.r_ready  = '0;
    response_clear        = '0;
    response_latch_en     = '0;
    apb_resp_o.pready     = '0;

    case (current_state)

      IDLE: begin
        if (apb_req_i.psel && !apb_req_i.penable) begin
          next_state = SETUP;
        end
      end

      SETUP: begin
        response_clear = 1'b1;
        if (apb_req_i.psel && apb_req_i.penable) begin
          if (apb_req_i.pwrite) begin
            next_state = SEND_AW;
          end else begin
            next_state = SEND_AR;
          end
        end
      end

      SEND_AW: begin
        intr_axi_req.aw_valid = 1'b1;
        if (intr_axi_resp.aw_ready) begin
          next_state = SEND_W;
        end
      end

      SEND_W: begin
        intr_axi_req.w_valid = 1'b1;
        if (intr_axi_resp.w_ready) begin
          next_state = RECV_B;
        end
      end

      RECV_B: begin
        intr_axi_req.b_ready = 1'b1;
        response_latch_en = 1'b1;
        if (intr_axi_resp.b_valid) begin
          next_state = ACCESS;
        end
      end

      SEND_AR: begin
        intr_axi_req.ar_valid = 1'b1;
        if (intr_axi_resp.ar_ready) begin
          next_state = RECV_R;
        end
      end

      RECV_R: begin
        intr_axi_req.r_ready = 1'b1;
        response_latch_en = 1'b1;
        if (intr_axi_resp.r_valid) begin
          next_state = ACCESS;
        end
      end

      ACCESS: begin
        apb_resp_o.pready = 1'b1;
        if (!apb_req_i.psel) begin
          next_state = IDLE;
        end else if (!apb_req_i.penable) begin
          next_state = SETUP;
        end
      end

      default: begin
      end

    endcase

  end

  always_comb cst_arst_n = apb_arst_ni & axi_arst_ni;

  always_ff @(posedge apb_clk_i or negedge cst_arst_n) begin
    if (~cst_arst_n) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

endmodule
