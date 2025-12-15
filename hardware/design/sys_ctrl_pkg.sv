// ============================================================================
// System Control Package
// ============================================================================
// Description:
//   Package containing register definitions for System Control (SYS_CTRL) peripheral.
//   Base Address: 0x0000_2000
// ============================================================================

package sys_ctrl_pkg;

  // ==========================================================================
  // Register Address Offsets (from base address 0x0000_2000)
  // ==========================================================================
  
  // Clock and Reset Control Registers
  localparam int REG_E_CORE_CLK_RST     = 12'h000;  // Efficiency Core Clock/Reset Control
  localparam int REG_P_CORE_CLK_RST     = 12'h004;  // Performance Core Clock/Reset Control
  localparam int REG_CORE_LINK_CLK_RST  = 12'h008;  // Core Link Clock/Reset Control
  localparam int REG_SYS_LINK_CLK_RST   = 12'h00C;  // System Link Clock/Reset Control
  
  // Boot Configuration Registers
  localparam int REG_BOOT_ADDR_E_CORE   = 12'h040;  // E-Core Boot Address
  localparam int REG_BOOT_ADDR_P_CORE   = 12'h044;  // P-Core Boot Address
  localparam int REG_BOOT_HARTID_E_CORE = 12'h080;  // E-Core HART_ID
  localparam int REG_BOOT_HARTID_P_CORE = 12'h084;  // P-Core HART_ID
  
  // PLL Configuration Registers
  localparam int REG_PLL_CFG_E_CORE     = 12'h0C0;  // E-Core PLL Configuration
  localparam int REG_PLL_CFG_P_CORE     = 12'h0C4;  // P-Core PLL Configuration
  localparam int REG_PLL_CFG_SYS_LINK   = 12'h0CC;  // System Link PLL Configuration

  // ==========================================================================
  // Register Typedefs 
  // ==========================================================================

  // E_CORE_CLK_RST Register - 0x000
  typedef struct packed {
    logic [29:0] Reserved;        // [31:2] Reserved
    logic        RST_N;           // [1] Active low reset for efficiency core
    logic        CLK_EN;          // [0] Enable clock for efficiency core
  } e_core_clk_rst_reg_t;

  // P_CORE_CLK_RST Register - 0x004
  typedef struct packed {
    logic [29:0] Reserved;        // [31:2] Reserved
    logic        RST_N;           // [1] Active low reset for performance core
    logic        CLK_EN;          // [0] Enable clock for performance core
  } p_core_clk_rst_reg_t;

  // CORE_LINK_CLK_RST Register - 0x008
  typedef struct packed {
    logic [29:0] Reserved;        // [31:2] Reserved
    logic        RST_N;           // [1] Active low reset for core link
    logic        Reserved_0;      // [0] Reserved
  } core_link_clk_rst_reg_t;

  // SYS_LINK_CLK_RST Register - 0x00C
  typedef struct packed {
    logic [29:0] Reserved;        // [31:2] Reserved
    logic        RST_N;           // [1] Active low reset for system link
    logic        Reserved_0;      // [0] Reserved
  } sys_link_clk_rst_reg_t;

  // BOOT_ADDR_E_CORE Register - 0x040
  typedef struct packed {
    logic [31:0] ADDR;            // [31:0] Boot address for E core
  } boot_addr_e_core_reg_t;

  // BOOT_ADDR_P_CORE Register - 0x044
  typedef struct packed {
    logic [31:0] ADDR;            // [31:0] Boot address for P core
  } boot_addr_p_core_reg_t;

  // BOOT_HARTID_E_CORE Register - 0x080
  typedef struct packed {
    logic [31:0] HART_ID;         // [31:0] HART_ID for E core
  } boot_hartid_e_core_reg_t;

  // BOOT_HARTID_P_CORE Register - 0x084
  typedef struct packed {
    logic [31:0] HART_ID;         // [31:0] HART_ID for P core
  } boot_hartid_p_core_reg_t;

  // PLL_CFG_E_CORE Register - 0x0C0
  typedef struct packed {
    logic [14:0] Reserved_31_17;  // [31:17] Reserved
    logic        LOCKED;          // [16] PLL lock status (RO)
    logic [11:0] FB_DIV;          // [15:4] Feedback divider value
    logic [3:0]  REF_DIV;         // [3:0] Reference divider value
  } pll_cfg_e_core_reg_t;

  // PLL_CFG_P_CORE Register - 0x0C4
  typedef struct packed {
    logic [14:0] Reserved_31_17;  // [31:17] Reserved
    logic        LOCKED;          // [16] PLL lock status (RO)
    logic [11:0] FB_DIV;          // [15:4] Feedback divider value
    logic [3:0]  REF_DIV;         // [3:0] Reference divider value
  } pll_cfg_p_core_reg_t;

  // PLL_CFG_SYS_LINK Register - 0x0CC
  typedef struct packed {
    logic [14:0] Reserved_31_17;  // [31:17] Reserved
    logic        LOCKED;          // [16] PLL lock status (RO)
    logic [11:0] FB_DIV;          // [15:4] Feedback divider value
    logic [3:0]  REF_DIV;         // [3:0] Reference divider value
  } pll_cfg_sys_link_reg_t;

endpackage