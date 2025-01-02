
`default_nettype  none

module spi_slave
	(
	// SPI ports
	input  logic                  scl,      // serial clock
	input  logic                  cs_n,     // chip select, active low
	input  logic                  sdi,      // serial data in
	inout  tri                    sdo_sdio  // Serial data out or serial data in/out
	);

	logic sdo_sdio_ctrl; // sdo_sdio_ctrl = 1 : SDIO, sdo_sdio_ctrl = 0 : SDO
	logic sdo;           // value to output on the sdo_sdio line

	assign sdo_sdio = (sdo_sdio_ctrl) ? sdo : 1'bz;
	
endmodule
