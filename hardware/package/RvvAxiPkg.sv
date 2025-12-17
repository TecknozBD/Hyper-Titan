//------------------------------------------------------------------------------
// File Name   : RvvAxiPkg.sv
// Project     : RVV Core Mini (AXI-Based)
// Author      : Amit Sikder
// Organization: Technoz
// Date        : December, 2025
// Version     : 1.0
// Description :
//   This package defines AXI4-compatible request/response structures and
//   debug-related data structures used by the RVV Core Mini AXI wrapper
//   and associated verification components.
//
//   The package includes:
//     - AXI Slave and Master channel typedefs (AW, W, B, AR, R)
//     - Packed structs for clean AXI signal bundling
//     - Core debug output aggregation structure
//
//   These typedefs simplify connectivity between the DUT, wrappers,
//   and UVM/verification environments.
//------------------------------------------------------------------------------

`include "axi/typedef.svh"

package RvvAxiPkg;

  `AXI_TYPEDEF_ALL(rvv_axi, logic [31:0], logic [5:0], logic [127:0], logic [15:0], logic [7:0])

  typedef struct packed {
  
    // ----------------------------
    // PC / Instruction trace
    // ----------------------------
    logic [3:0][31:0] addr;  
    logic [3:0][31:0] inst;  
    logic [31:0]      cycles;
  
    // ----------------------------
    // Debug DBUS
    // ----------------------------
    logic             dbus_valid;
    logic [31:0]      dbus_addr;
    logic [127:0]     dbus_wdata;
    logic             dbus_write;
  
    // ----------------------------
    // Dispatch information (4 lanes)
    // ----------------------------
    logic [3:0]        dispatch_instFire;
    logic [3:0][31:0]  dispatch_instAddr;
    logic [3:0][31:0]  dispatch_instInst;
  
    // ----------------------------
    // Regfile write address (0..3)
    // ----------------------------
    logic [3:0]        regfile_waddr_valid;
    logic [3:0][4:0]   regfile_waddr_bits;
  
    // ----------------------------
    // Regfile write data (0..5)
    // ----------------------------
    logic [5:0]        regfile_wdata_valid;
    logic [5:0][4:0]   regfile_wdata_bits_addr;
    logic [5:0][31:0]  regfile_wdata_bits_data;
  
    // ----------------------------
    // Floating-point writeback
    // ----------------------------
    logic        float_writeAddr_valid;
    logic [4:0]  float_writeAddr_bits;
  
    logic        float_writeData_0_valid;
    logic [31:0] float_writeData_0_bits_addr;
    logic [31:0] float_writeData_0_bits_data;
  
    logic        float_writeData_1_valid;
    logic [31:0] float_writeData_1_bits_addr;
    logic [31:0] float_writeData_1_bits_data;
  
  } io_debug_out_t;

  typedef struct packed {
    logic        valid;
    logic [4:0]  addr;
    logic [31:0] data;
  } slog_debug_t;

endpackage
