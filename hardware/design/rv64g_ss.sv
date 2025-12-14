module rv64g_ss #() (
    input logic clk_i,
    input logic arst_ni
);

axi_ram #(
    .MEM_BASE     (), // TODO
    .MEM_SIZE     (), // TODO
    .ALLOW_WRITES (), // TODO
    .req_t        (), // TODO
    .resp_t       ()  // TODO
) u_tcdm (
    .clk_i    (clk_i),
    .arst_ni  (arst_ni),
    .req_i    (),
    .resp_o   ()
);

axi_dma #(
    .mp_aw_chan_t (), // TODO
    .mp_w_chan_t  (), // TODO
    .mp_b_chan_t  (), // TODO
    .mp_ar_chan_t (), // TODO
    .mp_r_chan_t  (), // TODO
    .sp_aw_chan_t (), // TODO
    .sp_w_chan_t  (), // TODO
    .sp_b_chan_t  (), // TODO
    .sp_ar_chan_t (), // TODO
    .sp_r_chan_t  (), // TODO
    .mp_req_t     (), // TODO
    .mp_resp_t    (), // TODO
    .sp_req_t     (), // TODO
    .sp_resp_t    ()  // TODO
) u_dma (
    .clk_i     (clk_i), // TODO
    .arst_ni   (arst_ni), // TODO
    .mp_req_i  (), // TODO
    .mp_resp_o (), // TODO
    .sp_req_o  (), // TODO
    .sp_resp_i () // TODO
);

endmodule
