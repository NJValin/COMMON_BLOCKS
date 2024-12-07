
module clock_gate_test;
	logic clk_in=0;
	logic enable=0;
	logic test_pin=0;
	logic clk_out;

	clock_gate dut (
		.enable,
		.test_pin,
		.clk_in,
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
		// Initialize signals
		#500
		enable = 1'b1;
		#1000
		enable = 1'b0;
		#200
		enable = 1'b1;

		#1000


		// End simulation
		$stop;
	end

	initial begin
	$dumpfile("waveform.vcd"); // Name of the VCD file
	$dumpvars(0, dut); // Dump all variables in the testbench
    end

endmodule
