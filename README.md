# Hyper-Titan SoC

## Overview

Hyper-Titan is a Dual Core SoC design with big-Little architecture, featuring an RV64G Performance core and an RV32IMF Efficiency core. The design incorporates TCDM memory for low-latency access, a DMA controller for efficient data transfers, and a suite of peripherals including UART & SPI.

## Features

- **Dual Core Architecture**: Combines a high-performance RV64G core with a power-efficient RV32IMF core.
- **TCDM Memory**: Provides low-latency access to shared memory for both cores.
- **DMA Controller**: Facilitates efficient data transfers between peripherals and memory without CPU intervention.
- **Peripherals**: Includes UART for serial communication and SPI for high-speed data exchange.
- **Open Source**: Fully open-source design, allowing for customization and extension.

## Repository

This repository contains the complete RTL design, simulation testbenches, and documentation for the Hyper-Titan SoC.

## Getting Started

To get started with the Hyper-Titan SoC, clone this repository and follow the instructions

| _TODO:_ Add details for running simulations

## Architecture Overview

The Hyper-Titan SoC architecture is designed to optimize performance and power efficiency through its dual-core configuration. The RV64G core is meant to handle compute-intensive tasks, while the RV32IMF core is meant to manage less demanding workloads. The Architecture diagram below illustrates the key components and their interactions.

![System Architecture](document/svg/architecture.drawio.svg)

_Figure 1: Hyper-Titan SoC Architecture_

- _Efficiency Core:_ RV32IMF core designed for low power consumption.
- _Performance Core:_ RV64G core optimized for high performance.
- _ITCM Memory, DTCM Memory & TCDM Memory:_ Shared memories accessible by both cores for fast data exchange.
- _DMA Controller:_ Manages data transfers between different blocks.
- _Interanl ROM:_ Non-volatile memory for boot code and firmware.
- _External RAM:_ Connections for external memory and I/O devices.
- _APB Slave Interface:_ Facilitates external access to the system bus.
- _System Controller:_ Manages system-level functions and configurations.
- _Clock & Reset Generator:_ Provides clock signals and reset functionality.
- _SPI Master:_ Serial Peripheral Interface for high-speed communication with external devices.
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

| _TODO:_ Add more as necessary

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
