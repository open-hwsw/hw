#!/bin/bash

#bug
if [[ ! -d bug ]]; then
    mkdir -pv bug
fi

#doc
if [[ ! -d doc ]]; then
    mkdir -pv doc
fi

#flist
if [[ ! -d flist ]]; then
    mkdir -pv flist
    touch flist/tb.f
    touch flist/rtl.f
    echo -e "-F rtl.f
+incdir+../vip
+incdir+../env
+incdir+../ral
+incdir+../tc
incdir+../tb
../tb/tb.sv" > flist/tb.f
fi

#model
if [[ ! -d model ]]; then
    mkdir -pv model

    if [[ ! -d model/c ]]; then
        mkdir -pv model/c
    fi

    if [[ -d model/c_plus_plus ]]; then
        mkdir -pv model/c_plus_plus

        if [[ -d model/c_plus_plus/systemc ]]; then
            mkdir -pv model/c plus plus/systemc
        fi

    fi

    if [[ ! -d model/python]]; then
        mkdir -pv model/python    
    fi

    if [[ -d model/matlab ]]; then
        mkdir -pv model/matlab
    fi

    if [[ -d model/systemverilog ]]; then
        mkdir -pv model/systemverilog
    fi

    if [[ -d model/verilog ]]; then
        mkdir -pv model/verilog
    fi

    if [[ -d model/vhdl ]]; then
        mkdir -pv model/vhdl
    fi
fi

#vip
if [[ ! -d vip ]]; then
    mkdir -pv vip
fi

#ral
if [[ ! -d ral ]]; then
    mkdir -pv ral
fi

#env
if [[ ! -d env ]]; then
    mkdir -pv env
fi

#tc
if [[ ! -d tc ]]; then
    mkdir -pv tc
    touch tc/test_top.sv
fi

#tb
if [[ ! -d tb ]];then
    mkdir -pv tb
    echo -e "module automatic tb;

        \`include \"test_top.sv\"

        initial begin
            run_test();
        end
    
    endmodule : tb" > tb/tb.sv
fi

#script
if [[ ! -d script ]]; then
    mdkir -pv script

    if [[ ! -d script/shell ]]; then
        mkdir -pv script/shell
        touch script/shell/run.sh
        chmod u+x script/shell/run.sh
    fi

    if [[ ! -d script/python ]]; then
        mkdir -pv script/python
        if [[ ！ -d script/python ]]; then
            mkdir -pv script/python
        fi
    fi
fi

#sim
if [[ ! -d sim ]];then
    mkdir -pv sim
    touch sim/Makefile
    ln -s ../script/shell/run.sh sim/run

    if [[ ! -d sim/cfg ]]; then
        mkdir -pv sim/cfg
        touch sim/cfg/vlg.mk
        touch sim/cfg/assert.mk
        touch sim/cfg/cov.mk
        touch sim/cfg/dump.mk
        touch sim/cfg/lint.mk
        touch sim/cfg/macros.mk
        touch sim/cfg/solver.mk
        touch sim/cfg/uvm.mk
        touch sim/cfg/timescale.mk
        touch sim/cfg/log.mk
    fi

    if [[ ! -d sim/log ]]; then
        mkdir -pv sim/log

        if [[ ! -d sim/log/cmp ]]; then
            mkdir -pv sim/log/cmp
        fi
        if [[ ! -d sim/log/sim ]]; then
            mkdir -pv sim/log/sim
        fi
        if [[ ! -d sim/log/rgs ]]; then
            mkdir -pv sim/log/rgs
        fi
    fi

    if [[ ! -d sim/wave ]]; then
        mkdir -pv sim/wave
        
        if [[ ! -d sim/wave/fsdb ]]; then
            mkdir -pv sim/wave/fsdb
        fi
        if [[ ! -d sim/wave/vcd ]]; then
            mkdir -pv sim/wave/vcd
        fi
        if [[ ! -d sim/wave/vpd ]]; then
            mkdir -pv sim/wave/vpd
        fi
    fi

    if [[ ! -d sim/cov ]]; then

        mkdir -pv sim/cov
        
        if [[ ! -d sim/cov ]]; then
            mkdir -pv sim/cov/cfg
            touch     sim/cov/cfg/cov.cfg
        fi

    fi

fi

#Makefile
echo -e "CMP_OPTS   ?=
SIM_OPTS   ?=
VERDI_OPTS ?=
DVE_OPTS   ?=

TB_FILES    = ../flist/tb.f
TOP_MODULE ?= tb

USER_DEF_CMP_OPTS +=
USER_DEF_SIM_OPTS +=

MODE    = \$(shell getconf LONG_BIT)
ifeq (\$(MODE), 64)
    CMP_OPTS += -full64
endif

CPUS    = \$(shell nproc)
CMP_OPTS += -j\$(CPUS)

include cfg/vlg.mk
include cfg/macros.mk
include cfg/lint.mk
include cfg/dbg.mk
include cfg/solver.mk
include cfg/uvm.mk
include cfg/assert.mk
include cfg/cov.mk
include cfg/log.mk
include cfg/dump.mk

cmp:
    vcs -V \$(CMP_OPTS) \$(USER_DEF_CMP_OPTS) -f \$(TB_FILES) -top \$(TOP_MODULE)

sim:
    simv \$(SIM_OPTS) \$(USER_DEF_SIM_OPTS)
	@echo \"\"
	@echo \"+-----------------------------------------------------------------+\"
	@echo \"+     Compile    log    :   ./log/cmp/cmp.log                      \"
	@echo \"+     Simulation log    :   ./log/sim/\$(tc_full_name).log         \"
    @echo \"+     Simulation wave   :   ./log/wave/\$(tc_full_name).fsdb       \"
	@echo \"+     Coverage   check  :   dve -full64 -cov -dir ./cov/cm.vdb &   \"
	@echo \"+-----------------------------------------------------------------+\"
	@echo \"\"

wav:
    verdi -sv -ntb_opts uvm-\$(UVM_VER) -ssf \$(WAVE_DIR) -nologo -f \$(TB_FILES) -ptrTitle \$(TOP_MODULE) -top \$(TOP_MODULE)

cov_verdi:
    verdi -cov -covdir \$(COV_DIR)/\$(TOP_MODULE).vdb

clr:
    @find . -type f -name \"*.log\" -delete
    @find . -type f -name \"*.fsdb\" -delete
    @find . -type f -name \"*.vdb\" -delete
    @rm -rf *simv*
    @rm -rf *.daidir
    @rm -rf csrc vc_hdrs.h ucli.key
    @rm -rf vdCovLog
    @rm -rf stack.info.*
    @rm -rf urgReport
    @rm -rf *.vpd
    @rm -rf vcs.cfg
    @rm -rf pli_learn.tab
    @rm -rf novas.* verdiLog
    @rm -rf DVEfiles
    @rm -rf ova.report.disablelog
    @rm -rf ova.report
    @rm -rf xsim.dir
    @rm -rf xvlog.pb
    @rm -rf .__solver_cache__
	@echo \"\"
	@echo \"+-------------------------------------------+\"
	@echo \"+            clean done ... ...             \"
	@echo \"+-------------------------------------------+\"
	@echo \"\"  " > sim/Makefile

#vlg.mk
echo -e "SV_EN   ?= 1
V2K_EN  ?= 1
V95_EN  ?= 1

ifeq (\$(SV_EN),1)
    CMP_OPTS += -sverilog
endif

ifeq (\$(V2K_EN),1)
    CMP_OPTS += +v2k
endif" sim/cfg/vlg.mk

#assert.mk
echo -e "SVA_EN         ?= 1
SVA_FAIL_MAX_NUM ?= 20
SVA_SUCC_EN      ?= 1
SVA_SUCC_MAX_NUM ?= 20

ifeq (\$(SVA_EN), 1)
    CMP_OPTS += -assert enable_diag -assert dbgopt
    SIM_OPTS += -assert maxfail=\$(SVA_FAIL_MAX_NUM) +fsdb_sva_index_info +fsdb+sva_status
ifeq (\$(SVA_SUCC_EN), 1)
    SIM_OPTS += -assert success -assert summary +maxsuccess=\$(SVA_SUCC_MAX_NUM) +fsdb+sva_success
endif
    SIM_OPTS += -assert report=ova.report
else
    CMP_OPTS += -assert disable
endif" > sim/cfg/assert.mk

#cov.mk
echo -e "COV_EN         ?= 0
CODE_COV_EN     ?= 0
SVA_COV_EN      ?= 0
COV_DIR          = cov

ifeq (\$(COV_EN), 1)

ifeq (\$(CODE_COV_EN), 1)
    CMP_OPTS += -cm line+cond+fsm+tgl+branch -cm_dir \$(COV_DIR)/\$(TOP_MODULE)..vdb -cm_hier cov/cfg/cov.cfg
    SIM_OPTS += -cm line+cond+fsm+tgl+branch -cm_log \$(COV_DIR)/cov.log
endif

ifeq (\$(SVA_EN), 1)

ifeq (\$(SVA_COV_EN), 1)
    CMP_OPTS += -cm assert
    SIM_OPTS += -cm assert
else
    CMP_OPTS += -assert disable_cover
endif

endif

ifeq (\$(tc),)

ifeq (\$(seed),)
    SIM_OPTS += -cm_name novas
else
    SIM_OPTS += -cm_name novas_\$(seed)
endif

else

ifeq (\$(seed),)
    SIM_OPTS += -cm_name \$(tc)
else
    SIM_OPTS += -cm_name \$(tc)_\$(seed)
endif

endif

endif" > sim/cfg/cov.mk

#cov.cfg
echo -e "#+tree
#-tree
#+module
#-module
#+moduletree
#-moduletree
#+file
#-file" > sim/cov/cfg/cov.cfg

#dbg.mk
echo -e "DBG_EN     ?= 1
GUI_EN      ?= 0

ifeq (\$(DBG_EN),1)
    CMP_OPTS += -kdb -debug_access+all -lca -debug_all
endif

ifeq (\$(GUI_EN),1)
    SIM_OPTS += -gui
endif

#endless loop debug
LOOP_NUM ?= 1000
#CMP_OPTS += +vcs+loopreport+\$(LOOP_NUM)" > sim/cfg/dbg.mk

#lint.mk
echo -e "CMP_OPTS += +lint=TFIPC-L" > sim/cfg/lint.mk

#log.mk
echo -e "CMP_LOG_DIR ?= log/cmp
SIM_LOG_DIR ?= log/sim

CMP_OPTS += -l \$(CMP_LOG_DIR)/cmp.log
SIM_OPTS += -l \$(SIM_LOG_DIR)/\$(tc_full_name).log" > sim/cfg/log.mk

#macros.mk
echo -e "MACROS_DEBUG_EN = 0

ifeq (\$(MACROS_DEBUG_EN), 1)
    CMP_OPTS += -Xrawtoken=debug_macros
endif" > sim/cfg/macros.mk

#solver.mk
echo -e "SEED_MANUAL     ?= 1
seed        ?= \$(shell data \"+%m%d%H%M%S\")

ifeq (\$(SEED_MANUAL),1)
    SIM_OPTS += ntb_random_seed=\$(seed)
else
    SIM_OPTS += ntb_random_seed_automatic
endif

SIM_OPTS += solver_array_size_warn=10000" > sim/cfg/solver.mk

#timescale.mk
echo -e "CMP_OPTS += -override_timescale=1ns/1ps" > sim/cfg/timescale.mk

#uvm.mk
echo -e "UVM_EN             ?= 1
UVM_VER                 ?= 1.2
DPI_HDL_API_EN          ?= 1
UVM_REG_ADDR_WIDTH      ?= 64
UVM_REG_DATA_WIDTH      ?= 64
UVM_DBG                 ?= 0
UVM_PHASE_TRACE_EN      ?= 0
UVM_OBJECTION_TRACE_EN  ?= 0
UVM_RESOURCE_TRACE_EN   ?= 0
UVM_CONFIG_DB_TRACE_EN  ?= 0

tc      ?=
vl      ?= UVM_MEDIUM
qc      ?= 10
to      ?= 5000000000

ifeq (\$(UVM_EN),1)

ifeq (\$(UVM_VER), 1.1)
    CMP_OPTS += -ntb_opts uvm-1.1
else ifeq (\$(UVM_VER), 1.2)
    CMP_OPTS += -ntb_opts uvm-1.2
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

endif" > sim/cfg/uvm.mk

#dump.mk
echo -e "WAVE_EN        ?= 1
WAVE_FORMAT     ?= FSDB
DUMP_STRENGTH   ?= 1
DUMP_FORCE      ?= 1

ifeq (\$(WAVE)_EN), 1)

ifeq (\$(WAVE_FORMAT), FSDB)
    WAVE_DIR = wave/fsdb
    CMP_OPTS += +vcs+fsdbon
ifeq (\$(DUMP_STRENGTH), 1)
    SIM_OPTS += +fsdb+strength=on
endif

ifeq (\$(DUMP_FORCE), 1)
    SIM_OPTS += +fsdb+force
endif

else ifeq (\$(WAVE_FORMAT), VPD)
    WAVE_DIR = wave/vpd
else
    WAVE_DIR = wave/vcd
endif

SIM_OPTS += +fsdbfile+\$(WAVE_DIR)/\$(tc_full_name).fsdb

endif" > sim/cfg/dump.mk

echo -e "
|folder                 |description                                        |
|---                    |---                                                |
|flist                  |file list                                          |
|model                  |simulation model                                   |
|model/c_plus_plus      |c plus plus language model                         |
|model/matlab           |matlab language model                              |
|model/python           |python language model                              |
|model/systemverilog    |systemverilog language model                       |
|model/systemc          |systemclanguage model                              |
|model/verilog          |verilog Language model                             |
|vip                    |uvm agent,uvm driver,uvm monitor,uvm sequencer,etc.|
|env                    |uvm env                                            |
|tc                     |uvm_test                                           |
|bug                    |record buglog and waveform                         |
|ral                    |register abstraction layer                         |
|tb                     |testbench                                          |
|script                 |script                                             |
|sim                    |Makefile                                           |
|sim/log                |logs                                               |
|sim/log/cmp            |compile log                                        |
|sim/Log/sim            |simulation log                                     |
|sim/wave               |waveforms                                          |
|sim/wave/fsdb          |fast signal database                               |
|sim/wave/vcd           |value change dump                                  |
|sim/wave/vpd           |synopsys                                           |
|sim/cov                |coverage                                           |
|sim/cov/cfg            |coverage configuration                             |
|sim/cov/*.vdb          |coverage database                                  |
|sim/cfg                |sub Makefile files                                 |" > doc/readme.md

run="#!/bin/bash

declare -A tcs

help info=\"
.open verdi
run -v

.generate test case
. run -tcgen -tcidx xx -tcname xx               :generate a new test case
. run -tcgen -tcidx xx -tcname xx -tcref xx     :generate a new test case from a old testcase

.delete test case
. run -tcdel xx                                 :delete a test case by tcidx
. run -tedel -tcidx xx                          :delete a test case by tcidx
. run -tcdel -tcname xx                         :delete a test case by tcname

.refresh test case
. run -tcrtsh                                   :refresh other test case that copy form other path

.view test case information
. run -tclist                                   :show all test case
. run -tclist -tcidx xx                         :get tc name

.run test case in post-processing mode
. run xx
. run xx xx
. run xx -seed xx
. run -tcidx xx
. run -tcidx xx -seed xx
. run -tcname xx
. run -tcname xx -seed xx

.run test case in interactive mode
. run xx -gui
. run xx xx -gui
. run xx -seed xx -gui
. run -tcidx xx -gui
. run -tcidx xx -seed xx -gui
. run -tcname xx -gui
. run -tcname xx -seed xx -gui

.run test case in regress mode(-waveoff: turn off dump)
. run -rgsnum xx
. run xx -rgsnum xx
. run -tcidx xx -rgsnum xx
. run -tcname xx -rgsnum xx
. run -tcidx xx -tcname xx -rgsnum xx

.generate vip
. run -viplist
. run -vipgen -vipname xx

.delete vip
. run -vipdel -vipname xx

.generate ral
. run -ralgen -topblock xx

.set top module name
run -top xx : xx is top module name

\"

opt=\$(getopt -o -v -a -l tcgen,tcdel,tcidx:,tcname:,tcref:,tclist,tcrfsh,seed:,gui,rgsnum:,waveoff,vipgen,vipdel,vipname:,viplist,ralgen,topblock:,bug:,help,top: -- \"\$@\")

if [ \$? != 0 ]; then
    exit 1;
fi

eval set -- \"\$opt\"

if [ \"\$1\" == \"--\" ] && [ -z \"\$2\" ]; then
    echo \"\$help_info\"
fi

while :; do

    case \$1 in
        --help)
            echo \"$(help_info)\"
            shift 1
            exit 0
            ;;
        --top)
            top=\$2
            shift 2
            ;;
        --tcgen)
            tcgen=1
            shift 1
            ;;
        --tcidx)
            tcidx=\$2
            shift 2
            ;;
        --tcname)
            tcname=\$2
            shift 2
            ;;
        --tcdel)
            tcdel=1
            shift 1
            ;;
        --tcref)
            tcref=\$2
            shift 2
            ;;
        --tclist)
            tclist=1
            shift 1
            ;;
        --tcrfsh)
            tcrfsh=1
            shift 1
            ;;
        --seed)
            seed=\$2
            shift 2
            ;;
        --gui)
            gui=1
            shift 1
            ;;
        --rgsnum)
            rgsnum=\$2
            shift 2
            ;;
        --waveoff)
            waveoff=1
            shift 1
            ;;
        --vipgen)
            vipgen=1
            shift 1
            ;;
        --vipdel)
            vipgen=1
            shift 1
            ;;
        --viplist)
            viplist=1
            shift 1
            ;;
        --vipname)
            vipname=\$2
            shift 2
            ;;
        --ralgen)
            ralgen=1
            shift 1
            ;;
        --topblock)
            topblock=\$2
            shift 2
            ;;
        --bug)
            bug=\$2
            shift 2
            ;;
        -v)
            verdi=1
            shift 1
            ;;
        --)
            break
            ;;
        '')
            break
            ;;
        *)
            ;;
    esac
done

if [ -n \"\verdi\" ]; then
    make wav
    exit 0
fi

if [ -n \"\$top\" ]; then
    mv ../tb/*tb.sv ../tb/\$top.sv
    sed -i \"s/\\b\\(\\w*tb\\)/\$top/\" ../tb/\$top.sv
    mv  ../flist/*tb.f ../flist/\$top.f
    sed -i \"s/\\(.*\/\\).*tb\\(.sv\\)/\\1\$top\\2/g\" ../flist/\$top.f
    sed -i \"s/\\(.*t\\/\\).*\\(.f\\)/\\1\$top\\2/g\" Makefile
    sed -i \"s/\\(TOP_MODULE ?= \\).*$/\\1\$top/g\" Makefile
    exit 0
fi

if [ -n \"\$tcrfsh\" ]; then

    tcname=\$(find ../tc/ -type f -name \"tc*\" | sed -e 's/\.sv//' | sed -e 's/..\/tc\///')

    for i in \$tcname;
    do
        for j in \$(tcs[@]);
        do
            if [ \"\$i\" == \"\$j\" ]; then
                tcname=\$(echo \$tcname | sed \"s/\$i//\")
            fi
        done
    done

    tcidx=()

    for i in \$(!tcs[@]);
    do
        tcidx+=(\"\$(echo \$i | sed -n '/^[0-9]*$/p')\")
    done

    tcidx_max=0
    for i in \$(tcidx[@])
    do
        if (( \$i > \$tcidx_max )); then
            tcidx_max=\$i
        fi
    done

    for i in \$tcname;
    do
        tcidx_max=\$((\$tcidx_max + 1))
        echo \"\\\`include \\\"\$i.sv\\\"\" >> ../tc/test_top.sv
        sed -i \"5i tcs[\\\"\$tcidx_max\\\"]=\\\"\$i\\\"\" ../script/shell/run.sh
    done

    exit 0
fi

if [-n \"\$tcgen\" ]; then
    if [ -z \$tcidx ] && [ -z \$tcname ]; then
        echo \"please type valid tcidx and tcname\"
        exit 1
    elif [ -z \$tcidx ] && [ -n \$tcname ]; then
        echo \"please type valid tcidx\"
        exit 1
    elif [ -n \$tcidx ] && [ -z \$tcname ]; then
        echo \"please type valid tcname\"
        exit 1
    else
        
        for key in \"\${!tcs[@]}\"
        do
            if [ \"\$key\" == \"\$tcidx\" ]; then
                echo \"tcidx is already exist, please type another tcidx\"
                exit 1
            fi
        done

        for key in \"\${tcs[@]}\"
        do
            if [ \"\$key\" == \"\$tcname\" ]; then
                echo \"tcname is already exist, plese type another tcname\"
                exit 1
            fi
        done

        if [ -z \"\$tcref\" ]; then
            echo \"\\\`include \\\"\$tcname.sv\\\"\" >> ../tc/test_top.sv
            sed -i \"5i tcs\\[\\\"\$tcidx\\\"\\]=\\\"\$tcname\\\"\" ../script/shell/run.sh
        else

            if [ \"\$tcidx\" -eq \"\$tcref\" ]; then
                echo \"invalid: tcidx == tcref\"
                exit 1
            fi

            for key in \"\${!tcs[@]}\"
            do
                if [ \"\$key\" -eq \"\$tcref\" ]; then
                    tcidx_match=1
                    break
                fi
            done

            if [ -z \"\$tcidx_match\" ]; then
                echo \"invalid: tcref is cannot be found from old test case\"
                exit 1
            else
                cp ../tc/\${tcs[\$tcref]}.sv ../tc/\$tcname.sv
                sed -i \"s/Date://g\" ../tc/\$tcname.sv
                sed -i \"s/\\<\${tcs[\$tcref]}\\>/\$tcname/g\" ../tc/\$tcname.sv
                sed -i \"s/\`echo \"\${tcs[\$tcref]}\" | tr a-z A-Z\` /\`echo \"\$tcname\" | tr a-z A-Z\`/g\" ../tc/\$tcname.sv
                sed -i \"5i tcs\\[\\\"\$tcidx\\\"\\]=\\\"\$tcname\\\"\" ../script/shell/run.sh
            fi
        fi

    exit 0
fi

if [ -n \"\$tcdel\" ]; then
    if [ -n \"\$tcidx\" ]; then
        if [[ -n \"\${tcs[\$tcidx]}\" ]]; then
            read -p \"Are you sure delete \$tcidx: (y/n)?\" ack
            if [[ \$ack == [Yy] ]] || [ -z \"\$ack\" ]; then
                rm -rf ../tc/\${tcs[\$tcidx]}.sv
                sed -i \"/\<\${tcs[\$tcidx]}\>/d\" ../tc/test_top.sv
                sed -i \"/\\<tcs\\[\\\"\$tcidx\\\"\\]=\\\$\${tcs[\$tcidx]}\\\"/d\" ../script/shell/run.sh
                exit 0
            else
                exit 0
            fi
        fi
        echo \"delete test failed bacause \$tcidx cannot be found in test list\"
        exit 1
    elif [ -n \"\$tcname\" ]; then
        for key in \"\${tcs[@]}\"
        do
            if [ \$key == \$tcname ]; then
                read -p \"Are you sure delete \$tcname: (y/n)?\" ack
                if [[ \$ack == [Yy] ]] || [ -z \"\$ack\" ]; then
                    rm -rf ../tc/\${tcname}.sv
                    sed -i \"/\<\${tcname}\>/d\" ../tc/test_top.sv
                    sed -i \"/\\<tcs\\[\\\".*\\\"\\]=\\\"\${tcname}\\\"/d\" ../script/shell/run.sh
                    exit 0                    
                else
                    exit 0
            fi
        done

        echo \"delete test failed bacause \$tcname cannot be found in test list\"
        exit 1
    elif [ -n \"\$2\" ]; then
        if [[ -n \"\${tcs[\$2]}\" ]]; then
            read -p \"Are you sure delete \$2: (y/n)?\" ack
            if [[ \$ack == [Yy] ]] || [ -z \"\$ack\" ]; then
                rm -rf ../tc/\${tcs[\$2]}.sv
                sed -i \"/\<\${tcs[\$2]}\>/d\" ../tc/test_top.sv
                sed -i \"/\\<tcs\\[\\\"\$2\\\"\\]=\\\$\${tcs[\$2]}\\\"/d\" ../script/shell/run.sh
                exit 0
            else
                exit 0
            fi
        fi
    else
        echo \"please type a invalid tcidx or tcname\"
        exit 1
    fi
fi

if [ -n \"\$tclist\" ]; then
    if [ \${#tcs[@]} -eq θ ]; then
        echo \"test case is null\"
        exit 0
    fi
    if [ -n \"\$tcidx\" ]; then
        echo \${tcs[\$tcidx]}
        exit 0
    fi
    printf \"there are (%d) test case below:\n\" \${#tcs[@]}
    printf \"%-10s%-10s\n\" tcidx tcname
    sorted_key=\$(for tcidx in \"\${!tcs[@]}\"; do echo \"\$tcidx\"; done | sort-n)
    for tcidx in \$sorted_key;
    do
        printf \"%-10s%-10s\n\" \$tcidx \${tcs[\$tcidx]}
    done
    exit 0
fi

if [ -n \"\$bug\" ]; then

    rm -rf ../bug/\$bug
    mkdir ../bug/\$bug

    cp log/sim/\$bug.log ../bug/\$bug
    if [ \$? -eq l ]; then
        exit 1
    fi

    cp wave/fsdb/\$bug.fsdb ../bug/\$bug
    if [ \$? -eq l ]; then
        exit 1
    fi

    read -p \"please type some bug keyword to trace:\" ack

    if [ -n \"\$ack\" ]; then
        echo \"\$ack\" >> ../bug/\$bug/bug_info.md
    fi

    exit 0
fi

rgs_analysis () {
    rgs_Log item=\$(find log/rgs/\$rgs_begin time/*.log -group \$(groups) -user \$(whoami) -type f)
    for i in \$rgs_log_item;
    do
        uvm rpt=\$(grep -E \"^UVM_[W,E,F].*:\" \$i | grep -oE\"[0-9]+\")

        for j in \$uvm_rpt;
        do
            uvm_rpt_sum=\$((\$uvm_rpt_sum+\$j))
            failNum=0
            passNum=0
            if [[ \$uvm_rpt_sum -gt 0 ]]; then
                echo \"\$i @ FAILED!!!\" >> log/rgs/\$rgs_begin_time/rgs_summary.log
                failNum=\$((\$failNum + 1))
            else
                echo \"\$i @ PASSED!!!\" >> log/rgs/\$rgs_begin_time/rgs_summary.log
                passNum=\$((\$passNum + 1))                
            fi
            uvm_rpt_sum = 0;
        done
    done

    echo \"++++++++++++++++++++++++++++++++++++++++++++++++\" >> log/rgs/\$rgs_begin time/rgs_summary.log
    echo \"+The total number of failed test case =\$failNum\" >> log/rgs/\$rgs_begin time/rgs_summary.log
    echo \"+The total number of passed test case =\$passNum\" >> log/rgs/\$rgs_begin time/rgs_summary.log
    echo \"++++++++++++++++++++++++++++++++++++++++++++++++\" >> log/rgs/\$rgs_begin time/rgs_summary.log

}

if [ -n \"\$rgsnum\" ]; then

    make cmp

    if [ \$? -ne θ ]; then
        exit 2
    fi

    rgs_begin_time=\$(date +%Y-%m-d-%H-M-%S)

    mkdir -p log/rgs/\$rgs_begin _time

    if [ -n \"\$tcidx\" ] && [ -z \"\$tcname\" ]; then

        if [[ -n \"\${tcs[\$tcidx]}\" ]]; then

            for ((i=0; i<\$rgsnum; i++))
            do
                if [ -n \"\$waveoff\" ]; then
                    make sim tc=\${tcs[\${tcidx}]} WAVE_EN=0 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                else
                    make sim tc=\${tcs[\${tcidx}]} WAVE_EN=1 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                fi
            done

            rgs_analysis

            exit 0
        else
            echo \"tcidx is not found in test case list\"
            exit 1
        fi
    elif [ -z \"\$tcidx\" ] && [ -n \"\$tcname\" ]; then
        for key in \"\${tcs[@]}\"
        do
            if [ \${key} == \${tcname} ]; then
                for ((i=0;i<\$rgsnum;i++))
                do
                    if [ -n \"\$waveoff\" ]; then
                        make sim tc=\${tcname} WAVE_EN=θ SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                    else
                        make sim tc=\${tcname} WAVE_EN=1 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                    fi
                done

                rgs_analysis

                exit 0
            fi
        done

        echo \"tcname is not found in test case list\"
        exit 1
    elif [ -n \"\$tcidx\" ] && [ -n \"\$tcname\" ]; then

        if [ \${tcs{\$tcidx]} != \$tcname ]; then
            echo\"tcidx must match tcname\"
            exit 1
        fi

        for (( i=0; i<\$rgsnum; i++ ))
        do
            if [ -n \"\$waveoff\" ]; then
                make sim tc=\${tcname} WAVE_EN=θ SIM_LOG_DIR=log/rgs/\$rgs_begin_time
            else
                make sim tc=\${tcname} WAVE_EN=1 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
            fi
        done

        rgs_analysis
        exit 0
        
    else

        for ((i=0; i < \$rgsnum; i++))
        do
            for key in \"\${tcs[@]}\"
            do
                if [ -n \"\$waveoff\" ]; then
                    make sim tc=\$key WAVE_EN=0 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                else
                    make sim tc=\$key WAVE_EN=1 SIM_LOG_DIR=log/rgs/\$rgs_begin_time
                fi
            done
        done

        rgs_analysis
        exit 0
    fi
else
    if [ -n \"\$tcidx\" ] && [ -z \"\$tcname\" ]; then
        if [[ -z \"\${tcs[\$tcidx]}\" ]]; then
            echo \"invalid tcidx\"
            exit 1
        fi
    elif [ -z \"\$tcidx\" ] && [ -n \"\$tcname\" ]; then
        for key in \"\${tcs[@]}\"
        do
            if [ \$key == \$tcname ]; then
                break;
            fi
        done
    elif [ -z \"\$tcidx\" ] && [ -z \"\$tcname\" ]; then
        if [ -z \"\$2\" ]; then
            exit 1
        else
            tcidx=\$2
        fi
        if [ -z \"\$seed\" ] && [ -n \"\$3\" ]; then
            seed=\$3
        fi
        if [[ -z \"\${tcs[\$tcidx]}\" ]]; then
            echo \"invalid tcidx\"
            exit 1
        fi

        read -p \"Are you want to recompile before simulation(y/n)?\" ack

        if [[ \$ack == [Yy] ]] || [ -z \"\$ack\" ]; then
            make cmp
            if [ \$? -ne 0 ]; then
                exit 2
            fi
        fi

        if [ -z \"\$seed\" ]; then
            if [ -n \"\$tcidx\" ]; then
                if [[ -n \"\${tcs[\$tcidx]}\" ]]; then

                    if [ -n \"\$gui\" ]; then
                        make sim tc=\${tcs[\$tcidx]} GUI_EN=1 COV_EN=0
                    else
                        make sim tc=\${tcs[\$tcidx]} COV_EN=0
                fi
                exit 0
            else
                echo \"invalid tcidx\"
                exit 1
            fi
        elif [ -n \"\${tcname}\" ]; then
            for key in \"\${tcs[@]}\"
            do
                if [ \$key == \$tcname ]; then
                    if [ -n \"\$gui\" ]; then
                        make sim tc=\${tcname} GUI_EN=1 COV_EN=0
                    else
                        make sim tc=\${tcname} COV_EN=0
                    fi
                    exit 0
                fi
            done
            echo \"invalid tcname\"
            exit 1
        fi
    else
        #user-defined seed
        if [ -n \"\$tcidx\" ]; then
            if [[ -n \"\${tcs[\$tcidx]}\" ]]; then
                if [ -n \"\$gui\" ]; then
                    make sim  tc=\${tcs[\$tcidx]} GUI_EN=1 seed=\$seed COV_EN=0
                else
                    make sim  tc=\${tcs[\$tcidx]} GUI_EN=1 seed=\$seed COV_EN=0
                fi
            else
                echo \"invalid tcidx\"
            fi
        elif [ -n \"\${tcname}\" ]; then
            for key in \"\${tcs[@]}\"
            do
                if [ \$key == \$tcname ]; then
                    if [ -n \"\$gui\" ]; then
                        make sim tc=\$tcname GUI_EN=1 seed=\$seed COV_EN=0
                    else
                        make sim tc=\$tcname seed=\$seed COV_EN=0
                    fi
                fi
            done
        fi
    fi

fi
"

echo "$run" > script/shell/run.sh

echo 'successful ...'