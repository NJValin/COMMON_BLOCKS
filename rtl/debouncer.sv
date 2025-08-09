///////////////////////////////////////////////////////////
// Copyright (c) 2025 Neil Valin. All Rights Reserved.
//
// Basically just drives the input onto the output if it stable
// for stable_cycles cycles of the clock
//
///////////////////////////////////////////////////////////

`default_nettype none

module debouncer #(
		parameter DATA_W = 8,
		parameter STABLE_CYCLES_W=8,
		parameter RST_VAL=0
	) 
	(
		input  logic                        clk,
		input  logic                        rstb,
		input  logic  [STABLE_CYCLES_W-1:0] stable_cycles,
		input  logic  [DATA_W-1:0]          data_in,
		output logic  [DATA_W-1:0]          data_out
	);


	enum bit {DATA_LATCH, STABLE_COUNT} state;

	logic [DATA_W-1:0] data_latched;
	logic [STABLE_CYCLES_W-1:0] stable_cnt;

	always_ff @(posedge clk, negedge rstb) begin
		if (!rstb) begin
			data_out <= {DATA_W{RST_VAL}};
			data_latched <= {DATA_W{RST_VAL}};
			state <= DATA_LATCH;
			stable_cnt <= 'h0;
		end
		else begin
			case (state)
				DATA_LATCH : begin
					// If there is no change in the input do nothing
					if (data_latched != data_in) begin
						data_latched <= data_in;
						stable_cnt <= 'h0;
						state <= STABLE_COUNT;
					end
				end
				STABLE_COUNT : begin
					if (data_latched != data_in) begin
						state <= DATA_LATCH;
					end
					else if (stable_cnt >= stable_cycles) begin
						data_out <= data_latched;
						stable_cnt <= 'h0;
						
					end
					else begin
						stable_cnt <= stable_cnt+'b1;
					end
				end
				default : begin
					$display("How did you get here?");
					data_out <= {DATA_W{RST_VAL}};
					data_latched <= {DATA_W{RST_VAL}};
					state <= DATA_LATCH;
					stable_cnt <= 'h0;
				end
			endcase
		end
	end
		
endmodule
