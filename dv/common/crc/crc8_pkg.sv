`ifndef CRC8_PKG_SV
`define CRC8_PKG_SV

package crc8_pkg;

	function bit [7:0] crc8(bit [7:0] data[], poly, init, xorout, bit refin, refout);

		bit [7:0] crc;

		crc = init;

		foreach(data[i])begin

			if(refin) begin
				data[i] = {<<{data[i]}};
			end

			crc ^= data[i];

			for (int j = 0; j < 8; j++) begin
                if(crc[7])
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

	endfunction : crc8

	// crc8-autosar
	function bit [7:0] crc8_autosar(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h2F), .init(8'hFF), .xorout(8'hFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_autosar
	
	// crc8-bluetooth
	function bit [7:0] crc8_bluetooth(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'hA7), .init(8'h00), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_bluetooth

	// crc8-cdma2000
	function bit [7:0] crc8_cdma2000(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h9B), .init(8'hFF), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_cdma2000

	// crc8-darc
	function bit [7:0] crc8_darc(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h39), .init(8'h00), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_darc

	// crc8-dvb-s2
	function bit [7:0] crc8_dvb_s2(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'hD5), .init(8'h00), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_dvb_s2

	// crc8-gsm-a
	function bit [7:0] crc8_gsm_a(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'h00), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_gsm_a

	// crc8-gsm-b
	function bit [7:0] crc8_gsm_b(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h49), .init(8'h00), .xorout(8'hFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_gsm_b

	// crc8-gsm-b
	function bit [7:0] crc8_hitag(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'hFF), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_hitag

	// crc8-i-432-1/crc8-itu
	function bit [7:0] crc8_i_432_1(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h07), .init(8'h00), .xorout(8'h55), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_i_432_1

	// crc8-i-code
	function bit [7:0] crc8_i_code(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'hFD), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_i_code

	// crc8-lte
	function bit [7:0] crc8_lte(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h9B), .init(8'h00), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_lte

	// crc8-maxim-dow
	function bit [7:0] crc8_maxim_dow(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h31), .init(8'h00), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_maxim_dow

	// crc8-mifare-mad
	function bit [7:0] crc8_mifare_mad(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'hC7), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_mifare_mad

	// crc8-nrsc-5
	function bit [7:0] crc8_nrsc_5(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h31), .init(8'hFF), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_nrsc_5

	// crc8-opensafety
	function bit [7:0] crc8_opensafety(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h2F), .init(8'h00), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_opensafety

	// crc8-rohc
	function bit [7:0] crc8_rohc(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h07), .init(8'hFF), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_rohc

	// crc8-sae-j1850
	function bit [7:0] crc8_sae_j1850(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'hFF), .xorout(8'hFF), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_sae_j1850

	// crc8-smbus
	function bit [7:0] crc8_smbus(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h07), .init(8'h00), .xorout(8'h00), .refin(1'b0), .refout(1'b0));
	endfunction : crc8_smbus

	// crc8-tech-3250
	function bit [7:0] crc8_tech_3250(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h1D), .init(8'hFF), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_tech_3250

	// crc8-wcdma
	function bit [7:0] crc8_wcdma(bit [7:0] data[]);
		return crc8(.data(data), .poly(8'h9B), .init(8'h00), .xorout(8'h00), .refin(1'b1), .refout(1'b1));
	endfunction : crc8_wcdma

endpackage : crc8_pkg

`endif // CRC8_PKG_SV