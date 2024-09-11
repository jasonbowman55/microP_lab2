 //Jason Bowman
//jbowman@g.hmc.edu
//9-9-24

module top (
	input logic clk,
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg,
	output logic [4:0] led
	);

	seven_seg_decoder MOD1 (clk, reset, left, right, seg);

	binary_disp_decoder MOD2 (reset, left, right, led);

endmodule

// MOD1 //////////////////////////////////////
// 7 segment decoder
module seven_seg_decoder (
	input logic clk,
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg
	);

	//initializing variables
	logic [23:0] state;

	// adding 1 to the value of the state to oscillate based on clk
	always_ff @(posedge clk) begin
		if (reset == 0)
			state <= 24'b0;
		else
			state <= state + 1;
	end

 //combinational logic to assign bits to the displays
	always_comb begin
		if (state[5] == 0)
			case(left)
				4'h0: seg = 7'b0000001;
				4'h1: seg = 7'b1001111;
				4'h2: seg = 7'b0010010;
				4'h3: seg = 7'b0000110;
				4'h4: seg = 7'b1001100;
				4'h5: seg = 7'b0100100;
				4'h6: seg = 7'b0100000;
				4'h7: seg = 7'b0001111;
				4'h8: seg = 7'b0000000;
				4'h9: seg = 7'b0001100;
				4'hA: seg = 7'b0001000;
				4'hB: seg = 7'b1100000;
				4'hC: seg = 7'b0110001;
				4'hD: seg = 7'b1000010;
				4'hE: seg = 7'b0110000;
				4'hF: seg = 7'b0111000;
				default: seg = 7'b1111111;
			endcase

		else
			case(right)
				4'h0: seg = 7'b0000001;
				4'h1: seg = 7'b1001111;
				4'h2: seg = 7'b0010010;
				4'h3: seg = 7'b0000110;
				4'h4: seg = 7'b1001100;
				4'h5: seg = 7'b0100100;
				4'h6: seg = 7'b0100000;
				4'h7: seg = 7'b0001111;
				4'h8: seg = 7'b0000000;
				4'h9: seg = 7'b0001100;
				4'hA: seg = 7'b0001000;
				4'hB: seg = 7'b1100000;
				4'hC: seg = 7'b0110001;
				4'hD: seg = 7'b1000010;
				4'hE: seg = 7'b0110000;
				4'hF: seg = 7'b0111000;
				default: seg = 7'b1111111;
			endcase

	end


endmodule
///////////////////////////////////////////

// MOD2 /////////////////////////////////////////
module binary_disp_decoder(
	input logic clk,
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [4:0] led
);
	always_ff @(posedge clk) begin
		led[0] = left[1];
		led[1] = right[1];
	end
	
endmodule
