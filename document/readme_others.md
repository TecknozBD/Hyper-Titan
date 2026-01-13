## Repository

This repository contains the complete RTL design, simulation testbenches, and documentation for the Hyper-Titan SoC.

**Repository Structure:**

```text
Hyper-Titan/
├── build/                 # Temporary build files
├── document/              # Documentation files
├── hardware/              # RTL source files and testbenches
│   ├── design/            # SoC design source files
│   ├── filelist/          # File lists for synthesis and simulation
│   ├── include/           # Common include files
│   ├── interface/         # Interface definitions
│   ├── package/           # Common packages
│   └── testbench/         # Testbenches for simulation
├── log/                   # Simulation logs and reports
├── software/              # Firmware and driver source code
│   ├── include/           # Common include files
│   ├── linkers/           # Linker scripts
│   └── source/            # Firmware and driver source files
├── submodule/             # External third-party dependencies
├── .gitmodules            # Git submodule configuration
├── LICENSE                # License information
├── Makefile               # Top-level Makefile for build automation
└── README.md              # Project overview
```

## Getting Started

**Pre-requisites:**

- A Unix-based development environment
- GNU Makefile
- GNU toolchain for RISC-V
- AMD Xilinx Vivado

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

```mermaid
%%{init: {"pie": {"sort": false}} }%%
pie title IP Sources
  "Tecknoz" : ###TECKNOZ_IP_COUNT###
  "google-coral" : 59000
  "lowRISC" : 22000
  "pulp-platform" : 36000
  "squared-studio": 2000
  "ultraembedded": 6000
```

> Note: Pie chart rendering requires Mermaid support in your Markdown renderer.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
