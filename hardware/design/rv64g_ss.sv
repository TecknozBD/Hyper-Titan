module rv64g_ss #() (
    input logic clk_i,
    input logic arst_ni
);

ariane #(
    .DmBaseAddress (),  // TODO
    .CachedAddrBeg ()  // TODO
) (
    .clk_i(clk_i),
    .rst_ni(arst_ni),

    .boot_addr_i(),   // TODO
    .hart_id_i(),     // TODO
    .irq_i(),         // TODO
    .ipi_i(),         // TODO
    .time_irq_i(),    // TODO
    .debug_req_i(),   // TODO
    .axi_req_o(),     // TODO
    .axi_resp_i()     // TODO
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
    .req_i    (),// TODO
    .resp_o   () // TODO
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
    .clk_i     (clk_i),    // TODO
    .arst_ni   (arst_ni),  // TODO
    .mp_req_i  (),         // TODO
    .mp_resp_o (),         // TODO
    .sp_req_o  (),         // TODO
    .sp_resp_i ()          // TODO
);


module axi_xbar
import cf_math_pkg::idx_width;
#(
  .Cfg                                                    (), //TODO
  . ATOPs                                                 (), //TODO
  .Connectivity                                         (), //TODO
  .slv_aw_chan_t                                        (), //TODO
  .mst_aw_chan_t                                        (), //TODO
  .w_chan_t                                             (), //TODO
  .slv_b_chan_t                                         (), //TODO
  .mst_b_chan_t                                         (), //TODO
  .slv_ar_chan_t                                        (), //TODO
  .mst_ar_chan_t                                        (), //TODO
  .slv_r_chan_t                                         (), //TODO
  .mst_r_chan_t                                         (), //TODO
  .slv_req_t                                            (), //TODO
  .slv_resp_t                                           (), //TODO
  .mst_req_t                                            (), //TODO
  .mst_resp_t                                           (), //TODO
  .rule_t                                               ()  //TODO
  )  
(
  
.clk_i                                                  (clk_i),   //TODO
.rst_ni                                                 (arst_ni), //TODO  
.test_i                                                 (),        //TODO  
.slv_ports_req_i                                        (),        //TODO  
.slv_ports_resp_o                                       (),        //TODO  
.mst_ports_req_o                                        (),        //TODO  
.mst_ports_resp_i                                       (),        //TODO  
.addr_map_i                                             (),        //TODO  
.en_default_mst_port_i                                  (),        //TODO  
.default_mst_port_i
);



endmodule
