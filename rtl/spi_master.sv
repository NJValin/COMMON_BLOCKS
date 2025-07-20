////////////////////////////////////////////////
// test
////////////////////////////////////////////////
`default_nettype none

`define BYTE_LEN 8
module spi_master
	#(
		parameter CS_INST      = 1  // number of chip selects, each one corresponding to a slave
	) 
	(
		// Interface
		output logic [`BYTE_LEN-1:0]  data_out, // De-serialized data read from slave to be put on system data bus
		input  logic [`BYTE_LEN-1:0]  data_in,  // Data to be serialized and written to the selected slave.
		
		// SPI ports
		output logic                  scl,      // serial clock
		output logic [CS_INST-1:0]    cs_n,     // chip select, active low
		input  logic                  sdi,      // serial data in, aka MISO
		inout  logic                  sdo_sdio  // Serial data out or serial data in/out. aka MOSI
	);

	// CPOL : Determines the logical position of the clock when chip select is high
	//        CPOL=1 means that the clock idles at 1'b1 when chip select is 1
	//        CPOL=0 means that the clock idles at 1'b0 when chip select is 1
	// CPHA : Determines the configuration of the CPOL
	// [CPOL|CPHA]
	//   1     0
	logic [`SPI_REG_LEN-1:0] spi_control_reg; 
	
endmodule
