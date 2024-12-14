uvm_sequencer_code_snippets="""
`ifndef GUARD_${1}_SEQUENCER_SV
`define GUARD_${1}_SEQUENCER_SV

class ${1}_sequencer extends uvm_sequencer #(${1}_item);

    `uvm_component_utils(${1}_sequencer)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : ${1}_sequencer

`endif // GUARD_${1}_SEQUENCER_SV
"""