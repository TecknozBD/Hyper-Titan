# Hyper-Titan SoC

## Overview

Hyper-Titan is a Dual Core SoC design with big-Little architecture, featuring an RV64G Performance core and an RV32IMF Efficiency core. The design incorporates TCM memory for low-latency access, a DMA controller for efficient data transfers, and a suite of peripherals including UART & SPI.

## Features

- **Dual Core Architecture**: Combines a high-performance RV64G core with a power-efficient RV32IMF core.
- **TCM Memory**: Provides low-latency access to shared memory for both cores.
- **DMA Controller**: Facilitates efficient data transfers between peripherals and memory without CPU intervention.
- **Peripherals**: Includes UART for serial communication and SPI for high-speed data exchange.
- **Open Source**: Fully open-source design, allowing for customization and extension.

## Repository

This repository contains the complete RTL design, simulation testbenches, and documentation for the Hyper-Titan SoC.

## Getting Started

To get started with the Hyper-Titan SoC, clone this repository and follow the instructions

| _TODO:_ Add details for running simulations

## Architecture Overview

The Hyper-Titan SoC architecture is designed to optimize performance and power efficiency through its dual-core configuration. The RV64G core is meant to handle compute-intensive tasks, while the RV32IMF core is meant to manage less demanding workloads. The Architecture diagram below illustrates the key components and their interactions. Both clocks operate on their own dedicated clock domains, allowing for independent frequency scaling and power management. For connecting the cores to a common system bus, the design employs a Core Link module, which manages communication between the two cores. Additionally, the System Link and Peripheral Link modules facilitate connections to memory controllers and peripheral devices, respectively. The Core Link operate on the fastest clock domain between the two cores to minimize latency in inter-core communication. The System Link and Peripheral Link modules operate on their own clock domains, optimized for their specific performance and power requirements. The Peripheral Link module connects to various peripherals, including UART and SPI, ensuring efficient data transfer between the cores and external devices. As the bandwidth demands of peripherals are generally lower than those of the cores, the Peripheral Link operates at a lower frequency of 100 MHz to conserve power.


![System Architecture](document/svg/architecture.drawio.svg)

_**Figure:** Hyper-Titan SoC Architecture_

### Key Components
- _Efficiency Core:_ RV32IMF core designed for low power consumption.
- _Performance Core:_ RV64G core optimized for high performance.
- _TCM Memory:_ Shared memories accessible by both cores for fast data exchange.
- _DMA Controller:_ Manages data transfers between different blocks.
- _Internal ROM:_ Read only memory for boot code and firmware.
- _External RAM:_ Connections for external memory and I/O devices.
- _APB Bridge:_ Facilitates external access to the system bus.
- _System Controller:_ Manages system-level functions and configurations.
- _Clock & Reset Generator:_ Provides clock signals and reset functionality.
- _SPI Host:_ Serial Peripheral Interface for high-speed communication with external devices.
- _UART:_ Universal Asynchronous Receiver-Transmitter for serial communication.
- _CLINT:_ Core Local Interruptor for handling interrupts.
- _PLIC:_ Platform-Level Interrupt Controller for managing external interrupts.

#### [Detailed Architecture](document/detailed_architecture.md)

## Third-Party Components
This project utilizes several third-party components, including:
- [google-coral/coralnpu](https://github.com/google-coral/coralnpu)
- [lowRISC/ariane](https://github.com/lowRISC/ariane)
- [pulp-platform/axi](https://github.com/pulp-platform/axi)
- [pulp-platform/common_cells](https://github.com/pulp-platform/common_cells)
- [squared-studio/common](https://github.com/squared-studio/common)
- [squared-studio/SoC](https://github.com/squared-studio/SoC)
- [ultraembedded/core_ddr3_controller](https://github.com/ultraembedded/core_ddr3_controller)

| _TODO:_ Add more as necessary

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
