module task1(
    output wire o_w_out,
    input wire[1:0] i_w_sel,
    input wire i_w_in1,
    input wire i_w_in2,
    input wire i_w_clk,
    input wire i_w_reset
);
    task0 t0(
     .o_w_out(o_w_out),
           .i_w_sel(i_w_sel),
           .i_w_clk(i_w_clk),
           .i_w_reset(i_w_reset),
           .i_w_in1(i_w_in1),
           .i_w_in2(i_w_in2)
);

endmodule
