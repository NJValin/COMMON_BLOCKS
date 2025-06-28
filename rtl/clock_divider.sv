`default_nettype none

module clock_divider (
	input  logic          clk_in,
	input  logic          rstn,
	input  logic [31:0]   int_div,
	output logic         clk_out
	);

	int sync_div;
	int counter;
	int en_count;
	logic clk_out_driver;
	always_ff @ (posedge clk_in, negedge rstn) begin
		if (!rstn) begin
			sync_div<='h0;
			counter <='h1;
			clk_out_driver <= 1'b0;
		end
		else if (sync_div == counter<<1) begin
			clk_out_driver <= ~clk_out_driver;
			counter <= 'h1;
		end
		else begin
			sync_div <= int_div;
			en_count <= 32'hffffffff; // bit-mask to make sure that
			counter <= (counter + 32'h1) & en_count; // Increment and mask
		end
	end

	assign clk_out = clk_out_driver;
endmodule
