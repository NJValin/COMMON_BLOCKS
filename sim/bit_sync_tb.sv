`timescale 1ns/10fs

module bit_sync_tb;

	localparam int num_ff = 2;

	logic data_test;
	logic data_out;
	logic source_clk=0;
	logic destination_clk=0;
	logic rstn = 1;
	

	ndff_bit_sync dut (
		.D_in(data_test),
		.dest_clk(destination_clk),
		.rstn(rstn),
		.D_out(data_out)
	);

	initial begin
		$dumpfile("waves.vcd");
		$dumpvars(0, bit_sync_tb);
		rstn = 0;
		#100
		rstn=1;
	end

	always_ff @(posedge source_clk, negedge rstn) begin : blockName
		if (!rstn) begin
			data_test<=0;
		end
		else begin
			data_test <= data_test+1;
		end
	end

	always #50 source_clk = ~source_clk;
	always #6 destination_clk = ~destination_clk;
endmodule
