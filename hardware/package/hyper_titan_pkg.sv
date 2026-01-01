`include "axi/typedef.svh"

package hyper_titan_pkg;

  import axi_pkg::xbar_cfg_t;
  import axi_pkg::xbar_rule_32_t;

  localparam int GLOBAL_AW = 32;
  localparam int GLOBAL_UW = 8;

  // verilog_format: off

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MEMORY MAP Localparams
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int ITCM_E_CORE_START = 'h0000_0000;
  localparam int ITCM_E_CORE_END   = 'h0000_1FFF;

  localparam int SYS_CTRL_START    = 'h0000_2000;
  localparam int SYS_CTRL_END      = 'h0000_2FFF;

  localparam int CLINT_START       = 'h0000_3000;
  localparam int CLINT_END         = 'h0000_3FFF;

  localparam int PLIC_START        = 'h0000_4000;
  localparam int PLIC_END          = 'h0000_4FFF;

  localparam int UART_START        = 'h0000_5000;
  localparam int UART_END          = 'h0000_5FFF;

  localparam int SPI_CSR_START     = 'h0000_6000;
  localparam int SPI_CSR_END       = 'h0000_6FFF;

  localparam int DMA_START         = 'h0000_F000;
  localparam int DMA_END           = 'h0000_FFFF;

  localparam int DTCM_E_CORE_START = 'h0001_0000;
  localparam int DTCM_E_CORE_END   = 'h0001_7FFF;

  localparam int DTCM_P_CORE_START = 'h0800_0000;
  localparam int DTCM_P_CORE_END   = 'h080F_FFFF;

  localparam int BOOT_ROM_START    = 'h0900_0000;
  localparam int BOOT_ROM_END      = 'h0900_FFFF;

  localparam int SPI_MEM_START     = 'h1000_0000;
  localparam int SPI_MEM_END       = 'h1FFF_FFFF;

  localparam int RAM_START         = 'h8000_0000;
  localparam int RAM_END           = 'hFFFF_FFFF;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // SYSTEM CONTROL REGISTER OFFSETS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int REG_OFFSET_E_CORE_CLK_RST      = 'h000;
  localparam int REG_OFFSET_P_CORE_CLK_RST      = 'h004;
  localparam int REG_OFFSET_CORE_LINK_CLK_RST   = 'h008;
  localparam int REG_OFFSET_SYS_LINK_CLK_RST    = 'h00C;
  localparam int REG_OFFSET_PERIPH_LINK_CLK_RST = 'h010;
  localparam int REG_OFFSET_BOOT_ADDR_E_CORE    = 'h040;
  localparam int REG_OFFSET_BOOT_ADDR_P_CORE    = 'h044;
  localparam int REG_OFFSET_BOOT_HARTID_E_CORE  = 'h080;
  localparam int REG_OFFSET_BOOT_HARTID_P_CORE  = 'h084;
  localparam int REG_OFFSET_PLL_CFG_E_CORE      = 'h0C0;
  localparam int REG_OFFSET_PLL_CFG_P_CORE      = 'h0C4;
  localparam int REG_OFFSET_PLL_CFG_SYS_LINK    = 'h0CC;

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // UART REGISTERS OFFSETS
  ////////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int REG_OFFSET_UART_CTRL          = 'h000;
  localparam int REG_OFFSET_UART_REQ_ID_PUSH   = 'h004;
  localparam int REG_OFFSET_UART_GNT_ID_PEEK   = 'h008;
  localparam int REG_OFFSET_UART_GNT_ID_POP    = 'h00C;
  localparam int REG_OFFSET_UART_CFG           = 'h010;
  localparam int REG_OFFSET_UART_TX_DATA       = 'h014;
  localparam int REG_OFFSET_UART_RX_DATA       = 'h018;
  localparam int REG_OFFSET_UART_RX_DATA_PEEK  = 'h01C;
  localparam int REG_OFFSET_UART_TX_FIFO_COUNT = 'h020;
  localparam int REG_OFFSET_UART_RX_FIFO_COUNT = 'h024;

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // DMA REGISTERS OFFSETS
  ////////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int REG_OFFSET_DMA_CTRL               = 'h000;
  localparam int REG_OFFSET_DMA_STATUS             = 'h004;
  localparam int REG_OFFSET_DMA_TRANSFER_SIZE      = 'h008;
  localparam int REG_OFFSET_DMA_TRANSFER_REMAINING = 'h00C;
  localparam int REG_OFFSET_DMA_TRANSFER_SIDEBAND  = 'h010;
  localparam int REG_OFFSET_DMA_SRC_ADDR_LOWER     = 'h020;
  localparam int REG_OFFSET_DMA_SRC_ADDR_UPPER     = 'h024;
  localparam int REG_OFFSET_DMA_DEST_ADDR_LOWER    = 'h028;
  localparam int REG_OFFSET_DMA_DEST_ADDR_UPPER    = 'h02C;

  // verilog_format: on


  //////////////////////////////////////////////////////////////////////////////////////////////////
  // CORE LINK Localparams
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int CL_NUM_SP = 3;
  localparam int CL_NUM_MP = 3;

  localparam int CL_SP_IW = 2;
  localparam int CL_SP_AW = GLOBAL_AW;
  localparam int CL_SP_UW = GLOBAL_UW;
  localparam int CL_SP_DW = 128;

  localparam int CL_MP_IW = CL_SP_IW + $clog2(CL_NUM_SP);
  localparam int CL_MP_AW = CL_SP_AW;
  localparam int CL_MP_UW = CL_SP_UW;
  localparam int CL_MP_DW = CL_SP_DW;

  `AXI_TYPEDEF_ALL(cl_s_axi, logic [CL_SP_AW-1:0], logic [CL_SP_IW-1:0], logic [CL_SP_DW-1:0],
                   logic [CL_SP_DW/8-1:0], logic [CL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(cl_m_axi, logic [CL_MP_AW-1:0], logic [CL_MP_IW-1:0], logic [CL_MP_DW-1:0],
                   logic [CL_MP_DW/8-1:0], logic [CL_MP_UW-1:0])

  localparam int NUM_CL_RULES = 5;
  localparam xbar_rule_32_t [NUM_CL_RULES-1:0] cl_rules = '{
      '{idx: 0, start_addr: DTCM_E_CORE_START, end_addr: DTCM_E_CORE_END},
      '{idx: 0, start_addr: ITCM_E_CORE_START, end_addr: ITCM_E_CORE_END},
      '{idx: 1, start_addr: DTCM_P_CORE_START, end_addr: DTCM_P_CORE_END}
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
  // SYSTEM LINK Localparams
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int SL_NUM_SP = 2;
  localparam int SL_NUM_MP = 4;

  localparam int SL_SP_IW = 2;
  localparam int SL_SP_AW = GLOBAL_AW;
  localparam int SL_SP_UW = GLOBAL_UW;
  localparam int SL_SP_DW = 64;

  localparam int SL_MP_IW = SL_SP_IW + $clog2(SL_NUM_SP);
  localparam int SL_MP_AW = SL_SP_AW;
  localparam int SL_MP_UW = SL_SP_UW;
  localparam int SL_MP_DW = SL_SP_DW;

  localparam int SL_NUM_SP = 1;
  localparam int SL_NUM_MP = 6;

  `AXI_TYPEDEF_ALL(sl_s_axi, logic [SL_SP_AW-1:0], logic [SL_SP_IW-1:0], logic [SL_SP_DW-1:0],
                   logic [SL_SP_DW/8-1:0], logic [SL_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(sl_m_axi, logic [SL_MP_AW-1:0], logic [SL_MP_IW-1:0], logic [SL_MP_DW-1:0],
                   logic [SL_MP_DW/8-1:0], logic [SL_MP_UW-1:0])

  localparam int NUM_SL_RULES = 11;
  localparam xbar_rule_32_t [NUM_SL_RULES-1:0] cl_rules = '{
      '{idx: 0, start_addr: DMA_START, end_addr: DMA_END},
      '{idx: 0, start_addr: DTCM_E_CORE_START, end_addr: DTCM_E_CORE_END},
      '{idx: 0, start_addr: ITCM_E_CORE_START, end_addr: ITCM_E_CORE_END},
      '{idx: 0, start_addr: DTCM_P_CORE_START, end_addr: DTCM_P_CORE_END},
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
  // PERIPHERAL LINK Localparams
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int PL_NUM_SP = 1;
  localparam int PL_NUM_MP = 5;

  localparam int PL_SP_AW = GLOBAL_AW;
  localparam int PL_SP_DW = 32;

  localparam int PL_MP_AW = PL_SP_AW;
  localparam int PL_MP_DW = PL_SP_DW;

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
  // p_core_ss LINK Localparams
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam int RS_NUM_SP = 3;
  localparam int RS_NUM_MP = 3;

  localparam int RS_SP_IW = 4;
  localparam int RS_SP_AW = 64;
  localparam int RS_SP_UW = 1;
  localparam int RS_SP_DW = 64;

  localparam int RS_MP_IW = RS_SP_IW + $clog2(RS_NUM_SP);
  localparam int RS_MP_AW = RS_SP_AW;
  localparam int RS_MP_UW = RS_SP_UW;
  localparam int RS_MP_DW = RS_SP_DW;

  `AXI_TYPEDEF_ALL(rs_s_axi, logic [RS_SP_AW-1:0], logic [RS_SP_IW-1:0], logic [RS_SP_DW-1:0],
                   logic [RS_SP_DW/8-1:0], logic [RS_SP_UW-1:0])

  `AXI_TYPEDEF_ALL(rs_m_axi, logic [RS_MP_AW-1:0], logic [RS_MP_IW-1:0], logic [RS_MP_DW-1:0],
                   logic [RS_MP_DW/8-1:0], logic [RS_MP_UW-1:0])

  localparam int NUM_RS_RULES = 2;
  localparam xbar_rule_32_t [NUM_RS_RULES-1:0] rs_rules = '{
      '{idx: 0, start_addr: DTCM_P_CORE_START, end_addr: DTCM_P_CORE_END},
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

  //////////////////////////////////////////////////////////////////////////////////////////////////
  // RE-ALIAS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  typedef ec_cl_s_req_t = RvvAxiPkg::rvv_axi_req_t;
  typedef ec_cl_s_resp_t = RvvAxiPkg::rvv_axi_resp_t;

  typedef cl_ec_d_req_t = RvvAxiPkg::rvv_axi_req_t;
  typedef cl_ec_d_resp_t = RvvAxiPkg::rvv_axi_resp_t;

  typedef pc_cl_s_req_t = rs_m_axi_req_t;
  typedef pc_cl_s_resp_t = rs_m_axi_resp_t;

  typedef cl_pc_d_req_t = rs_s_axi_req_t;
  typedef cl_pc_d_resp_t = rs_s_axi_resp_t;

  typedef ec_cl_d_req_t = cl_s_axi_req_t;
  typedef ec_cl_d_resp_t = cl_s_axi_resp_t;

  typedef cl_ec_s_req_t = cl_m_axi_req_t;
  typedef cl_ec_s_resp_t = cl_m_axi_resp_t;

  typedef pc_cl_d_req_t = cl_s_axi_req_t;
  typedef pc_cl_d_resp_t = cl_s_axi_resp_t;

  typedef cl_pc_s_req_t = cl_m_axi_req_t;
  typedef cl_pc_s_resp_t = cl_m_axi_resp_t;

  typedef cl_sl_s_req_t = cl_m_axi_req_t;
  typedef cl_sl_s_resp_t = cl_m_axi_resp_t;

  typedef sl_cl_d_req_t = cl_s_axi_req_t;
  typedef sl_cl_d_resp_t = cl_s_axi_resp_t;

  typedef cl_sl_d_req_t = sl_s_axi_req_t;
  typedef cl_sl_d_resp_t = sl_s_axi_resp_t;

  typedef sl_cl_s_req_t = sl_m_axi_req_t;
  typedef sl_cl_s_resp_t = sl_m_axi_resp_t;

  typedef sl_rom_req_t = sl_m_axi_req_t;
  typedef sl_rom_resp_t = sl_m_axi_resp_t;

  typedef sl_ram_req_t = sl_m_axi_req_t;
  typedef sl_ram_resp_t = sl_m_axi_resp_t;

  typedef ap_sl_req_t = sl_s_axi_req_t;
  typedef ap_sl_resp_t = sl_s_axi_resp_t;

  typedef sl_pl_s_req_t = sl_m_axi_req_t;
  typedef sl_pl_s_resp_t = sl_m_axi_resp_t;

  typedef sl_pl_d_req_t = sl_m_axi_req_t;
  typedef sl_pl_d_resp_t = sl_m_axi_resp_t;

  typedef sl_pl_axil_req_t = pl_s_axil_req_t;
  typedef sl_pl_axil_resp_t = pl_s_axil_resp_t;

  typedef pl_sc_req_t = pl_m_axil_req_t;
  typedef pl_sc_resp_t = pl_m_axil_resp_t;

  typedef pl_sh_req_t = pl_m_axil_req_t;
  typedef pl_sh_resp_t = pl_m_axil_resp_t;

  typedef pl_ur_req_t = pl_m_axil_req_t;
  typedef pl_ur_resp_t = pl_m_axil_resp_t;

  typedef pl_cli_req_t = pl_m_axil_req_t;
  typedef pl_cli_resp_t = pl_m_axil_resp_t;

  typedef pl_pli_req_t = pl_m_axil_req_t;
  typedef pl_pli_resp_t = pl_m_axil_resp_t;

endpackage
