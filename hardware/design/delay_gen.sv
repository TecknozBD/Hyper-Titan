// delay_gen.sv
// Generates delayed reset and enable signals using an RTC tick and a clock.
//
// Behavior summary:
// - `reset_counter` counts RTC ticks until `RESET_CYCLES` is reached.
// - When reset is done (`reset_done` asserted), `clock_counter` begins
//   counting RTC ticks until `CLOCK_CYCLES` is reached.
// - `arst_no` is asserted when reset sequencing is complete.
// - `en_o` follows `en_i` gated by `clock_done` (and synchronized to `clk_i`).
module delay_gen #(
    // Number of RTC cycles to wait before indicating reset is complete
    parameter int RESET_CYCLES = 10,
    // Number of RTC cycles to wait after reset_done before enabling outputs
    parameter int CLOCK_CYCLES = 10
) (
    // Active-low asynchronous reset input (external system reset)
    input logic arst_ni,
    // RTC tick / slow clock used to advance the delay counters
    input logic rtc_i,
    // Local clock used to sample/gate the final enable output
    input logic clk_i,
    // Input enable that will be passed through when delays complete
    input logic en_i,

    // Active-high reset output indicating reset sequence completed
    output logic arst_no,
    // Final gated enable output (en_i AND clock_done)
    output logic en_o
);

  // Counter widths chosen to hold the respective cycle counts
  logic [$clog2(RESET_CYCLES+1)-1:0] reset_counter;
  logic [$clog2(CLOCK_CYCLES+1)-1:0] clock_counter;

  // Completion flags derived from the counters
  logic reset_done;
  logic clock_done;

  // Asserted when corresponding counter reached configured cycles
  assign reset_done = (reset_counter == RESET_CYCLES);
  assign clock_done = (clock_counter == CLOCK_CYCLES);

  // Count RTC ticks for reset sequencing.
  // - Triggered on positive edge of `rtc_i`.
  // - Asynchronous clear using external active-low reset `arst_ni`.
  // - Stops incrementing once `reset_done` is reached.
  always_ff @(posedge rtc_i or negedge arst_ni) begin
    if (~arst_ni) begin
      reset_counter <= '0;
    end else begin
      if (~reset_done) begin
        reset_counter <= reset_counter + 1;
      end
    end
  end

  // After `reset_done` is asserted, start counting RTC ticks for the
  // clock staging delay. The use of `negedge reset_done` in the sensitivity
  // list clears `clock_counter` while reset is ongoing.
  always_ff @(posedge rtc_i or negedge reset_done) begin
    if (~reset_done) begin
      clock_counter <= '0;
    end else begin
      if (~clock_done) begin
        clock_counter <= clock_counter + 1;
      end
    end
  end

  // Output an active-high reset-done signal (synchronous with logic that
  // samples `arst_no`). This converts internal counter state to an output
  // that the rest of the system can use.
  assign arst_no = reset_done;

  // Gate the external `en_i` with `clock_done` and register it to `clk_i`.
  // Note: the original code uses `posedge ~clk_i` to create a specific
  // phase relationship with `clk_i` (inversion is intentional to match
  // system timing). The block also uses `arst_ni` as an async clear.
  always_ff @(posedge ~clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      en_o <= '0;
    end else begin
      en_o <= en_i & clock_done;
    end
  end

endmodule
