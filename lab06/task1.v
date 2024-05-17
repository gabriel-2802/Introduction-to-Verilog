`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task1
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task1(
		output wire o_w_sum,
		output wire o_w_carry_out,
		input wire i_w_bit_A,
		input wire i_w_bit_B,
		input wire i_w_carry_in
    );
	
	// TODO 1.b: Implement a full-adder using the half-adder
	wire [1:0] l_r_dummy_carry;
    wire l_r_dummy_o_w_sum;

    task0 input_bits(.o_w_sum(l_r_dummy_o_w_sum), .o_w_carry(l_r_dummy_carry[0]), .i_w_bit_A(i_w_bit_A), .i_w_bit_B(i_w_bit_B));
    task0 o_w_sum_and_carry(.o_w_sum(o_w_sum), .o_w_carry(l_r_dummy_carry[1]), .i_w_bit_A(l_r_dummy_o_w_sum), .i_w_bit_B(i_w_carry_in));
    
    assign o_w_carry_out = l_r_dummy_carry[0] | l_r_dummy_carry[1];
endmodule
