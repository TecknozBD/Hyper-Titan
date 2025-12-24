export SHELL=/bin/bash

####################################################################################################
# General
####################################################################################################

TOP     := hyper_titan_tb_cfg
TEST    := default
HART_ID := 0

####################################################################################################
# Directory
####################################################################################################

export HYPER_TITAN=${CURDIR}

BUILD    := ${HYPER_TITAN}/build
LOG      := ${HYPER_TITAN}/log
FILELIST := ${HYPER_TITAN}/hardware/filelist

export SUBMODULE=${HYPER_TITAN}/submodule
export AXI=${SUBMODULE}/axi
export COMMON=${SUBMODULE}/common
export COMMON_CELLS=${SUBMODULE}/common_cells
export SOC=${SUBMODULE}/SoC
export CORE_DDR3_CONTROLLER=${SUBMODULE}/core_ddr3_controller
export XILINX_IPS=${SUBMODULE}/xilinx

####################################################################################################
# Tools
####################################################################################################

RISCV64_GCC     ?= riscv64-unknown-elf-gcc
RISCV64_OBJCOPY ?= riscv64-unknown-elf-objcopy
RISCV64_NM      ?= riscv64-unknown-elf-nm
RISCV64_OBJDUMP ?= riscv64-unknown-elf-objdump

####################################################################################################
# Command Output Filtering
####################################################################################################

EW_HL := | grep -E "WARNING:|ERROR:|" --color=auto
EW_O := | grep -E "WARNING:|ERROR:" --color=auto || true

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
	echo -e " \033[0;33m*\033[0m ${BASENAME}\033[25G ${LOG}/xvlog_${BASENAME}.log"
	cd ${BUILD} && xvlog -f ${FILELIST}/${BASENAME}.f --log ${LOG}/xvlog_${BASENAME}.log ${EW_O}
endef

.PHONY: all
all:
	@git submodule update --init --depth 1
	@make -s clean_full
	@make -s ${BUILD}
	@make -s ${LOG}
	@echo -e "\033[1;33mCOMPILING:\033[0m"
	@$(foreach file, $(shell find ${FILELIST} -type f -name "*.f"),$(call COMPILE,${file}))
	@echo -e "\033[1;33mELABORATING:\033[0m"
	@echo -e " \033[0;33m*\033[0m ${TOP}\033[25G ${LOG}/xelab_${TOP}.log"
	@cd ${BUILD} && xelab work.${TOP} --log ${LOG}/xelab_${TOP}.log ${EW_O}
	@echo -e "\033[1;33mSIMULATING:\033[0m"
	@echo -e " \033[0;33m*\033[0m ${TOP}::${TEST} ${LOG}/xsim_${TOP}_${TEST}.log"
	@cd ${BUILD} && xsim ${TOP} --log ${LOG}/xsim_${TOP}_${TEST}.log --runall ${EW_HL}

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

