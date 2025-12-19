# Hyper-Titan Address Map

| Device                  | Base Address    | Ending Address  |
| ----------------------- | --------------- | --------------- |
| ITCM_E_CORE             | 0x0000_0000     | 0x0000_1FFF     |
| [SYS_CTRL](sys_ctrl.md) | 0x0000_2000     | 0x0000_2FFF     |
| CLINT                   | 0x0000_3000     | 0x0000_3FFF     |
| PLIC                    | 0x0000_4000     | 0x0000_4FFF     |
| [UART](uart.md)         | 0x0000_5000     | 0x0000_5FFF     |
| SPI_CSR                 | 0x0000_6000     | 0x0000_6FFF     |
| **RESERVED**            | **0x0000_7000** | **0x0000_EFFF** |
| [DMA](dma.md)           | 0x0000_F000     | 0x0000_FFFF     |
| DTCM_E_CORE             | 0x0001_0000     | 0x0001_7FFF     |
| **RESERVED**            | **0x0001_8000** | **0x0002_FFFF** |
| **CSR RESERVED**        | **0x0003_0000** | **0x07FF_FFFF** |
| TCDM_P_CORE             | 0x0800_0000     | 0x080F_FFFF     |
| **RESERVED**            | **0x0810_0000** | **0x08FF_FFFF** |
| BOOT_ROM                | 0x0900_0000     | 0x0900_FFFF     |
| **RESERVED**            | **0x0901_0000** | **0x0FFF_FFFF** |
| SPI_MEM                 | 0x1000_0000     | 0x1FFF_FFFF     |
| **RESERVED**            | **0x2000_0000** | **0x7FFF_FFFF** |
| RAM                     | 0x8000_0000     | 0xFFFF_FFFF     |
