`ifndef CRC_PKG_SV
`define CRC_PKG_SV

package crc_pkg;

	import crc8_pkg::*;
	export crc8_pkg::crc8;
	export crc8_pkg::crc8_autosar;
	export crc8_pkg::crc8_bluetooth;
	export crc8_pkg::crc8_cdma2000;
	export crc8_pkg::crc8_darc;
	export crc8_pkg::crc8_dvb_s2;
	export crc8_pkg::crc8_gsm_a;
	export crc8_pkg::crc8_gsm_b;
	export crc8_pkg::crc8_hitag;
	export crc8_pkg::crc8_i_432_1;
	export crc8_pkg::crc8_i_code;
	export crc8_pkg::crc8_lte;
	export crc8_pkg::crc8_maxim_dow;
	export crc8_pkg::crc8_mifare_mad;
	export crc8_pkg::crc8_nrsc_5;
	export crc8_pkg::crc8_opensafety;
	export crc8_pkg::crc8_rohc;
	export crc8_pkg::crc8_sae_j1850;
	export crc8_pkg::crc8_smbus;
	export crc8_pkg::crc8_tech_3250;
	export crc8_pkg::crc8_wcdma;

	import crc16_pkg::*;
	export crc16_pkg::crc16;
	export crc16_pkg::crc16_arc;
	export crc16_pkg::crc16_cdma2000;
	export crc16_pkg::crc16_cms;
	export crc16_pkg::crc16_dds_100;
	export crc16_pkg::crc16_dect_r;
	export crc16_pkg::crc16_dect_x;
	export crc16_pkg::crc16_dnp;
	export crc16_pkg::crc16_en_13757;
	export crc16_pkg::crc16_genibus;
	export crc16_pkg::crc16_gsm;
	export crc16_pkg::crc16_ibm_3470;
	export crc16_pkg::crc16_ibm_sdlc;
	export crc16_pkg::crc16_iso_iec_14443_3_a;
	export crc16_pkg::crc16_kermit;
	export crc16_pkg::crc16_lj1200;
	export crc16_pkg::crc16_m17;
	export crc16_pkg::crc16_maxim_dow;
	export crc16_pkg::crc16_mcrf4xx;
	export crc16_pkg::crc16_modbus;
	export crc16_pkg::crc16_nrsc_5;
	export crc16_pkg::crc16_opensafety_a;
	export crc16_pkg::crc16_opensafety_b;
	export crc16_pkg::crc16_profibus;
	export crc16_pkg::crc16_riello;
	export crc16_pkg::crc16_fujitsu;
	export crc16_pkg::crc16_t10_dif;
	export crc16_pkg::crc16_teledisk;
	export crc16_pkg::crc16_tms37157;
	export crc16_pkg::crc16_umts;
	export crc16_pkg::crc16_usb;
	export crc16_pkg::crc16_xmodem;

	import crc32_pkg::*;
	export crc32_pkg::crc32;
	export crc32_pkg::crc32_axim;
	export crc32_pkg::crc32_autosar;
	export crc32_pkg::crc32_base91_d;
	export crc32_pkg::crc32_bzip2;
	export crc32_pkg::crc32_cd_rom_edc;
	export crc32_pkg::crc32_cksum;
	export crc32_pkg::crc32_iscsi;
	export crc32_pkg::crc32_iso_hdlc;
	export crc32_pkg::crc32_jamcrc;
	export crc32_pkg::crc32_mef;
	export crc32_pkg::crc32_mpeg_2;
	export crc32_pkg::crc32_xfer;

endpackage : crc_pkg

`endif // CRC_PKG_SV