uvm_agent_code_snippets="""
`ifndef GUARD_${1}_AGENT_SV
`define GUARD_${1}_AGENT_SV

class ${1}_agent extends uvm_agent;

    ${1}_cfg cfg;
    ${1}_coverage_collector coverage_collector;
    ${1}_monitor monitor;
    ${1}_sequencer #(${1}_item) sequencer;
    ${1}_driver driver;

    `uvm_component_utils(${1}_agent)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(${1}_cfg)::get(this, "", "cfg", cfg)) begin
            `uvm_fatal("NOCFG", {"configure object must be set for: ", get_full_name(), ".cfg"})
        end

        if(cfg.coverage_enable)
            coverage_collector = ${1}_coverage_collector::type_id::create("coverage_collector", this);

        monitor = ${1}_monitor::type_id::create("monitor", this);
        if(is_active == UVM_ACTIVE) begin
            sequencer = ${1}_sequencer::type_id::create("sequencer", this);
            driver = ${1}_driver::type_id::create("driver", this);
        end

    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE)
            driver.seq_item_port.connect(sequencer.seq_item_export);
        
        if(${1}_cfg.coverage_enable)
            monitor.collected_item_port.connect(coverage_collector.collected_item_export);

    endfunction : connect_phase

endclass : ${1}_agent

`endif // GUARD_${1}_AGENT_SV
"""