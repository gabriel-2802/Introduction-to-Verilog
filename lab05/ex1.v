module ex1(
    output o_w_AN0,
    output o_w_AN1,
    output o_w_AN2,
    output o_w_AN3,
    output o_w_CA,
    output o_w_CB,
    output o_w_CC,
    output o_w_CD,
    output o_w_CE,
    output o_w_CF,
    output o_w_CG,
    output o_w_DP
    );

    // TODO - print '0' to the 7 segment display
    assign o_w_AN0 = 0; // enable first digit
    assign o_w_AN1 = 1;
    assign o_w_AN2 = 1;
    assign o_w_AN3 = 1;
    
    assign o_w_CA = 0;
    assign o_w_CB = 0;
    assign o_w_CC = 0;
    assign o_w_CD = 0;
    assign o_w_CE = 0;
    assign o_w_CF = 0;
    assign o_w_CG = 1;
    assign o_w_DP = 1;
endmodule
