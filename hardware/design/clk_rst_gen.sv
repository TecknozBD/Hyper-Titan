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
    // - `rst_e_core_ni`:  E-core reset input (active-low)
    // - `clk_e_core_o`:   E-core generated clock output
    // - `rst_e_core_o`:   E-core reset output (synchronized as needed)
    input  logic clk_en_e_core_i,
    input  logic rst_e_core_ni,
    output logic clk_e_core_o,
    output logic rst_e_core_o,

    // P CORE
    // P-core domain clock enable/reset and outputs
    input  logic clk_en_p_core_i,
    input  logic rst_p_core_ni,
    output logic clk_p_core_o,
    output logic rst_p_core_o,

    // CORE LINK
    // Core-link (interconnect) domain signals
    input  logic clk_en_cl_i,
    input  logic rst_cl_ni,
    output logic clk_cl_o,
    output logic rst_cl_o,

    // SYSTEM LINK
    // System-link domain signals. `clk_src_sl_o` exposes the
    // selected clock source for the system-link domain.
    input  logic clk_en_sl_i,
    input  logic rst_sl_ni,
    output logic clk_sl_o,
    output logic rst_sl_o,
    output logic clk_src_sl_o,

    // PERIPHERAL LINK
    // Peripheral-link domain clock/reset signals
    input  logic clk_en_pl_i,
    input  logic rst_pl_ni,
    output logic clk_pl_o,
    output logic rst_pl_o
);

endmodule
