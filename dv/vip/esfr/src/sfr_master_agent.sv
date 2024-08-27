`ifndef SFR_MASTER_AGENT
`define SFR_MASTER_AGENT

class sfr_master_agent extends uvm_agent;

    sfr_master_cfg cfg;
    sfr_master_sequencer sequencer;
    sfr_master_driver driver;
    sfr_master_monitor monitor;
    uvm_reg_block regmodel;
    reg2sfr_adapter adapter;

    virtual function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);

        if(!uvm_config_db#(sfr_master_cfg)::get(this,"","cfg",cfg))begin
            `uvm_fatal("NOCFG",{"sfr_master_cfg object must be set for: ",
                        get_full_name(),".cfg"});
        end else begin
            uvm_config_db#(sfr_master_cfg)::set(this,"monitor","cfg",cfg);
            if(cfg.is_active)begin
                uvm_config_db#(sfr_master_cfg)::set(this,"driver","cfg",cfg);
            end
        end

        if(cfg.uvm_reg_enable)begin
            if(!uvm_config_db#(uvm_reg_block)::get(this,"","regmodel",regmodel))begin
                `uvm_fatal("NOREGMODEL",{"uvm_reg_block object must be set for: ",
                            get_full_name(),".regmodel"});
            end else begin
                adapter = reg2sfr_adapter::type_id::create("adapter",this);
            end
        end

        monitor = sfr_master_monitor::type_id::create("monitor",this);
        sequencer = sfr_master_sequencer::type_id::create("sequencer",this);
        driver = sfr_master_driver::type_id::create("driver",this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        if(cfg.uvm_reg_enable)begin
            regmodel.default_map.set_sequencer(sequencer,adapter);
            regmodel.default_map.set_auto_predict(1);
        end
    endfunction : connect_phase
    
endclass : sfr_master_agent

`endif //SFR_MASTER_AGENT