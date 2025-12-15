//------------------------------------------------------------------------------
// File Name   : RvvCoreWrapper.sv
// Module Name : RvvCoreMiniAxi_wrapper
// Project     : RVV Core Mini (AXI-Based)
// Author      : Amit Sikder
// Organization: Technoz
// Date        : December, 2025
// Version     : 1.0
// Description :
//   This module is a SystemVerilog wrapper around the `rvvcoreminiaxi` DUT.
//   It converts flat AXI signal ports into structured AXI request/response
//   interfaces defined in `RvvAxiPkg`.
//
//   The wrapper provides:
//     - AXI Slave interface adaptation (struct ↔ flat signals)
//     - AXI Master interface adaptation (flat signals ↔ struct)
//     - Aggregation of extensive core debug signals into a single struct
//     - Clean separation between DUT internals and testbench/UVM components
//
//   This wrapper is intended for simulation, verification, and UVM-based
//   environments, while remaining elaboration-safe and synthesis-friendly.
//
// Dependencies:
//   - RvvAxiPkg.sv
//   - rvvcoreminiaxi.sv
//------------------------------------------------------------------------------

module RvvCoreMiniAxi_wrapper
  import RvvAxiPkg::rvv_axi_aw_chan_t;
  import RvvAxiPkg::rvv_axi_w_chan_t;
  import RvvAxiPkg::rvv_axi_b_chan_t;
  import RvvAxiPkg::rvv_axi_ar_chan_t;
  import RvvAxiPkg::rvv_axi_r_chan_t;
  import RvvAxiPkg::rvv_axi_req_t;
  import RvvAxiPkg::rvv_axi_resp_t;
  import RvvAxiPkg::io_debug_out_t;
  import RvvAxiPkg::slog_debug_t;
(
    input logic io_aclk,
    input logic io_aresetn,

    output rvv_axi_req_t m_axi_req_o,
    input  rvv_axi_req_t m_axi_resp_i,

    input  rvv_axi_req_t s_axi_req_i,
    output rvv_axi_req_t s_axi_resp_o,


    output io_debug_out,
    output slog_debug,

    // --------------------------
    // OTHER SIGNALS
    // --------------------------
    input  logic       io_irq,
    input  logic       io_te,
    output logic       io_halted,
    output logic       io_fault,
    output logic       io_wfi,
    output logic [3:0] io_debug_en
);

  import RvvAxiPkg::*;

  // SLOG debug (from DUT)
  logic         dbg_slog_valid;
  logic [  4:0] dbg_slog_addr;
  logic [ 31:0] dbg_slog_data;

  assign slog_debug.valid = dbg_slog_valid;
  assign slog_debug.addr  = dbg_slog_addr;
  assign slog_debug.data  = dbg_slog_data;

  // PC instruction trace
  logic [31:0] dbg_addr_0, dbg_addr_1, dbg_addr_2, dbg_addr_3;
  logic [31:0] dbg_inst_0, dbg_inst_1, dbg_inst_2, dbg_inst_3;
  logic [ 31:0] dbg_cycles;

  // DBUS
  logic         dbg_dbus_valid;
  logic [ 31:0] dbg_dbus_addr;
  logic [127:0] dbg_dbus_wdata;
  logic         dbg_dbus_write;

  // Floating-point debug
  logic         dbg_float_writeAddr_valid;
  logic [  4:0] dbg_float_writeAddr_bits;

  logic         dbg_float_writeData_0_valid;
  logic [ 31:0] dbg_float_writeData_0_bits_addr;
  logic [ 31:0] dbg_float_writeData_0_bits_data;

  logic         dbg_float_writeData_1_valid;
  logic [ 31:0] dbg_float_writeData_1_bits_addr;
  logic [ 31:0] dbg_float_writeData_1_bits_data;

  //---------------------------------------------------------
  // DEBUG SIGNALS
  //---------------------------------------------------------
  // PC / instruction trace
  assign io_debug_out.addr[0] = dbg_addr_0;
  assign io_debug_out.addr[1] = dbg_addr_1;
  assign io_debug_out.addr[2] = dbg_addr_2;
  assign io_debug_out.addr[3] = dbg_addr_3;

  assign io_debug_out.inst[0] = dbg_inst_0;
  assign io_debug_out.inst[1] = dbg_inst_1;
  assign io_debug_out.inst[2] = dbg_inst_2;
  assign io_debug_out.inst[3] = dbg_inst_3;

  assign io_debug_out.cycles = dbg_cycles;

  // DBUS
  assign io_debug_out.dbus_valid = dbg_dbus_valid;
  assign io_debug_out.dbus_addr = dbg_dbus_addr;
  assign io_debug_out.dbus_wdata = dbg_dbus_wdata;
  assign io_debug_out.dbus_write = dbg_dbus_write;

  // ============================================================
  // DEBUG — flat DUT-facing wires
  // ============================================================

  // ----------------------------
  // Dispatch (4 lanes)
  // ----------------------------
  logic [3:0]       dbg_dispatch_instFire;
  logic [3:0][31:0] dbg_dispatch_instAddr;
  logic [3:0][31:0] dbg_dispatch_instInst;

  // ----------------------------
  // Regfile write address (0..3)
  // ----------------------------
  logic [3:0]       dbg_regfile_waddr_valid;
  logic [3:0][ 4:0] dbg_regfile_waddr_bits;

  // ----------------------------
  // Regfile write data (0..5)
  // ----------------------------
  logic [5:0]       dbg_regfile_wdata_valid;
  logic [5:0][ 4:0] dbg_regfile_wdata_bits_addr;
  logic [5:0][31:0] dbg_regfile_wdata_bits_data;

  // Dispatch
  for (genvar i = 0; i < 4; i++) begin
    assign io_debug_out.dispatch_instFire[i] = dbg_dispatch_instFire[i];
    assign io_debug_out.dispatch_instAddr[i] = dbg_dispatch_instAddr[i];
    assign io_debug_out.dispatch_instInst[i] = dbg_dispatch_instInst[i];
  end

  // Regfile write addr
  for (genvar i = 0; i < 4; i++) begin
    assign io_debug_out.regfile_waddr_valid[i] = dbg_regfile_waddr_valid[i];
    assign io_debug_out.regfile_waddr_bits[i]  = dbg_regfile_waddr_bits[i];
  end

  // Regfile write data
  for (genvar i = 0; i < 6; i++) begin
    assign io_debug_out.regfile_wdata_valid[i]     = dbg_regfile_wdata_valid[i];
    assign io_debug_out.regfile_wdata_bits_addr[i] = dbg_regfile_wdata_bits_addr[i];
    assign io_debug_out.regfile_wdata_bits_data[i] = dbg_regfile_wdata_bits_data[i];
  end

  // Float
  assign io_debug_out.float_writeAddr_valid       = dbg_float_writeAddr_valid;
  assign io_debug_out.float_writeAddr_bits        = dbg_float_writeAddr_bits;
  assign io_debug_out.float_writeData_0_valid     = dbg_float_writeData_0_valid;
  assign io_debug_out.float_writeData_0_bits_addr = dbg_float_writeData_0_bits_addr;
  assign io_debug_out.float_writeData_0_bits_data = dbg_float_writeData_0_bits_data;
  assign io_debug_out.float_writeData_1_valid     = dbg_float_writeData_1_valid;
  assign io_debug_out.float_writeData_1_bits_addr = dbg_float_writeData_1_bits_addr;
  assign io_debug_out.float_writeData_1_bits_data = dbg_float_writeData_1_bits_data;


  // ---------------------------------------------------------
  // CORE INSTANTIATION (FULLY CONNECTED)
  // ---------------------------------------------------------
  rvvcoreminiaxi u_core (
      .io_aclk   (io_aclk),
      .io_aresetn(io_aresetn),

      //-------------------------------------------
      // SLAVE AW
      //-------------------------------------------
      .io_axi_slave_write_addr_ready        (s_axi_resp_o.aw_ready),
      .io_axi_slave_write_addr_valid        (s_axi_req_i.aw_valid),
      .io_axi_slave_write_addr_bits_addr    (s_axi_req_i.aw.addr),
      .io_axi_slave_write_addr_bits_prot    (s_axi_req_i.aw.prot),
      .io_axi_slave_write_addr_bits_id      (s_axi_req_i.aw.id),
      .io_axi_slave_write_addr_bits_len     (s_axi_req_i.aw.len),
      .io_axi_slave_write_addr_bits_size    (s_axi_req_i.aw.size),
      .io_axi_slave_write_addr_bits_burst   (s_axi_req_i.aw.burst),
      .io_axi_slave_write_addr_bits_lock    (s_axi_req_i.aw.lock),
      .io_axi_slave_write_addr_bits_cache   (s_axi_req_i.aw.cache),
      .io_axi_slave_write_addr_bits_qos     (s_axi_req_i.aw.qos),
      .io_axi_slave_write_addr_bits_region  (s_axi_req_i.aw.region),

      //-------------------------------------------
      // SLAVE W
      //-------------------------------------------
      .io_axi_slave_write_data_ready        (s_axi_resp_o.w_ready),
      .io_axi_slave_write_data_valid        (s_axi_req_i.w_valid),
      .io_axi_slave_write_data_bits_data    (s_axi_req_i.w.data),
      .io_axi_slave_write_data_bits_last    (s_axi_req_i.w.last),
      .io_axi_slave_write_data_bits_strb    (s_axi_req_i.w.strb),

      //-------------------------------------------
      // SLAVE B
      //-------------------------------------------
      .io_axi_slave_write_resp_ready        (s_axi_req_i.b_ready),
      .io_axi_slave_write_resp_valid        (s_axi_resp_o.b_valid),
      .io_axi_slave_write_resp_bits_id      (s_axi_resp_o.b.id),
      .io_axi_slave_write_resp_bits_resp    (s_axi_resp_o.b.resp),

      //-------------------------------------------
      // SLAVE AR
      //-------------------------------------------
      .io_axi_slave_read_addr_ready         (s_axi_resp_o.ar_ready),
      .io_axi_slave_read_addr_valid         (s_axi_req_i.ar_valid),
      .io_axi_slave_read_addr_bits_addr     (s_axi_req_i.ar.addr),
      .io_axi_slave_read_addr_bits_prot     (s_axi_req_i.ar.prot),
      .io_axi_slave_read_addr_bits_id       (s_axi_req_i.ar.id),
      .io_axi_slave_read_addr_bits_len      (s_axi_req_i.ar.len),
      .io_axi_slave_read_addr_bits_size     (s_axi_req_i.ar.size),
      .io_axi_slave_read_addr_bits_burst    (s_axi_req_i.ar.burst),
      .io_axi_slave_read_addr_bits_lock     (s_axi_req_i.ar.lock),
      .io_axi_slave_read_addr_bits_cache    (s_axi_req_i.ar.cache),
      .io_axi_slave_read_addr_bits_qos      (s_axi_req_i.ar.qos),
      .io_axi_slave_read_addr_bits_region   (s_axi_req_i.ar.region),

      //-------------------------------------------
      // SLAVE R
      //-------------------------------------------
      .io_axi_slave_read_data_ready         (s_axi_req_i.r_ready),
      .io_axi_slave_read_data_valid         (s_axi_resp_o.r_valid),
      .io_axi_slave_read_data_bits_data     (s_axi_resp_o.r.data),
      .io_axi_slave_read_data_bits_id       (s_axi_resp_o.r.id),
      .io_axi_slave_read_data_bits_resp     (s_axi_resp_o.r.resp),
      .io_axi_slave_read_data_bits_last     (s_axi_resp_o.r.last),


      //-------------------------------------------
      // MASTER AW
      //-------------------------------------------
      .io_axi_master_write_addr_ready       (m_axi_resp_i.aw_ready),
      .io_axi_master_write_addr_valid       (m_axi_req_o.aw_valid),
      .io_axi_master_write_addr_bits_addr   (m_axi_req_o.aw.addr),
      .io_axi_master_write_addr_bits_prot   (m_axi_req_o.aw.prot),
      .io_axi_master_write_addr_bits_id     (m_axi_req_o.aw.id),
      .io_axi_master_write_addr_bits_len    (m_axi_req_o.aw.len),
      .io_axi_master_write_addr_bits_size   (m_axi_req_o.aw.size),
      .io_axi_master_write_addr_bits_burst  (m_axi_req_o.aw.burst),
      .io_axi_master_write_addr_bits_lock   (m_axi_req_o.aw.lock),
      .io_axi_master_write_addr_bits_cache  (m_axi_req_o.aw.cache),
      .io_axi_master_write_addr_bits_qos    (m_axi_req_o.aw.qos),
      .io_axi_master_write_addr_bits_region (m_axi_req_o.aw.region),

      //-------------------------------------------
      // MASTER W
      //-------------------------------------------
      .io_axi_master_write_data_ready       (m_axi_resp_i.w_ready),
      .io_axi_master_write_data_valid       (m_axi_req_o.w_valid),
      .io_axi_master_write_data_bits_data   (m_axi_req_o.w.data),
      .io_axi_master_write_data_bits_last   (m_axi_req_o.w.last),
      .io_axi_master_write_data_bits_strb   (m_axi_req_o.w.strb),

      //-------------------------------------------
      // MASTER B
      //-------------------------------------------
      .io_axi_master_write_resp_ready       (m_axi_req_o.b_ready),
      .io_axi_master_write_resp_valid       (m_axi_resp_i.b_valid),
      .io_axi_master_write_resp_bits_id     (m_axi_resp_i.b.id),
      .io_axi_master_write_resp_bits_resp   (m_axi_resp_i.b.resp),

      //-------------------------------------------
      // MASTER AR
      //-------------------------------------------
      .io_axi_master_read_addr_ready        (m_axi_resp_i.ar_ready),
      .io_axi_master_read_addr_valid        (m_axi_req_o.ar_valid),
      .io_axi_master_read_addr_bits_addr    (m_axi_req_o.ar.addr),
      .io_axi_master_read_addr_bits_prot    (m_axi_req_o.ar.prot),
      .io_axi_master_read_addr_bits_id      (m_axi_req_o.ar.id),
      .io_axi_master_read_addr_bits_len     (m_axi_req_o.ar.len),
      .io_axi_master_read_addr_bits_size    (m_axi_req_o.ar.size),
      .io_axi_master_read_addr_bits_burst   (m_axi_req_o.ar.burst),
      .io_axi_master_read_addr_bits_lock    (m_axi_req_o.ar.lock),
      .io_axi_master_read_addr_bits_cache   (m_axi_req_o.ar.cache),
      .io_axi_master_read_addr_bits_qos     (m_axi_req_o.ar.qos),
      .io_axi_master_read_addr_bits_region  (m_axi_req_o.ar.region),

      //-------------------------------------------
      // MASTER R
      //-------------------------------------------
      .io_axi_master_read_data_ready        (m_axi_req_o.r_ready),
      .io_axi_master_read_data_valid        (m_axi_resp_i.r_valid),
      .io_axi_master_read_data_bits_data    (m_axi_resp_i.r.data),
      .io_axi_master_read_data_bits_id      (m_axi_resp_i.r.id),
      .io_axi_master_read_data_bits_resp    (m_axi_resp_i.r.resp),
      .io_axi_master_read_data_bits_last    (m_axi_resp_i.r.last),

      // ------------------------------
      // Other status/debug signals
      // ------------------------------
      .io_irq     (io_irq),
      .io_te      (io_te),
      .io_halted  (io_halted),
      .io_fault   (io_fault),
      .io_wfi     (io_wfi),
      .io_debug_en(io_debug_en),

      .io_slog_valid(dbg_slog_valid),
      .io_slog_addr (dbg_slog_addr),
      .io_slog_data (dbg_slog_data),

      // =========================================================
      // DEBUG: PC / Instruction trace
      // =========================================================
      .io_debug_addr_0(dbg_addr_0),
      .io_debug_addr_1(dbg_addr_1),
      .io_debug_addr_2(dbg_addr_2),
      .io_debug_addr_3(dbg_addr_3),

      .io_debug_inst_0(dbg_inst_0),
      .io_debug_inst_1(dbg_inst_1),
      .io_debug_inst_2(dbg_inst_2),
      .io_debug_inst_3(dbg_inst_3),

      .io_debug_cycles(dbg_cycles),

      // =========================================================
      // DEBUG: DBUS
      // =========================================================
      .io_debug_dbus_valid     (dbg_dbus_valid),
      .io_debug_dbus_bits_addr (dbg_dbus_addr),
      .io_debug_dbus_bits_wdata(dbg_dbus_wdata),
      .io_debug_dbus_bits_write(dbg_dbus_write),

      // =========================================================
      // DEBUG: Dispatch lane 0
      // =========================================================
      .io_debug_dispatch_0_instFire(dbg_dispatch_instFire[0]),
      .io_debug_dispatch_0_instAddr(dbg_dispatch_instAddr[0]),
      .io_debug_dispatch_0_instInst(dbg_dispatch_instInst[0]),

      // =========================================================
      // DEBUG: Dispatch lane 1
      // =========================================================
      .io_debug_dispatch_1_instFire(dbg_dispatch_instFire[1]),
      .io_debug_dispatch_1_instAddr(dbg_dispatch_instAddr[1]),
      .io_debug_dispatch_1_instInst(dbg_dispatch_instInst[1]),

      // =========================================================
      // DEBUG: Dispatch lane 2
      // =========================================================
      .io_debug_dispatch_2_instFire(dbg_dispatch_instFire[2]),
      .io_debug_dispatch_2_instAddr(dbg_dispatch_instAddr[2]),
      .io_debug_dispatch_2_instInst(dbg_dispatch_instInst[2]),

      // =========================================================
      // DEBUG: Dispatch lane 3
      // =========================================================
      .io_debug_dispatch_3_instFire(dbg_dispatch_instFire[3]),
      .io_debug_dispatch_3_instAddr(dbg_dispatch_instAddr[3]),
      .io_debug_dispatch_3_instInst(dbg_dispatch_instInst[3]),

      // =========================================================
      // DEBUG: Regfile write address (0..3)
      // =========================================================
      .io_debug_regfile_writeAddr_0_valid(dbg_regfile_waddr_valid[0]),
      .io_debug_regfile_writeAddr_0_bits (dbg_regfile_waddr_bits[0]),

      .io_debug_regfile_writeAddr_1_valid(dbg_regfile_waddr_valid[1]),
      .io_debug_regfile_writeAddr_1_bits (dbg_regfile_waddr_bits[1]),

      .io_debug_regfile_writeAddr_2_valid(dbg_regfile_waddr_valid[2]),
      .io_debug_regfile_writeAddr_2_bits (dbg_regfile_waddr_bits[2]),

      .io_debug_regfile_writeAddr_3_valid(dbg_regfile_waddr_valid[3]),
      .io_debug_regfile_writeAddr_3_bits (dbg_regfile_waddr_bits[3]),

      // =========================================================
      // DEBUG: Regfile write data (0..5)
      // =========================================================
      .io_debug_regfile_writeData_0_valid    (dbg_regfile_wdata_valid[0]),
      .io_debug_regfile_writeData_0_bits_addr(dbg_regfile_wdata_bits_addr[0]),
      .io_debug_regfile_writeData_0_bits_data(dbg_regfile_wdata_bits_data[0]),

      .io_debug_regfile_writeData_1_valid    (dbg_regfile_wdata_valid[1]),
      .io_debug_regfile_writeData_1_bits_addr(dbg_regfile_wdata_bits_addr[1]),
      .io_debug_regfile_writeData_1_bits_data(dbg_regfile_wdata_bits_data[1]),

      .io_debug_regfile_writeData_2_valid    (dbg_regfile_wdata_valid[2]),
      .io_debug_regfile_writeData_2_bits_addr(dbg_regfile_wdata_bits_addr[2]),
      .io_debug_regfile_writeData_2_bits_data(dbg_regfile_wdata_bits_data[2]),

      .io_debug_regfile_writeData_3_valid    (dbg_regfile_wdata_valid[3]),
      .io_debug_regfile_writeData_3_bits_addr(dbg_regfile_wdata_bits_addr[3]),
      .io_debug_regfile_writeData_3_bits_data(dbg_regfile_wdata_bits_data[3]),

      .io_debug_regfile_writeData_4_valid    (dbg_regfile_wdata_valid[4]),
      .io_debug_regfile_writeData_4_bits_addr(dbg_regfile_wdata_bits_addr[4]),
      .io_debug_regfile_writeData_4_bits_data(dbg_regfile_wdata_bits_data[4]),

      .io_debug_regfile_writeData_5_valid    (dbg_regfile_wdata_valid[5]),
      .io_debug_regfile_writeData_5_bits_addr(dbg_regfile_wdata_bits_addr[5]),
      .io_debug_regfile_writeData_5_bits_data(dbg_regfile_wdata_bits_data[5]),

      // =========================================================
      // DEBUG: Floating-point writeback
      // =========================================================
      .io_debug_float_writeAddr_valid(dbg_float_writeAddr_valid),
      .io_debug_float_writeAddr_bits (dbg_float_writeAddr_bits),

      .io_debug_float_writeData_0_valid    (dbg_float_writeData_0_valid),
      .io_debug_float_writeData_0_bits_addr(dbg_float_writeData_0_bits_addr),
      .io_debug_float_writeData_0_bits_data(dbg_float_writeData_0_bits_data),

      .io_debug_float_writeData_1_valid    (dbg_float_writeData_1_valid),
      .io_debug_float_writeData_1_bits_addr(dbg_float_writeData_1_bits_addr),
      .io_debug_float_writeData_1_bits_data(dbg_float_writeData_1_bits_data)
  );

endmodule
