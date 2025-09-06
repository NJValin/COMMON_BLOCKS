///////////////////////////////////////////////////////////////
// Copyright (c) 2025 Neil Valin. All Rights Reserved.
//
// design yoinked from https://www.eetimes.com/techniques-to-make-clock-switching-glitch-free/
///////////////////////////////////////////////////////////////

`default_nettype none
module clock_mux #(
		parameter ASYNC_CLK = 0
	)(
		input  logic rstn,
		input  logic clk0,
		input  logic clk1,
		input  logic sel,
		output logic clk_out
	);

	logic clk0_gate, clk1_gate;
	logic clk0_Q, clk1_Q;

	generate
		if (ASYNC_CLK) begin : CLK_ASYNC
			logic clk0_Q_sync, clk1_Q_sync;
			always_ff @(negedge clk0, negedge rstn) begin
				if (!rstn) begin
					clk0_Q <= 1'b0;
					clk0_Q_sync <= 1'b0;
				end
				else begin
					clk0_Q_sync <= clk0_gate;
					clk0_Q <= clk0_Q_sync;
				end
			end

			always_ff @(negedge clk1, negedge rstn) begin
				if (!rstn) begin
					clk1_Q <= 1'b0;
					clk1_Q_sync <= 1'b0;
				end
				else begin
					clk1_Q_sync <= clk1_gate;
					clk1_Q <= clk1_Q_sync;
				end
			end
		end
		else begin : CLK_SYNC
			always_ff @(negedge clk0, negedge rstn) begin
				if (!rstn) begin
					clk0_Q <= 1'b0;
				end
				else begin
					clk0_Q <= clk0_gate;
				end
			end

			always_ff @(negedge clk1, negedge rstn) begin
				if (!rstn) begin
					clk1_Q <= 1'b0;
				end
				else begin
					clk1_Q <= clk1_gate;
				end
			end
		end
	endgenerate

	always_comb begin
		clk0_gate = sel & (~clk1_Q);
		clk1_gate = sel & (~clk0_Q);
	end


	
endmodule
