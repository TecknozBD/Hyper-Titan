module dummy_tb;

  import dummy_pkg::dummy_function;

  dummy_if dif ();

  `include "dummy_inc.svh"

  initial begin
    dummy_function();
  end

endmodule
