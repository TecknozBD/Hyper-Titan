// clk_rst_gen.sv
// Clock and reset generation top-level for Hyper-Titan
// - Handles PLL configuration inputs and lock outputs
// - Exposes clock enables and reset inputs per domain
// - Emits generated clocks, reset outputs and selected clock sources

module clk_rst_gen (

    // Global Inputs
    // - `ref_clk_i`: reference input clock used by PLLs and clocking fabric
    // - `glob_arst_ni`: global asynchronous reset (active-low input)
    input logic ref_clk_i,
    input logic glob_arst_ni,

    output logic rtc_o,  // Real-time clock output (from reference clock)

    // PLL E CORE
    // Configuration and status for the E-core PLL
    // - `pll_ref_div_e_core_i`: reference divider for E-core PLL
    // - `pll_fb_div_e_core_i`: feedback divider for E-core PLL
    // - `pll_locked_e_core_o`: PLL lock status for E-core domain
    input  logic [ 3:0] pll_ref_div_e_core_i,
    input  logic [11:0] pll_fb_div_e_core_i,
    output logic        pll_locked_e_core_o,

    // PLL P CORE
    // Configuration and status for the P-core PLL
    input  logic [ 3:0] pll_ref_div_p_core_i,
    input  logic [11:0] pll_fb_div_p_core_i,
    output logic        pll_locked_p_core_o,

    // PLL SYSTEM LINK
    // Configuration and status for the System-Link PLL
    input  logic [ 3:0] pll_ref_div_sl_i,
    input  logic [11:0] pll_fb_div_sl_i,
    output logic        pll_locked_sl_o,

    // E CORE
    // E-core domain clock enable/reset and outputs
    // - `clk_en_e_core_i`: enable E-core clock
    // - `arst_e_core_ni`:  E-core reset input (active-low)
    // - `clk_e_core_o`:   E-core generated clock output
    // - `arst_e_core_no`:   E-core reset output (synchronized as needed)
    input  logic clk_en_e_core_i,
    input  logic arst_e_core_ni,
    output logic clk_e_core_o,
    output logic arst_e_core_no,

    // P CORE
    // P-core domain clock enable/reset and outputs
    input  logic clk_en_p_core_i,
    input  logic arst_p_core_ni,
    output logic clk_p_core_o,
    output logic arst_p_core_no,

    // CORE LINK
    // Core-link (interconnect) domain signals `clk_src_cl_o` exposes the
    // selected clock source for the core-link domain.
    input  logic clk_en_cl_i,
    input  logic arst_cl_ni,
    output logic clk_cl_o,
    output logic arst_cl_no,
    output logic clk_src_cl_o,

    // SYSTEM LINK
    // System-link domain signals.
    input  logic clk_en_sl_i,
    input  logic arst_sl_ni,
    output logic clk_sl_o,
    output logic arst_sl_no,

    // PERIPHERAL LINK
    // Peripheral-link domain clock/reset signals
    input  logic clk_en_pl_i,
    input  logic arst_pl_ni,
    output logic clk_pl_o,
    output logic arst_pl_no
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // Signal Declarations
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic w_0_4;
  logic w_1_5;
  logic w_2_6;
  logic w_4_3_7_12;
  logic w_5_3_9_14;
  logic w_3_8_13;
  logic w_6_10_15;
  logic w_7_12;
  logic w_12_7;
  logic w_13_8;
  logic w_14_9;
  logic w_15_10;
  logic w_16_11;
  logic w_17_12;
  logic w_18_13;
  logic w_19_14;
  logic w_20_15;
  logic w_21_16;

  logic slow_clk;

  logic [3:0] pll_ref_div_e_core_q;
  logic [11:0] pll_fb_div_e_core_q;
  logic [3:0] pll_ref_div_p_core_q;
  logic [11:0] pll_fb_div_p_core_q;

  logic [11:0] clk_src_cl_d;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // Sub module Instantiations
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always_comb rtc_o = ref_clk_i;

  pll #(
      .REF_DEV_WIDTH(4),
      .FB_DIV_WIDTH (12)
  ) u0 (
      .arst_ni  (glob_arst_ni),
      .clk_ref_i(ref_clk_i),
      .refdiv_i (pll_ref_div_e_core_i),
      .fbdiv_i  (pll_fb_div_e_core_i),
      .clk_o    (w_0_4),
      .locked_o (pll_locked_e_core_o)
  );

  pll #(
      .REF_DEV_WIDTH(4),
      .FB_DIV_WIDTH (12)
  ) u1 (
      .arst_ni  (glob_arst_ni),
      .clk_ref_i(ref_clk_i),
      .refdiv_i (pll_ref_div_p_core_i),
      .fbdiv_i  (pll_fb_div_p_core_i),
      .clk_o    (w_1_5),
      .locked_o (pll_locked_p_core_o)
  );

  pll #(
      .REF_DEV_WIDTH(4),
      .FB_DIV_WIDTH (12)
  ) u2 (
      .arst_ni  (glob_arst_ni),
      .clk_ref_i(ref_clk_i),
      .refdiv_i (pll_ref_div_sl_i),
      .fbdiv_i  (pll_fb_div_sl_i),
      .clk_o    (w_2_6),
      .locked_o (pll_locked_sl_o)
  );

  clk_mux u3 (
      .arst_ni(glob_arst_ni),
      .sel_i  (clk_src_cl_o),
      .clk0_i (w_4_3_7_12),
      .clk1_i (w_5_3_9_14),
      .clk_o  (w_3_8_13)
  );

  clk_gate u4 (
      .arst_ni(glob_arst_ni),
      .en_i   (pll_locked_e_core_o),
      .clk_i  (w_0_4),
      .clk_o  (w_4_3_7_12)
  );

  clk_gate u5 (
      .arst_ni(glob_arst_ni),
      .en_i   (pll_locked_p_core_o),
      .clk_i  (w_1_5),
      .clk_o  (w_5_3_9_14)
  );

  clk_gate u6 (
      .arst_ni(glob_arst_ni),
      .en_i   (pll_locked_sl_o),
      .clk_i  (w_2_6),
      .clk_o  (w_6_10_15)
  );

  clk_gate u7 (
      .arst_ni(arst_e_core_no),
      .en_i   (w_7_12),
      .clk_i  (w_4_3_7_12),
      .clk_o  (clk_e_core_o)
  );

  clk_gate u8 (
      .arst_ni(arst_cl_no),
      .en_i   (w_13_8),
      .clk_i  (w_3_8_13),
      .clk_o  (clk_cl_o)
  );

  clk_gate u9 (
      .arst_ni(arst_p_core_no),
      .en_i   (w_14_9),
      .clk_i  (w_5_3_9_14),
      .clk_o  (clk_p_core_o)
  );

  clk_gate u10 (
      .arst_ni(arst_sl_no),
      .en_i   (w_15_10),
      .clk_i  (w_6_10_15),
      .clk_o  (clk_sl_o)
  );

  clk_gate u11 (
      .arst_ni(arst_pl_no),
      .en_i   (w_16_11),
      .clk_i  (ref_clk_i),
      .clk_o  (clk_pl_o)
  );

  delay_gen #(
      .RESET_CYCLES(10),
      .CLOCK_CYCLES(10)
  ) u12 (
      .arst_ni(w_17_12),
      .rtc_i  (ref_clk_i),
      .clk_i  (w_4_3_7_12),
      .en_i   (clk_en_e_core_i),
      .arst_no(arst_e_core_no),
      .en_o   (w_12_7)
  );

  delay_gen #(
      .RESET_CYCLES(10),
      .CLOCK_CYCLES(10)
  ) u13 (
      .arst_ni(w_18_13),
      .rtc_i  (ref_clk_i),
      .clk_i  (w_3_8_13),
      .en_i   (clk_en_cl_i),
      .arst_no(arst_cl_no),
      .en_o   (w_13_8)
  );

  delay_gen #(
      .RESET_CYCLES(10),
      .CLOCK_CYCLES(10)
  ) u14 (
      .arst_ni(w_19_14),
      .rtc_i  (ref_clk_i),
      .clk_i  (w_5_3_9_14),
      .en_i   (clk_en_p_core_i),
      .arst_no(arst_p_core_no),
      .en_o   (w_14_9)
  );

  delay_gen #(
      .RESET_CYCLES(10),
      .CLOCK_CYCLES(10)
  ) u15 (
      .arst_ni(w_20_15),
      .rtc_i  (ref_clk_i),
      .clk_i  (w_6_10_15),
      .en_i   (clk_en_sl_i),
      .arst_no(arst_sl_no),
      .en_o   (w_15_10)
  );

  delay_gen #(
      .RESET_CYCLES(10),
      .CLOCK_CYCLES(10)
  ) u16 (
      .arst_ni(w_21_16),
      .rtc_i  (ref_clk_i),
      .clk_i  (ref_clk_i),
      .en_i   (clk_en_pl_i),
      .arst_no(arst_pl_no),
      .en_o   (w_16_11)
  );

  always_comb w_17_12 = glob_arst_ni & arst_e_core_ni;

  always_comb w_18_13 = glob_arst_ni & arst_cl_ni;

  always_comb w_19_14 = glob_arst_ni & arst_p_core_ni;

  always_comb w_20_15 = glob_arst_ni & arst_sl_ni;

  always_comb w_21_16 = glob_arst_ni & arst_pl_ni;

  // u22
  clk_div #(
      .DIV_WIDTH(5)
  ) u_clk_div_tx (
      .arst_ni(glob_arst_ni),
      .clk_i  (ref_clk_i),
      .div_i  ('h10),
      .clk_o  (slow_clk)
  );

  // verilog_format: off
  always_comb clk_src_cl_d = (pll_fb_div_p_core_q / pll_ref_div_p_core_q)
                           > (pll_fb_div_e_core_q / pll_ref_div_e_core_q);
  // verilog_format: on

  always_ff @(posedge slow_clk or negedge glob_arst_ni) begin
    if (~glob_arst_ni) begin
      pll_ref_div_e_core_q <= '0;
      pll_fb_div_e_core_q  <= '0;
      pll_ref_div_p_core_q <= '0;
      pll_fb_div_p_core_q  <= '0;
      clk_src_cl_o         <= '0;
    end else begin
      pll_ref_div_e_core_q <= pll_ref_div_e_core_i;
      pll_fb_div_e_core_q  <= pll_ref_div_e_core_i;
      pll_ref_div_p_core_q <= pll_ref_div_e_core_i;
      pll_fb_div_p_core_q  <= pll_ref_div_e_core_i;
      clk_src_cl_o         <= clk_src_cl_d;
    end
  end

endmodule
