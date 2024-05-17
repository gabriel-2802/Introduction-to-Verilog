`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task2
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task2(
		output wire o_w_carry_out,
		output wire [7:0] o_w_sum,
		input wire [7:0] i_w_A,
		input wire [7:0] i_w_B,
		input wire i_w_carry_in
    );
	
	// TODO 2: Implement an 8-bit ripple-carry adder using the full-adder
	// Hint: Use a buffer for carry
    wire [6:0] l_w_dummy_carry;
    task1 bit_0(.o_w_sum(o_w_sum[0]), .o_w_carry_out(l_w_dummy_carry[0]), .i_w_bit_A(i_w_A[0]), .i_w_bit_B(i_w_B[0]), .i_w_carry_in(i_w_carry_in));
    task1 bit_1(.o_w_sum(o_w_sum[1]), .o_w_carry_out(l_w_dummy_carry[1]), .i_w_bit_A(i_w_A[1]), .i_w_bit_B(i_w_B[1]), .i_w_carry_in(l_w_dummy_carry[0]));
    task1 bit_2(.o_w_sum(o_w_sum[2]), .o_w_carry_out(l_w_dummy_carry[2]), .i_w_bit_A(i_w_A[2]), .i_w_bit_B(i_w_B[2]), .i_w_carry_in(l_w_dummy_carry[1]));
    task1 bit_3(.o_w_sum(o_w_sum[3]), .o_w_carry_out(l_w_dummy_carry[3]), .i_w_bit_A(i_w_A[3]), .i_w_bit_B(i_w_B[3]), .i_w_carry_in(l_w_dummy_carry[2]));
    task1 bit_4(.o_w_sum(o_w_sum[4]), .o_w_carry_out(l_w_dummy_carry[4]), .i_w_bit_A(i_w_A[4]), .i_w_bit_B(i_w_B[4]), .i_w_carry_in(l_w_dummy_carry[3]));
    task1 bit_5(.o_w_sum(o_w_sum[5]), .o_w_carry_out(l_w_dummy_carry[5]), .i_w_bit_A(i_w_A[5]), .i_w_bit_B(i_w_B[5]), .i_w_carry_in(l_w_dummy_carry[4]));
    task1 bit_6(.o_w_sum(o_w_sum[6]), .o_w_carry_out(l_w_dummy_carry[6]), .i_w_bit_A(i_w_A[6]), .i_w_bit_B(i_w_B[6]), .i_w_carry_in(l_w_dummy_carry[5]));
    task1 bit_7(.o_w_sum(o_w_sum[7]), .o_w_carry_out(o_w_carry_out),  .i_w_bit_A(i_w_A[7]), .i_w_bit_B(i_w_B[7]), .i_w_carry_in(l_w_dummy_carry[6]));
endmodule
