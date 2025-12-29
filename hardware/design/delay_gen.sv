// Simple delay generator: wait for CYCLES pulses of `rtc_i`, then
// allow `en_o` to follow `en_i` (sampled on the gating clock).
//
// Notes:
// - `arst_ni` is an active-low asynchronous reset.
// - `rtc_i` is the reference/timebase clock used to increment the
//   internal counter. After `CYCLES` pulses `done` becomes true.
// - `en_o` is updated on the positive edge of `~clk_i` (equivalent to
//   the negative edge of `clk_i`) and will be `en_i & done` when not
//   in reset. This intentionally samples `en_i` on the falling edge of
//   `clk_i` (see implementation below).

module delay_gen #(
    parameter int CYCLES = 10
) (
    // Active-low asynchronous reset
    input  logic arst_ni,
    // Reference/timebase clock used for counting delay cycles
    input  logic rtc_i,
    // Domain clock used to sample the output enable; sampled on
    // the falling edge of `clk_i` (see always_ff below)
    input  logic clk_i,
    // Input enable that is passed through to `en_o` once the delay
    // counter has reached `CYCLES`
    input  logic en_i,
    // Output enable asserted when `en_i` is high AND the delay is done
    output logic en_o
);

  // Small counter sized to hold values up to CYCLES
  logic [$clog2(CYCLES+1)-1:0] counter;
  // Pulse that goes true when counter reaches the target
  logic done;

  // done is asserted when counter equals the configured cycle count
  assign done = (counter == CYCLES);

  // Count `rtc_i` pulses. Reset is asynchronous (active-low).
  always_ff @(posedge rtc_i or negedge arst_ni) begin
    if (~arst_ni) begin
      counter <= '0;
    end else begin
      if (~done) begin
        counter <= counter + 1;
      end
    end
  end

  // Drive `en_o` sampled on the falling edge of `clk_i`.
  // Note: `@(posedge ~clk_i)` is equivalent to `@(negedge clk_i)` and
  // is used here to make the sampling domain explicit in the source.
  always_ff @(posedge ~clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      en_o <= '0;
    end else begin
      // Allow en_o only when the delay counter indicates completion
      en_o <= en_i & done;
    end
  end

endmodule
