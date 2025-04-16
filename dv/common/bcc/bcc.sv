`ifndef BCC_SV
`define BCC_SV

// Block Check Character
package bcc_pkg;

	function bit [7:0] bcc8(bit [7:0] data[]);
		return data.xor();
	endfunction : bcc8

	function bit [15:0] bcc16(bit [15:0] data[]);
		return data.xor();
	endfunction : bcc16

	function bit [31:0] bcc32(bit [31:0] data[]);
		return data.xor();
	endfunction : bcc32

endpackage : bcc_pkg

`endif //BCC_SV