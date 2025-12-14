`include "axi/typedef.svh"

package hyper_titan_nocs_pkg;

  parameter int GLOBAL_AW = 32;
  parameter int GLOBAL_UW = 8;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // CORE LINK PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int CL_NUM_SP = 3;
  parameter int CL_NUM_MP = 3;

  parameter int CL_SP_IW = 2;
  parameter int CL_SP_AW = GLOBAL_AW;
  parameter int CL_SP_UW = GLOBAL_UW;
  parameter int CL_SP_DW = 128;

  parameter int CL_MP_IW = CL_SP_IW + $clog2(CL_NUM_SP);
  parameter int CL_MP_AW = GLOBAL_AW;
  parameter int CL_MP_UW = GLOBAL_UW;
  parameter int CL_MP_DW = 128;

  `AXI_TYPEDEF_ALL(cl_s_axi,
    logic [CL_SP_AW-1:0],
    logic [CL_SP_IW-1:0],
    logic [CL_SP_DW-1:0],
    logic [CL_SP_DW/8-1:0],
    logic [CL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(cl_m_axi,
    logic [CL_MP_AW-1:0],
    logic [CL_MP_IW-1:0],
    logic [CL_MP_DW-1:0],
    logic [CL_MP_DW/8-1:0],
    logic [CL_MP_UW-1:0])

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SYSTEM LINK PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int SL_NUM_SP = 2;
  parameter int SL_NUM_MP = 4;

  parameter int SL_SP_IW = 2;
  parameter int SL_SP_AW = GLOBAL_AW;
  parameter int SL_SP_UW = GLOBAL_UW;
  parameter int SL_SP_DW = 64;

  parameter int SL_MP_IW = SL_SP_IW + $clog2(SL_NUM_SP);
  parameter int SL_MP_AW = GLOBAL_AW;
  parameter int SL_MP_UW = GLOBAL_UW;
  parameter int SL_MP_DW = 64;

  parameter int SL_NUM_SP = 1;
  parameter int SL_NUM_MP = 6;

  `AXI_TYPEDEF_ALL(sl_s_axi,
    logic [SL_SP_AW-1:0],
    logic [SL_SP_IW-1:0],
    logic [SL_SP_DW-1:0],
    logic [SL_SP_DW/8-1:0],
    logic [SL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(sl_m_axi,
    logic [SL_MP_AW-1:0],
    logic [SL_MP_IW-1:0],
    logic [SL_MP_DW-1:0],
    logic [SL_MP_DW/8-1:0],
    logic [SL_MP_UW-1:0])

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PERIPHERAL LINK PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int PL_SP_AW = GLOBAL_AW;
  parameter int PL_SP_DW = 32;

  parameter int PL_MP_AW = GLOBAL_AW;
  parameter int PL_MP_DW = 32;

  `AXI_LITE_TYPEDEF_ALL(pl_s_axil,
    logic [PL_SP_AW-1:0],
    logic [PL_SP_DW-1:0],
    logic [PL_SP_DW/8-1:0])

  `AXI_LITE_TYPEDEF_ALL(pl_m_axil,
    logic [PL_MP_AW-1:0],
    logic [PL_MP_DW-1:0],
    logic [PL_MP_DW/8-1:0])

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // RV64G_SS LINK PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int RS_NUM_SP = 3;
  parameter int RS_NUM_MP = 3;

  parameter int RS_SP_IW = 4;
  parameter int RS_SP_AW = 64;
  parameter int RS_SP_UW = 1;
  parameter int RS_SP_DW = 64;

  parameter int RS_MP_IW = RS_SP_IW + $clog2(RS_NUM_SP);
  parameter int RS_MP_AW = 64;
  parameter int RS_MP_UW = 1;
  parameter int RS_MP_DW = 64;

  `AXI_TYPEDEF_ALL(rs_s_axi,
    logic [RS_SP_AW-1:0],
    logic [RS_SP_IW-1:0],
    logic [RS_SP_DW-1:0],
    logic [RS_SP_DW/8-1:0],
    logic [RS_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(rs_m_axi,
    logic [RS_MP_AW-1:0],
    logic [RS_MP_IW-1:0],
    logic [RS_MP_DW-1:0],
    logic [RS_MP_DW/8-1:0],
    logic [RS_MP_UW-1:0])

endpackage
