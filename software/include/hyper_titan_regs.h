#ifndef __GUARD_HYPER_TITAN_REGS_H__
#define __GUARD_HYPER_TITAN_REGS_H__ 0

////////////////////////////////////////////////////////////////////////////////////////////////////
// BASE ADDRESS
////////////////////////////////////////////////////////////////////////////////////////////////////

#define SYS_CTRL_BASE      0x00001000
#define UART_BASE          0x00004000

////////////////////////////////////////////////////////////////////////////////////////////////////
// SYS_CTRL REGISTERS
////////////////////////////////////////////////////////////////////////////////////////////////////

#define REG_E_CORE_CLK_RST     *(volatile int*)(SYS_CTRL_BASE+0x000)
#define REG_P_CORE_CLK_RST     *(volatile int*)(SYS_CTRL_BASE+0x004)
#define REG_CORE_LINK_CLK_RST  *(volatile int*)(SYS_CTRL_BASE+0x008)
#define REG_SYS_LINK_CLK_RST   *(volatile int*)(SYS_CTRL_BASE+0x00C)
#define REG_BOOT_ADDR_E_CORE   *(volatile int*)(SYS_CTRL_BASE+0x040)
#define REG_BOOT_ADDR_P_CORE   *(volatile int*)(SYS_CTRL_BASE+0x044)
#define REG_BOOT_HARTID_E_CORE *(volatile int*)(SYS_CTRL_BASE+0x080)
#define REG_BOOT_HARTID_P_CORE *(volatile int*)(SYS_CTRL_BASE+0x084)
#define REG_PLL_CFG_E_CORE     *(volatile int*)(SYS_CTRL_BASE+0x0C0)
#define REG_PLL_CFG_P_CORE     *(volatile int*)(SYS_CTRL_BASE+0x0C4)
#define REG_PLL_CFG_SYS_LINK   *(volatile int*)(SYS_CTRL_BASE+0x0CC)

////////////////////////////////////////////////////////////////////////////////////////////////////
// UART REGISTERS
////////////////////////////////////////////////////////////////////////////////////////////////////

#define REG_UART_CTRL          *(volatile int*)(UART_BASE+0x000)
#define REG_UART_REQ_ID_PUSH   *(volatile int*)(UART_BASE+0x004)
#define REG_UART_GNT_ID_PEEK   *(volatile int*)(UART_BASE+0x008)
#define REG_UART_GNT_ID_POP    *(volatile int*)(UART_BASE+0x00C)
#define REG_UART_CFG           *(volatile int*)(UART_BASE+0x010)
#define REG_UART_TX_DATA       *(volatile int*)(UART_BASE+0x014)
#define REG_UART_RX_DATA       *(volatile int*)(UART_BASE+0x018)
#define REG_UART_RX_DATA_PEEK  *(volatile int*)(UART_BASE+0x01C)
#define REG_UART_TX_FIFO_COUNT *(volatile int*)(UART_BASE+0x020)
#define REG_UART_RX_FIFO_COUNT *(volatile int*)(UART_BASE+0x024)

#endif
