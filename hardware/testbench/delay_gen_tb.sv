module delay_gen_tb;

  localparam int CYCLES = 10;

  logic clk_i;
  logic arst_ni;
  logic en_i;
  logic rtc_i;
  logic en_o;

  // ------------------------------------------------------------
  // DUT instantiation
  // ------------------------------------------------------------
  delay_gen #(
      .CYCLES(CYCLES)
  ) dut (
      .arst_ni(arst_ni),
      .rtc_i  (rtc_i),
      .clk_i  (clk_i),
      .en_i   (en_i),
      .en_o   (en_o)
  );

  initial begin
    $dumpfile("delay_gen_tb.vcd");
    $dumpvars(0, delay_gen_tb);

    clk_i   = 0;
    arst_ni = 0;
    en_i    = 0;
    rtc_i   = 0;

    #15ns arst_ni = 1;
    #10ns en_i = 1;

    repeat (CYCLES + 5) begin
      #10ns rtc_i = 1;
      #10ns rtc_i = 0;
    end

    #20ns $finish;
  end

endmodule
