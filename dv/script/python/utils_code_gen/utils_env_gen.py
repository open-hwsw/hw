utils_env_gen_code_snippets="""
`ifndef GUARD_${1}_ENV_SV
`define GUARD_${1}_ENV_SV

class ${1}_env extends uvm_env;

    ${1}_env_cfg cfg;
    ${1}_agent agent[];

    `uvm_component_utils(${1}_env)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(${1}_env_cfg)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal("NOCFG", {"configure object must be set for: ", get_full_name(), ".cfg"})
        end

    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : connect_phase

endclass : ${1}_env

`endif // GUARD_${1}_ENV_SV
"""