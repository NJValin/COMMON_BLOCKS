//////////////////////////////////////////////////////
// Copyright (c) 2025 Neil Valin. All Rights Reserved.
//
//
//////////////////////////////////////////////////////
`default_nettype none

module mux_bit_sync #(
		parameter bit RESET_VAL = 1'b0,
		parameter int NUM_OF_SYNC_FLOPS = 2
	) (
		input  logic              data_in,
		input  logic              dest_clk,
		input  logic              rstn,
		input  logic              ready,
		output logic              data_out
	);

	logic registered_data_out;

	always_ff @(posedge dest_clk, negedge rstn) begin
		if (!rstn) begin
			registered_data_out <= RESET_VAL;
		end
		else begin
			registered_data_out <= (sync_ready) ? data_in : registered_data_out;
		end
	end



	assign data_out = registered_data_out;

	synchronize_bit #(NUM_OF_SYNC_FLOPS)
	u_sync_ready (
		.D_in(ready),
		.dest_clk(dest_clk),
		.rstn(rstn),
		.D_out(sync_ready)
	);

endmodule
