# Makefile for DMA simulation
# Location: Hyper-Titan/Make/Makefile

export REPO_ROOT := $(abspath $(CURDIR)/..)


export HYPER_TITAN := $(REPO_ROOT)
print_root:
	@echo REPO_ROOT=$(REPO_ROOT)

#BUILD    := $(HYPER_TITAN)/build
#LOG      := $(HYPER_TITAN)/log
FILELIST := ${HYPER_TITAN}/hardware/filelist
#INC_DIRS := +incdir+$(REPO_ROOT)/submodule/axi/include +incdir+$(REPO_ROOT)/submodule/SoC/include



export SUBMODULE := $(HYPER_TITAN)/submodule
#export APB := $(SUBMODULE)/apb
export AXI := $(SUBMODULE)/axi
#export COMMON := $(SUBMODULE)/common
export COMMON_CELLS := $(SUBMODULE)/common_cells
export HARDWARE := $(HYPER_TITAN)/hardware
export SOC := $(SUBMODULE)/SoC
#export CORE_DDR3_CONTROLLER := $(SUBMODULE)/core_ddr3_controller
#xport XILINX_IPS := $(SUBMODULE)/xilinx
export SOURCE = $(SUBMODULE)/common_cells/src
TB_TOP := tb_dma_simple

FLST := $(REPO_ROOT)/Make/flist2.f
#INC_DIRS := +incdir+$(REPO_ROOT)/submodule/axi/include
INC_DIRS := -i "$(REPO_ROOT)/submodule/axi/include" \
            -i "$(REPO_ROOT)/submodule/SoC/include" \
            -i "$(REPO_ROOT)/submodule/AXI-DMA/rtl" \
            -i "$(REPO_ROOT)/submodule/common_cells/include"


print_inc:
	@echo INC_DIRS=$(INC_DIRS)
BUILD_DIR := $(REPO_ROOT)/build
SIM_SNAP := $(TB_TOP)_sim

.PHONY: build
build:
	@mkdir -p "$(BUILD_DIR)"
	@echo "*" > "$(BUILD_DIR)/.gitignore"

.PHONY: test_args
test_args: | build
	@echo "--testplusarg REPO_ROOT=$(REPO_ROOT)" > "$(BUILD_DIR)/test_args"

.PHONY: all
all: test_args
	@echo "Starting DMA simulation..."
	@cd "$(BUILD_DIR)" && xvlog -sv $(INC_DIRS) -f "$(FLST)"
	@cd "$(BUILD_DIR)" && xelab "$(TB_TOP)" -timescale=1ns/1ps -s "$(SIM_SNAP)"
	# @cd "$(BUILD_DIR)" && xsim "$(SIM_SNAP)" -runall -f test_args

.PHONY: compile
compile: test_args
	@cd "$(BUILD_DIR)" && xvlog -sv -f "$(FLST)"

.PHONY: elaborate
elaborate: compile
	@cd "$(BUILD_DIR)" && xelab "$(TB_TOP)" -s "$(SIM_SNAP)"

.PHONY: run
run: test_args
	@cd "$(BUILD_DIR)" && xsim "$(SIM_SNAP)" -runall -f test_args

.PHONY: gui
gui: test_args
	@cd "$(BUILD_DIR)" && xvlog -sv -f "$(FLST)"
	@cd "$(BUILD_DIR)" && xelab -debug all "$(TB_TOP)" -s "$(SIM_SNAP)_gui"
	@cd "$(BUILD_DIR)" && xsim "$(SIM_SNAP)_gui" -gui

.PHONY: clean
clean:
	@rm -rf "$(BUILD_DIR)" *.log *.jou *.wdb xsim.dir .Xil vivado_project
	reset

.PHONY: rebuild
rebuild: clean all
