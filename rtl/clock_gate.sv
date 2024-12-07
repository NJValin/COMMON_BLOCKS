///////////////////////////////////////////////////////////////
// 
// 
///////////////////////////////////////////////////////////////
`default_nettype none

module clock_gate (
	input  logic  enable,
	input  logic  test_pin,
	input  logic  clk_in,
	output logic  clk_out
	);

	logic latch_out;

	always_latch begin
		if (!clk_in)
			latch_out <= enable | test_pin;
		else begin
		end
	end

	always_comb begin
		if (clk_in & latch_out)
			clk_out = 1'b1;
		else
			clk_out = 1'b0;
	end
	
endmodule
