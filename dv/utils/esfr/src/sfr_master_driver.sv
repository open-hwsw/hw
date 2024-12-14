`ifndef SFR_MASTER_DRIVER
`define SFR_MASTER_DRIVER

class sfr_master_driver extends uvm_driver;

    virtual sfr_interface vif;
    sfr_cfg cfg;
    sfr_item item;

    `uvm_component_utils(sfr_master_driver);

    function new(string name = "sfr_master_driver", uvm_component parent = null);
        super.new(name,parent);
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

        super.run_phase(phase);

        @(posedge vif.sfr_master_driver_cb.rst);
        do begin
            @(posedge vif.sfr_master_driver_cb);
        end while(vif.sfr_master_driver_cb.rst !== 0);

        get_and_drive();

    endtask : run_phase
    
    virtual protected task get_and_drive();

        process main_thread;
        process rst_mon_thread;

        forever begin

            seq_item_port.get_next_item(req);
            $cast(rsp,req.clone());
            rsp.set_id_info(req);

            fork
                begin
                    main_thread = process::self();
                    drive_item(rsp);
                end
                begin
                    rst_mon_thread = process::self();
                    @(posedge vif.sfr_master_driver_cb.rst);
                    if(main_thread) main_thread.kill();
                    reset_signal();
                end
            join_any
            disable fork;

            seq_item_port.item_done();
            seq_item_port.put_response(rsp);
        end

    endtask : get_and_drive

    virtual protected task drive_item(input sfr_item item);

        @(vif.sfr_master_driver_cb);

        if(cfg.multi_page == 1)begin
            if(vif.sfr_master_driver_cb.sfr_page_sel !== item.addr[7+:$bits(vif.sfr_page_sel)]begin
                vif.sfr_master_driver_cb.sfraddr  <= { {$bits(vif.esfr_page_sel){1'b0}}, cfg.page_switch_reg_addr };
                vif.sfr_master_driver_cb.sfrwe    <= 1'b1;
                vif.sfr_master_driver_cb.sfrdatao <= {cfg.page_switch_key, item.addr[7+:$bits(vif.sfr_page_sel)]};
                @(vif.sfr_master_driver_cb);
            end
        end

        vif.sfr_master_driver_cb.sfraddr <= item.addr;

        if(item.kind == sfr_item::WRITE)begin
            vif.sfr_master_driver_cb.sfrwe <= 1'b1;
            vif.sfr_master_driver_cb.sfroe <= 1'b0;
            vif.sfr_master_driver_cb.sfrdatao <= item.data;
            do begin
                @(vif.sfr_master_driver_cb);
            end while(vif.sfr_master_driver_cb.sfrack == 1'b0);
            vif.sfr_master_driver_cb.sfrwe <= 1'b0;
        end else if( item.kind == sfr_item::READ )begin
            vif.sfr_master_driver_cb.sfroe <= 1'b1;
            vif.sfr_master_driver_cb.sfrwe <= 1'b0;
            do begin
                @(vif.sfr_master_driver_cb);
            end while(vif.sfr_master_driver_cb.sfrack == 1'b0);
            vif.sfr_master_driver_cb.sfroe <= 1'b0;
            item.data = vif.sfr_master_driver_cb.sfrdata_i;
        end

    endtask : drive_item

    virtual protected task reset_signal();
        vif.sfr_master_driver_cb.sfroe    <= 0;
        vif.sfr_master_driver_cb.sfrwe    <= 0;
        vif.sfr_master_driver_cb.sfraddr  <= 0;
        vif.sfr_master_driver_cb.sfrdatao <= 0;
    endtask : reset_signal

endclass : sfr_master_driver

`endif //SFR_MASTER_DRIVER
