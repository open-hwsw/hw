`ifndef SFR_MASTER_SEQUENCER
`define SFR_MASTER_SEQUENCER

class sfr_master_sequencer extends uvm_sequencer#(sfr_item);

    `uvm_component_utils(sfr_master_sequencer)

    function new(string name = "sfr_master_sequencer", uvm_component parent = null);
        super.new(name,parent);
    endfunction : new

endclass : sfr_master_sequencer

`endif //SFR_MASTER_SEQUENCER