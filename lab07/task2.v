`timescale 1ns / 1ps

module task2(
		 output wire [15:0] o_w_sum,
		 output wire o_w_c_out,
		 input wire [15:0] i_w_a,
		 input wire [15:0] i_w_b,
		 input wire i_w_c_in
    );

  
	wire [2:0] l_w_carry;
	// TODO 3: implementati un adder pe 16 de biti (Hint: don't write too much code)
	task0 adder_3_0(.o_w_sum(o_w_sum[3:0]), .o_w_c_out(l_w_carry[0]), .i_w_a(i_w_a[3:0]), .i_w_b(i_w_b[3:0]), .i_w_c_in(i_w_c_in)); 
    task0 adder_7_4(.o_w_sum(o_w_sum[7:4]), .o_w_c_out(l_w_carry[1]), .i_w_a(i_w_a[7:4]), .i_w_b(i_w_b[7:4]), .i_w_c_in(l_w_carry[0])); 
    task0 adder_11_8(.o_w_sum(o_w_sum[11:8]), .o_w_c_out(l_w_carry[2]), .i_w_a(i_w_a[11:8]), .i_w_b(i_w_b[11:8]), .i_w_c_in(l_w_carry[1])); 
    task0 adder_15_12(.o_w_sum(o_w_sum[15:12]), .o_w_c_out(o_w_c_out), .i_w_a(i_w_a[15:12]), .i_w_b(i_w_b[15:12]), .i_w_c_in(l_w_carry[2])); 
endmodule
