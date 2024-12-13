uvm_coverage_collector_code_snippets="""
`ifndef GUARD_${1}_COVERAGE_COLLECTOR_SV
`define GUARD_${1}_COVERAGE_COLLECTOR_SV

class ${1}_coverage_collector extends uvm_component;

    protected ${1}_item collected_item;

    `uvm_component_utils(${1}_coverage_collector)

    `uvm_analysis_imp_collected_item #(${1}_item, ${1}_coverage_collector) collected_item_export;

    covergroup collected_item_cg;
        option.per_instance = 1;
    endgroup : collected_item_cg

    function new (string name, uvm_component parent);
        super.new(name, parent);
        collected_item_cg = new;
        collected_item_cg.set_inst_name({get_full_name(), ".collected_item_cg"});
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        collected_item_export = new("collected_item_export", this);

    endfunction : build_phase

    function void write_collected_item(${1}_item item);
        collected_item = item;
        collected_item_cg.sample();
    endfunction : write_collected_item

endclass : ${1}_coverage_collector

`endif // GUARD_${1}_COVERAGE_COLLECTOR_SV
"""