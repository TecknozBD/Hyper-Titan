export SHELL=/bin/bash

####################################################################################################
# General Variables
####################################################################################################

EW_HL := | grep -E "WARNING:|ERROR:|" --color=auto
EW_O := | grep -E "WARNING:|ERROR:" --color=auto || true

####################################################################################################
# Directory Variables
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

.PHONY: submodules
submodules:
	@git submodule update --init --depth

define COMPILE
	$(eval BASENAME=$(shell basename $1 .f))
	echo -e " * ${BASENAME}\033[20G ${LOG}/xvlog_${BASENAME}.log"
	cd ${BUILD} && xvlog -f ${FILELIST}/${BASENAME}.f --log ${LOG}/xvlog_${BASENAME}.log ${EW_O}
endef

.PHONY: all
all:
	@make -s ${BUILD}
	@make -s ${LOG}
	@echo -e "\033[1;33mCOMPILING:\033[0m"
	@$(foreach file, $(shell find ${FILELIST} -type f -name "*.f"),$(call COMPILE,${file}))
# TODO XELAB and XSIM steps

