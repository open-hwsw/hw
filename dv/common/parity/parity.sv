`ifndef PARITY_SV
`define PARITY_SV

package parity_pkg;

	typedef enum bit { 
		ODD  = 0,
		EVEN = 1
	} parity_mode_e;

	function bit parityGen(bit [7:0] data, parity_mode_e parity_mode);
		return (parity_mode == ODD) ? ~^data : ^data;
	endfunction : parityGen

	function bit parityCheck(bit [7:0] data, bit parity, parity_mode_e parity_mode);
		return (parity_mode == ODD) ? (~^data == parity) ? 1'b1 : 1'b0 : (^data == parity) ? 1'b1 : 1'b0;
	endfunction : parityCheck

	function bit oddParityCheck(bit [7:0] data, bit parity);
		return parityCheck(data, parity, ODD);
	endfunction : oddParityCheck

	function bit evenParityCheck(bit [7:0] data, bit parity);
		return parityCheck(data, parity, EVEN);
	endfunction : evenParityCheck

endpackage : parity_pkg

`endif // PARITY_SV