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


module tb_RvvCoreMiniAxi_wrapper;

  // ------------------------------------------------------------
  // Clock / Reset
  // ------------------------------------------------------------
  logic io_aclk;
  logic io_aresetn;

  // ------------------------------------------------------------
  // DUT connections (minimal for linear TB)
  // ------------------------------------------------------------
  logic        io_irq;
  logic        io_te;
  logic        io_halted;
  logic        io_fault;
  logic        io_wfi;
  logic [3:0]  io_debug_en;

  // AXI structs
  import RvvAxiPkg::*;

  axi_aw_req_t s_aw_req;
  axi_aw_rsp_t s_aw_rsp;
  axi_w_req_t  s_w_req;
  axi_w_rsp_t  s_w_rsp;
  axi_b_req_t  s_b_req;
  axi_b_rsp_t  s_b_rsp;
  axi_ar_req_t s_ar_req;
  axi_ar_rsp_t s_ar_rsp;
  axi_r_req_t  s_r_req;
  axi_r_rsp_t  s_r_rsp;

  axi_aw_req_t m_aw_req;
  axi_aw_rsp_t m_aw_rsp;
  axi_w_req_t  m_w_req;
  axi_w_rsp_t  m_w_rsp;
  axi_b_req_t  m_b_req;
  axi_b_rsp_t  m_b_rsp;
  axi_ar_req_t m_ar_req;
  axi_ar_rsp_t m_ar_rsp;
  axi_r_req_t  m_r_req;
  axi_r_rsp_t  m_r_rsp;

  io_debug_out_t io_debug_out;
  slog_debug_t   slog_debug;

  // ------------------------------------------------------------
  // DUT instantiation
  // ------------------------------------------------------------
  RvvCoreMiniAxi_wrapper dut (
    .io_aclk      (io_aclk),
    .io_aresetn   (io_aresetn),

    .s_aw_req     (s_aw_req),
    .s_aw_rsp     (s_aw_rsp),
    .s_w_req      (s_w_req),
    .s_w_rsp      (s_w_rsp),
    .s_b_req      (s_b_req),
    .s_b_rsp      (s_b_rsp),
    .s_ar_req     (s_ar_req),
    .s_ar_rsp     (s_ar_rsp),
    .s_r_req      (s_r_req),
    .s_r_rsp      (s_r_rsp),

    .m_aw_req     (m_aw_req),
    .m_aw_rsp     (m_aw_rsp),
    .m_w_req      (m_w_req),
    .m_w_rsp      (m_w_rsp),
    .m_b_req      (m_b_req),
    .m_b_rsp      (m_b_rsp),
    .m_ar_req     (m_ar_req),
    .m_ar_rsp     (m_ar_rsp),
    .m_r_req      (m_r_req),
    .m_r_rsp      (m_r_rsp),

    .io_debug_out (io_debug_out),
    .slog_debug  (slog_debug),

    .io_irq      (io_irq),
    .io_te       (io_te),
    .io_halted   (io_halted),
    .io_fault    (io_fault),
    .io_wfi      (io_wfi),
    .io_debug_en (io_debug_en)
  );

  // ------------------------------------------------------------
  // Clock control
  // ------------------------------------------------------------
  bit clk_enable;

  initial begin
    io_aclk = 0;
    forever begin
      if (clk_enable)
        #5 io_aclk = ~io_aclk;
      else
        #5 io_aclk = io_aclk;
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

    s_aw_req = '0;
    s_w_req  = '0;
    s_b_req  = '{ready:1'b1};
    s_ar_req = '0;
    s_r_req  = '{ready:1'b1};

    m_aw_rsp = '{ready:1'b1};
    m_w_rsp  = '{ready:1'b1};
    m_b_rsp  = '0;
    m_ar_rsp = '{ready:1'b1};
    m_r_rsp  = '0;

    start_clock();
    apply_reset();
    #100;
    stop_clock();

    $display("%0t ns: TB Completed", $stime);
    $finish;
  end

endmodule
