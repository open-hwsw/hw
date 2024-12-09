module tb;
    
    typedef struct packed { // default unsigned 
        bit [3:0] GFC; 
        bit [7:0] VPI; 
        bit [11:0] VCI; 
        bit CLP; 
        bit [3:0] PT ; 
        bit [7:0] HEC; 
        bit [47:0] [7:0] Payload; 
        bit [2:0] filler;
    } s_atmcell;

    typedef union packed { // default unsigned
        s_atmcell acell;    
        bit [423:0] bit_slice; 
        bit [52:0][7:0] byte_slice; 
    } u_atmcell;

    u_atmcell u1;
    byte b;
    bit [3:0] nib;

    initial begin

        u1.byte_slice[51] = 8'h55;
        b = u1.bit_slice[415:408]; // same as b = u1.byte_slice[51];
        assert(u1.byte_slice[51] == u1.bit_slice[415:408]);
        assert(u1.byte_slice[51] == b);
        assert(u1.bit_slice[415:408] == b);

        u1.acell.GFC = 8'hA;
        nib = u1.bit_slice[423:420]; // same as nib = u1.acell.GFC;
        assert(u1.acell.GFC == u1.bit_slice[423:420]);
        assert(u1.acell.GFC == nib);
        assert(u1.bit_slice[423:420] == nib);
        
    end

endmodule : tb