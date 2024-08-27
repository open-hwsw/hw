`ifndef SFR_MASTER_MONITOR
`define SFR_MASTER_MONITOR

class sfr_master_monitor extends uvm_monitor;

    virtual sfr_if vif;
    sfr_cfg cfg;
    protected fr_item item;
    uvm_analysis_port#(sfr_item) item_collected_port;

    `uvm_component_utils(sfr_master_monitor)

    function new(string name = "sfr_master_monitor", uvm_component parent = null);
        super.new(name,parent);
        item_collected_port = new("item_collected_port",this);
        item = sfr_item::type_id::create("item",this);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual sfr_interface)::get(this,"","vif",vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",
                                get_full_name(),".vif"});
        if(!uvm_config_db#(virtual sfr_cfg)::get(this,"","cfg",cfg))
            `uvm_fatal("NOCFG",{"Config Object must be set for: ",
                                get_full_name(),".cfg"});
    endfunction : build_phase
    
    virtual task run_phase(uvm_phase phase);
    
        process main_thread;
        process rst_mon_thread;

        super.run_phase(phase);
        
        @(posedge vif.sfr_master_driver_cb.rst);

        do begin
            @(posedge vif.sfr_master_driver_cb);
        end while(vif.sfr_master_driver_cb.rst !== 0);

        forever begin
            fork
                begin
                    main_thread = process::self();
                    collect_item();
                end
                begin
                    rst_mon_thread = process::self();
                    @(posedge vif.sfr_master_driver_cb.rst)begin
                        if(main_thread) main_thread.kill();
                    end
                end
            join_any
            disable fork;
        end

    endtask : run_phase

    virtual protected task collect_item();
        wait( ( vif.sfr_master_monitor_cb.sfroe ^ vif.sfr_master_monitor_cb.sfrwe ) & vif.sfr_master_monitor_cb.sfrack);
        item.kind = ( vif.sfr_master_monitor_cb.sfrwe === 1 ) ? sfr_item::WRITE : sfr_item::READ;
        item.data = ( vif.sfr_master_monitor_cb.sfrwe === 1 ) ? vif.sfr_master_monitor_cb.sfrdatao : vif.sfr_master_monitor_cb.sfrdatai;
        item.addr = vif.sfr_master_monitor_cb.sfraddr;
        @(vif.sfr_master_monitor_cb);
        item_collected_port.write(item);
    endtask : collect_item

endclass : sfr_master_monitor

`endif //SFR_MASTER_MONITOR