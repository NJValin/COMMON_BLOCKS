///////////////////////////////////////////////////////
// Copyright (c) 2025 Neil Valin. All Rights Reserved.
// ----------------------------------------------------
//
///////////////////////////////////////////////////////
`default_nettype none

module synchronize_bit #(
		parameter NUM_OF_FLOPS  = 2 // min 2
	) (
		input  logic  D_in,
		input  logic  dest_clk,
		input  logic  rstn,
		output logic  D_out,
		output logic  sync_pulse
	);

	`ifdef VIVADO
	(* ASYNC_REG = "True" *) logic [NUM_OF_FLOPS-1:0] sync_flops;
	(* ASYNC_REG = "True" *) logic                    sync_int;
	`else
	logic [NUM_OF_FLOPS-1:0]    sync_flops;
	logic                       sync_int;
	`endif

	always_ff @(posedge dest_clk, negedge rstn) begin
		if (!rstn) begin
			sync_flops[0] <= 'b0;
		end
		else begin
			sync_flops[0]<=D_in;
		end
	end

	genvar i;
	generate
		for (i=1; i<NUM_OF_FLOPS; i++) begin : SYNC_FLOPS
			always_ff @(posedge dest_clk, negedge rstn) begin
				if (!rstn) begin
					sync_flops[i] <= 'b0;
				end
				else begin
					sync_flops[i]<=sync_flops[i-1];
				end
			end
		end
	endgenerate

	always_ff @(posedge dest_clk, negedge rstn) begin
		if (!rstn) begin
			D_out <= 'b0;
		end
		else begin
			D_out <= sync_flops[NUM_OF_FLOPS-1];
		end
	end


	always_ff @(posedge clk, negedge rstn) begin
		if (!rstn) begin
			sync_int <= 'b0;
		end
		else begin
			sync_int <= sync_flops[NUM_OF_FLOPS-2] ^ sync_flops[NUM_OF_FLOPS-1];
		end
	end
	
	assign sync_pulse = sync_int;

		
endmodule
