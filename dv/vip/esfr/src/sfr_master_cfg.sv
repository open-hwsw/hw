`ifndef SFR_MASTER_CFG
`define SFR_MASTER_CFG

class sfr_master_cfg extends uvm_object;

    bit                         is_active = 1       ;
    bit                         uvm_reg_enable      ;

    bit                         multi_page          ;
    bit [`SFR_ADDR_WIDTH-1:0]   page_switch_reg_addr;
    bit [`SFR_DATA_WIDTH-1:0]   page_switch_key     ;

    `uvm_object_utils_begin(sfr_master_cfg)

        `uvm_field_int(is_active            , UVM_ALL_ON)
        `uvm_field_int(uvm_reg_enable       , UVM_ALL_ON)

        `uvm_field_int(multi_page           , UVM_ALL_ON)
        `uvm_field_int(page_switch_reg_addr , UVM_ALL_ON)
        `uvm_field_int(page_switch_key      , UVM_ALL_ON)

    `uvm_object_utils_end

    function new(string name = "sfr_master_cfg");
        super.new(name);
    endfunction : new

endclass : sfr_master_cfg

`endif //SFR_MASTER_CFG