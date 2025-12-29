module delay_gen #(
    parameter int CYCLES = 5
) (
    input  logic arst_ni,
    input  logic rtc_i,
    input  logic clk_i,
    input  logic en_i,
    output logic en_o
);

  logic [$clog2(CYCLES+1)-1:0] counter;
  logic done;

  assign done = (counter == CYCLES);

  always_ff @(posedge rtc_i or negedge arst_ni) begin
    if (~arst_ni) begin
      counter <= '0;
    end else begin
      if (~done) begin
        counter <= counter + 1;
      end
    end
  end

endmodule
