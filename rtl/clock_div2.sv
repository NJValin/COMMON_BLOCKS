///////////////////////////////////////////////////////////
// Copyright (c) 2025 Neil Valin. All Rights Reserved.
//
//
///////////////////////////////////////////////////////////

`default_nettype none
module clock_div2  #(parameter RST_VAL=0) (
		input logic clk,
		input logic rstn,
		output logic clk_div2
	);

	logic int_clk_div2;

	always_ff @(posedge clk, negedge rstn) begin
		if (!rstn) begin
			int_clk_div2 <= RST_VAL;
		end
		else begin
			int_clk_div2 <= ~int_clk_div2;
		end
	end

	assign clk_div2 = int_clk_div2;
	
endmodule
