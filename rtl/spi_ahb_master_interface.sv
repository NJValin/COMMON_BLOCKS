`default_nettypes none

module spi_ahb_master_interface 
	#(
		parameter DATA_WIDTH   = 32,// must be 2^n for 3<=n<=10
		parameter ADDR_WIDTH   = 32,
		parameter HBURST_WIDTH = 3, // can either be 0 or 3
		parameter HPROT_WIDTH  = 4, // can either be 0,4,7
		parameter CS_INST      = 1  // number of chip selects, each one corresponding to a slave
	) 
	(
		// AHB bus ports 
		input  logic                  hresetn,
		input  logic                  hclk,
		input  logic                  hready,  // The slave asserts this to hold the data cycle.
		input  logic                  hresp,
		input  logic [DATA_WIDTH-1:0] hrdata, // Data read from slave
		output logic [ADDR_WIDTH-1:0] haddr,
		output logic                  hwrite,// Indicates the transfer direction 1:write 0:read
		output logic [2:0]            hsize, // Indicates the size of the transfer
		output logic [HBURST_WIDTH-1:0] hburst, // Indicates # of transfers are in the burst and how the address increments
		output logic [HPROT_WIDTH-1:0] hprot, // Protection control signal, tells the access type.
		output logic [1:0]            htrans, // Indicates the transfer type. Can be IDLE, BUSY, NONSEQUENTIAL, & SEQUENTIAL 
		output logic                  hmastlock, // Indicates that the current transfer is part of a locked sequence.
		output logic [DATA_WIDTH-1:0] hwdata,
			                                      
		output logic [DATA_WIDTH>>3-1:0] hwstrb, // Write strobes. There is 1 bit for each byte of HWDATA. HWSTRB[n] corresponds to HWDATA[(8n)+7:(8n)].
												 // Deasserted to indicate when active write data byte lanes do not contain valid data
		// SPI ports
		output logic                  scl,      // serial clock
		output logic [CS_INST-1:0]    cs_n,     // chip select, active low
		input  logic                  sdi,      // serial data in
		inout  tri                    sdo_sdio  // Serial data out or serial data in/out
	);
endmodule
