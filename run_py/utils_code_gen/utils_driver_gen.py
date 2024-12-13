uvm_driver_code_snippets="""
`ifndef GUARD_${1}_DRIVER_SV
`define GUARD_${1}_DRIVER_SV

class ${1}_driver extends uvm_driver #(${1}_item);

    protected virtual ${1}_if vif;
    
    `uvm_component_utils(${1}_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(${1}_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end

    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);

        @(negedge vif.reset)
        do @(posedge vif.clock);
        while(vif.reset !== 1);

        get_and_drive();

    endtask : run_phase

    virtual protected task get_and_drive();

        process main_thread;
        process rst_mon_thread;

        forever begin
            
            while(vif.reset !== 1) @(posedge vif.clock);

            seq_item_port.get_next_item(req);
            $cast(rsp, req.clone());
            rsp.set_id_info(req);

            fork
                begin
                    main_thread = process::self();
                    drive_item();
                    if(rst_mon_thread) rst_mon_thread.kill();
                end
                begin
                    rst_mon_thread = process::self();
                    @(negedge vif.reset) begin
                        if(main_thread) main_thread.kill();
                        reset_signal();
                        reset_driver();
                    end
                end
            join_any

            seq_item_port.item_done();

        end

    endtask : get_and_drive

    // Reset the signals to their default signal
    virtual protected task reset_signal();

    endtask : reset_signal

    // Reset the driver specific state variables
    virtual protected task reset_driver();

    endtask : reset_driver

    // Drive the item
    virtual protected task drive_item (${1}_item item);

    endtask : drive_item

endclass : ${1}_driver

`endif // GUARD_${1}_DRIVER_SV
"""
print(uvm_driver_code_snippets.replace("${1}","maga"))