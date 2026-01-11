export SHELL=/bin/bash

####################################################################################################
# General
####################################################################################################

TOP     := hyper_titan_tb
TEST    := default
HART_ID := 0
GUI     := 0

####################################################################################################
# Command Output Filtering
####################################################################################################

ifeq ($(GUI), 0)
XSIM_ARGS := --runall
else
XSIM_ARGS := --gui
endif

EW_HL := | grep -E "Warning-|Error-|" --color=auto
EW_O := | grep -E "Warning-|Error-" --color=auto || true

VCS_FLAGS := -full64 -sverilog -nc

####################################################################################################
# Directory
####################################################################################################

export HYPER_TITAN=${CURDIR}

BUILD    := ${HYPER_TITAN}/build
LOG      := ${HYPER_TITAN}/log
FILELIST := ${HYPER_TITAN}/hardware/filelist

export SUBMODULE=${HYPER_TITAN}/submodule
export APB=${SUBMODULE}/apb
export AXI=${SUBMODULE}/axi
export COMMON=${SUBMODULE}/common
export COMMON_CELLS=${SUBMODULE}/common_cells
export HARDWARE=${SUBMODULE}/hardware
export SOC=${SUBMODULE}/SoC
export CORE_DDR3_CONTROLLER=${SUBMODULE}/core_ddr3_controller
export XILINX_IPS=${SUBMODULE}/xilinx

####################################################################################################
# Tools
####################################################################################################

VLOGAN          ?= vlogan
VCS             ?= vcs
XSIM            ?= xsim
RISCV64_GCC     ?= riscv64-unknown-elf-gcc
RISCV64_OBJCOPY ?= riscv64-unknown-elf-objcopy
RISCV64_NM      ?= riscv64-unknown-elf-nm
RISCV64_OBJDUMP ?= riscv64-unknown-elf-objdump

####################################################################################################
# Targets
####################################################################################################

${BUILD}:
	@mkdir -p ${BUILD}
	@echo "*" > ${BUILD}/.gitignore

${LOG}:
	@mkdir -p ${LOG}
	@echo "*" > ${LOG}/.gitignore

.PHONY: clean
clean:
	@rm -rf ${BUILD}

.PHONY: clean_full
clean_full:
	@make -s clean
	@rm -rf ${LOG}


define COMPILE
	$(eval BASENAME=$(shell basename $1 .f))
	echo -e " \033[0;33m*\033[0m ${BASENAME}\033[25G ${LOG}/vlogan_${BASENAME}.log"
	cd ${BUILD} && ${VLOGAN} ${VCS_FLAGS} -f ${FILELIST}/${BASENAME}.f -l ${LOG}/vlogan_${BASENAME}.log ${EW_O}
endef

.PHONY: all
all:
	@echo -e "\033[1;33mSETTING ENVIRONMENT:\033[0m"
	@git submodule update --init --depth 1
	@make -s clean_full
	@make -s ${BUILD}
	@make -s ${LOG}
	@echo "WORK > DEFAULT"                   > ${BUILD}/synopsys_sim.setup
	@echo "DEFAULT : worklib"               >> ${BUILD}/synopsys_sim.setup
	@echo "ariane : ariane"                 >> ${BUILD}/synopsys_sim.setup
	@echo "rvvcoreminiaxi : rvvcoreminiaxi" >> ${BUILD}/synopsys_sim.setup
	@echo -e "\033[1;33mCOMPILING:\033[0m"
	@$(foreach file, $(shell find ${FILELIST} -type f -name "*.f"),$(call COMPILE,${file}))
	@echo -e "\033[1;33mELABORATING:\033[0m"
	@echo -e " \033[0;33m*\033[0m ${TOP}\033[25G ${LOG}/xelab_${TOP}.log"
	@cd ${BUILD} && ${VCS} -licqueue ${VCS_FLAGS} -top ${TOP} -partcomp -timescale=1ns/1ps -l ${LOG}/vcs_${TOP}.log ${EW_O}
# 	@echo -e "\033[1;33mSIMULATING:\033[0m"
# 	@echo -e " \033[0;33m*\033[0m ${TOP}::${TEST}\033[25G ${LOG}/xsim_${TOP}_${TEST}.log"
# 	@cd ${BUILD} && ${XSIM} ${TOP} --log ${LOG}/xsim_${TOP}_${TEST}.log ${XSIM_ARGS} ${EW_HL}

.PHONY: test
test:
	@make -s ${BUILD}
	@$(eval TEST_PATH := $(shell find software/source -type f -name "*${TEST}*"))
	@if [ -z "${TEST_PATH}" ]; then echo -e "\033[1;31mTest file ${TEST} not found!\033[0m"; exit 1; fi
	@if [ $$(echo "${TEST_PATH}" | wc -w) -gt 1 ]; then echo -e "\033[1;31mMultiple test files found for ${TEST}:\n${TEST_PATH}\033[0m"; exit 1; fi
	@${RISCV64_GCC} -march=rv32imf -mabi=ilp32f -nostdlib -nostartfiles -T software/linkers/core_${HART_ID}.ld -o build/prog_${HART_ID}.elf software/include/startup.S ${TEST_PATH} -I software/include
	@${RISCV64_OBJCOPY} -O verilog build/prog_${HART_ID}.elf build/prog_${HART_ID}.hex
	@${RISCV64_NM} -n build/prog_${HART_ID}.elf > build/prog_${HART_ID}.sym
	@${RISCV64_OBJDUMP} -d build/prog_${HART_ID}.elf > build/prog_${HART_ID}.dis

####################################################################################################
# GEN DOC
####################################################################################################

.PHONY: gen_doc
gen_doc:
	@cat document/hyper-titan.md > README.md
	@echo "" >> README.md
	@cat document/readme_others.md >> README.md
	@sed -ri "s/\]\(/\]\(document\//g" README.md
	@sed -ri "s/document\/http/http/g" README.md
	@sed -ri "s/document\/LICENSE/LICENSE/g" README.md
	@$(eval FILES=$(shell find hardware -name "*.*v*"))
	@$(eval FILES+=$(shell find document -name "*.md"))
	@$(eval LINES=$(shell cat ${FILES} | wc -l))
	@sed -i "s/###TECKNOZ_IP_COUNT###/${LINES}/g" README.md
