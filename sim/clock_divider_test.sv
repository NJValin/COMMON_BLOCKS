`default_nettype none
`timescale 1ns / 100ps

module clock_divider_test;
	logic clk_in=0;
	logic rstn=1;
	int int_div=0;
	logic clk_out;

	clock_divider dut (
		.clk_in,
		.rstn,
		.int_div,
		.clk_out);

	initial begin
		forever begin
			clk_in = 1'b0;
			#(10);
			clk_in = 1'b1;
			#(10);
		end
	end

	initial begin
		#5
		// Initialize signals
		rstn = 1'b0;
		int_div = 4; // Default divider value (divide by 4)

		// Apply reset
		#5 rstn = 1'b1;

		// Wait for stabilization
		#1000;

		// Change divider value and observe behavior
		int_div = 2; // Divide by 2
		#1000;

		int_div = 8; // Divide by 8
		#2000;

		// End simulation
		$stop;
	end

	initial begin
        $monitor("Time: %0t | clk_in: %b | rstn: %b | int_div: %d | clk_out: %b",
                 $time, clk_in, rstn, int_div, clk_out);
	$dumpfile("waveform.vcd"); // Name of the VCD file
	$dumpvars(0, dut); // Dump all variables in the testbench
    end

endmodule
