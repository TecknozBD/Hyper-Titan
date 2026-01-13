# System Control (SYS_CTRL) Register Map

**Base Address:** `0x0000_2000`

| Register Name       | Offset | Description                          |
| ------------------- | ------ | ------------------------------------ |
| E_CORE_CLK_RST      | 0x000  | Efficiency Core Clock Reset Control  |
| P_CORE_CLK_RST      | 0x004  | Performance Core Clock Reset Control |
| CORE_LINK_CLK_RST   | 0x008  | Core Link Clock Reset Control        |
| SYS_LINK_CLK_RST    | 0x00C  | System Link Clock Reset Control      |
| PERIPH_LINK_CLK_RST | 0x010  | Peripheral Link Clock Reset Control  |
| BOOT_ADDR_E_CORE    | 0x040  | Efficiency Core Boot Address         |
| BOOT_ADDR_P_CORE    | 0x044  | Performance Core Boot Address        |
| BOOT_HARTID_E_CORE  | 0x080  | Efficiency Core HART_ID              |
| BOOT_HARTID_P_CORE  | 0x084  | Performance Core HART_ID             |
| PLL_CFG_E_CORE      | 0x0C0  | Efficiency Core PLL Configuration    |
| PLL_CFG_P_CORE      | 0x0C4  | Performance Core PLL Configuration   |
| PLL_CFG_SYS_LINK    | 0x0CC  | System Link PLL Configuration        |
| GPR_0               | 0xFF0  | General Purpose Register 0           |
| GPR_1               | 0xFF4  | General Purpose Register 1           |
| GPR_2               | 0xFF8  | General Purpose Register 2           |
| GPR_3               | 0xFFC  | General Purpose Register 3           |

## Register Descriptions

### E_CORE_CLK_RST

Offset: 0x000
Description : Controls the clock and reset for the efficiency core.

| Bit  | Name     | ACCESS | Reset Value | Description                          |
| ---- | -------- | ------ | ----------- | ------------------------------------ |
| 0    | CLK_EN   | RW     | 0           | Enable clock for efficiency core     |
| 1    | RST_N    | RW     | 1           | Active low reset for efficiency core |
| 31:2 | Reserved | -      | -           | Reserved                             |

### P_CORE_CLK_RST

Offset: 0x004
Description : Controls the clock and reset for the performance core.

| Bit  | Name     | ACCESS | Reset Value | Description                           |
| ---- | -------- | ------ | ----------- | ------------------------------------- |
| 0    | CLK_EN   | RW     | 0           | Enable clock for performance core     |
| 1    | RST_N    | RW     | 1           | Active low reset for performance core |
| 31:2 | Reserved | -      | -           | Reserved                              |

### CORE_LINK_CLK_RST

Offset: 0x008
Description : Controls the clock and reset for the core link.

| Bit  | Name     | ACCESS | Reset Value | Description                    |
| ---- | -------- | ------ | ----------- | ------------------------------ |
| 0    | CLK_EN   | RW     | 1           | Enable clock for core link     |
| 1    | RST_N    | RW     | 1           | Active low reset for core link |
| 2    | SRC_SEL  | RO     | -           | Clock source selection Read    |
| 31:3 | Reserved | -      | -           | Reserved                       |

### SYS_LINK_CLK_RST

Offset: 0x00C
Description : Controls the clock and reset for the system link.

| Bit  | Name     | ACCESS | Reset Value | Description                      |
| ---- | -------- | ------ | ----------- | -------------------------------- |
| 0    | CLK_EN   | RW     | 1           | Enable clock for system link     |
| 1    | RST_N    | RW     | 1           | Active low reset for system link |
| 31:2 | Reserved | -      | -           | Reserved                         |

### PERIPH_LINK_CLK_RST

Offset: 0x010
Description : Controls the clock and reset for the peripheral link.

| Bit  | Name     | ACCESS | Reset Value | Description                          |
| ---- | -------- | ------ | ----------- | ------------------------------------ |
| 0    | CLK_EN   | RO     | 1           | Enable clock for peripheral link     |
| 1    | RST_N    | RW     | 1           | Active low reset for peripheral link |
| 31:2 | Reserved | -      | -           | Reserved                             |

### BOOT_ADDR_E_CORE

Offset: 0x040
Description : Sets the boot address for the efficiency core.

| Bit  | Name | ACCESS | Reset Value | Description             |
| ---- | ---- | ------ | ----------- | ----------------------- |
| 31:0 | ADDR | RW     | 0           | Boot address for E core |

### BOOT_ADDR_P_CORE

Offset: 0x044
Description : Sets the boot address for the performance core.

| Bit  | Name | ACCESS | Reset Value | Description             |
| ---- | ---- | ------ | ----------- | ----------------------- |
| 31:0 | ADDR | RW     | 0           | Boot address for P core |

### BOOT_HARTID_E_CORE

Offset: 0x080
Description : Sets the HART_ID for the efficiency core.

| Bit  | Name    | ACCESS | Reset Value | Description        |
| ---- | ------- | ------ | ----------- | ------------------ |
| 31:0 | HART_ID | RW     | 0           | HART_ID for E core |

### BOOT_HARTID_P_CORE

Offset: 0x084
Description : Sets the HART_ID for the performance core.

| Bit  | Name    | ACCESS | Reset Value | Description        |
| ---- | ------- | ------ | ----------- | ------------------ |
| 31:0 | HART_ID | RW     | 1           | HART_ID for P core |

### PLL_CFG_E_CORE

Offset: 0x0C0
Description : Configuration register for the efficiency core PLL.

| Bit   | Name     | ACCESS | Reset Value | Description             |
| ----- | -------- | ------ | ----------- | ----------------------- |
| 3:0   | REF_DIV  | RW     | 0           | Reference divider value |
| 15:4  | FB_DIV   | RW     | 0           | Feedback divider value  |
| 16    | LOCKED   | RO     | -           | PLL lock status         |
| 31:17 | Reserved | -      | -           | Reserved                |

### PLL_CFG_P_CORE

Offset: 0x0C4
Description : Configuration register for the performance core PLL.

| Bit   | Name     | ACCESS | Reset Value | Description             |
| ----- | -------- | ------ | ----------- | ----------------------- |
| 3:0   | REF_DIV  | RW     | 0           | Reference divider value |
| 15:4  | FB_DIV   | RW     | 0           | Feedback                |
| 16    | LOCKED   | RO     | -           | PLL lock status         |
| 31:17 | Reserved | -      | -           | Reserved                |

### PLL_CFG_SYS_LINK

Offset: 0x0CC
Description : Configuration register for the system link PLL.

| Bit   | Name     | ACCESS | Reset Value | Description             |
| ----- | -------- | ------ | ----------- | ----------------------- |
| 3:0   | REF_DIV  | RW     | 0           | Reference divider value |
| 15:4  | FB_DIV   | RW     | 0           | Feedback                |
| 16    | LOCKED   | RO     | -           | PLL lock status         |
| 31:17 | Reserved | -      | -           | Reserved                |

### General Purpose Registers (GPRs)

Offsets: 0xFF0, 0xFF4, 0xFF8, 0xFFC
Description : Four general purpose registers for miscellaneous use.

| Bit  | Name | ACCESS | Reset Value | Description                |
| ---- | ---- | ------ | ----------- | -------------------------- |
| 31:0 | DATA | RW     | 0           | General purpose data field |
