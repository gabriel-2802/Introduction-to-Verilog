module task0(
    output wire o_w_out,
    input wire[1:0] i_w_sel,
    input wire i_w_in1,
    input wire i_w_in2,
    input wire i_w_clk,
    input wire i_w_reset
);
    reg l_r_out;
    always@(posedge i_w_clk) begin
        if (i_w_reset) begin
            l_r_out <= 0;
        end else begin
            case (i_w_sel)
                0: l_r_out <= i_w_in1 ^ i_w_in2;
                1: l_r_out <= ~(i_w_in1 & i_w_in2);
                2: l_r_out <= i_w_in1 | i_w_in2;
                3: l_r_out <= i_w_in1 & i_w_in2;
                default: l_r_out <= 1'b0;
            endcase
        end
    end
    
    assign o_w_out = l_r_out;
endmodule
