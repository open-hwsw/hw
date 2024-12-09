module prop_mod #(
    parameter PARAM = 8
)(
    input logic [3:0] v
);

    initial begin
        #1ns;
        $display("%m: v = 0x%x, PARAM = %d", v, PARAM);
    end

endmodule

module sub();
    
    parameter PARAM = 16;
    logic [3:0] v = 'ha;

    prop_mod #(.PARAM(PARAM)) prop_direct(.*);

endmodule

module dut();
    sub #(.PARAM(1)) u_sub_1();
    sub #(.PARAM(4)) u_sub_2();
endmodule

module top;
    dut u_dut();
endmodule

module bind_module;

    // Binding auxiliary code to scopes
    bind sub prop_mod #(.PARAM(PARAM)) prop_for_design(.*);
    // Binding auxiliary code to instances
    bind $root.top.u_dut.u_sub_2 prop_mod #(.PARAM(PARAM)) prop_for_instance(.*);

endmodule
