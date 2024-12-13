uvm_monitor_code_snippets="""
`ifndef GUARD_${1}_MONITOR_SV
`define GUARD_${1}_MONITOR_SV

class ${1}_monitor extends uvm_monitor;

    virtual ${1}_if vif;

    uvm_analysis_port#(${1}_item) collected_item_port;
    
    protected ${1}_item collected_item;
    
    `uvm_component_utils(${1}_monitor)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        collected_item_port = new("collected_item_port", this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);

        if (!uvm_config_db#(${1}_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
        end

    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);

        process main_thread;
        process rst_mon_thread;

        @(negedge vif.reset)
        do @(posedge vif.clock);
        while(vif.reset !== 1);
        
        forever begin
            
            while(vif.reset !== 1) @(posedge vif.clock);

            fork
                begin
                    main_thread = process::self();
                    collect_item();
                end
                begin
                    rst_mon_thread = process::self();
                    @(negedge vif.reset) begin
                        if(main_thread) main_thread.kill();
                        reset_monitor();
                    end
                end
            join_any

            if(rst_mon_thread) rst_mon_thread.kill();

        end

    endtask : run_phase
    
    // Collecting Transfers from the Bus
    virtual protected task collect_items();

        forever begin

            collected_item_port.write(collected_item);

            if(${1}_cfg.checks_enable)
                perform_item_checks();

        end

    endtask : collect_items

    // Perform item checks here
    virtual protected task perform_item_checks();

    endtask : perform_item_checks

    // Reset the monitor specific state variables
    virtual protected task reset_monitor();

    endtask : reset_monitor

endclass : ${1}_monitor

`endif // GUARD_${1}_MONITOR_SV
"""
print(uvm_monitor_code_snippets.replace("${1}","maga"))
