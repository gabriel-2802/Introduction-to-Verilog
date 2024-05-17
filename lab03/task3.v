module task3(
    output wire o_w_out,
    input wire[1:0] i_w_sel,
    input wire i_w_in1,
    input wire i_w_in2,
    input wire i_w_clk,
    input wire i_w_reset,
    input wire[4:0] i_w_prescaler
);
     wire l_w_in1;
     wire l_w_in2;
     task0 l_m_task0(
       .o_w_out(o_w_out),
       .i_w_sel(i_w_sel),
       .i_w_clk(i_w_clk),
       .i_w_reset(i_w_reset),
       .i_w_in1(l_w_in1),
       .i_w_in2(l_w_in2)
     );
   
     task2  l_m_task2_1(
       .o_w_out(l_w_in1),
       .i_w_clk(i_w_clk),
       .i_w_reset(i_w_reset),
       .i_w_in(i_w_in1),
       .i_w_sel(i_w_prescaler)
     );

     task2  l_m_task2_2(
       .o_w_out(l_w_in2),
       .i_w_clk(i_w_clk),
       .i_w_reset(i_w_reset),
       .i_w_in(i_w_in2),
       .i_w_sel(i_w_prescaler)
     );

endmodule
