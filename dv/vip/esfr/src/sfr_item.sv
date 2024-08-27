`ifndef SFR_ITEM
`define SFR_ITEM

class sfr_item extends uvm_sequence_item;

    typedef enum bit { READ,WRITE } kind_e;

    rand kind_e kind;
    rand bit [`SFR_ADDR_WIDTH-1:0] addr;
    rand bit [`SFR_DATA_WIDTH-1:0] data;

    `uvm_object_utils_begin(sfr_item)
        `uvm_field_enum(kind_e, kind, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "sfr_item");
        super.new(name);
    endfunction : new

endclass : sfr_item

`endif //SFR_ITEM