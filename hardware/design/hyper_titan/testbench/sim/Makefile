# =============================================================================
# RVV Mini Core Verification Makefile
# =============================================================================
# Author : Amit Sikder
# Date   : December 2025
#
# Description:
#   Automates compilation, elaboration, and simulation of the RVV Mini Core
#   using Xilinx Vivado XSim. Follows the same structure and robustness style
#   as the NEORV32 verification Makefile.
#
# Supports:
#   - SystemVerilog DUT + Testbench
#   - Auto directory creation
#   - Clean error-checked build flow
# =============================================================================

# -----------------------------------------------------------------------------
# Shell
# -----------------------------------------------------------------------------
SHELL := /bin/bash

# -----------------------------------------------------------------------------
# Directory Configuration
# -----------------------------------------------------------------------------
ROOT_DIR   := $(CURDIR)
SIM_DIR    := $(CURDIR)
BUILD_DIR  := $(SIM_DIR)/build
LOG_DIR    := $(SIM_DIR)/log

# DUT + TB Files
HYPER_TITAN_DIR := /d/Technoz/Hyper-Titan/submodule
RTL_DIR    := /d/Technoz/Hyper-Titan/hardware/design/hyper_titan/rtl
TB_DIR     := $(ROOT_DIR)/../top

DUT_SV     := $(HYPER_TITAN_DIR)/rvvcoreminiaxi.sv \
			  $(RTL_DIR)/RvvCoreWrapper.sv 
TB_SV      := $(TB_DIR)/tb_top.sv

# -----------------------------------------------------------------------------
# Top-Level Configuration
# -----------------------------------------------------------------------------
TOP ?= tb_RvvCoreMiniAxi_wrapper

# -----------------------------------------------------------------------------
# Vivado Tools
# -----------------------------------------------------------------------------
XVLOG = xvlog
XELAB = xelab
XSIM  = xsim
XVLOG_FLAGS = --sv --incr  -d VERILATOR -d XSIM
XELAB_FLAGS = --debug typical
XSIM_FLAGS  = --runall --log $(LOG_DIR)/$(TOP)_run.log

# -----------------------------------------------------------------------------
# Directory Setup
# -----------------------------------------------------------------------------
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)
	@echo "*" > $(BUILD_DIR)/.gitignore

$(LOG_DIR):
	@mkdir -p $(LOG_DIR)
	@echo "*" > $(LOG_DIR)/.gitignore

# -----------------------------------------------------------------------------
# Build + Elaborate Flow
# -----------------------------------------------------------------------------
$(BUILD_DIR)/$(TOP)_build_done: $(BUILD_DIR) $(LOG_DIR)
	@echo ""
	@echo "====================================================================="
	@echo ">> Compiling RVV Mini Core Verification Environment"
	@echo "====================================================================="

	@echo "[STEP 1] Compiling SystemVerilog sources..."
	@cd $(BUILD_DIR); $(XVLOG) $(XVLOG_FLAGS) $(DUT_SV) $(TB_SV) \
		> $(LOG_DIR)/xvlog.log \
		|| { echo '[ERROR] xvlog failed! Check log/xvlog.log'; \
		     head -n 15 $(LOG_DIR)/xvlog.log; exit 1; }

	@echo "[STEP 2] Elaborating design..."
	@cd $(BUILD_DIR); $(XELAB) $(XELAB_FLAGS) -s $(TOP)_sim work.$(TOP) \
		> $(LOG_DIR)/xelab.log \
		|| { echo '[ERROR] Elaboration failed! Check log/xelab.log'; \
		     head -n 15 $(LOG_DIR)/xelab.log; exit 1; }

	@touch $(BUILD_DIR)/$(TOP)_build_done
	@echo "[OK] Build & elaboration completed."

# -----------------------------------------------------------------------------
# Simulation
# -----------------------------------------------------------------------------
.PHONY: simulate
simulate:
	@make -s $(BUILD_DIR)/$(TOP)_build_done
	@echo ""
	@echo "====================================================================="
	@echo ">> Running Simulation: $(TOP)"
	@echo "====================================================================="
	@cd $(BUILD_DIR); $(XSIM) $(TOP)_sim $(XSIM_FLAGS)
	@echo ""
	@echo "[OK] Simulation complete. Check log/$(TOP)_run.log."

# -----------------------------------------------------------------------------
# Cleanup
# -----------------------------------------------------------------------------
.PHONY: clean
clean:
	@echo "[INFO] Cleaning build and log directories..."
	@rm -rf $(BUILD_DIR) $(LOG_DIR)
	@rm -rf *.jou *.log *.pb xsim.dir .Xil
	@echo "[OK] Cleanup complete."

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------
.PHONY: help
help:
	@echo ""
	@echo "================== RVV Mini Core Verification Makefile =================="
	@echo "Usage:"
	@echo "  make simulate                 - Compile + elaborate + run simulation"
	@echo "  make clean                    - Remove build artifacts"
	@echo ""
	@echo "Optional overrides:"
	@echo "  TOP=<module_name>             - Set testbench top (default: tb_top)"
	@echo ""
	@echo "Example:"
	@echo "  make simulate TOP=tb_top"
	@echo "=========================================================================="
