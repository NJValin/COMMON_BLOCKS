
`default_nettype  none

module spi_ahb_slave_interface 
	#(
		parameter DATA_WIDTH=32,
		parameter ADDR_WIDTH=32
	)
	(
	// AHB bus
	input  logic                  hclk,
	input  logic                  hresetn, // Global ahb bus reset
	input  logic                  hselx,   // Indicates whether or not this is the slave selected for transfer
	input  logic [ADDR_WIDTH-1:0] haddr,
	input  logic                  hwrite,
	input  logic [2:0]            hsize,
	input  logic [2:0]            hburst,
	input  logic [3:0]            hprot,
	input  logic [1:0]            htrans,
	input  logic                  hmastlock,
	input  logic                  hready,
	input  logic [DATA_WIDTH-1:0] hwdata,

	output logic                  hreadyout, // Indicates that a transfer has finished (drive low to extend transfer)
	output logic                  hresp, // 0 tells master transfer sts is ok. 1 tells master transfer sts is ERROR
	output logic [DATA_WIDTH-1:0] hrdata,
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
