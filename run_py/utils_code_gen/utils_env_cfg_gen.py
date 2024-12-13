utils_env_cfg_gen_code_snippets="""
`ifndef GUARD_${1}_ENV_CFG_SV
`define GUARD_${1}_ENV_CFG_SV

class ${1}_env_cfg extends uvm_object;

    int num_masters;
    int num_slaves;

    `uvm_object_utils_begin(${1}_env_cfg)
        `uvm_field_int(num_masters, UVM_ALL_ON)
        `uvm_field_int(num_slaves, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name);
        super.new(name);
    endfunction : new

endclass : ${1}_env_cfg

`endif // GUARD_${1}_ENV_CFG_SV
"""