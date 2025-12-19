# Detailed Architecture of Hyper-Titan SoC

This document provides an in-depth look into the architecture of the Hyper-Titan System on Chip (SoC). The diagram below illustrates the various components and their interconnections within the SoC.

![Detailed Architecture of Hyper-Titan SoC](svg/detailed_architecture.drawio.svg)

The Hyper-Titan SoC is composed of several key subsystems, each designed to handle specific tasks efficiently. The main components include:

- [Efficiency Core Subsystem](#efficiency-core-subsystem)
- [Performance Core Subsystem](#performance-core-subsystem)
- [Core Link](#core-link)
- [System Link](#system-link)
- [Peripheral Link](#peripheral-link)
- [Memory Subsystem](#memory-subsystem)
- [IO Subsystem](#io-subsystem)
- [APB Bridge](#apb-bridge)

## Hyper-Titan Address Map

| Device                       | Base Address    | Ending Address  |
| ---------------------------- | --------------- | --------------- |
| ITCM_E_CORE                  | 0x0000_0000     | 0x0000_1FFF     |
| [SYS_CTRL](maps/sys_ctrl.md) | 0x0000_2000     | 0x0000_2FFF     |
| CLINT                        | 0x0000_3000     | 0x0000_3FFF     |
| PLIC                         | 0x0000_4000     | 0x0000_4FFF     |
| [UART](maps/uart.md)         | 0x0000_5000     | 0x0000_5FFF     |
| SPI_CSR                      | 0x0000_6000     | 0x0000_6FFF     |
| **RESERVED**                 | **0x0000_7000** | **0x0000_EFFF** |
| [DMA](maps/dma.md)           | 0x0000_F000     | 0x0000_FFFF     |
| DTCM_E_CORE                  | 0x0001_0000     | 0x0001_7FFF     |
| **RESERVED**                 | **0x0001_8000** | **0x0002_FFFF** |
| **CSR RESERVED**             | **0x0003_0000** | **0x07FF_FFFF** |
| DTCM_P_CORE                  | 0x0800_0000     | 0x080F_FFFF     |
| **RESERVED**                 | **0x0810_0000** | **0x08FF_FFFF** |
| BOOT_ROM                     | 0x0900_0000     | 0x0900_FFFF     |
| **RESERVED**                 | **0x0901_0000** | **0x0FFF_FFFF** |
| SPI_MEM                      | 0x1000_0000     | 0x1FFF_FFFF     |
| **RESERVED**                 | **0x2000_0000** | **0x7FFF_FFFF** |
| RAM                          | 0x8000_0000     | 0xFFFF_FFFF     |

_**Figure:** Detailed Architecture of Hyper-Titan SoC_

## Components Description

### Efficiency Core Subsystem

This subsystem is built around the RV32IMF core and its internal memories. A 32-bit RISC-V core optimized for low power consumption, suitable for handling less demanding tasks. The basic specifications are as follows:

- **Clock:** clk_e_core (1-5000 MHz)
- **Reset:** arst_n_e_core
- **Master Interface:** AXI4
- **Slave Interface:** AXI4

#### [Efficiency Core Subsystem Detailed]() TODO: Add link

### Performance Core Subsystem

This subsystem is built around the RV64G core, Tightly Coupled Data Memorie and a Fly-by DMA. A 64-bit RISC-V core designed for high performance, capable of managing compute-intensive workloads. The basic specifications are as follows:

- **Clock:** clk_p_core (1-5000 MHz)
- **Reset:** arst_n_p_core
- **Master Interface:** AXI4
- **Slave Interface:** AXI4

#### [Performance Core Subsystem Detailed]() TODO: Add link

### Core Link

The Core Link module facilitates communication between the Efficiency Core Subsystem and the Performance Core Subsystem. It manages data transfers and synchronization between the two cores, ensuring efficient operation of the SoC. The basic specifications are as follows:

- **Clock:** clk_cl (1-5000 MHz)
- **Reset:** arst_n_cl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 3
- **Number of Master Ports:** 3

#### [Core Link Detailed]() TODO: Add link

### System Link

The System Link module connects the core subsystems to the broader system components, including memory controllers and peripheral interfaces. It handles data routing and arbitration to maintain system performance. The basic specifications are as follows:

- **Clock:** clk_sl (400-3200 MHz)
- **Reset:** arst_n_sl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 2
- **Number of Master Ports:** 4

#### [System Link Detailed]() TODO: Add link

### Peripheral Link

The Peripheral Link module manages communication between the core subsystems and the various peripheral devices integrated into the SoC. It ensures that data is efficiently transferred to and from peripherals. The basic specifications are as follows:

- **Clock:** clk_pl (100 MHz)
- **Reset:** arst_n_pl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 1
- **Number of Master Ports:** 5

#### [Peripheral Link Detailed]() TODO: Add link

### Memory Subsystem

The Memory Subsystem includes an on chip ROM and outbound AXI4 master interfaces to connect to DDR Phy when available. It is responsible for managing memory access and ensuring data integrity. The basic specifications are as follows:

- **Clock:** clk_mem (200-3200 MHz)
- **Reset:** arst_n_mem
- **Interface Type:** AXI4
- **Number of Slave Ports:** 2

#### [Memory Subsystem Detailed]() TODO: Add link

### IO Subsystem

The IO Subsystem provides interfaces for various input/output peripherals such as the UART & SPI. It also house low speed components such as the CLINT, PLIC, System Control CSR. The basic specifications are as follows:

- **Clock:** clk_io (100 MHz)
- **Reset:** arst_n_io
- **Interface Type:** AXI4 Lite
- **Number of Slave Ports:** 5

#### [IO Subsystem Detailed]() TODO: Add link

### APB Bridge

The APB Bridge module grants access to the system bus. It allows an external APB master to communicate with the SoC's internal components. The basic specifications are as follows:

- **Clock:** clk_apb (100 MHz)
- **Reset:** arst_n_apb
- **Interface Type:** AXI4 
- **Number of Master Ports:** 1

#### [APB Bridge Detailed]() TODO: Add link
