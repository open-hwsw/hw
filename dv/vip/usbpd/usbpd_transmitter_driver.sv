class usbpd_transmitter_driver extends uvm_driver;

    typedef enum bit [4:0] {
        Sync_1 = 5'b11000,
        Sync_2 = 5'b10001,
        Sync_3 = 5'b00110,
        RST_1  = 5'b00111,
        RST_2  = 5'b11001,
        EOP    = 5'b01101
    } k_code_e;

    typedef struct {
        k_code_e k_code [4];
    } ordered_set_t

    ordered_set_t cable_reset;
    ordered_set_t hard_reset;
    ordered_set_t sop;
    ordered_set_t sop_prime;
    ordered_set_t sop_double_prime;
    ordered_set_t sop_prime_debug;
    ordered_set_t sop_double_prime_debug;

    typedef struct {
        bit [63:0] preamble;
        ordered_set_t sop;
        //message header
        //data
        bit [31:0] crc;
        bit [4:0] eop;
    } packet_t;

    `uvm_component_utils(usbpd_transmitter_driver)

    function new(string name="usbpd_transmitter_driver");

        super.new(name);

        hard_reset.k_code[0] = rst_1;
        hard_reset.k_code[1] = rst_1;
        hard_reset.k_code[2] = rst_1;
        hard_reset.k_code[3] = rst_2;

        cable_reset.k_code[0] = rst_1;
        cable_reset.k_code[1] = sync_1;
        cable_reset.k_code[2] = rst_1;
        cable_reset.k_code[3] = sync_3;

        sop.k_code[0] = sync_1;
        sop.k_code[1] = sync_1;
        sop.k_code[2] = sync_1;
        sop.k_code[3] = sync_2;

        sop_prime.k_code[0] = sync_1;
        sop_prime.k_code[1] = sync_1;
        sop_prime.k_code[2] = sync_3;
        sop_prime.k_code[3] = sync_3;

        sop_double_prime.k_code[0] = sync_1;
        sop_double_prime.k_code[1] = sync_3;
        sop_double_prime.k_code[2] = sync_1;
        sop_double_prime.k_code[3] = sync_3;

        sop_prime_debug.k_code[0] = sync_1;
        sop_prime_debug.k_code[1] = rst_2;
        sop_prime_debug.k_code[2] = rst_2;
        sop_prime_debug.k_code[3] = sync_3;

        sop_double_prime_debug.k_code[0] = sync_1;
        sop_double_prime_debug.k_code[1] = rst_2;
        sop_double_prime_debug.k_code[2] = sync_3;
        sop_double_prime_debug.k_code[3] = sync_2;

    endfunction : new

    function bit [4:0] encoding(bit [3:0] fourb);
        case(fourb)
            4'b0000: return 5'b11110;
            4'b0001: return 5'b01001;
            4'b0010: return 5'b10100;
            4'b0011: return 5'b10101;
            4'b0100: return 5'b01010;
            4'b0101: return 5'b01011;
            4'b0110: return 5'b01110;
            4'b0111: return 5'b01111;
            4'b1000: return 5'b10010;
            4'b1001: return 5'b10011;
            4'b1010: return 5'b10110;
            4'b1011: return 5'b10111;
            4'b1100: return 5'b11010;
            4'b1101: return 5'b11011;
            4'b1110: return 5'b11100;
            4'b1111: return 5'b11101;
        endcase
    endfunction : encoding

    function bit [3:0] decoding(bit [4:0] fiveb);
        case(fiveb)
            5'b11110: return 4'b0000;
            5'b01001: return 4'b0001;
            5'b10100: return 4'b0010;
            5'b10101: return 4'b0011;
            5'b01010: return 4'b0100;
            5'b01011: return 4'b0101;
            5'b01110: return 4'b0110;
            5'b01111: return 4'b0111;
            5'b10010: return 4'b1000;
            5'b10011: return 4'b1001;
            5'b10110: return 4'b1010;
            5'b10111: return 4'b1011;
            5'b11010: return 4'b1100;
            5'b11011: return 4'b1101;
            5'b11100: return 4'b1110;
            5'b11101: return 4'b1111;
        endcase
    endfunction : decoding


    function bit [31:0] crc_cal();

        bit [31:0] poly = 32'h04C11D87;
        bit [31:0] init = 32'hFFFFFFFF;

    endfunction : crc_cal

endclass : usbpd_transmitter_driver
