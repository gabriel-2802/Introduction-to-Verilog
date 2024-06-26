`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Design 1
//  
// Module Name:  		task3
// Project Name:		Laborator 6
// Target Devices: 		Digilent Nexys 3
//////////////////////////////////////////////////////////////////////////////////

module task3(
		output wire o_w_borrow,
		output wire [7:0] o_w_diff,
		input wire [7:0] i_w_A,
		input wire [7:0] i_w_B,
		input wire i_w_borrow
    );

	// TODO 3: Implement an 8-bit ripple-carry subtractor (A - B) using the ripple-carry adder
	// Hint: Use a two's complement for B
	task2 l_m_task2(.o_w_carry_out(o_w_borrow), .o_w_sum(o_w_diff), .i_w_A(i_w_A), .i_w_B(~i_w_B), .i_w_carry_in(~i_w_borrow));
	
endmodule
