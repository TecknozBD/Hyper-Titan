# Hyper-Titan SoC

Hyper-Titan is a RISC‑V based heterogeneous System‑on‑Chip targeting both FPGA and future ASIC implementations. The design combines a high‑performance 64‑bit core with a smaller 32‑bit core, a hierarchical interconnect fabric, tightly‑coupled memories, and a scalable peripheral subsystem.

This README describes the *project* and the SoC architecture; repository usage details and scripts can live elsewhere.

## High‑Level Architecture

At a high level, Hyper-Titan integrates the following components (see diagrams below and under `document/svg`):

- **Cores**
	- `rv64imafd` main core (64‑bit, with integer, multiplication/division, atomic, single/double‑precision FP extensions).
	- `rv32imf` companion core (32‑bit, with integer, multiplication/division, single‑precision FP) for management, low‑power and off‑load tasks.

### Block Diagrams

**Top‑Level Architecture**

![Hyper-Titan Architecture](document/svg/architecture.svg)

**Detailed Interconnect & Clocking**

![Hyper-Titan Detailed](document/svg/detailed.svg)

- **Instruction & Data Interfaces**
	- **OBI.I / OBI.D**: Open Bus Interface ports from the main core.
	- **OBI‑to‑AXI bridges**: Two `OBI 2 AXI` blocks convert OBI transactions to a shared **AXI4‑64** fabric.

- **Interconnect & Links**
	- **Core Link**: High‑speed domain that connects the cores, OBI‑to‑AXI bridges, and TCDM banks.
	- **System Link**: System‑level interconnect in a potentially different clock domain, interfacing AXI fabric to memories and peripherals.
	- **CDC blocks**: Clock‑domain crossing cells between Core Link and System Link, and at key boundaries.

- **Memory Subsystem**
	- Multiple **TCDM** (Tightly‑Coupled Data Memory) banks in the Core Link domain for low‑latency access.
	- **RAM** and **ROM** attached on the System Link side via AXI.

- **DMA Engine**
	- A standalone **DMA** block connected to the Core Link, used for memory‑to‑memory moves and off‑loading large transfers from the cores.

- **Peripheral Subsystem**
	- **Peripheral Link (AXI‑Lite)**: AXI‑to‑AXI‑Lite bridge (`AXI 2 AXIL`) feeding a peripheral interconnect.
	- **APB Slave**: An **APB‑S** segment hanging off the peripheral link for simple low‑speed peripherals.
	- **System Control**: SoC configuration, status, reset control and clock gating.
	- **UART**: Serial debug/console interface.
	- **Clock & Reset Generator**: Input clock handling, PLL/DFLL hooks and SoC‑wide reset generation.

## Clocking Strategy

The diagrams capture an explicit multi‑domain clocking plan:

- **CL (Core Low)**: 1–2000 MHz range for the `rv32imf` core and possibly low‑power operation of the main core.
- **CH (Core High)**: 1–5000 MHz range for the `rv64imafd` core.
- **System / Memory clocks**:
	- System Link annotated at **3200 MHz** (target max for high‑speed interconnect / memory).
	- Peripheral Link annotated at **100 MHz** (AXI‑Lite / APB region).
- CDC modules isolate these domains, with the Core Link usually running at `max(CL, CH)` while peripherals stay at a much lower, synthesis‑friendly frequency.

Actual realized frequencies will depend on the target FPGA/ASIC technology and timing closure results.

## Project Goals

- **RTL Implementation**
	- Implement the complete SoC in **SystemVerilog**, with clean module boundaries that mirror the blocks in the diagrams.
	- Use synthesizable coding style with parameterization where useful (e.g., number/size of TCDM banks, AXI data width, presence of the rv32 core).

- **FPGA Bring‑Up**
	- Target one or more FPGA evaluation boards for early prototyping.
	- Integrate a minimal boot ROM, on‑chip RAM and UART‑based console for firmware bring‑up.

- **ASIC‑Ready Micro‑Architecture**
	- Keep clock‑domain crossings, resets, and power‑up sequencing explicitly modeled.
	- Avoid FPGA‑only primitives in shared RTL; isolate any vendor‑specific constructs behind wrappers.
	- Design CDC and reset schemes suitable for sign‑off in an ASIC flow (formal CDC, STA‑friendly resets).

## Planned Module Breakdown

The SystemVerilog codebase will roughly follow these top‑level blocks:

- `hyper_titan_top` – SoC top‑level wrapper (ports, clocks, resets, pad ring hooks).
- `ht_core_cluster` – Contains `rv64imafd`, `rv32imf`, OBI interfaces, OBI‑to‑AXI bridges, and TCDM banks.
- `ht_dma` – DMA engine connected to the Core Link.
- `ht_interconnect_core` – Core Link interconnect / arbitration.
- `ht_interconnect_sys` – System Link (AXI) interconnect.
- `ht_axi2axil` – AXI to AXI‑Lite down‑converter.
- `ht_apb_subsys` – APB bus and simple APB peripherals.
- `ht_sysctrl` – System control and configuration registers.
- `ht_uart` – UART peripheral.
- `ht_clk_rst_gen` – Clock/reset generator and distribution.

Module names are provisional and will evolve with the code, but the intent is to keep one major RTL block per logical diagram block.

## Verification & Firmware (Planned)

- **Verification**
	- UVM/SystemVerilog testbenches for OBI, AXI, and APB.
	- Directed smoke tests for each major block (cores, DMA, TCDM, interconnects, UART, System Control).
	- Clock‑domain crossing checks and basic formal properties for CDC cells.

- **Firmware & Tooling**
	- Bare‑metal bring‑up code for both `rv32imf` and `rv64imafd` cores.
	- Linker scripts and memory maps aligned with the TCDM/RAM/ROM layout.
	- Optional integration with standard RISC‑V toolchains for building and debugging.

## Current Status

- Architecture and clocking **captured in diagrams** under `document/svg/architecture.svg` and `document/svg/detailed.svg`.
- RTL implementation and verification environment are **work in progress / not yet published**.

## Contributing / Next Steps

- Flesh out the SystemVerilog module hierarchy following the "Planned Module Breakdown" section.
- Define a concrete memory map (TCDM size, RAM/ROM base addresses, peripheral address space).
- Select target FPGA and (longer‑term) ASIC technology node, then refine clock targets.
- Add separate documentation for build flow, simulation, and board support as the RTL lands.

If you are interested in collaborating on the SystemVerilog or verification side, feel free to propose changes to this architecture description or suggest additional blocks (e.g., timers, GPIO, SPI, debug modules).