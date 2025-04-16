`ifndef LRC_SV
`define LRC_SV

// Longitudinal redundancy check
package lrc_pkg;

	function bit [7:0] lrc(bit [7:0] data[]);
		return ~data.sum()+8'h01;
	endfunction : lrc

endpackage : lrc_pkg

`endif //LRC_SV