 //Jason Bowman
//jbowman@g.hmc.edu
//9-9-24

module top (
	input logic clk,
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg,
	output logic [4:0] led,
	output logic [1:0] select
	);

	seven_seg_decoder MOD1 (clk, reset, left, right, seg, select);

	binary_disp_decoder MOD2 (clk, reset, left, right, led);

endmodule

// MOD1 //////////////////////////////////////
// 7 segment decoder test 
module seven_seg_decoder (
	input logic clk,
	input logic reset,
	input logic [3:0] left,
	input logic [3:0] right,
	output logic [6:0] seg,
	output logic [1:0] select
	);

	//initializing variables
	logic [23:0] state;


	// adding 1 to the value of the state to oscillate based on clk
	//always_ff @(posedge clk) begin
		//if (reset)
			//state <= 24'b0;
		//else
			//state <= state + 1;
	//end
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 24'b0;
        select <= 2'b00; // Reset select to 00
    end else begin
        state <= state + 1'b1;

        // Update select based on the MSB of state
		if (state[23]) begin
            select <= 2'b10; // Select left input
        end else begin
            select <= 2'b01; // Select right input
        end
    end
end


 //combinational logic to assign bits to the displays
 always_comb begin
        case (select)
            2'b10: // Use left input
                case(left)
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
                    default: seg = 7'b1111110;
                endcase
            2'b01: // Use right input
                case(right)
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
                    default: seg = 7'b1111110;
                endcase
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
		led[2] = right[2];
		led[3] = right[2];
		led[4] = right[3];
	end
	
endmodule
