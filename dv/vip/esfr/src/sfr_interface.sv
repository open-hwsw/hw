`ifndef SFR_IF
`define SFR_IF

`ifdef SFR_USER_INCLUDE_DEFINES
    `include "sfr_user_defines.sv"
`endif

`include "sfr_defines.sv"

interface sfr_if(input clk);

    logic [`SFR_ADDR_WIDTH-1:0]         sfraddr     ;
    logic                               sfrack      ;
    logic                               sfrwe       ;
    logic [`SFR_DATA_WIDTH-1:0]         sfrdatao    ;
    logic                               sfroe       ;
    logic [`SFR_DATA_WIDTH-1:0]         sfrdatai    ;
    logic [$clog2(`SFR_PAGE_NUM)-1:0]   sfr_page_sel;
    
    clocking sfr_master_driver_cb@(posedge clk);
        output sfraddr      ;
        input  sfrack       ;
        output sfrwe        ;
        output sfrdatao     ;
        output sfroe        ;
        input  sfrdatai     ;
        input  rst          ;
        input  sfr_page_sel ;
    endclocking : sfr_master_driver_cb

    clocking sfr_master_monitor_cb@(posedge clk);
        input  sfraddr      ;
        input  sfrack       ;
        input  sfrwe        ;
        input  sfrdatao     ;
        input  sfroe        ;
        input  sfrdatai     ;
        input  rst          ;
        input  sfr_page_sel ;
    endclocking : sfr_master_monitor_cb

endinterface : sfr_if

`endif //SFR_IF