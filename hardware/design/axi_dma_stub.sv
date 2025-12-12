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
    input  sp_resp_t sp_resp_i
);

  assign mp_resp_o = '0;
  assign sp_req_o  = '0;

endmodule
