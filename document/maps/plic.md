# Platform Level Interrupt Controller (PLIC) Memory Map

**Base Address:** `0x0000_4000`

| Register Name | Offset | Description         |
| ------------- | ------ | ------------------- |
| PLIC_CTRL     | 0x000  | PLIC Control        |
| PLIC_CLAIM    | 0x004  | PLIC Claim/Complete |
| PLIC_PRIORITY | 0x100  | Interrupt Priority  |

## Register Descriptions

### PLIC_CTRL

Offset: 0x000
Description: Controls the global settings of the PLIC.

| Bit  | Name      | ACCESS | Reset Value | Description                      |
| ---- | --------- | ------ | ----------- | -------------------------------- |
| 0    | ENABLE    | RW     | 0           | Enable/Disable the PLIC          |
| 1    | THRESHOLD | RW     | 0           | Global interrupt threshold level |
| 31:2 | Reserved  | -      | -           | Reserved                         |

### PLIC_CLAIM

Offset: 0x004
Description: Used to claim and complete interrupts.

| Bit  | Name       | ACCESS | Reset Value | Description                       |
| ---- | ---------- | ------ | ----------- | --------------------------------- |
| 31:0 | CLAIM_COMP | RW     | 0           | Claim an interrupt or complete it |

### PLIC_PRIORITY

Offset: 0x100
Description: Sets the priority for each interrupt source.

| Bit  | Name     | ACCESS | Reset Value | Description                     |
| ---- | -------- | ------ | ----------- | ------------------------------- |
| 3:0  | PRIORITY | RW     | 0           | Priority level of the interrupt |
| 31:4 | Reserved | -      | -           | Reserved                        |
