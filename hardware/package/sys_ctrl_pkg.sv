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
  localparam int REG_E_CORE_CLK_RST = 12'h000;  // Efficiency Core Clock/Reset Control
  localparam int REG_P_CORE_CLK_RST = 12'h004;  // Performance Core Clock/Reset Control
  localparam int REG_CORE_LINK_CLK_RST = 12'h008;  // Core Link Clock/Reset Control
  localparam int REG_SYS_LINK_CLK_RST = 12'h00C;  // System Link Clock/Reset Control
  localparam int REG_PERIPH_LINK_CLK_RST = 12'h010;  // Peripheral Link Clock/Reset Control

  // Boot Configuration Registers
  localparam int REG_BOOT_ADDR_E_CORE = 12'h040;  // E-Core Boot Address
  localparam int REG_BOOT_ADDR_P_CORE = 12'h044;  // P-Core Boot Address
  localparam int REG_BOOT_HARTID_E_CORE = 12'h080;  // E-Core HART_ID
  localparam int REG_BOOT_HARTID_P_CORE = 12'h084;  // P-Core HART_ID

  // PLL Configuration Registers
  localparam int REG_PLL_CFG_E_CORE = 12'h0C0;  // E-Core PLL Configuration
  localparam int REG_PLL_CFG_P_CORE = 12'h0C4;  // P-Core PLL Configuration
  localparam int REG_PLL_CFG_SYS_LINK = 12'h0CC;  // System Link PLL Configuration

endpackage
