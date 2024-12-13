vip_agt_cfg_gen_code_snippets="""
`ifndef GUARD_${1}_AGENT_CFG_SV
`define GUARD_${1}_AGENT_CFG_SV

class ${1}_agt_cfg extends uvm_object;

    bit checks_enable;
    bit coverage_enable;

    `uvm_object_utils_begin(${1}_agt_cfg)
        `uvm_field_int(checks_enable, UVM_ALL_ON)
        `uvm_field_int(coverage_enable, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name);
        super.new(name);
    endfunction : new

endclass : ${1}_agt_cfg

`endif // GUARD_${1}_AGENT_CFG_SV
"""