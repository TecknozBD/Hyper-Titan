//------------------------------------------------------------------------------
// Author      : Amit Sikder
// Organization: Technoz
// Date        : 14-Dec-2025
// Description :
//   This is a linear (non-UVM) SystemVerilog testbench for the
//   RvvCoreMiniAxi_wrapper module. The testbench is intended for
//   basic bring-up, smoke testing, and functional sanity verification
//   of the RVV Core Mini design.
//
//   The testbench provides the following functionality:
//     - Clock generation with start/stop control
//     - Active-low reset sequencing
//------------------------------------------------------------------------------

config RvvCoreMiniAxi_wrapper_tb_cfg;
    design work.RvvCoreMiniAxi_wrapper_tb;
    default liblist work;
    instance RvvCoreMiniAxi_wrapper_tb.dut.u_core liblist rvvcoreminiaxi;
endconfig


module RvvCoreMiniAxi_wrapper_tb;

  // ------------------------------------------------------------
  // Clock / Reset
  // ------------------------------------------------------------
  logic       io_aclk;
  logic       io_aresetn;

  // ------------------------------------------------------------
  // DUT connections (minimal for linear TB)
  // ------------------------------------------------------------
  logic       io_irq;
  logic       io_te;
  logic       io_halted;
  logic       io_fault;
  logic       io_wfi;
  logic [3:0] io_debug_en;

  // AXI structs
  import RvvAxiPkg::*;

  rvv_axi_req_t  m_axi_req_o;
  rvv_axi_resp_t m_axi_resp_i;

  rvv_axi_req_t  s_axi_req_i;
  rvv_axi_resp_t s_axi_resp_o;

  io_debug_out_t io_debug_out;
  slog_debug_t   slog_debug;

  // ------------------------------------------------------------
  // DUT instantiation
  // ------------------------------------------------------------
  RvvCoreMiniAxi_wrapper dut (
      .io_aclk   (io_aclk),
      .io_aresetn(io_aresetn),

      .m_axi_req_o (m_axi_req_o),
      .m_axi_resp_i(m_axi_resp_i),
      .s_axi_req_i (s_axi_req_i),
      .s_axi_resp_o(s_axi_resp_o),

      .io_debug_out(io_debug_out),
      .slog_debug  (slog_debug),

      .io_irq     (io_irq),
      .io_te      (io_te),
      .io_halted  (io_halted),
      .io_fault   (io_fault),
      .io_wfi     (io_wfi),
      .io_debug_en(io_debug_en)
  );

  // ------------------------------------------------------------
  // Clock control
  // ------------------------------------------------------------
  bit clk_enable;

  initial begin
    io_aclk = 0;
    forever begin
      if (clk_enable) #5 io_aclk = ~io_aclk;
      else #5 io_aclk = io_aclk;
    end
  end

  task start_clock();
    clk_enable = 1;
  endtask

  task stop_clock();
    clk_enable = 0;
  endtask

  // ------------------------------------------------------------
  // Reset task
  // ------------------------------------------------------------
  task apply_reset();
    io_aresetn = 0;
    #100;
    io_aresetn = 1;
  endtask

  // ------------------------------------------------------------
  // Initial sequence (LINEAR FLOW)
  // ------------------------------------------------------------
  initial begin
    // defaults
    $display("%0t ns: Starting RvvCoreMiniAxi_wrapper Linear TB", $stime);
    clk_enable = 0;
    io_irq     = 0;
    io_te      = 0;

    start_clock();
    apply_reset();
    #100;
    stop_clock();

    $display("%0t ns: TB Completed", $stime);
    $finish;
  end

endmodule
