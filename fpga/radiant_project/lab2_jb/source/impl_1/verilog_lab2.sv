// Jason Bowman
// jbowman@g.hmc.edu
// 9-8-24

module top (
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg,
	output logic [4:0] led,
	output logic [3:0] select, 
	output logic [1:0] osc
	);
// variable initialization
	logic [24:0] state;
	
// HSOSC logic //////////////////
HSOSC #(.CLKHF_DIV(2'b01)) 
	hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

always_ff @(posedge int_osc) begin
    if (reset == 0)
		state <= 24'b0;
    else
        state <= state + 1'b1;
end
		
always_ff @(posedge int_osc) begin
        //Update select based on the MSB of states
	if (state[12] == 0) begin
		select <= right; // Select left input/
		osc[0] <= 1;
		osc[1] <= 0;
	end
    else begin
        select <= left; // Select right input
		osc[0] <= 0;
		osc[1] <= 1;
    end
end
////////////////////////////////

// instantiated modules
seven_seg_decoder MOD1 (reset, seg, select);

binary_disp_decoder MOD2 (left, right, led);

endmodule

// MOD1 //////////////////////////////////////
// 7 segment decoder test 
module seven_seg_decoder (
	input logic reset,
	output logic [6:0] seg,
	output logic [3:0] select
	);

 //combinational logic to assign bits to the displays
 
 always_comb begin
	case(select)
		4'b0000: seg = 7'b0000001;
		4'b0001: seg = 7'b1001111;
		4'b0010: seg = 7'b0010010;
		4'b0011: seg = 7'b0000110;
		4'b0100: seg = 7'b1001100;
		4'b0101: seg = 7'b0100100;
		4'b0110: seg = 7'b0100000;
		4'b0111: seg = 7'b0001111;
		4'b1000: seg = 7'b0000000;
		4'b1001: seg = 7'b0001100;
		4'b1010: seg = 7'b0001000;
		4'b1011: seg = 7'b1100000;
		4'b1100: seg = 7'b0110001;
		4'b1101: seg = 7'b1000010;
		4'b1110: seg = 7'b0110000;
		4'b1111: seg = 7'b0111000;
		default: seg = 7'b1111111;
	endcase
end

endmodule
///////////////////////////////////////////

// MOD2 //////////////////////////////////////////
module binary_disp_decoder(
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [4:0] led
);
logic [4:0] sum;

always_comb begin
	sum = ~right + ~left;
end

assign led = sum;

endmodule
