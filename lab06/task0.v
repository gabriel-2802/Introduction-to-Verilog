`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:57 04/03/2022 
// Design Name: 
// Module Name:    task0 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module task0(
		output wire o_w_sum,
		output wire o_w_carry,
		input wire i_w_bit_A,
		input wire i_w_bit_B
    );
	
	// TODO 1.a: Implement a half-adder 
	// nivel structural
	xor(o_w_sum, i_w_bit_A, i_w_bit_B);
    and(o_w_carry, i_w_bit_A, i_w_bit_B);
    
    // nivel flux de date
    assign o_w_sum = i_w_bit_A ^ i_w_bit_B;
    assign o_w_carry = i_w_bit_A & i_w_bit_B;
    
    // nivel procedural
    reg o_r_sum;
    reg o_r_carry;
    
    always @(*) begin
        o_r_sum = i_w_bit_A ^ i_w_bit_B;
        o_r_carry = i_w_bit_A & i_w_bit_B;
    end
    
    assign o_w_sum = o_r_sum;
    assign o_w_carry = o_r_carry;
endmodule
