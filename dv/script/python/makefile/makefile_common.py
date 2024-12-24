CPUS = $(shell nproc)
MODE = $(shell getconf LONG_BIT)
SEED = $(shell data +%m%d%H%M%S)
SVN_REV = $(shell svn info | grep 'Revision' | awk '{print $$2}')

ifeq ($(MODE), 64)
    VCS_CMP_OPTS += -full64
endif

VCS_SIM_OPTS += +ntb_random_seed=$(SEED)

UVM_EN ?= 1
UVM_TC ?=

ifdef UVM_TC
    TC_FULL_NAME = $(UVM_TC)_$(SEED)
endif

ifeq ($(UVM_EN), 1)
    VCS_CMP_OPTS += +define+UVM +UVM_TESTNAME=$(UVM_TC)
endif

SV_EN ?= 1
ifeq ($(SV_EN), 1)
    VCS_CMP_OPTS += -sverilog
endif

LOG_DIR ?= log
CMP_LOG_DIR ?= $(LOG_DIR)/cmp
SIM_LOG_DIR ?= $(LOG_DIR)/sim

VCS_CMP_OPTS += -l $(CMP_LOG_DIR)/cmp.log
VCS_SIM_OPTS += -l $(SIM_LOG_DIR)/$(TC_FULL_NAME).log

COV_EN ?= 0
COV_DIR ?= cov
ifeq ($(COV_EN), 1)
    -cm_dir $(COV_DIR)/$(SVN_REV)/$(TOP_MODULE).vdb
endif