`ifndef REG2SFR_ADAPTER
`define REG2SFR_ADAPTER

class reg2sfr_adapter extends uvm_reg_adapter;

    `uvm_object_utils(reg2sfr_adapter)

    function new(string name = "reg2apb_adapter"); 
        super.new(name);
    endfunction

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        sfr_item sfr = sfr_item::type_id::create("sfr");
        sfr.kind = (rw.kind == UVM_READ) ? sfr_item::READ : sfr_item::WRITE;
        sfr.addr = rw.addr;
        sfr.data = rw.data;
        return sfr;
    endfunction : reg2bus

    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        sfr_item sfr;
        if (!$cast(sfr,bus_item)) begin
            `uvm_fatal("NOT_SFR_TYPE","Provided bus_item is not of the correct type") 
            return; 
        end 
        rw.kind = sfr.kind ? UVM_READ : UVM_WRITE; 
        rw.addr = sfr.addr; 
        rw.data = sfr.data; 
        rw.status = UVM_IS_OK; 
    endfunction : bus2reg

endclass : reg2sfr_adapter

`endif //REG2SFR_ADAPTER