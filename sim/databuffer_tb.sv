`timescale 100ns/10ns
module databuffer_tb;
	
	int word_size = 8;
	int depth = 4;
	logic                  clk = 0;
	logic                  rstn = 1;
	logic                  write = 0;
	logic                  read = 0;
	
	logic [8-1:0]  data_in;
	logic [8-1:0] data_out;

	logic                 buffer_full;
	logic                 overflow;
	data_buffer 
		#(.WORD_SIZE(8),
		  .DEPTH(4))
		u_data_buffer (
		.clk,
		.rstn,
		.write,
		.read,
		.data_in,
		.data_out,

		.buffer_full,
		.overflow);

	initial begin
		$dumpfile("waves.vcd");
		$dumpvars(0, databuffer_tb);
		#1;
		rstn = 0;
		#1000;
		rstn = 1;
		data_in = 'd51;
		#1000;
		write = 1;
		#1000;
		write = 0;
		#1000
		data_in = 'd14;
		#1000;
		write = 1;
		#1000;
		write = 0;
		#1000
		data_in = 'd128;
		#1000;
		write = 1;
		#1000;
		write = 0;
		#1000;
		read = 1;
		#1000;
		read = 0;
		#1000;
		read = 1;
		#1000;
		read = 0;
		#1000;
		read = 1;
		#1000;
		read = 0;
		#1000;
		read = 1;
		#1000;
		read = 0;
		#1000;
		read = 1;
		#1000;
		read = 0;
	end
	
	always #50 clk = ~clk;
	
endmodule
