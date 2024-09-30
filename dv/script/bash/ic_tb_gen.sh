#!/usr/bin/env bash
hw_dir=hw
hw_agt_dir=${hw_dir}/agt
hw_env_dir=${hw_dir}/env
hw_flist_dir=${hw_dir}/flist
hw_ral_dir=${hw_dir}/ral
hw_rtl_dir=${hw_dir}/rtl
hw_tb_dir=${hw_dir}/tb
hw_tc_dir=${hw_dir}/tc

sw_dir=sw
run_dir=run

#Shell Function Definitions
function dir_gen() {

    local path=$1

    if [ ! -d ${path} ]; then
        mkdir -pv ${path}
    else
        echo "directory ${path} exists"
    fi

}

dir_gen ${hw_dir}
dir_gen ${hw_agt_dir}
dir_gen ${hw_env_dir}
dir_gen ${hw_flist_dir}
dir_gen ${hw_ral_dir}
dir_gen ${hw_rtl_dir}
dir_gen ${hw_tb_dir}
dir_gen ${hw_tc_dir}
