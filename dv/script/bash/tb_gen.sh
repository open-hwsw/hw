#!/bin/bash

tb_help="
|directory or file  |description                                                        |
|---                |---                                                                |
|doc                |this directory used to store user-markdown files                   |
|doc/readme.md      |this markdown file described directory tree                        |
|bug                |back up bug log and waveform, share with other engineers           |
|flist              |this directory used to store file list                             |
|flist/lib.f        |library file list                                                  |
|flist/modle.f      |model file list                                                    |
|flist/rtl.f        |register transfer level file list                                  |
|flist/tb.f         |testbench file list                                                |
|rtl                |this directory used to store rtl files                             |
|model              |this directory used to store model files                           |
|model/c            |this directory used to store c model files                         |
|model/cpp          |this directory used to store cpp model files                       |
|model/cpp/systemc  |this directory used to store systemc model files                   |
|model/matlab       |this directory used to store matlab model files                    |
|model/systemverilog|this directory used to store systemverilog model files             |
|model/verilog      |this directory used to store verilog model files                   |
|model/vhdl         |this directory used to store verilog model files                   |
|vip                |this directory used to store verification ip files                 |
|ral                |this directory used to store uvm register abstraction layer files  |
|env                |this directory used to store uvm env layer files                   |
|tc                 |this directory used to store uvm test layer files                  |
|tb                 |this directory used to store testbench files                       |
|tb/tb.sv           |testbench                                                          |
|tb/tb_gcr.sv       |testbench, connect global clock and reset                          |
|tb/tb_conn.sv      |testbench, connect bfm to dut                                      |
|script             |this directory used to store script files                          |
|script/bash        |this directory used to store bash script files                     |
|script/bash/run.sh |this bash script file used to build simulation flow                |
|script/python      |this directory used to store python script files                   |
|run                |this directory used to store compile and simulation files          |
|run/log            |this directory used to store compile and simulation logs           |
|run/log/cmp        |this directory used to store compile logs                          |
|run/log/sim        |this directory used to store simulation logs                       |
|run/log/rgs        |this directory used to store regress simulation logs               |
|run/wave           |this directory used to store simulation waveforms                  |
|run/wave/wlf       |this directory used to store wlf simulation waveforms              |
|run/wave/vcd       |this directory used to store vcd simulation waveforms              |
|run/wave/fsdb      |this directory used to store fsdb simulation waveforms             |
|run/wave/vpd       |this directory used to store vpd simulation waveforms              |
|run/wave/shm       |this directory used to store shm simulation waveforms              |
|run/cov            |this directory used to store simulation coverage date              |
|run/cov/cfg        |this directory used to store simulation coverage configuration file|
|run/cov/cfg/cov.cfg|coverage configuration file                                        |
|sw                 |this directory used to store software files                        |
|sw/src             |this directory used to store software source files                 |
|sw/inc             |this directory used to store software header files                 |
"

run_help="
# tools
. run -org xx                                       : set the organization name, default is hwsw
. run -repo xx                                      : set the repository or project name
. run -editor xx                                    : set the default editor, xx can be vim / gvim / emacs / gedit / nano, defautl is gvim
. run -simulator xx                                 : set the default simulator, xx can be vcs / questaSim / verilator / vivado, default is vcs
. run -waveform xx                                  : set the default waveform, xx can be verdi / dve / gtkwave, default is verdi

# generate interface
. run -ifgen xx				            : generate a interface demo
. run -ifgen xx -modref xx			    : generate a interface base on a module

# waveform debug
. run -v                                            : open waveform debug tool

# top module
. run -top xx                                       : set the top module, xx is top module name
. run -gettop                                       : get the top module name

# generate test case
. run -tcgen -tcidx xx -tcname xx                   : generate a new test case
. run -tcgen -tcidx xx -tcname xx -tcref xx         : generate a new test case from a old test case
. run -tcmerge                                      : merge other test case that copy form other path

# delete test case
. run -tcdel xx                                     : delete a test case by tcidx
. run -tedel -tcidx xx                              : delete a test case by tcidx
. run -tcdel -tcname xx                             : delete a test case by tcname

# view test case
. run -tclist                                       : show all test case
. run -tclist -tcidx xx                             : get test name

# start test case in post-processing mode
. run xx                                            : start a test case by tcidx in post-processing mode
. run -tcidx xx                                     : start a test case by tcidx in post-processing mode
. run xx xx                                         : start a test case by tcidx and a used-defined seed in post-processing mode
. run xx -seed xx                                   : start a test case by tcidx and a used-defined seed in post-processing mode
. run -tcidx xx -seed xx                            : start a test case by tcidx and a used-defined seed in post-processing mode
. run -tcname xx                                    : start a test case by tcname in post-processing mode
. run -tcname xx -seed xx                           : start a test case by tcname and a used-defined seed in post-processing mode

# start test case in interactive mode
. run xx -gui                                       : start a test case by tcidx in interactive mode
. run -tcidx xx -gui                                : start a test case by tcidx in interactive mode
. run xx xx -gui                                    : start a test case by tcidx and a used-defined seed in interactive mode
. run xx -seed xx -gui                              : start a test case by tcidx and a used-defined seed in interactive mode
. run -tcidx xx -seed xx -gui                       : start a test case by tcidx and a used-defined seed in interactive mode
. run -tcname xx -gui                               : start a test case by tcname in interactive mode
. run -tcname xx -seed xx -gui                      : start a test case by tcname and a used-defined seed in interactive mode

# start test case in regress mode(-waveoff: turn off dump)
. run -rgsnum xx                                    : regress all testcase
. run xx -rgsnum xx                                 : regress a test case by tcidx
. run -tcidx xx -rgsnum xx                          : regress a test case by tcidx
. run -tcname xx -rgsnum xx                         : regress a test case by tcname
. run -tcidx xx -tcname xx -rgsnum xx               : regress a test case by both tcidx and tcname

# generate ral
. run -ralgen -topblock xx                          : generate a register model by ralf file
"

Makefile="
ORG         ?= hwsw
REPO        ?= 
EDITOR      ?= gvim
SIMULATOR   ?= vcs
WAVEFORM    ?= verdi
MODE        ?= \$(shell getconf LONG_BIT)
CORES       ?= \$(shell nproc)

TB_FILES   = ../flist/tb.f
TOP_MODULE = tb

CMP_OPTS    ?=
SIM_OPTS    ?=
WAV_OPTS    ?=

USER_DEF_CMP_OPTS +=
USER_DEF_SIM_OPTS +=
USER_DEF_WAV_OPTS +=

include cfg/vlg.mk
include cfg/macro.mk
include cfg/lint.mk
include cfg/dbg.mk
include cfg/solver.mk
include cfg/uvm.mk
include cfg/assert.mk
include cfg/cov.mk
include cfg/log.mk
include cfg/dump.mk
include cfg/ams.mk

cmp:
    \$(SIMULATOR) -V \$(CMP_OPTS) \$(USER_DEF_CMP_OPTS) -f \$(TB_FILES) -top \$(TOP_MODULE)

sim:
    simv \$(SIM_OPTS) \$(USER_DEF_SIM_OPTS)
	@echo \"\"
	@echo \"+-----------------------------------------------------------------+\"
	@echo \"+     Compile    log    :   ./log/cmp/cmp.log                      \"
	@echo \"+     Simulation log    :   ./log/sim/\$(tc_full_name).log         \"
    @echo \"+     Simulation wave   :   ./log/wave/\$(tc_full_name).fsdb       \"
	@echo \"+-----------------------------------------------------------------+\"
	@echo \"\"

wav:
    \$(WAVEFORM) -nologo -f \$(TB_FILES) -ptrTitle \$(TOP_MODULE) -top \$(TOP_MODULE)

"

run_main="#!/bin/bash

opts=\$(getopt -o -v -a -l editor:,simulator:,waveform: -- \"\$@\")

if [ \$? != 0 ]; then
    exit 1;
fi

eval set -- \"\$opts\"

while :; do

    case \$1 in
        --editor)
            editor=\$2
            shift 2
            ;;
        --simulator)
            simulator=\$2
            shift 2
            ;;
        --waveform)
            waveform=\$2
            shift 2
            ;;
        --)
            break
            ;;
        *)
            ;;
    esac

done

if [ -n \"\$editor\" ]; then
    if [ which \$editor -ne 0 ]; then
        echo \"\$editor not found in system, please select anthor editor\"
        exit 1
    else
        #sed -i \"s/\(EDITOR *?= \).*/\1\$editor/\" Makefile
        exit 0
    fi
fi

if [ -n \"\$simulator\" ]; then
    if [ which \$simulator -ne 0 ]; then
        echo \"\$simulator not found in system, please select anthor simulator\"
        exit 1
    else
        #sed -i \"s/\(SIMULATOR *?= \).*/\1\$simulator/\" Makefile
        exit 0
    fi
fi

if [ -n \"\$waveform\" ]; then
    if [ which \$waveform -ne 0 ]; then
        echo \"\$waveform not found in system, please select anthor waveform\"
        exit 1
    else
        #sed -i \"s/\(WAVEFORM *?= \).*/\1\$waveform/\" Makefile
        exit 0
    fi
fi

"

uvm_mk_main="
UVM_EN                  ?= 1
UVM_VER                 ?= 1.2
DPI_HDL_API_EN          ?= 1
UVM_REG_ADDR_WIDTH      ?= 64
UVM_REG_DATA_WIDTH      ?= 64
UVM_DBG                 ?= 0
UVM_PHASE_TRACE_EN      ?= 0
UVM_OBJECTION_TRACE_EN  ?= 0
UVM_RESOURCE_TRACE_EN   ?= 0
UVM_CONFIG_DB_TRACE_EN  ?= 0

tc                      ?=
vl                      ?= UVM_MEDIUM
qc                      ?= 10
to                      ?= 5000000000

ifeq (\$(UVM_EN),1)
    CMP_OPTS + +define+UVM
    WAV_OPTS + +define+UVM
ifeq (\$(UVM_VER), 1.1)
    CMP_OPTS += -ntb_opts uvm-1.1
    WAV_OPTS += -ntb_opts umv-1.1
else ifeq (\$(UVM_VER), 1.2)
    CMP_OPTS += -ntb_opts uvm-1.2
    WAV_OPTS += -ntb_opts umv-1.2
else ifeq (\$(UVM_VER), ieee)
    CMP_OPTS += -ntb_opts uvm-ieee
else ifeq (\$(UVM_VER), ieee-2020)
    CMP_OPTS += -ntb_opts uvm-ieee-2020
else ifeq (\$(UVM_VER), ieee-2020-2.0)
    CMP_OPTS += -ntb_opts uvm-ieee-2020-2.0
endif

ifeq (\$(DPI_HDL_API_EN), 0)
    CMP_OPTS += +define+UVM_HDL_NO_DPI
endif

    CMP_OPTS += +define+UVM_REG_ADDR_WIDTH=\$(UVM_REG_ADDR_WIDTH)
    CMP_OPTS += +define+UVM_REG_DATA_WIDTH=\$(UVM_REG_DATA_WIDTH)

    SIM_OPTS += UVM_TESTNAME=\$(tc) +UVM_VERBOSITY=\$(vl) +UVM_MAX_QUIT_COUNT=\$(qc) +UVM_TIMEOUT=\$(to)

ifeq (\$(UVM_DBG), 1)

ifeq (\$(GUI_EN), 1)
    SIM_OPTS += +UVM_PHASE_RECORD +UVM+TR+RECORD +UVM_VERDI_TRACE=\"UVM_AWARE+RAL+HIER+COMPWAVE\"
endif

    VERDI_OPTS += -uvmDebug

ifeq (\$(UVM_PHASE_TRACE_EN), 1)
    SIM_OPTS += +UVM_PHASE_TRACE
endif

ifeq (\$(UVM_OBJECTION_TRACE_EN), 1)
    SIM_OPTS += +UVM_OBJECTION_TRACE
endif

ifeq (\$(UVM_RESOURCE_TRACE_EN), 1)
    SIM_OPTS += +UVM_RESOURCE_TRACE
endif

ifeq (\$(UVM_CONFIG_DB_TRACE_EN), 1)
    SIM_OPTS += +UVM_CONFIG_DB_TRACE
endif

endif

endif

ifeq (\$(tc),)

ifeq (\$(seed),)
    tc_full_name=novas
else
    tc_full_name=novas_\$(seed)
endif

else

ifeq (\$(seed),)
    tc_full_name=\$(tc)
else
    tc_full_name=\$(tc)_\$(seed)
endif

endif
"

while getopts "co:r:t:" opts;
do
    case $opts in
        o)
            org=$OPTARG
            ;;
        r)
            repo=$OPTARG
            ;;
        t)
            top_module=$OPTARG
            ;;
        c)
            rm -rfv doc/ bug/ flist/ model/ vip/ ral/ env/ tc/ tb/ script/ run/ rtl/ sw/
            exit 1
            ;;
        *)
            echo "invalid options"
            ;;
    esac
done

rm -rfv doc/ bug/ flist/ model/ vip/ ral/ env/ tc/ tb/ script/ run/

if [ -z "$org" ]; then
    echo "please setting your organization name by -o option"
    exit 1;
fi
if [ -z "$repo" ]; then
    echo "please setting your repository/project name by -r option"
    exit 1;
fi
if [ -z "$top_module" ]; then
    echo "please setting your top module name by -t option"
    exit 1;
fi

if [[ ! "$top_module" =~ tb$ ]]; then
    echo "please setting a name with the suffix tb"
    exit 1
fi

#doc
if [ ! -d doc ]; then
    mkdir -pv doc
else
	echo "directory doc exists"
fi

#bug
if [ ! -d bug ]; then
    mkdir -pv bug
else
	echo "directory bug exists"
fi

#flist
if [ ! -d flist ]; then
    mkdir -pv flist
else
	echo "directory flist exists"
fi

#flist/lib.f
if [ ! -e flist/lib.f ]; then
	touch flist/lib.f
else
	echo "file flist/lib.f exists"
fi

#flist/model.f
if [ ! -e flist/model.f ]; then
	touch flist/model.f
else
	echo "file flist/model.f exists"
fi

#flist/rtl.f
if [ ! -e flist/rtl.f ]; then
	touch flist/rtl.f
else
	echo "file flist/rtl.f exists"
fi

#flist/tb.f
if [ ! -e flist/$top_module.f ]; then
    touch flist/$top_module.f
else
    echo "file flist/$top_module.f exists"
fi

echo -e "
// USER CODE BEGIN

// USER CODE END

-F lib.f
-F model.f
-F rtl.f

+incdir+../vip
+incdir+../ral
+incdir+../env
+incdir+../tc
+incdir+../tb
../tb/$top_module.sv" > flist/$top_module.f

#rtl
if [ ! -d rtl ]; then
    mkdir -pv rtl
else
	echo "directory rtl exists"
fi

#model
if [ ! -d model ]; then
    mkdir -pv model
else
	echo "directory model exists"
fi

#model/c
if [ ! -d model/c ]; then
    mkdir -pv model/c
else
	echo "directory model/c exists"
fi

#model/cpp
if [ ! -d model/cpp ]; then
    mkdir -pv model/cpp
else
	echo "directory model/cpp exists"
fi

#model/cpp/systemc
if [ ! -d model/cpp/systemc ]; then
    mkdir -pv model/cpp/systemc
else
	echo "directory model/cpp/systemc exists"
fi

#model/matlab
if [ ! -d model/matlab ]; then
    mkdir -pv model/matlab
else
	echo "directory model/matlab exists"
fi

#model/systemverilog
if [ ! -d model/systemverilog ]; then
    mkdir -pv model/systemverilog
else
	echo "directory model/systemverilog exists"
fi

#model/verilog
if [ ! -d model/verilog ]; then
    mkdir -pv model/verilog
else
	echo "directory model/verilog exists"
fi

#model/vhdl
if [ ! -d model/vhdl ]; then
    mkdir -pv model/vhdl
else
	echo "directory model/vhdl exists"
fi

#vip
if [ ! -d vip ]; then
    mkdir -pv vip
else
	echo "directory vip exists"
fi

#ral
if [ ! -d ral ]; then
    mkdir -pv ral
else
	echo "directory ral exists"
fi

#env
if [ ! -d env ]; then
    mkdir -pv env
else
	echo "directory env exists"
fi

#tc
if [ ! -d tc ]; then
    mkdir -pv tc
else
	echo "directory tc exists"
fi
#tc/test_top.sv
if [ ! -e tc/"$top_module"_test_top.sv ]; then
    touch tc/"$top_module"_test_top.sv
else
	echo "file tc/${top_module}_test_top.sv exists"
fi

#tb
if [ ! -d tb ]; then
    mkdir -pv tb
else
	echo "directory tb exists"
fi
#tb/tb.sv
if [ ! -e tb/$top_module.sv ]; then
    touch tb/$top_module.sv
else
    echo "file tb/$top_module.sv exists"
fi
#tb/tb_gcr.sv
if [ ! -e tb/${top_module}_gcr.sv ]; then
    touch tb/${top_module}_gcr.sv
else
    echo "file tb/${top_module}_gcr.sv exists"
fi
#tb/tb_conn.sv
if [ ! -e tb/${top_module}_conn.sv ]; then
    touch tb/${top_module}_conn.sv
else
    echo "file tb/${top_module}_conn.sv exists"
fi

tb_main="
\`ifndef TB
\`define TB

\`ifdef UVM
    \`include \"uvm_pkg.sv\"
\`endif

module automatic $top_module;

    \`ifdef UVM
        import uvm_pkg::*; 
    \`endif
    
    //Global Clock and Reset
    \`include \"${top_module}_gcr.sv\"

    //Connect BFM to DUT
    \`include \"${top_module}_conn.sv\"

    \`ifdef UVM
        \`include \"${top_module}_test_top.sv\"
        
        initial begin
            run_test();
        end
    \`endif

endmodule : $top_module

\`endif //TB
"

echo "$tb_main" > tb/$top_module.sv

#script
if [ ! -d script ]; then
    mkdir -pv script
else
	echo "directory script exists"
fi
#script/bash
if [ ! -d script/bash ]; then
	mkdir -pv script/bash
else
	echo "directory script/bash exists"
fi
if [ ! -e script/bash/run.sh ]; then
	touch script/bash/run.sh
    chmod u+x script/bash/run.sh
else
	echo "file script/bash/run.sh exists"
fi
if [ ! -e script/bash/run.cfg ]; then
	touch script/bash/run.cfg
else
	echo "file script/bash/run.cfg exists"
fi

echo "$run_main" > script/bash/run.sh

#script/python
if [ ! -d script/python ]; then
	mkdir -pv script/python
else
	echo "directory script/python exists"
fi

#run
if [ ! -d run ]; then
	mkdir -pv run 
else
	echo "directory run exists"
fi
#run/cfg
if [ ! -d run/cfg ]; then
	mkdir -pv run/cfg
else
	echo "directory run/cfg exists"
fi
#run/cfg/vlg.mk
if [ ! -e run/cfg/vlg.mk ]; then
	touch  run/cfg/vlg.mk
else
	echo "file run/cfg/vlg.mk exists"
fi
#run/cfg/macro.mk
if [ ! -e run/cfg/macro.mk ]; then
	touch  run/cfg/macro.mk
else
	echo "file run/cfg/macro.mk exists"
fi
#run/cfg/lint.mk
if [ ! -e run/cfg/lint.mk ]; then
	touch  run/cfg/lint.mk
else
	echo "file run/cfg/lint.mk exists"
fi
#run/cfg/dbg.mk
if [ ! -e run/cfg/dbg.mk ]; then
	touch  run/cfg/dbg.mk
else
	echo "file run/cfg/dbg.mk exists"
fi
#run/cfg/solver.mk
if [ ! -e run/cfg/solver.mk ]; then
	touch  run/cfg/solver.mk
else
	echo "file run/cfg/solver.mk exists"
fi
#run/cfg/uvm.mk
if [ ! -e run/cfg/uvm.mk ]; then
	touch  run/cfg/uvm.mk
    echo -e "$uvm_mk_main" > run/cfg/uvm.mk 
else
	echo "file run/cfg/uvm.mk exists"
fi

#run/cfg/assert.mk
if [ ! -e run/cfg/assert.mk ]; then
	touch  run/cfg/assert.mk
else
	echo "file run/cfg/assert.mk exists"
fi
#run/cfg/cov.mk
if [ ! -e run/cfg/cov.mk ]; then
	touch  run/cfg/cov.mk
else
	echo "file run/cfg/cov.mk exists"
fi
#run/cfg/log.mk
if [ ! -e run/cfg/log.mk ]; then
	touch  run/cfg/log.mk
else
	echo "file run/cfg/log.mk exists"
fi
#run/cfg/dump.mk
if [ ! -e run/cfg/dump.mk ]; then
	touch  run/cfg/dump.mk
else
	echo "file run/cfg/dump.mk exists"
fi
#run/cfg/ams.mk
if [ ! -e run/cfg/ams.mk ]; then
	touch  run/cfg/ams.mk
else
	echo "file run/cfg/ams.mk exists"
fi

#run/log
if [ ! -d run/log ]; then
	mkdir -pv run/log
else
	echo "directory run/log exists"
fi
#run/log/cmp
if [ ! -d run/log/cmp ]; then
	mkdir -pv run/log/cmp
else
	echo "directory run/log/cmp exists"
fi
#run/log/sim
if [ ! -d run/log/sim ]; then
	mkdir -pv run/log/sim
else
	echo "directory run/log/sim exists"
fi
#run/log/rgs
if [ ! -d run/log/rgs ]; then
	mkdir -pv run/log/rgs
else
	echo "directory run/log/rgs exists"
fi
#run/wave
if [ ! -d run/wave ]; then
	mkdir -pv run/wave
else
	echo "directory run/wave exists"
fi
#run/wave/wlf
if [ ! -d run/wave/wlf ]; then
	mkdir -pv run/wave/wlf
else
	echo "directory run/wave/wlf exists"
fi
#run/wave/shm
if [ ! -d run/wave/shm ]; then
	mkdir -pv run/wave/shm
else
	echo "directory run/wave/shm exists"
fi
#run/wave/fsdb
if [ ! -d run/wave/fsdb ]; then
	mkdir -pv run/wave/fsdb
else
	echo "directory run/wave/fsdb exists"
fi
#run/wave/vpd
if [ ! -d run/wave/vpd ]; then
	mkdir -pv run/wave/vpd
else
	echo "directory run/wave/vpd exists"
fi
#run/wave/vcd
if [ ! -d run/wave/vcd ]; then
	mkdir -pv run/wave/vcd
else
	echo "directory run/wave/vcd exists"
fi
#run/cov
if [ ! -d run/cov ]; then
	mkdir -pv run/cov
else
	echo "directory run/cov exists"
fi
#run/cov/cfg
if [ ! -d run/cov/cfg ]; then
	mkdir -pv run/cov/cfg
else
	echo "directory run/cov/cfg exists"
fi
#run/cov/cfg/cov.cfg
if [ ! -e run/cov/cfg/cov.cfg ]; then
	mkdir -pv run/cov/cfg/cov.cfg
else
	echo "file run/cov/cfg/cov.cfg exists"
fi
#run/Makefile
if [ ! -e run/Makefile ]; then
    touch run/Makefile 
    echo "$Makefile" > run/Makefile
else
	echo "file run/Makefile exists"
fi
if [ -e script/bash/run.sh ]; then
    ln -s ../script/bash/run.sh run/run
fi

#doc/readme.md
if [ ! -e doc/readme.md ]; then
	touch doc/readme.md
else
	echo "file doc/readme.md exists"
fi

#sw
if [ ! -d sw ]; then
	mkdir -pv sw
else
	echo "directory sw exists"
fi

if [ ! -d sw/inc ]; then
	mkdir -pv sw/inc
else
	echo "directory sw/inc exists"
fi

if [ ! -d sw/src ]; then
	mkdir -pv sw/src
else
	echo "directory sw/src exists"
fi

if [ ! -e sw/src/main.c ]; then
	mkdir -pv sw/src/main.c
else
	echo "file sw/src/main.c exists"
fi

#echo to doc/readme.md and console
echo "$tb_help" | tee doc/readme.md

echo "$run_help"
