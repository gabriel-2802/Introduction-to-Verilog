`timescale 1ns / 1ps

module task0 (
        output wire [3:0] o_w_sum,
        output wire       o_w_c_out,
        input  wire  [3:0] i_w_a,
        input  wire  [3:0] i_w_b,
        input  wire   i_w_c_in
    );

	//TODO 1: implemetati logica unui sumator carry-lookahead pe 4 biti
	wire [3:0] l_w_carry_la;
    wire [3:0] l_w_P;
    wire [3:0] l_w_G;
        
    assign l_w_G[0] = i_w_a[0] & i_w_b[0];
    assign l_w_G[1] = i_w_a[1] & i_w_b[1];
    assign l_w_G[2] = i_w_a[2] & i_w_b[2];
    assign l_w_G[3] = i_w_a[3] & i_w_b[3];

    assign l_w_P[0] = i_w_a[0] | i_w_b[0];
    assign l_w_P[1] = i_w_a[1] | i_w_b[1];
    assign l_w_P[2] = i_w_a[2] | i_w_b[2];
    assign l_w_P[3] = i_w_a[3] | i_w_b[3];
    
    assign l_w_carry_la[0] = l_w_G[0] | l_w_P[0] & i_w_c_in; 
    assign l_w_carry_la[1] = l_w_G[1] | l_w_P[1] & l_w_G[0] | l_w_P[1] & l_w_P[0] & i_w_c_in; 
    assign l_w_carry_la[2] = l_w_G[2] | l_w_P[2] & l_w_G[1] | l_w_P[2] & l_w_P[1] & l_w_G[0] | l_w_P[2] & l_w_P[1] & l_w_P[0] & i_w_c_in; 
    assign l_w_carry_la[3] = l_w_G[3] | l_w_P[3] & l_w_G[2] | l_w_P[3] & l_w_P[2] & l_w_G[1] | l_w_P[3] & l_w_P[2] & l_w_P[1] & l_w_G[0] | l_w_P[3] & l_w_P[2] & l_w_P[1] & l_w_P[0] & i_w_c_in; 
    
    assign o_w_c_out = l_w_carry_la[3];
    // FA: sum = A xor B xor Cin
    assign o_w_sum = i_w_a ^ i_w_b ^ {l_w_carry_la[2:0], i_w_c_in};
endmodule
