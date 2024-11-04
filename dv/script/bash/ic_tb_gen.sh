#!/usr/bin/env bash

set -e
opts=$(getopt -o h -a -l org:,prj:,top: -- "$@")
eval set -- $opts

while :; do
    case $1 in
        --org)
            org=$2
            shift 2
            ;;
        --prj)
            prj=$2
            shift 2
            ;;
        --top)
            top=$2
            shift 2
            ;;
        --)
            break
            ;;
    esac
done

if [ -z $org ]; then
    echo "please setting your organization name by -org option"
    exit 1
fi

if [ -z $prj ]; then
    echo "please setting your project name by -prj option"
    exit 1
fi

if [ -z $top ]; then
    echo "please setting your top module name by -top option"
    exit 1
else

    if [[ $top =~ ^[0-9] ]]; then
        echo "top module name cannot start with a number"
        exit 1
    fi

fi

#Shell Function Definitions
function file_gen() {

    local file=$1

    if [ ! -e ${file} ]; then
        touch ${file}
    else
        echo "file ${file} exists"
    fi

}

function dir_gen() {

    local path=$1

    if [ ! -d ${path} ]; then
        mkdir -pv ${path}
    else
        echo "directory ${path} exists"
    fi

}

function dir_arr_gen() {

    local -a arr=("${!1}")

    if [ ${#arr[@]} -gt 0 ]; then for idx in ${arr[@]}; do
            if [ ! -d ${idx} ]; then
                mkdir -pv ${idx}
            else
                echo "directory ${idx} exists"
            fi
        done
    fi

}

prj_dir=$prj

doc_dir=${prj_dir}/doc
dir_gen ${doc_dir}
echo "
|directory or file  |description                                                        |
|---                |---                                                                |
|common             |common packages                                                    |
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
|tb/tb_connect.sv   |testbench, connect bfm to dut                                      |
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
" > ${doc_dir}/tree.md

hw_dir=${prj_dir}/hw
hw_ana_dir=${hw_dir}/ana

hw_dig_dir=${hw_dir}/dig
hw_dig_de_dir=${hw_dig_dir}/de
hw_dig_de_rtl_dir=${hw_dig_de_dir}/rtl
hw_dig_de_flist_dir=${hw_dig_de_dir}/flist
hw_dig_dv_dir=${hw_dig_dir}/dv
hw_dig_dv_bt_dir=${hw_dig_dv_dir}/bt
hw_dig_dv_it_dir=${hw_dig_dv_dir}/it
hw_dig_dv_st_dir=${hw_dig_dv_dir}/st
#hw_dig_dv_agt_dir=${hw_dig_dv_dir}/agt
#hw_dig_dv_env_dir=${hw_dig_dv_dir}/env
#hw_dig_dv_flist_dir=${hw_dig_dv_dir}/flist
#hw_dig_dv_ral_dir=${hw_dig_dv_dir}/ral
#hw_dig_dv_tb_dir=${hw_dig_dv_dir}/tb
#hw_dig_dv_tc_dir=${hw_dig_dv_dir}/tc

hw_dir_arr=(${hw_dir} \
${hw_ana_dir} \
${hw_dig_dir} \
${hw_dig_de_flist_dir} ${hw_dig_de_rtl_dir} \
${hw_dig_dv_dir} ${hw_dig_dv_bt_dir} ${hw_dig_dv_it_dir} ${hw_dig_dv_st_dir} \
#${hw_dig_dv_agt_dir} ${hw_dig_dv_env_dir} ${hw_dig_dv_flist_dir} ${hw_dig_dv_ral_dir} ${hw_dig_dv_tb_dir} ${hw_dig_dv_tc_dir} \
)

dir_arr_gen hw_dir_arr[@]

file_gen ${hw_dig_de_flist_dir}/${top}.f

touch ${hw_dig_de_rtl_dir}/${top}.sv

#flist
#echo "

#-F lib.f
#-F model.f
#-F ../../de/flist/${top}.f

#+incdir+../agt
#+incdir+../ral
#+incdir+../env
#+incdir+../tc
#+incdir+../tb

#../tb/${top}_tb.sv

#" > ${hw_dig_dv_flist_dir}/${top}_tb.f

#env
#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_ENV_SV
#\`define ${org^^}_${prj^^}_${top^^}_ENV_SV
#
#//${top}_env groups together other verification components that are interrelated
#
#class ${top}_env extends uvm_env;
#    
#    \`uvm_component_utils(${top}_env)
#    
#    function new(string name = \"${top}_env\", uvm_component parent = null);
#        super.new(name, parent);
#    endfunction : new
#    
#    extern function void build_phase(uvm_phase phase);
#    extern function void connect_phase(uvm_phase phase);
#    extern function void end_of_elaboration_phase(uvm_phase phase);
#    extern function void start_of_simulation_phase(uvm_phase phase);
#    extern task run_phase(uvm_phase phase);
#    extern function void extract_phase(uvm_phase phase);
#    extern function void check_phase(uvm_phase phase);
#    extern funciton void report_phase(uvm_phase phase);
#    extern function void final_phase(uvm_phase phase);
#    
#endclass : ${top}_env
#
#virtual function void ${top}_env::build_phase(uvm_phase phase);
#    super.build_phase(phase);
#    
#    //get configuration values for the component being built
#    
#    //set configuration values for sub-components
#
#    //instantiate uvm_agent
#    
#    //instantiate uvm_scoreboard
#        
#    //instantiate other uvm_env
#    
#    //instantiate register model
#    
#endfunction : build_phase
#    
#virtual function void ${top}_env::connect_phase(uvm_phase phase);
#    super.connect_phase(phase);
#endfunction : connect_phase
#
#virtual function void ${top}_env::end_of_elaboration_phase(uvm_phase phase);
#    super.end_of_elaboration_phase(phase);
#endfunction : end_of_elaboration_phase
#
#virtual function void ${top}_env::start_of_simulation_phase(uvm_phase phase);
#    super.start_of_simulation_phase(phase);
#endfunction : start_of_simulation_phase
#
#virtual function void ${top}_env::extract_phase(uvm_phase phase);
#    super.extract_phase(phase);
#endfunction : extract_phase
#
#virtual function void ${top}_env::check_phase(uvm_phase phase);
#    super.check_phase(phase);
#endfunction : check_phase
#
#virtual function void ${top}_env::report_phase(uvm_phase phase);
#    super.report_phase(phase);
#endfunction : report_phase
#
#virtual function void ${top}_env::final_phase(uvm_phase phase);
#    super.final_phase(phase);
#endfunction : final_phase
#
#\`endif //${org^^}_${prj^^}_${top^^}_ENV_SV
#" > ${hw_dig_dv_env_dir}/${top}_env.sv

#tc
#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_BASE_TEST_SV
#\`define ${org^^}_${prj^^}_${top^^}_BASE_TEST_SV
#
#class ${top}_base_test extends uvm_test;
#    
#    ${top}_env m_${top}_env;
#
#    \`uvm_component_utils(${top}_base_test)
#    
#    function new(string name = \"${top}_base_test\", uvm_component parent = null);
#        super.new(name, parent);
#    endfunction : new
#    
#    extern function void build_phase(uvm_phase phase);
#    extern function void connect_phase(uvm_phase phase);
#    extern function void end_of_elaboration_phase(uvm_phase phase);
#    extern function void start_of_simulation_phase(uvm_phase phase);
#    extern task run_phase(uvm_phase phase);
#    extern function void extract_phase(uvm_phase phase);
#    extern function void check_phase(uvm_phase phase);
#    extern funciton void report_phase(uvm_phase phase);
#    extern function void final_phase(uvm_phase phase);
#    
#endclass : ${top}_base_test
#
#virtual function void ${top}_base_test::build_phase(uvm_phase phase);
#
#    super.build_phase(phase);
#    
#    m_${top}_env = ${top}_env::type_id::create("m_${top}_env", this);
#
#endfunction : build_phase
#    
#virtual function void ${top}_base_test::connect_phase(uvm_phase phase);
#
#    super.connect_phase(phase);
#
#endfunction : connect_phase
#
#virtual function void ${top}_base_test::end_of_elaboration_phase(uvm_phase phase);
#
#    super.end_of_elaboration_phase(phase);
#
#endfunction : end_of_elaboration_phase
#
#virtual function void ${top}_base_test::start_of_simulation_phase(uvm_phase phase);
#
#    super.start_of_simulation_phase(phase);
#
#endfunction : start_of_simulation_phase
#
#virtual task ${top}_base_test::run_phase(uvm_phase phase);
#
#    super.run_phase(phase)
#
#    phase.phase_done.set_drain_time(this, (500));
#
#endtask : run_phase
#
#virtual function void ${top}_base_test::extract_phase(uvm_phase phase);
#
#    super.extract_phase(phase);
#
#endfunction : extract_phase
#
#virtual function void ${top}_base_test::check_phase(uvm_phase phase);
#
#    super.check_phase(phase);
#
#endfunction : check_phase
#
#virtual function void ${top}_base_test::report_phase(uvm_phase phase);
#
#    super.report_phase(phase);
#
#endfunction : report_phase
#
#virtual function void ${top}_base_test::final_phase(uvm_phase phase);
#
#    uvm_report_server svr;
#
#    super.final_phase(phase);
#
#    svr = uvm_report_server::get_server();
#
#    if (svr.get_server_count(UVM_FATAL) + svr.get_server_count(UVM_ERROR) + 
#        svr.get_server_count(UVM_WARNING) > 0) begin
#        \`uvm_info(\"final_phase\",\"\\nTets Failed\\n\", UVM_LOW)
#    end else begin
#        \`uvm_info(\"final_phase\",\"\\nTets Passed\n\", UVM_LOW)
#    end
#endfunction : final_phase
#
#\`endif //${org^^}_${prj^^}_${top^^}_BASE_TEST_SV
#
#" > ${hw_dig_dv_tc_dir}/${top}_base_test.sv

#echo "
#\`include\"${top}_base_test.sv\"
#" > ${hw_dig_dv_tc_dir}/${top}_test_top.sv

#tb
#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_TB_SV
#\`define ${org^^}_${prj^^}_${top^^}_TB_SV
#
#\`ifdef UVM
#    //Include the standard UVM and VIP files and packages
#    \`include \"uvm_pkg.sv\"
#\`endif
#
#//TestBench Definitions
#module automatic ${top}_tb;
#
#    \`ifdef UVM
#        //Wildcard Import Packages
#        import uvm_pkg::*; 
#    \`endif
#
#    //Global Clock and Reset
#    \`include \"${top}_gcr.sv\"
#    
#    //DUT Module Instantiation
#
#    //Connecting the VIP BFM to the DUT
#    \`include \"${top}_connect.sv\"
#
#    \`ifdef UVM
#        //Include Test
#        \`include \"${top}_test_top.sv\"
#        
#        //Run Test
#        initial begin
#            run_test();
#            uvm_top.enable_print_topology();
#        end
#    \`endif
#
#endmodule : ${top}_tb
#
#\`endif //${org^^}_${prj^^}_${top^^}_TB_SV
#" > ${hw_dig_dv_tb_dir}/${top}_tb.sv

#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_TB_GCR_SV
#\`define ${org^^}_${prj^^}_${top^^}_TB_GCR_SV
#
#\`endif //${org^^}_${prj^^}_${top^^}_TB_GCR_SV
#" > ${hw_dig_dv_tb_dir}/${top}_tb_gcr.sv
#
#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_TB_CONNECT_SV
#\`define ${org^^}_${prj^^}_${top^^}_TB_CONNECT_SV
#
#\`endif //${org^^}_${prj^^}_${top^^}_TB_CONNECT_SV
#" > ${hw_dig_dv_tb_dir}/${top}_tb_connect.sv
#
#echo "
#\`ifndef ${org^^}_${prj^^}_${top^^}_TB_TIMING_CHECK_SV
#\`define ${org^^}_${prj^^}_${top^^}_TB_TIMING_CHECK_SV
#
#\`endif //${org^^}_${prj^^}_${top^^}_TB_TIMING_CHECK_SV
#" > ${hw_dig_dv_tb_dir}/${top}_tb_timing_check.sv

#fpga
hw_fpga_dir=${hw_dir}/fpga
hw_fpga_xdc_dir=${hw_fpga_dir}/xdc

hw_fpga_dir_arr=(${hw_fpga_dir} ${hw_fpga_xdc_dir})

dir_arr_gen hw_fpga_dir_arr[@]

touch ${hw_fpga_xdc_dir}/physical.xdc
touch ${hw_fpga_xdc_dir}/power.xdc
touch ${hw_fpga_xdc_dir}/timing.xdc
touch ${hw_fpga_xdc_dir}/waiver.xdc
touch ${hw_fpga_xdc_dir}/debug.xdc

echo "
# ------------------------------------------------------------
# netlist constraints
# ------------------------------------------------------------

# ------------------------------------------------------------
# io constraints
# ------------------------------------------------------------

# ------------------------------------------------------------
# placement constraints
# ------------------------------------------------------------

# ------------------------------------------------------------
# routing constraints
# ------------------------------------------------------------

# ------------------------------------------------------------
# config constraints
# ------------------------------------------------------------

" > ${hw_fpga_xdc_dir}/physical.xdc

echo "
# !!! IMPORTANT: the timing constraints order should be kept

# ------------------------------------------------------------
# 1. set_disable_timing
# ------------------------------------------------------------


# ------------------------------------------------------------
# 2. set_case_analysis
# ------------------------------------------------------------


# ------------------------------------------------------------
# 3. primary clocks
# ------------------------------------------------------------


# ------------------------------------------------------------
# 4. generated clocks
# ------------------------------------------------------------


# ------------------------------------------------------------
# 5. set_clock_sense 
# ------------------------------------------------------------

# ------------------------------------------------------------
# 6. set_clock_latency
# ------------------------------------------------------------


# ------------------------------------------------------------
# 7. set_propagated_clock
# ------------------------------------------------------------


# ------------------------------------------------------------
# 8. set_clock_uncertainty
# ------------------------------------------------------------


# ------------------------------------------------------------
# 9. set_input_jitter
# ------------------------------------------------------------


# ------------------------------------------------------------
# 10. set_system_jitter
# ------------------------------------------------------------


# ------------------------------------------------------------
# 11. set_input_delay
# ------------------------------------------------------------


# ------------------------------------------------------------
# 12. set_output_delay
# ------------------------------------------------------------


# ------------------------------------------------------------
# 13. set_clock_groups
# ------------------------------------------------------------


# ------------------------------------------------------------
# 14. set_false_path 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 15. set_min_delay 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 16. set_max_delay 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 17. set_multicycle_path 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 18. set_bus_skew 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 19. set_max_time_borrow 
# ------------------------------------------------------------


# ------------------------------------------------------------
# 20. set_external_delay
# ------------------------------------------------------------


" > ${hw_fpga_xdc_dir}/timing.xdc

sw_dir=${prj_dir}/sw
sw_inc_dir=${sw_dir}/inc
sw_src_dir=${sw_dir}/src

sw_dir_arr=(${sw_dir} ${sw_inc_dir} ${sw_src_dir})

run_dir=${prj_dir}/run
run_bug_dir=${run_dir}/bug
run_cov_dir=${run_dir}/cov
run_cov_cfg_dir=${run_cov_dir}/cfg
run_cov_el_dir=${run_cov_dir}/el
run_mk_dir=${run_dir}/mk
run_log_dir=${run_dir}/log
run_log_cmp_dir=${run_log_dir}/cmp
run_log_sim_dir=${run_log_dir}/sim
run_log_rgs_dir=${run_log_dir}/rgs
run_wav_dir=${run_dir}/wav
run_wav_fsdb_dir=${run_wav_dir}/fsdb
run_wav_shm_dir=${run_wav_dir}/shm
run_wav_vcd_dir=${run_wav_dir}/vcd
run_wav_vpd_dir=${run_wav_dir}/vpd
run_wav_wlf_dir=${run_wav_dir}/wlf

run_dir_arr=(${run_dir} \
${run_bug_dir} \
${run_cov_dir} ${run_cov_cfg_dir} ${run_cov_el_dir} \
${run_log_dir} ${run_log_cmp_dir} ${run_log_sim_dir} ${run_log_rgs_dir} \
${run_mk_dir} \
${run_wav_dir} ${run_wav_fsdb_dir} ${run_wav_shm_dir} ${run_wav_vcd_dir} ${run_wav_vpd_dir} ${run_wav_wlf_dir} \
)

script_dir=${prj_dir}/script
script_bash_dir=${script_dir}/bash
script_python_dir=${script_dir}/python
script_dir_arr=(${script_dir} ${script_bash_dir} ${script_python_dir})

dir_arr_gen sw_dir_arr[@]
dir_arr_gen run_dir_arr[@]
dir_arr_gen script_dir_arr[@]

touch ${run_mk_dir}/ams.mk

echo "
CPU_DBG_EN ?= 0
ifeq (\$(CPU_DBG_EN), 1)
    CMP_OPTS += -reportstats
    SIM_OPTS += -reportstats
endif
" > ${run_mk_dir}/cpustats.mk

echo "
COV_EN          ?= 0
CODE_COV_EN     ?= 0
SVA_COV_EN      ?= 0
COV_DIR          = cov

ifeq (\$(COV_EN), 1)

ifeq (\$(CODE_COV_EN), 1)
    CMP_OPTS += -cm line+cond+fsm+tgl+branch -cm_dir \$(COV_DIR)/\$(TOP_MODULE).vdb -cm_hier cov/cfg/cov.cfg
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
" > ${run_mk_dir}/cov.mk

echo "
DBG_EN     ?= 1
GUI_EN     ?= 0

ifeq (\$(DBG_EN),1)
    CMP_OPTS += -kdb -debug_access+all -lca -debug_all
endif

ifeq (\$(GUI_EN),1)
    SIM_OPTS += -gui
endif

#endless loop debug
LOOP_NUM ?= 1000
CMP_OPTS += +vcs+loopreport+\$(LOOP_NUM)
" > ${run_mk_dir}/dbg.mk

echo "
WAVE_EN         ?= 1
WAVE_FORMAT     ?= FSDB
DUMP_STRENGTH   ?= 1
DUMP_FORCE      ?= 1
DUMP_DELTA      ?=off

ifeq (\$(WAVE)_EN), 1)

ifeq (\$(WAVE_FORMAT), FSDB)

    WAVE_DIR = wave/fsdb
    CMP_OPTS += +vcs+fsdbon

ifeq (\$(DUMP_STRENGTH), 1)
    SIM_OPTS += +fsdb+strength=on
else
    SIM_OPTS += +fsdb+strength=off
endif

ifeq (\$(DUMP_DELTA), 1)
    SIM_OPTS += +fsdb+delta
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

endif
" > ${run_mk_dir}/dump.mk

echo "
CMP_OPTS += +lint=TFIPC-L
" > ${run_mk_dir}/lint.mk

echo "
CMP_LOG_DIR ?= log/cmp
SIM_LOG_DIR ?= log/sim

CMP_OPTS += -l \$(CMP_LOG_DIR)/cmp.log
SIM_OPTS += -l \$(SIM_LOG_DIR)/\$(tc_full_name).log
" > ${run_mk_dir}/log.mk

echo "
MACROS_DEBUG_EN = 0

ifeq (\$(MACROS_DEBUG_EN), 1)
    CMP_OPTS += -Xrawtoken=debug_macros
endif
" > ${run_mk_dir}/macro.mk

echo "
SVA_EN           ?= 1
IMMEDIATE_SVA_EN ?= 1
SVA_FAIL_MAX_NUM ?= 20
SVA_SUCC_EN      ?= 1
SVA_SUCC_MAX_NUM ?= 20

ifeq (\$(SVA_EN), 1)

ifeq (\$(IMMEDIATE_SVA_EN), 1)
    SIM_OPTS += -assert enable_diag 
endif
    CMP_OPTS += -assert dbgopt
    SIM_OPTS += -assert maxfail=\$(SVA_FAIL_MAX_NUM) +fsdb_sva_index_info +fsdb+sva_status
ifeq (\$(SVA_SUCC_EN), 1)
    SIM_OPTS += -assert success -assert summary +maxsuccess=\$(SVA_SUCC_MAX_NUM) +fsdb+sva_success
endif
    SIM_OPTS += -assert report=ova.report
else
    CMP_OPTS += -assert disable
endif
" > ${run_mk_dir}/sva.mk

echo "
SEED_MANUAL     ?= 1
seed            ?= \$(shell data \"+%m%d%H%M%S\")

ifeq (\$(SEED_MANUAL),1)
    SIM_OPTS += ntb_random_seed=\$(seed)
else
    SIM_OPTS += ntb_random_seed_automatic
endif

SIM_OPTS += solver_array_size_warn=10000
" > ${run_mk_dir}/solver.mk

echo "
TIMESCALE_DBG_EN ?= 0

CMP_OPTS += -timescale=1ns/1ps

ifeq (\$(TIMESCALE_DBG_EN), 1)
    CMP_OPTS += -diag timescale
endif
" > ${run_mk_dir}/timescale.mk

echo "
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
" > ${run_mk_dir}/uvm.mk

echo "
SV_EN   ?= 1
V2K_EN  ?= 1
V95_EN  ?= 1

ifeq (\$(SV_EN),1)
    CMP_OPTS += -sverilog
endif

ifeq (\$(V2K_EN),1)
    CMP_OPTS += +v2k
endif
" > ${run_mk_dir}/vlg.mk

echo "
ORG         ?= 
PRJ         ?= 
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
include cfg/sva.mk
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
    \$(WAVEFORM) -nologo  -ptrTitle \$ORG_\$PRJ_\$(TOP_MODULE) -f \$(TB_FILES) -top \$(TOP_MODULE)

cov:
    \${WAVEFORM} -cov covdir \${COV_DOR}/\${TOP_MODULE}.vdb -elfile \${TOP_MODULE}.el

sva_dbg:
    verdi -sv -f $(TB_FILES) -ssf sv.fsdb -workMode assertionDebug

" > ${run_dir}/Makefile

echo "
//+tree instance_name [level_number] : vcs compile only the specified instance and the instances under it for coverage
//-tree instances [level_number] : vcs exclude this instance from coverage and other instances under it
//+module
//-module
//+moduletree
//-moduletree
//+file
//-file
" > ${run_cov_cfg_dir}/cov.cfg

file_gen ${run_cov_el_dir}/${top}.el

if [ -e ${script_bash_dir}run.sh ]; then
    ln -s ${script_bash_dir}run.sh ${run_dir}/run
fi

uvm_interface_main="
\`ifndef GUARD_${vip^^}_INTERFACE_SV
\`define GUARD_${vip^^}_INTERFACE_SV

\`timescale 1ns/1ps

interface ${vip}_if(
    input   clk,
    input   rst
);

endinterface : ${vip}_if

\`endif //GUARD_${vip^^}_INTERFACE_SV
"

uvm_sequence_item_main="
\`ifndef GUARD_${vip^^}_ITEM_SV
\`define GUARD_${vip^^}_ITEM_SV

class ${vip}_item extends uvm_sequence_item;

    \`uvm_object_utils_begin(${vip}_item)

    \`uvm_object_utils_end

    function new(string name = \"${vip}_item\")
        super.new(name);
    endfunction : new

    //valid_constraint_block

    //reasonable_constraint_block

endclass : ${vip}_item

\`endif //GUARD_${vip^^}_ITEM_SV
"

#uvm_monitor_main="
#\`ifndef GUARD_${vip^^}_MONITOR_SV
#\`define GUARD_${vip^^}_MONITOR_SV
#
#class ${vip}_monitor extends uvm_monitor;
#
#    uvm_analysis_port#(${vip}_item) item_collected_port;
#
#    `uvm_component_utils(${vip}_monitor)
#
#    function new(string name = \"${vip}_monitor\", uvm_component parent);
#        super.new(name, parent);
#    endfunction : new
#
#    extern function void build_phase(uvm_phase phase);
#    extern task run_phase(uvm_phase phase);
#
#endclass : ${vip}_monitor
#
#virtual function void ${vip}_monitor::build_phase(uvm_phase phase);
#
#    super.build_phase(phase);
#    
#    if(!uvm_config_db\#(virtual ${vip}_if)::get(this, \"\", \"vif\", vif))begin
#        `uvm_fatal(\"NOVIF\", {\"virtual interface must be set for: \", get_full_name(), \".vif\"})
#    end
#
#endfunction : build_phase
#
#virtual task run_phase(uvm_phase phase);
#
#    process main_thread;
#    process rst_mon_thread;
#
#    super.run_phase(phase);
#
#    forever begin
#
#        fork
#            begin
#                main_thread = process::self();
#            end
#            begin
#                rst_mon_thread = process::self();
#                if(main_thread) main_thread.kill();
#            end
#        join_any
#
#        if(rst_mon_thread) rst_mon_thread.kill();
#    end
#
#endtask : run_phase
#
#\`endif //GUARD_${vip^^}_MONITOR_SV
#"
#
#uvm_driver_main="
#\`ifndef GUARD_${vip^^}_DRIVER_SV
#\`define GUARD_${vip^^}_DRIVER_SV
#
#class ${vip}_driver extends uvm_driver \#(${vip}_item});
#
#    ${vip}_item s_item;
#
#    `uvm_component_utils(${vip}_driver)
#
#    function new(string name = \"${vip}_driver\", uvm_component parent);
#        super.new(name, parent);
#    endfunction : new
#
#    extern function void build_phase(uvm_phase phase);
#    extern task run_phase(uvm_phase phase);
#
#endclass : ${vip}_driver
#
#virtual function void ${vip}_driver::build_phase(uvm_phase phase);
#
#    super.build_phase(phase);
#    
#    if(!uvm_config_db\#(virtual ${vip}_if)::get(this, \"\", \"vif\", vif))begin
#        `uvm_fatal(\"NOVIF\", {\"virtual interface must be set for: \", get_full_name(), \".vif\"})
#    end
#
#endfunction : build_phase
#
#virtual task ${vip}_driver::run_phase(uvm_phase phase);
#    forver begin
#        seq_item_port.get_next_item(s_item);
#        drive_item(s_item);
#        seq_item_port.item_done(rsp);
#    end
#endtask : run_phase
#
#virtual task drive_item(input ${vip}_item item);
#    
#endtask : drive_item
#
#\`endif //GUARD_${vip^^}_DRIVER_SV
#"
#
#uvm_sequencer_main="
#\`ifndef GUARD_${vip^^}_SEQUENCER_SV
#\`define GUARD_${vip^^}_SEQUENCER_SV
#
#class ${vip}_sequencer extends uvm_sequencer \#(${vip}_item})
#    
#    `uvm_component_utils(${vip}_sequencer)
#
#    function new(string name = \"${vip}_sequencer\", uvm_component parent);
#        super.new(name, parent);
#    endfunction : newv
#
#endclass : ${vip}_sequencer
#
#\`endif //GUARD_${vip^^}_SEQUENCER_SV
#"
#
#uvm_agent_main="
#\`ifndef GUARD_${vip^^}_AGENT_SV
#\`define GUARD_${vip^^}_AGENT_SV
#
#class ${vip}_agent extends uvm_agent;
#
#    ${vip}_driver driver;
#    ${vip}_sequencer sequencer;
#    ${vip}_monitor monitor;
#
#    \`uvm_component_utils(${vip}_agent)
#
#    function new(string name = \"${vip}_agent\", uvm_component parent);
#        super.new(name, parent);
#    endfunction : new
#
#    extern function void build_phase(uvm_phase phase);
#    extern function void connect_phase(uvm_phase phase);
#
#endclass : ${vip}_agent
#
#virtual function void ${vip}_driver::build_phase(uvm_phase phase);
#
#    super.build_phase(phase);
#    
#    monitor = ${vip}_monitor::type_id::create(\"monitor\",this);
#
#    if(is_active == UVM_ACTIVE)begin
#        driver = ${vip}_driver::type_id::create(\"driver\",this);
#        sequencer = ${vip}_sequencer::type_id::create(\"sequencer\",this);
#    end
#
#endfunction : build_phase
#
#virtual function void connect_phase(uvm_phase phase);
#
#    super.connect_phase(phase);
#
#    if(is_active == UVM_ACTIVE)begin
#        driver.seq_item_port.connect(sequencer.seq_item_export);
#    end
#
#endfunction : connect_phase
#
#\`endif //GUARD_${vip^^}_AGENT_SV
#"
#
uvm_package_main="
\`ifndef GUARD_${vip^^}_PKG_SV
\`define GUARD_${vip^^}_PKG_SV

\`include \"${vip})if.sv\"
\`include \"uvm_macro.svh\"

package ${vip}_pkg;

    import uvm_pkg::*;

    typedef virtual ${vip}_if ${vip}_vif;

    \`include \"${vip}_item.sv\"
    \`include \"${vip}_config.sv\"
    \`include \"${vip}_monitor.sv\"
    \`include \"${vip}_driver.sv\"
    \`include \"${vip}_sequencer.sv\"
    \`include \"${vip}_agent.sv\"

endpackage : ${vip}_pkg

\`endif //GUARD_${vip^^}_PKG_SV
"

uvm_virtual_sequence="
\`ifndef ${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCER_SV
\`define ${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCER_SV

class ${top}_virtual_sequence extends uvm_sequence;

    \`uvm_object_utils(${top}_virtual_sequence)

    function new(string name = \"${top}_virtual_sequence)\");
        super.new(name)
    endfunction : new

endclass : ${top}_virtual_sequence

\`end //${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCE_SV
"

uvm_virtual_sequencer="
\`ifndef ${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCER_SV
\`define ${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCER_SV

class ${top}_virtual_sequencer extends uvm_sequencer;

    \`uvm_component_utils(${top}_virtual_sequencer)

    function new(string name = \"${top}_virtual_sequencer)\", uvm_component parent = null);
        super.new(name,parent)
    endfunction : new

endclass : ${top}_virtual_sequencer

\`end //${org^^}_${prj^^}_${top^^}_VIRTUAL_SEQUENCER_SV
"

uvm_scoreboard="
\`ifndef ${org^^}_${prj^^}_${top^^}_SCOREBOARD_SV
\`define ${org^^}_${prj^^}_${top^^}_SCOREBOARD_SV

//The UVM Scoreboard's main function is to check the behavior of a certain DUT.
class ${top}_scoreboard extends uvm_scoreboard;

    //The UVM Scoreboard usually receives transaction carrying inputs and outputs of DUT through UVM Agent analysis ports

    \`uvm_component_utils(${top}_scoreboard)

    function new(string name = \"${top}_scoreboard\", uvm_component parent);
        super.new(name,parent);
    endfunction : new

    //reference model(predictor) : run the input transactios to produce expected transactions

    //compares the expected output versus the actual output

endclass : ${top}_scoreboard

\`endif //${org^^}_${prj^^}_${top^^}_SCOREBOARD_SV
"

#. run -btgen -mod xx
#
#. run -vipgen -vipname xx
#. run -vipgen -vipname xx -onlymst
#. run -vipgen -vipname xx -onlyslv
#
#. run -bt -mod xx -vipadd xx
#. run -bt -mod xx -vipdel xx
#
#. run -bt -mod xx -tcidx xx
#. run -bt -modlist
#. run -bt -mod xx -tcgen xx
#. run -bt -mod xx -tcgen xx -tcref xx
#. run -bt -mod xx -tcdel xx
#. run -bt -mod xx -tclist
#. run -bt -mod xx -tcidx xx -tcrename xx

run_sh="
set -e
opts=\$(getopt -o h -a -l btgen, mod: -- \"$@\")
eval set -- \$opts

while :; do
    case \$1 in
        --btgen)
            shift 1
            ;;
        --)
            break
            ;;
    esac
done
"

if [ -n \$btgen ]; then

    if [ -z \$mod ]; then
        echo \"please enter a module name\"
        exit
    fi
     
    mkdir \$mod

    exit
fi

which tree > /dev/null

if [ $? -eq 0 ]; then
    tree .
fi
