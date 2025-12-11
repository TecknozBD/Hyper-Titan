# Hyper-Titan Address Map

| Device                             | Base Address    | Ending Address  |
| ---------------------------------- | --------------- | --------------- |
| **RESERVED**                       | **0x0000_0000** | **0x0000_0FFF** |
| [SYS_CTRL](./reg_maps/sys_ctrl.md) | 0x0000_1000     | 0x0000_1FFF     |
| CLINT                              | 0x0000_2000     | 0x0000_2FFF     |
| PLIC                               | 0x0000_3000     | 0x0000_3FFF     |
| UART                               | 0x0000_4000     | 0x0000_4FFF     |
| DMA                                | 0x0000_5000     | 0x0000_5FFF     |
| SPI_CSR                            | 0x0000_6000     | 0x0000_6FFF     |
| **RESERVED**                       | **0x0000_7000** | **0x07FF_FFFF** |
| TCDM                               | 0x0800_0000     | 0x080F_FFFF     |
| **RESERVED**                       | **0x0810_0000** | **0x08FF_FFFF** |
| BOOT_ROM                           | 0x0900_0000     | 0x0900_FFFF     |
| **RESERVED**                       | **0x0901_0000** | **0x0FFF_FFFF** |
| SPI_MEM                            | 0x1000_0000     | 0x1FFF_FFFF     |
| **RESERVED**                       | **0x2000_0000** | **0x7FFF_FFFF** |
| RAM                                | 0x8000_0000     | 0xFFFF_FFFF     |
