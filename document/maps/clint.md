# Core Local Interruptor (CLINT) Register Map

**Base Address:** `0x0000_3000`

The CLINT provides per-core local interrupt sources:

- **Software interrupts** (MSIP) for inter-core signaling.
- **Timer interrupts** driven by a free-running `MTIME` counter and per-core `MTIMECMP` comparators.

This document follows the same register-description style as `sys_ctrl.md`. If the RTL implementation changes, update the offsets/fields here to match.

| Register Name            | Offset | Description                                 |
| ------------------------ | ------ | ------------------------------------------- |
| CLINT_MSIP_E_CORE        | 0x000  | Software interrupt pending (E core / hart0) |
| CLINT_MSIP_P_CORE        | 0x004  | Software interrupt pending (P core / hart1) |
| CLINT_MTIMECMP_E_CORE_LO | 0x100  | Timer compare low 32 bits (hart0)           |
| CLINT_MTIMECMP_E_CORE_HI | 0x104  | Timer compare high 32 bits (hart0)          |
| CLINT_MTIMECMP_P_CORE_LO | 0x108  | Timer compare low 32 bits (hart1)           |
| CLINT_MTIMECMP_P_CORE_HI | 0x10C  | Timer compare high 32 bits (hart1)          |
| CLINT_MTIME_LO           | 0x200  | Timer counter low 32 bits                   |
| CLINT_MTIME_HI           | 0x204  | Timer counter high 32 bits                  |

## Register Descriptions

### CLINT_MSIP_E_CORE

Offset: 0x000
Description : Software interrupt pending bit for the Efficiency Core (hart0). When set to 1, a machine-mode software interrupt is raised for the target core.

| Bit  | Name     | ACCESS | Reset Value | Description                      |
| ---- | -------- | ------ | ----------- | -------------------------------- |
| 0    | MSIP     | RW     | 0           | 1: set pending, 0: clear pending |
| 31:1 | Reserved | -      | 0           | Reserved                         |

### CLINT_MSIP_P_CORE

Offset: 0x004
Description : Software interrupt pending bit for the Performance Core (hart1). When set to 1, a machine-mode software interrupt is raised for the target core.

| Bit  | Name     | ACCESS | Reset Value | Description                      |
| ---- | -------- | ------ | ----------- | -------------------------------- |
| 0    | MSIP     | RW     | 0           | 1: set pending, 0: clear pending |
| 31:1 | Reserved | -      | 0           | Reserved                         |

### CLINT_MTIMECMP_E_CORE_LO

Offset: 0x100
Description : Low 32 bits of the timer compare value for hart0. A timer interrupt is asserted when `MTIME >= MTIMECMP` for the corresponding core.

| Bit  | Name        | ACCESS | Reset Value | Description                       |
| ---- | ----------- | ------ | ----------- | --------------------------------- |
| 31:0 | MTIMECMP_LO | RW     | 0           | Timer compare value (low 32 bits) |

### CLINT_MTIMECMP_E_CORE_HI

Offset: 0x104
Description : High 32 bits of the timer compare value for hart0.

| Bit  | Name        | ACCESS | Reset Value | Description                        |
| ---- | ----------- | ------ | ----------- | ---------------------------------- |
| 31:0 | MTIMECMP_HI | RW     | 0           | Timer compare value (high 32 bits) |

### CLINT_MTIMECMP_P_CORE_LO

Offset: 0x108
Description : Low 32 bits of the timer compare value for hart1.

| Bit  | Name        | ACCESS | Reset Value | Description                       |
| ---- | ----------- | ------ | ----------- | --------------------------------- |
| 31:0 | MTIMECMP_LO | RW     | 0           | Timer compare value (low 32 bits) |

### CLINT_MTIMECMP_P_CORE_HI

Offset: 0x10C
Description : High 32 bits of the timer compare value for hart1.

| Bit  | Name        | ACCESS | Reset Value | Description                        |
| ---- | ----------- | ------ | ----------- | ---------------------------------- |
| 31:0 | MTIMECMP_HI | RW     | 0           | Timer compare value (high 32 bits) |

### CLINT_MTIME_LO

Offset: 0x200
Description : Low 32 bits of the free-running timer counter.

| Bit  | Name     | ACCESS | Reset Value | Description            |
| ---- | -------- | ------ | ----------- | ---------------------- |
| 31:0 | MTIME_LO | RO     | 0           | Timer counter low word |

### CLINT_MTIME_HI

Offset: 0x204
Description : High 32 bits of the free-running timer counter.

| Bit  | Name     | ACCESS | Reset Value | Description             |
| ---- | -------- | ------ | ----------- | ----------------------- |
| 31:0 | MTIME_HI | RO     | 0           | Timer counter high word |
