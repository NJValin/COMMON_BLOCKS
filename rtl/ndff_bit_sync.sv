`default_nettype none

module ndff_bit_sync #(
		parameter NUM_OF_FLOPS = 2
	)
	(
		input  logic  D_in,
		input  logic  dest_clk,
		input  logic  rstn,
		output logic  D_out
	);

	logic [NUM_OF_FLOPS-1:0] sync_flops;
	integer i;

	always_ff @(posedge dest_clk, negedge rstn) begin
		if (!rstn) begin
			sync_flops <= 'b0;
		end
		else begin
			for (i=0; i<NUM_OF_FLOPS; i=i+1) begin
				if (i==0) begin
					sync_flops[i]<=D_in;
				end
				else begin
					sync_flops[i]<=sync_flops[i-1];
				end
			end
		end
	end


	assign D_out = sync_flops[NUM_OF_FLOPS-1];
		
endmodule
