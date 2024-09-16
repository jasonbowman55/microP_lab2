// Jason Bowman
// jbowman@g.hmc.edu
// 9-8-24
// This lab uses the UPduino FPGA to time-multiplex a dual 7-segment display, showing independent hexadecimal values (1-F) from separate binary DIP switch inputs

module top (
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg,
	output logic [4:0] led,
	output logic [3:0] select, 
	output logic [1:0] osc
	);
// internal counter variable instantiation
	logic [24:0] counter;
	
// HSOSC logic used to increment the counter variable, allowing selection of toggle speed between displays
HSOSC #(.CLKHF_DIV(2'b01)) 
	hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

always_ff @(posedge int_osc) begin
    if (reset == 0)
		counter <= 24'b0;
    else
        counter <= counter + 1'b1;
end

// controls display toggle speed and updates corresponding inputs for binary-to-hexadecimal combinational logic
always_ff @(posedge int_osc) begin
    // counter[#] controlls toggle speed
	if (counter[12] == 0) begin
		select <= right; // Select left DIP-switch input
		osc[0] <= 1; // turn on left display
		osc[1] <= 0;
	end
    else begin
        select <= left; // Select right DIP-switch input
		osc[0] <= 0;
		osc[1] <= 1; // turn on right display
    end
end

// instantiated submodules
seven_seg_decoder MOD1 (reset, seg, select);

binary_disp_decoder MOD2 (left, right, led);
//**

endmodule



// MOD1: 7 segment decoder combinational logic 
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



// MOD2: controls 5-bit binary LED logic 
module binary_disp_decoder(
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [4:0] led
);
//instantiation of internal variabe
logic [4:0] sum;

	// sum right and left DIP-switch binary inputs
	always_comb begin
		sum = ~right + ~left;
	end

	// assign ouput bits
	assign led[0] = sum[0];
	assign led[1] = sum[1];
	assign led[2] = sum[2];
	assign led[3] = sum[3];
	assign led[4] = sum[4];

endmodule