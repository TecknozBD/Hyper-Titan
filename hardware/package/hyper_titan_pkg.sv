`include "axi/typedef.svh"

package hyper_titan_pkg;

  parameter int GLOBAL_AW = 32;
  parameter int GLOBAL_UW = 8;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MEMORY MAP PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // verilog_format: off
  parameter int ITCM_E_CORE_START = 'h0000_0000;
  parameter int ITCM_E_CORE_END   = 'h0000_1FFF;

  parameter int SYS_CTRL_START    = 'h0000_2000;
  parameter int SYS_CTRL_END      = 'h0000_2FFF;

  parameter int CLINT_START       = 'h0000_3000;
  parameter int CLINT_END         = 'h0000_3FFF;

  parameter int PLIC_START        = 'h0000_4000;
  parameter int PLIC_END          = 'h0000_4FFF;

  parameter int UART_START        = 'h0000_5000;
  parameter int UART_END          = 'h0000_5FFF;

  parameter int SPI_CSR_START     = 'h0000_6000;
  parameter int SPI_CSR_END       = 'h0000_6FFF;

  parameter int DMA_START         = 'h0000_F000;
  parameter int DMA_END           = 'h0000_FFFF;

  parameter int DTCM_E_CORE_START = 'h0001_0000;
  parameter int DTCM_E_CORE_END   = 'h0001_7FFF;

  parameter int TCDM_P_CORE_START = 'h0800_0000;
  parameter int TCDM_P_CORE_END   = 'h080F_FFFF;

  parameter int BOOT_ROM_START    = 'h0900_0000;
  parameter int BOOT_ROM_END      = 'h0900_FFFF;

  parameter int SPI_MEM_START     = 'h1000_0000;
  parameter int SPI_MEM_END       = 'h1FFF_FFFF;

  parameter int RAM_START         = 'h8000_0000;
  parameter int RAM_END           = 'hFFFF_FFFF;
  // verilog_format: on

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
  parameter int CL_MP_AW = CL_SP_AW;
  parameter int CL_MP_UW = CL_SP_UW;
  parameter int CL_MP_DW = CL_SP_DW;

  `AXI_TYPEDEF_ALL(cl_s_axi, logic [CL_SP_AW-1:0], logic [CL_SP_IW-1:0], logic [CL_SP_DW-1:0],
                   logic [CL_SP_DW/8-1:0], logic [CL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(cl_m_axi, logic [CL_MP_AW-1:0], logic [CL_MP_IW-1:0], logic [CL_MP_DW-1:0],
                   logic [CL_MP_DW/8-1:0], logic [CL_MP_UW-1:0])

  localparam int NUM_CL_RULES = 5;
  localparam xbar_rule_32_t [NUM_CL_RULES-1:0] cl_rules = '{
      '{idx: 0, start_addr: DTCM_E_CORE_START, end_addr: DTCM_E_CORE_END},
      '{idx: 0, start_addr: ITCM_E_CORE_START, end_addr: ITCM_E_CORE_END},
      '{idx: 1, start_addr: TCDM_P_CORE_START, end_addr: TCDM_P_CORE_END}
  };
  // DEFAULT 2

  localparam xbar_cfg_t cl_link_cfg = '{
      NoSlvPorts : CL_NUM_SP,
      NoMstPorts : CL_NUM_MP,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: CL_SP_IW,
      AxiIdUsedSlvPorts: CL_SP_IW,
      UniqueIds: 1,
      AxiAddrWidth: CL_SP_AW,
      AxiDataWidth: CL_SP_DW,
      NoAddrRules: NUM_CL_RULES
  };

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
  parameter int SL_MP_AW = SL_SP_AW;
  parameter int SL_MP_UW = SL_SP_UW;
  parameter int SL_MP_DW = SL_SP_DW;

  parameter int SL_NUM_SP = 1;
  parameter int SL_NUM_MP = 6;

  `AXI_TYPEDEF_ALL(sl_s_axi, logic [SL_SP_AW-1:0], logic [SL_SP_IW-1:0], logic [SL_SP_DW-1:0],
                   logic [SL_SP_DW/8-1:0], logic [SL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(sl_m_axi, logic [SL_MP_AW-1:0], logic [SL_MP_IW-1:0], logic [SL_MP_DW-1:0],
                   logic [SL_MP_DW/8-1:0], logic [SL_MP_UW-1:0])

  localparam int NUM_SL_RULES = 11;
  localparam xbar_rule_32_t [NUM_SL_RULES-1:0] cl_rules = '{
      '{idx: 0, start_addr: DMA_START, end_addr: DMA_END},
      '{idx: 0, start_addr: DTCM_E_CORE_START, end_addr: DTCM_E_CORE_END},
      '{idx: 0, start_addr: ITCM_E_CORE_START, end_addr: ITCM_E_CORE_END},
      '{idx: 0, start_addr: TCDM_P_CORE_START, end_addr: TCDM_P_CORE_END},
      '{idx: 1, start_addr: BOOT_ROM_START, end_addr: BOOT_ROM_END},
      '{idx: 3, start_addr: CLINT_START, end_addr: CLINT_END},
      '{idx: 3, start_addr: PLIC_START, end_addr: PLIC_END},
      '{idx: 3, start_addr: SPI_CSR_START, end_addr: SPI_CSR_END},
      '{idx: 3, start_addr: SPI_MEM_START, end_addr: SPI_MEM_END},
      '{idx: 3, start_addr: SYS_CTRL_START, end_addr: SYS_CTRL_END},
      '{idx: 3, start_addr: UART_START, end_addr: UART_END}
  };
  // DEFAULT 2

  localparam xbar_cfg_t sl_link_cfg = '{
      NoSlvPorts : SL_NUM_SP,
      NoMstPorts : SL_NUM_MP,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: SL_SP_IW,
      AxiIdUsedSlvPorts: SL_SP_IW,
      UniqueIds: 1,
      AxiAddrWidth: SL_MP_AW,
      AxiDataWidth: SL_MP_DW,
      NoAddrRules: NUM_SL_RULES
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // PERIPHERAL LINK PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int PL_NUM_SP = 1;
  parameter int PL_NUM_MP = 5;

  parameter int PL_SP_AW = GLOBAL_AW;
  parameter int PL_SP_DW = 32;

  parameter int PL_MP_AW = PL_SP_AW;
  parameter int PL_MP_DW = PL_SP_DW;

  `AXI_LITE_TYPEDEF_ALL(pl_s_axil, logic [PL_SP_AW-1:0], logic [PL_SP_DW-1:0],
                        logic [PL_SP_DW/8-1:0])

  `AXI_LITE_TYPEDEF_ALL(pl_m_axil, logic [PL_MP_AW-1:0], logic [PL_MP_DW-1:0],
                        logic [PL_MP_DW/8-1:0])

  localparam int NUM_PL_RULES = 4;
  localparam xbar_rule_32_t [NUM_PL_RULES-1:0] cl_rules = '{
      '{idx: 0, start_addr: SYS_CTRL_START, end_addr: SYS_CTRL_END},
      '{idx: 2, start_addr: UART_START, end_addr: UART_END},
      '{idx: 3, start_addr: CLINT_START, end_addr: CLINT_END},
      '{idx: 4, start_addr: PLIC_START, end_addr: PLIC_END}
  };
  // DEFAULT 1

  localparam xbar_cfg_t pl_link_cfg = '{
      NoSlvPorts : PL_NUM_SP,
      NoMstPorts : PL_NUM_MP,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: 0,
      AxiIdUsedSlvPorts: 0,
      UniqueIds: 1,
      AxiAddrWidth: PL_MP_AW,
      AxiDataWidth: PL_MP_DW,
      NoAddrRules: NUM_PL_RULES
  };

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
  parameter int RS_MP_AW = RS_SP_AW;
  parameter int RS_MP_UW = RS_SP_UW;
  parameter int RS_MP_DW = RS_SP_DW;

  `AXI_TYPEDEF_ALL(rs_s_axi, logic [RS_SP_AW-1:0], logic [RS_SP_IW-1:0], logic [RS_SP_DW-1:0],
                   logic [RS_SP_DW/8-1:0], logic [RS_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(rs_m_axi, logic [RS_MP_AW-1:0], logic [RS_MP_IW-1:0], logic [RS_MP_DW-1:0],
                   logic [RS_MP_DW/8-1:0], logic [RS_MP_UW-1:0])

  localparam int NUM_RS_RULES = 2;
  localparam xbar_rule_32_t [NUM_RS_RULES-1:0] rs_rules = '{
      '{idx: 0, start_addr: TCDM_P_CORE_START, end_addr: TCDM_P_CORE_END},
      '{idx: 1, start_addr: DMA_START, end_addr: DMA_END}
  };
  // DEFAULT 2

  localparam xbar_cfg_t rs_link_cfg = '{
      NoSlvPorts : RS_NUM_SP,
      NoMstPorts : RS_NUM_MP,
      MaxMstTrans: 2,
      MaxSlvTrans: 2,
      FallThrough: 0,
      LatencyMode: axi_pkg::CUT_ALL_PORTS,
      PipelineStages: 2,
      AxiIdWidthSlvPorts: RS_SP_IW,
      AxiIdUsedSlvPorts: RS_SP_IW,
      UniqueIds: 1,
      AxiAddrWidth: RS_MP_AW,
      AxiDataWidth: RS_MP_DW,
      NoAddrRules: NUM_RS_RULES
  };

endpackage
