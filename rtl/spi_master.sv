`default_nettypes none

module spi_master
	#(
		parameter CS_INST      = 1  // number of chip selects, each one corresponding to a slave
	) 
	(
		// SPI ports
		output logic                  scl,      // serial clock
		output logic [CS_INST-1:0]    cs_n,     // chip select, active low
		input  logic                  sdi,      // serial data in
		inout  tri                    sdo_sdio  // Serial data out or serial data in/out
	);
endmodule
