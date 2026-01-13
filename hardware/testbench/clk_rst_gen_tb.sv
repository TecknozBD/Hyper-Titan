// Simple smoke testbench for clk_rst_gen: drives default PLL/divider params and enables.
module clk_rst_gen_tb;

  // DUT IO mirrors
  logic        ref_clk_i;
  logic        glob_arst_ni;
  logic        rtc_o;
  logic [ 3:0] pll_ref_div_e_core_i;
  logic [11:0] pll_fb_div_e_core_i;
  logic        pll_locked_e_core_o;
  logic [ 3:0] pll_ref_div_p_core_i;
  logic [11:0] pll_fb_div_p_core_i;
  logic        pll_locked_p_core_o;
  logic [ 3:0] pll_ref_div_sl_i;
  logic [11:0] pll_fb_div_sl_i;
  logic        pll_locked_sl_o;
  logic        clk_en_e_core_i;
  logic        arst_e_core_ni;
  logic        clk_e_core_o;
  logic        arst_e_core_no;
  logic        clk_en_p_core_i;
  logic        arst_p_core_ni;
  logic        clk_p_core_o;
  logic        arst_p_core_no;
  logic        clk_en_cl_i;
  logic        arst_cl_ni;
  logic        clk_cl_o;
  logic        arst_cl_no;
  logic        clk_src_cl_o;
  logic        clk_en_sl_i;
  logic        arst_sl_ni;
  logic        clk_sl_o;
  logic        arst_sl_no;
  logic        clk_en_pl_i;
  logic        arst_pl_ni;
  logic        clk_pl_o;
  logic        arst_pl_no;

  clk_rst_gen dut (.*);

  // Generate stimulus and collect waveform
  initial begin

    $dumpfile("clk_rst_gen_tb.vcd");
    $dumpvars(0, clk_rst_gen_tb);

    // Default resets low and nominal PLL divide/multiply
    ref_clk_i = 0;
    glob_arst_ni = 0;
    pll_ref_div_e_core_i = 4'd4;
    pll_fb_div_e_core_i = 12'd48;
    pll_ref_div_p_core_i = 4'd4;
    pll_fb_div_p_core_i = 12'd48;
    pll_ref_div_sl_i = 4'd4;
    pll_fb_div_sl_i = 12'd48;
    clk_en_e_core_i = 1'b1;
    arst_e_core_ni = 1'b1;
    clk_en_p_core_i = 1'b1;
    arst_p_core_ni = 1'b1;
    clk_en_cl_i = 1'b1;
    arst_cl_ni = 1'b1;
    clk_en_sl_i = 1'b1;
    arst_sl_ni = 1'b1;
    clk_en_pl_i = 1'b1;
    arst_pl_ni = 1'b1;

    // Release global reset after some cycles
    #100;
    glob_arst_ni = 1;

    // Run for a while and then finish
    #10000;
    $finish;
  end

endmodule
