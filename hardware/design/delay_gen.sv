module delay_gen #(
    parameter int RESET_CYCLES = 10,
    parameter int CLOCK_CYCLES = 10
) (
    input logic arst_ni,
    input logic rtc_i,
    input logic clk_i,
    input logic en_i,

    output logic arst_no,
    output logic en_o
);

  logic [$clog2(RESET_CYCLES+1)-1:0] reset_counter;
  logic [$clog2(CLOCK_CYCLES+1)-1:0] clock_counter;

  logic reset_done;
  logic clock_done;

  assign reset_done = (reset_counter == RESET_CYCLES);
  assign clock_done = (clock_counter == CLOCK_CYCLES);

  always_ff @(posedge rtc_i or negedge arst_ni) begin
    if (~arst_ni) begin
      reset_counter <= '0;
    end else begin
      if (~reset_done) begin
        reset_counter <= reset_counter + 1;
      end
    end
  end

  always_ff @(posedge rtc_i or negedge reset_done) begin
    if (~reset_done) begin
      clock_counter <= '0;
    end else begin
      if (~clock_done) begin
        clock_counter <= clock_counter + 1;
      end
    end
  end

  assign arst_no = reset_done;

  always_ff @(posedge ~clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      en_o <= '0;
    end else begin
      en_o <= en_i & clock_done;
    end
  end

endmodule
