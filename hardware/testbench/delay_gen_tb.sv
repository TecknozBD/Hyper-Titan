// delay_gen_tb.sv
// Testbench for `delay_gen` module
// - Drives clocks and reset, toggles `en_i` stimulus
// - Dumps waveform to `delay_gen_tb.vcd` for visual inspection

module delay_gen_tb;

  // Match the DUT parameter used in the test
  localparam int RESET_CYCLES = 5;
  localparam int CLOCK_CYCLES = 3;

  // Testbench signals
  logic clk_i = '0;  // domain clock sampled by DUT (falling-edge in DUT)
  logic arst_ni = '1;  // active-low asynchronous reset
  logic en_i = '0;  // input enable stimulus
  logic rtc_i = '0;  // reference clock used by DUT counter
  logic arst_no;  // DUT output reset
  logic en_o;  // DUT output enable

  // Instantiate DUT with parameterized CYCLES
  delay_gen #(
      .RESET_CYCLES(RESET_CYCLES),
      .CLOCK_CYCLES(CLOCK_CYCLES)
  ) dut (
      .arst_ni(arst_ni),
      .rtc_i  (rtc_i),
      .clk_i  (clk_i),
      .en_i   (en_i),
      .arst_no(arst_no),
      .en_o   (en_o)
  );

  initial begin
    // Waveform dump for GTKWave / post-sim inspection
    $dumpfile("delay_gen_tb.vcd");
    $dumpvars(0, delay_gen_tb);

    // Assert reset briefly at start
    arst_ni <= '0;
    #15ns;
    arst_ni <= '1;

    // Stimulus generators (run in parallel):
    // - rtc_i toggles every 11ns (reference/timebase)
    // - clk_i toggles every 3ns (domain clock sampled by DUT)
    // - en_i toggles every 37ns to exercise enable gating
    // - periodic glitch on arst_ni to exercise reset handling
    fork
      forever #11ns rtc_i <= ~rtc_i;
      forever #3ns clk_i <= ~clk_i;
      forever begin
        // Toggle enable input
        #37ns en_i <= '1;
        #107ns en_i <= '0;
      end
      forever begin
        // Inject occasional asynchronous reset pulse
        #823ns arst_ni <= '0;
        #15ns arst_ni <= '1;
      end
    join_none

    // Run simulation for a fixed time then finish
    #20us;
    $finish;
  end

endmodule
