`ifndef CRC16_PKG_SV
`define CRC16_PKG_SV

package crc16_pkg;

	function bit [15:0] crc16(bit [7:0] data[], bit [15:0] poly, init, xorout, bit refin, refout);

		bit [15:0] crc;

		crc = init;

		foreach(data[i])begin

			if(refin) begin
				data[i] = {<<{data[i]}};
			end

			crc ^= (data[i] << 8);

			for (int j = 0; j < 8; j++) begin
                if(crc[15])
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

	endfunction : crc16

	// crc16-arc
	function bit [7:0] crc16_arc(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'h0000), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_arc

	// crc16-cdma2000
	function bit [7:0] crc16_cdma2000(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'hC867), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_cdma2000

	// crc16-cms
	function bit [7:0] crc16_cms(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_cms

	// crc16-dds-100
	function bit [7:0] crc16_dds_100(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'h800D), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_dds_100

	// crc16-dect-r
	function bit [7:0] crc16_dect_r(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h0589), .init(16'h0000), .xorout(16'h0001), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_dect_r

	// crc16-dect-x
	function bit [7:0] crc16_dect_x(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h0589), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_dect_x

	// crc16-dnp
	function bit [7:0] crc16_dnp(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h3D65), .init(16'h0000), .xorout(16'hFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_dnp

	// crc16-en-13757
	function bit [7:0] crc16_en_13757(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h3D65), .init(16'h0000), .xorout(16'hFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_en_13757

	// crc16-en-13757
	function bit [7:0] crc16_genibus(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'hFFFF), .xorout(16'hFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_genibus

	// crc16-gsm
	function bit [7:0] crc16_gsm(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'h0000), .xorout(16'hFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_gsm

	// crc16-ibm-3470
	function bit [7:0] crc16_ibm_3470(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_ibm_3470

	// crc16-ibm-sdlc
	function bit [7:0] crc16_ibm_sdlc(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'hFFFF), .xorout(16'hFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_ibm_sdlc

	// crc16-iso-iec-14443-3-a
	function bit [7:0] crc16_iso_iec_14443_3_a(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'hC6C6), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_iso_iec_14443_3_a

	// crc16-kermit
	function bit [7:0] crc16_kermit(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'h0000), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_kermit

	// crc16-lj1200
	function bit [7:0] crc16_lj1200(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h6F63), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_lj1200

	// crc16-m17
	function bit [7:0] crc16_m17(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h5935), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_m17

	// crc16-maxim-dow
	function bit [7:0] crc16_maxim_dow(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'h0000), .xorout(16'hFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_maxim_dow

	// crc16-mcrf4xx
	function bit [7:0] crc16_mcrf4xx(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_mcrf4xx

	// crc16-modbus
	function bit [7:0] crc16_modbus(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_modbus

	// crc16-nrsc-5
	function bit [7:0] crc16_nrsc_5(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h080BB), .init(16'hFFFF), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_nrsc_5

	// crc16-opensafety-a
	function bit [7:0] crc16_opensafety_a(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h5935), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_opensafety_a

	// crc16-opensafety-b
	function bit [7:0] crc16_opensafety_b(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h755B), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_opensafety_b

	// crc16-profibus
	function bit [7:0] crc16_profibus(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1DCF), .init(16'hFFFF), .xorout(16'hFFFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_profibus

	// crc16-riello
	function bit [7:0] crc16_riello(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'B2AA), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_riello

	// crc16-fujitsu
	function bit [7:0] crc16_fujitsu(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'h1D0F), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_fujitsu

	// crc16-t10-dif
	function bit [7:0] crc16_t10_dif(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8BB7), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_t10_dif

	// crc16-teledisk
	function bit [7:0] crc16_teledisk(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'hA097), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_teledisk

	// crc16-tms37157
	function bit [7:0] crc16_tms37157(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'h89EC), .xorout(16'h0000), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_tms37157

	// crc16-umts
	function bit [7:0] crc16_umts(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_umts

	// crc16-usb
	function bit [7:0] crc16_usb(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h8005), .init(16'hFFFF), .xorout(16'hFFFF), .refin(1'b1), .refout(1'b1));
	endfunction : crc16_usb

	// crc16-xmodem
	function bit [7:0] crc16_xmodem(bit [7:0] data[]);
		return crc16(.data(data), .poly(16'h1021), .init(16'h0000), .xorout(16'h0000), .refin(1'b0), .refout(1'b0));
	endfunction : crc16_xmodem

endpackage : crc16_pkg

`endif // CRC16_PKG_SV