`ifndef CHECKSUM_SV
`define CHECKSUM_SV

package checksum_pkg;

	function bit [7:0] checksum8(bit [7:0] data[]);
		return data.sum();
	endfunction : checksum8

	function bit [15:0] checksum16(bit [15:0] data[]);
		return data.sum();
	endfunction : checksum16

	function bit [31:0] checksum32(bit [31:0] data[]);
		return data.sum();
	endfunction : checksum32

endpackage : checksum_pkg

`endif // CHECKSUM_SV