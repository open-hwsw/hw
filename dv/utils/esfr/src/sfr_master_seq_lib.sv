virtual class sfr_base_sequence extends uvm_sequence#(sfr_item);
    
    function new(string name = "sfr_base_sequence");
        super.name(name);
        set_automatic_phase_objection(1);
    endfunction : new

endclass : sfr_base_sequence

class read_data_sequence extends sfr_base_sequence;

    rand bit [`SFR_ADDR_WIDTH-1:0] raddr;

    `uvm_object_utils_begin(read_data_sequence)
        `uvm_field_int(raddr, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "read_data_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_do_with(req,
            {
                req.addr == raddr;
                req.kind == sfr_item::READ;
            }
        )
        get_response(rsp);
        `uvm_info(get_type_name(),
        $sformatf("%s, read: addr = 0x%0h, data = 0x%0h",get_sequence_path(),rsq.addr,rsp.data),
        UVM_LOW)
    endtask : body

endclass : read_data_sequence

class write_data_sequence extends sfr_base_sequence;

    rand bit [`SFR_ADDR_WIDTH-1:0] waddr;
    rand bit [`SFR_DATA_WIDTH-1:0] wdata;

    `uvm_object_utils_begin(write_data_sequence)
        `uvm_field_int(waddr, UVM_ALL_ON)
        `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "write_data_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_do_with(req,
            {
                req.addr == waddr;
                req.data == wdata;
                req.kind == sfr_item::WRITE;
            }
        )
        get_response(rsp);
        `uvm_info(get_type_name(),
        $sformatf("%s, write: addr = 0x%0h, data = 0x%0h",get_sequence_path(),rsq.addr,rsp.data),
        UVM_LOW)
    endtask : body

endclass : read_data_sequence