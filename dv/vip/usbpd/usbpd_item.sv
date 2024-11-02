class usbpd_item extends uvm_sequence_item;
    
    //physical layer
    bit [63:0] preamble = 64'h5555555555555555;

    //protocol layer
    
    //messager header
    typedef enum bit {
        CONTROL_OR_DATA_MESSAGE = 0,
        EXTENDED_MESSAGE        = 1
    } extended_e;
    
    typedef enum bit {
        SINK   = 0,
        SOURCE = 1
    } port_power_role_e;

    typedef enum bit [1:0] {
        REVISION_1P0 = 0,
        REVISION_2P0 = 1,
        REVISION_3PX = 2
    } specification_revision_e

    typedef enum bit {
        UFP = 0,
        DFP = 1
    } port_data_role_e;

    struct packed {
        extended_e extended;
        bit [2:0] number_of_data_objects;
        bit [2:0] messageid;
        //port power role or cable plug
        bit [1:0] specification_revision;
        //port data role or reserved 
        bit [4:0] message_type;
    } message_header_t;

    `uvm_object_utils_begin(usbpd_item)
        `uvm_field_int(preamble, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name="usbpd_item");
        super.new(name);
    endfunction : new

endclass : usbpd_item
