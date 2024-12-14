`ifndef SFR_PAGE_NUM
    `define SFR_PAGE_NUM 4
`endif

`ifndef SFR_ADDR_WIDTH
    `define SFR_ADDR_WIDTH ( 7 + $clog2(`SFR_PAGE_NUM) )
`endif

`ifndef SFR_DATA_WIDTH
    `define SFR_DATA_WIDTH 8
`endif
