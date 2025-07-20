`default_nettype none

module data_buffer #(
		parameter WORD_SIZE = 8,
		parameter DEPTH     = 4
	) (
		input logic                  clk,
		input logic                  rstn,
		input logic                  write,
		input logic                  read,
		
		input logic [WORD_SIZE-1:0]  data_in,
		output logic [WORD_SIZE-1:0] data_out,

		output logic                 buffer_full,
		output logic                 overflow
	);

	logic [DEPTH-1:0][WORD_SIZE-1:0] buffer;
	logic                            buffer_empty;
	logic [$clog2(DEPTH)-1:0]        max_index;
	logic [$clog2(DEPTH)-1:0]        write_pointer;

	assign max_index    = DEPTH-1;
	assign buffer_full  = ~&(max_index ^ write_pointer); // buffer is full if max_index = write_pointer
	assign buffer_empty = ~&write_pointer; // Unary NAND to 

	assign data_out     = buffer[0];

	always_ff @(posedge clk, negedge rstn) begin
		if (!rstn) begin
			for (int i=0; i<DEPTH; i=i+1) begin
				buffer[i] <= 'b0;
			end
			write_pointer <= 'b0;
			overflow <= 'b0;
		end	
		else begin
			if (read) begin
				for (int i=DEPTH-1; i>0; i=i-1) begin
					buffer[i-1] <= buffer[i];
				end 
				write_pointer <= (buffer_empty)?write_pointer:write_pointer-1;
			end
			else begin
			end
			if (write) begin
				buffer[write_pointer] <= data_in;
				write_pointer <= (buffer_full)?write_pointer:write_pointer+1;
				overflow <= (buffer_full)?1'b1:1'b0;
			end
			else begin
				
			end
		end
	end 
endmodule
