config hyper_titan_tb;
    design work.hyper_titan_tb_top;
    default liblist work;
    instance hyper_titan_tb_top.u_dut.u_e_core_ss liblist rvvcoreminiaxi;
    instance hyper_titan_tb_top.u_dut.u_p_core_ss liblist ariane;
endconfig

module hyper_titan_tb_top;

  logic                              ref_clk_i;
  logic                              glob_arst_ni;
  logic                              apb_clk_i;
  logic                              apb_arst_ni;
  hyper_titan_pkg::apb_req_t         apb_req_i;
  hyper_titan_pkg::apb_resp_t        apb_resp_o;
  logic                              spi_cs_no;
  logic                              spi_sck_o;
  wire                        [ 3:0] spi_sd_io;
  logic                              uart_tx_o;
  logic                              uart_rx_i;
  logic                              ddr3_ck_p_o;
  logic                              ddr3_ck_n_o;
  logic                              ddr3_cke_o;
  logic                              ddr3_reset_n_o;
  logic                              ddr3_ras_n_o;
  logic                              ddr3_cas_n_o;
  logic                              ddr3_we_n_o;
  logic                              ddr3_cs_n_o;
  logic                       [ 2:0] ddr3_ba_o;
  logic                       [13:0] ddr3_addr_o;
  logic                              ddr3_odt_o;
  logic                       [ 1:0] ddr3_dm_o;
  wire                        [ 1:0] ddr3_dqs_p_io;
  wire                        [ 1:0] ddr3_dqs_n_io;
  wire                        [15:0] ddr3_dq_io;

  hyper_titan u_dut (.*);

  initial begin
    $timeformat(-12, 2, "ps", 20);
    fork
      forever begin
        $display("%0t", $realtime);
        #1ps;
      end
    join_none
    $display("Test running...");
    #10ns;
    $finish;
  end

endmodule
