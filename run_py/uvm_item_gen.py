uvm_sequence_item_code_snippets="""
class ${1}_item extends uvm_sequence_item;

    `uvm_object_utils_begin(${1}_item)
    
    `uvm_object_utils_end

    function new (string name = "${1}_item");
        super.new(name);
    endfunction : new

endclass : ${1}_item
"""