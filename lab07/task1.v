`timescale 1ns / 1ps

module task1 (
        output wire [3:0] o_w_diff,
        output wire       o_w_c_out,
        input  wire [3:0] i_w_a,
        input  wire [3:0] i_w_b
    );

    //TODO 2: implemetati logica pentru un scazator carry-lookahead pe 4 biti
    task0 subber(.o_w_sum(o_w_diff) , .o_w_c_out(o_w_c_out) , .i_w_a(i_w_a), .i_w_b(~i_w_b), .i_w_c_in(1'b1));
endmodule