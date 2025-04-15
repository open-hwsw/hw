`ifndef CRC32_PKG_SV
`define CRC32_PKG_SV

package crc32_pkg;

	function bit [31:0] crc32(bit [7:0] data[], bit [31:0] poly, init, xorout, bit refin, refout);

		bit [31:0] crc;

		crc = init;

		foreach(data[i])begin

			if(refin) begin
				data[i] = {<<{data[i]}};
			end

			crc ^= (data[i] << 24);

			for (int j = 0; j < 8; j++) begin
                if(crc[31])
					crc = (crc << 1) ^ poly;
				else
					crc = (crc << 1);
			end

		end

		if(refout) begin
			crc = {<<{crc}};
		end

		crc ^= xorout;

		return crc;

	endfunction : crc32

	// crc32-axim
	function bit [31:0] crc32_axim(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h814141AB), .init(32'h00000000), .xorout(32'h00000000), .refin(1'b0), .refout(1'b0));
	endfunction : crc32_axim
	
	// crc32-autosar
	function bit [31:0] crc32_autosar(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'hF4ACFB13), .init(32'hFFFFFFFF), .xorout(32'hFFFFFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_autosar

	// crc32-base91-d
	function bit [31:0] crc32_base91_d(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'hA833982B), .init(32'hFFFFFFFF), .xorout(32'hFFFFFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_base91_d

	// crc32-bzip2
	function bit [31:0] crc32_bzip2(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h04C11DB7), .init(32'hFFFFFFFF), .xorout(32'hFFFFFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc32_bzip2

	// crc32-cd-rom-edc
	function bit [31:0] crc32_cd_rom_edc(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h8001801B), .init(32'h00000000), .xorout(32'h00000000), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_cd_rom_edc

	// crc32-cksum
	function bit [31:0] crc32_cksum(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h04C11DB7), .init(32'h00000000), .xorout(32'hFFFFFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc32_cksum

	// crc32-iscsi
	function bit [31:0] crc32_iscsi(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h1EDC6F41), .init(32'hFFFFFFFF), .xorout(32'hFFFFFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_iscsi

	// crc32-iso-hdlc
	function bit [31:0] crc32_iso_hdlc(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h04C11DB7), .init(32'hFFFFFFFF), .xorout(32'hFFFFFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_iso_hdlc

	// crc32-jamcrc
	function bit [31:0] crc32_jamcrc(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h04C11DB7), .init(32'hFFFFFFFF), .xorout(32'h00000000), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_jamcrc

	// crc32-mef
	function bit [31:0] crc32_mef(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h741B8CD7), .init(32'hFFFFFFFF), .xorout(32'h00000000), .refin(1'b1), .refout(1'b1));
	endfunction : crc32_mef

	// crc32-mpeg-2
	function bit [31:0] crc32_mpeg_2(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h04C11DB7), .init(32'hFFFFFFFF), .xorout(32'h00000000), .refin(1'b0), .refout(1'b0));
	endfunction : crc32_mpeg_2

	// crc32-xfer
	function bit [31:0] crc32_xfer(bit [7:0] data[]);
		return crc32(.data(data), .poly(32'h000000AF), .init(32'h00000000), .xorout(32'h00000000), .refin(1'b0), .refout(1'b0));
	endfunction : crc32_xfer

endpackage : crc32_pkg

`endif // CRC32_PKG_SV