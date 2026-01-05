# Hyper-Titan SoC

## Overview

Hyper-Titan is an open-source dual-core RISC-V SoC built around a big-LITTLE style architecture: an RV64G Performance core for compute-heavy work and an RV32IMF Efficiency core for control-oriented tasks. It combines low-latency TCM, DMA-assisted data movement, and practical peripherals (UART/SPI) into a cohesive, research-friendly platform.

Hyper-Titan is designed as a “middle ground” SoC: more capable than typical microcontroller-class designs, while staying smaller and more approachable than full Linux-class platforms.

## Features

The key features of Hyper-Titan include:

- **Big-LITTLE dual-core RISC-V**: Partition workloads between the RV64G Performance core and RV32IMF Efficiency core.
- **Low-latency TCM**: Fast shared memory for tight control loops and inter-core data exchange.
- **DMA-assisted transfers**: Move data between peripherals and memory with reduced CPU involvement.
- **Practical peripherals**: UART for bring-up/debug and SPI for external device connectivity.
- **Open-source RTL + docs**: A solid base for learning, experimentation, and customization.

## Why Hyper-Titan

- **Faster bring-up for ideas**: A complete SoC integration target (cores, memory, interconnect, peripherals) for rapid iteration in simulation.
- **Teachable architecture**: Clear separation of compute vs control roles and multiple clock domains for real-world SoC concepts.
- **Extensible baseline**: Add/replace peripherals, expand memory, and evolve the interconnect while keeping a working reference design.

## Ideal For

- RISC-V SoC exploration and architectural experiments
- Verification and system-level testbench development
- Firmware/driver bring-up against memory-mapped peripherals
- Research projects needing a modifiable dual-core baseline

## Architecture Overview

Hyper-Titan uses a dual-core architecture to balance performance and efficiency: the RV64G core targets compute-intensive workloads, while the RV32IMF core targets control-oriented tasks.

The diagram below shows the main blocks and how they connect. Each core runs in its own dedicated clock domain, enabling independent frequency scaling and power management.

Interconnect is organized into three links:

- **Core Link** connects the two cores to a common system bus and runs in the fastest clock domain of the two cores to minimize inter-core communication latency.
- **System Link** connects the cores to memory controllers and operates in its own clock domain.
- **Peripheral Link** connects peripherals (e.g., UART and SPI) and operates in its own clock domain. Since peripheral bandwidth requirements are typically lower than core bandwidth, the Peripheral Link runs at 100 MHz to conserve power.

![System Architecture](svg/architecture.svg)

_**Figure:** Hyper-Titan SoC Architecture_

### Key Components

- **Efficiency Core:** RV32IMF core designed for low power consumption.
- **Performance Core:** RV64G core optimized for high performance.
- **TCM Memory:** Shared memories accessible by both cores for fast data exchange.
- **DMA Controller:** Manages data transfers between different blocks.
- **Internal ROM:** Read only memory for boot code and firmware.
- **External RAM:** Connections for external DDR3 memory.
- **APB Bridge:** Facilitates external access to the system bus.
- **System Controller:** Manages system-level functions and configurations.
- **Clock & Reset Generator:** Provides clock signals and reset functionality.
- **SPI Host:** Serial Peripheral Interface for high-speed communication with external devices.
- **UART:** Universal Asynchronous Receiver-Transmitter for serial communication.
- **CLINT:** Core Local Interruptor for handling interrupts.
- **PLIC:** Platform-Level Interrupt Controller for managing external interrupts.

#### [Detailed Architecture](detailed_architecture.md)
