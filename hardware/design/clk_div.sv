module clk_div #(
    parameter int DIV_WIDTH = 4
) (
    input logic                 arst_ni,  // active low asynchronous reset
    input logic                 clk_i,    // input clock
    input logic [DIV_WIDTH-1:0] div_i,    // input clock divider

    output logic clk_o  // output clock
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [DIV_WIDTH-1:0] counter_q;  // Current value of the counter
  logic [DIV_WIDTH-1:0] counter_n;  // Next value of the counter
  logic                 toggle_en;  // Enable signal to toggle the output clock

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // This block determines when to toggle the output clock.  The output clock is toggled when the counter reaches 0.
  always_comb toggle_en = (counter_q == '0);

  // This block implements the counter logic.
  always_comb begin
    // If the divisor is 0, reset the counter to 0. This handles the case where no clock division is desired.
    if (div_i == '0) begin
      counter_n = '0;
    end else begin
      // Increment the counter.
      counter_n = counter_q + 1;
      // If the counter reaches the divisor value, reset it to 0.
      if (counter_n >= div_i) begin
        counter_n = '0;
      end
    end
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SEQUENTIALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // This block implements the counter register.
  always @(clk_i or negedge arst_ni) begin
    // Asynchronous reset.
    if (~arst_ni) begin
      counter_q <= '0;
    end else begin
      // Update the counter with the next value.
      counter_q <= counter_n;
    end
  end

  // This block implements the output clock toggle logic.
  always @(clk_i or negedge arst_ni) begin
    // Asynchronous reset.
    if (~arst_ni) begin
      clk_o <= '0;
    end else begin
      // If the toggle enable signal is high, toggle the output clock.
      if (toggle_en) begin
        clk_o <= ~clk_o;
      end
    end
  end

endmodule
