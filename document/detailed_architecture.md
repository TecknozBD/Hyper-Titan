# Detailed Architecture of Hyper-Titan SoC

This document provides an in-depth look into the architecture of the Hyper-Titan System on Chip (SoC). The Hyper-Titan SoC is a high-performance, energy-efficient platform designed for embedded applications, featuring dual-core RISC-V processors and advanced interconnects. The diagram below illustrates the various components and their interconnections within the SoC.

![Detailed Architecture of Hyper-Titan SoC](svg/detailed_architecture.svg)

_**Figure:** Detailed Architecture of Hyper-Titan SoC_

The Hyper-Titan SoC is composed of several key subsystems, each designed to handle specific tasks efficiently. The main components include:

- [Efficiency Core Subsystem](#efficiency-core-subsystem)
- [Performance Core Subsystem](#performance-core-subsystem)
- [Core Link](#core-link)
- [System Link](#system-link)
- [Peripheral Link](#peripheral-link)
- [Memory Subsystem](#memory-subsystem)
- [IO Subsystem](#io-subsystem)
- [System Control](#system-control)
- [Clock Reset Generator](#clock-reset-generator)
- [APB Bridge](#apb-bridge)
- [AXI to AXI Lite Bridge](#axi-to-axi-lite-bridge)
- [AXI Converter](#axi-converter)

These components are interconnected through advanced AXI-based links, enabling seamless data flow and efficient resource sharing across the SoC. This modular design allows for scalability and optimized performance tailored to specific application needs.

## Subsystems

This section provides a brief, system-level summary of each major subsystem shown in the architecture diagram. For implementation details and signal-level interfaces, follow the corresponding detailed module links.

### Efficiency Core Subsystem

This subsystem is built around the RV32IMF core and its internal memories. It is a 32-bit RISC-V core optimized for low power consumption and suited for less demanding tasks. The basic specifications are as follows:

- **Clock:** clk_e_core (1-5000 MHz)
- **Reset:** arst_n_e_core
- **Master Interface:** AXI4
- **Slave Interface:** AXI4

#### [Efficiency Core Subsystem Detailed](modules/e_core_ss.md)

### Performance Core Subsystem

This subsystem is built around the RV64G core, tightly coupled data memories, and a fly-by DMA. It is a 64-bit RISC-V core designed for high performance and capable of managing compute-intensive workloads. The basic specifications are as follows:

- **Clock:** clk_p_core (1-5000 MHz)
- **Reset:** arst_n_p_core
- **Master Interface:** AXI4
- **Slave Interface:** AXI4

#### [Performance Core Subsystem Detailed](modules/p_core_ss.md)

### Core Link

The Core Link module facilitates communication between the Efficiency Core Subsystem and the Performance Core Subsystem. It manages data transfers and synchronization between the two cores, ensuring efficient operation of the SoC. The basic specifications are as follows:

- **Clock:** clk_cl (1-5000 MHz)
- **Reset:** arst_n_cl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 3
- **Number of Master Ports:** 3

#### [Core Link Detailed](modules/cl.md)

### System Link

The System Link module connects the core subsystems to the broader system components, including memory controllers and peripheral interfaces. It handles data routing and arbitration to maintain system performance. The basic specifications are as follows:

- **Clock:** clk_sl (100-3200 MHz)
- **Reset:** arst_n_sl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 2
- **Number of Master Ports:** 4

#### [System Link Detailed](modules/sl.md)

### Peripheral Link

The Peripheral Link module manages communication between the core subsystems and the various peripheral devices integrated into the SoC. It ensures that data is efficiently transferred to and from peripherals. The basic specifications are as follows:

- **Clock:** clk_pl (100 MHz)
- **Reset:** arst_n_pl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 1
- **Number of Master Ports:** 4

#### [Peripheral Link Detailed](modules/pl.md)

### Memory Subsystem

The Memory Subsystem includes an on-chip ROM and outbound AXI4 master interfaces to connect to a DDR3 PHY. It is responsible for managing memory access and ensuring data integrity. The basic specifications are as follows:

- **Clock:** clk_sl (100-3200 MHz)
- **Reset:** arst_n_sl
- **Interface Type:** AXI4
- **Number of Slave Ports:** 2

#### [Memory Subsystem Detailed](modules/mem_ss.md)

### IO Subsystem

The IO Subsystem provides interfaces for low-speed peripherals such as UART and SPI. It also houses system components such as the CLINT, PLIC. The basic specifications are as follows:

- **Clock:** clk_pl (100 MHz)
- **Reset:** arst_n_pl
- **Interface Type:** AXI4 Lite
- **Number of Slave Ports:** 4

#### [IO Subsystem Detailed](modules/io_ss.md)

### APB Bridge

The APB Bridge module grants access to the system bus. It allows an external APB master to communicate with the SoC's internal components. The basic specifications are as follows:

- **Clock:** clk_apb & clk_sl (100-3200 MHz)
- **Reset:** arst_n_apb & arst_n_sl
- **Interface Type:** APB3 & AXI4
- **Number of Master Ports:** 1 (APB3)
- **Number of Slave Ports:** 1 (AXI4)

#### [APB Bridge Detailed](modules/apb_bridge.md)

### System Control

The System Control module manages system-level functions and configurations, including clock management, reset control, and power management. It ensures the proper operation of the SoC by coordinating various subsystems. The basic specifications are as follows:

- **Clock:** clk_sl (100 MHz)
- **Reset:** arst_n_pl

#### [System Control Detailed](modules/sys_ctrl.md)

### Clock Reset Generator

The Clock Reset Generator module is responsible for generating and distributing clock and reset signals throughout the SoC. It ensures that all components operate synchronously and can be reset appropriately. The basic specifications are as follows:

- **Input Clock:** ref_clk_i (100 MHz)
- **Input Reset:** glob_arst_n_i

#### [Clock Reset Generator Detailed](modules/crg.md)

### AXI 2 AXI Lite Bridge

The AXI to AXI Lite Bridge module converts AXI4 transactions to AXI4 Lite transactions. This is essential for interfacing high-performance components with low-speed peripherals. The basic specifications are as follows:

- **Clock:** clk_sl (100-3200 MHz)
- **Reset:** arst_n_sl
- **Interface Type:** AXI4 & AXI4 Lite
- **Number of Master Ports:** 1 (AXI4)
- **Number of Master Ports:** 1 (AXI4 Lite)

#### [AXI to AXI Lite Bridge Detailed](modules/axi2axil.md)

### AXI Converter

The AXI Converter module translates between different AXI4 protocols, enabling compatibility between diverse ID, Address, and Data widths. The basic specifications are as follows:

- **Interface Type:** AXI4
- **Number of Master Ports:** 1
- **Number of Slave Ports:** 1

#### [AXI Converter Detailed](modules/axi_converter.md)

## Ports

The Hyper-Titan SoC features a variety of ports to facilitate communication with external components and systems. Below is a summary of the primary ports available on the SoC:

| Port Name      | Type   | Direction | Description                                        |
| -------------- | ------ | --------- | -------------------------------------------------- |
| ref_clk_i      | Input  | Input     | Global reference clock                             |
| glob_arst_ni   | Input  | Input     | Global asynchronous reset (active low)             |
| apb_clk_i      | Input  | Input     | APB system control clock                           |
| apb_arst_ni    | Input  | Input     | APB system control asynchronous reset (active low) |
| apb_req_i      | Input  | Input     | APB request interface                              |
| apb_resp_o     | Output | Output    | APB response interface                             |
| spi_cs_no      | Output | Output    | SPI flash chip select (active low)                 |
| spi_sck_o      | Output | Output    | SPI flash serial clock                             |
| spi_sd_io      | Inout  | Inout     | SPI flash serial data (4-bit)                      |
| uart_tx_o      | Output | Output    | UART console transmit                              |
| uart_rx_i      | Input  | Input     | UART console receive                               |
| ddr3_ck_p_o    | Output | Output    | DDR3 PHY clock positive                            |
| ddr3_ck_n_o    | Output | Output    | DDR3 PHY clock negative                            |
| ddr3_cke_o     | Output | Output    | DDR3 PHY clock enable                              |
| ddr3_reset_n_o | Output | Output    | DDR3 PHY reset (active low)                        |
| ddr3_ras_n_o   | Output | Output    | DDR3 PHY row address strobe (active low)           |
| ddr3_cas_n_o   | Output | Output    | DDR3 PHY column address strobe (active low)        |
| ddr3_we_n_o    | Output | Output    | DDR3 PHY write enable (active low)                 |
| ddr3_cs_n_o    | Output | Output    | DDR3 PHY chip select (active low)                  |
| ddr3_ba_o      | Output | Output    | DDR3 PHY bank address (3-bit)                      |
| ddr3_addr_o    | Output | Output    | DDR3 PHY address (14-bit)                          |
| ddr3_odt_o     | Output | Output    | DDR3 PHY on-die termination                        |
| ddr3_dm_o      | Output | Output    | DDR3 PHY data mask (2-bit)                         |
| ddr3_dqs_p_io  | Inout  | Inout     | DDR3 PHY data strobe positive (2-bit)              |
| ddr3_dqs_n_io  | Inout  | Inout     | DDR3 PHY data strobe negative (2-bit)              |
| ddr3_dq_io     | Inout  | Inout     | DDR3 PHY data (16-bit)                             |

## Hyper-Titan Address Map

The Hyper-Titan Address Map outlines the memory layout of the SoC, assigning unique address ranges to each component. This mapping is crucial for enabling efficient communication between software and hardware, preventing address conflicts, and facilitating proper resource allocation across the system.

| Device                       | Base Address    | Ending Address  |
| ---------------------------- | --------------- | --------------- |
| ITCM_E_CORE                  | 0x0000_0000     | 0x0000_1FFF     |
| [SYS_CTRL](maps/sys_ctrl.md) | 0x0000_2000     | 0x0000_2FFF     |
| [CLINT](maps/clint.md)       | 0x0000_3000     | 0x0000_3FFF     |
| [PLIC](maps/plic.md)         | 0x0000_4000     | 0x0000_4FFF     |
| [UART](maps/uart.md)         | 0x0000_5000     | 0x0000_5FFF     |
| [SPI_CSR](maps/spi_csr.md)   | 0x0000_6000     | 0x0000_6FFF     |
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
