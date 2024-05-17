`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Organization and Architecture
//  
// Module Name:  		task2
// Project Name:		Laborator 8
// Target Devices: 		Digilent Nexys 7
//////////////////////////////////////////////////////////////////////////////////

module task2(
    output wire [7:0] o_w_result,
    input  wire [3:0] i_w_a,
    input  wire [3:0] i_w_b,
    input  wire [2:0] i_w_op_sel
);
    // TODO 1: Define local wire and use task0 and task1 for MUL, DIV and MOD
    wire[7:0] l_w_mul;
    wire[3:0] l_w_div;
    wire[3:0] l_w_mod;
    
    task0 prod(
        .o_w_out(l_w_mul),
        .i_w_M(i_w_a),
        .i_w_R(i_w_b)
     );

    task1 div(
        .o_w_quotient(l_w_div),
        .o_w_remainder(l_w_mod), 
        .i_w_M(i_w_b),
        .i_w_Q(i_w_a)
    );

    // TODO 2: Define a result reg and implement the logic to run the operation from op_sel on a and b
    reg[7:0] l_r_result;

    always @(*) begin
        case(i_w_op_sel)
            // AND
            3'd0: l_r_result = {4'b0000, i_w_a & i_w_b};
            // XOR
            3'd1: l_r_result = {4'b0000, i_w_a ^ i_w_b};
            // OR
            3'd2: l_r_result = {4'b0000, i_w_a | i_w_b};
            // ADD: use opeartor +
            3'd3: l_r_result = {4'b0000, i_w_a} + {4'b0000, i_w_b};
            // SUB: use operator -
            3'd4: l_r_result = {4'b0000, i_w_a} - {4'b0000, i_w_b};
            // MUL: use result from task0
            3'd5: l_r_result = l_w_mul;
            // DIV: use result from task1
            3'd6: l_r_result = l_w_div;
            // MOD: use result from task1
            3'd7: l_r_result = l_w_mod;
            default: l_r_result = 8'd0;
        endcase
    end

    // TODO 3: Assign o_w_result to result
    assign o_w_result = l_r_result;
endmodule