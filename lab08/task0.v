`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ACS
// Computer Organization and Architecture
//  
// Module Name:  		task0
// Project Name:		Laborator 8
// Target Devices: 		Digilent Nexys 7
//////////////////////////////////////////////////////////////////////////////////

module task0(
    output wire [7:0] o_w_out,
    input  wire [3:0] i_w_M,
    input  wire [3:0] i_w_R
);

    // TODO: Implement Booth's algorithm
    wire [3:0] l_w_neg_M;
    assign l_w_neg_M = ~i_w_M + 1;

    reg [8:0] l_r_P;
    reg [8:0] l_r_M_plus;
    reg [8:0] l_r_M_minus;

    always @(*) begin
        // TODO 1: Calculate P, M+ and M-
        l_r_P = {4'b0000, i_w_R, 1'b0};
        l_r_M_plus = {i_w_M, 5'b0000};
        l_r_M_minus = {l_w_neg_M, 5'b0000};

        // TODO 2: Repeat the algorithm N times
        repeat(4) begin
            case (l_r_P[1:0])
                2'b00 : l_r_P = l_r_P;
                2'b01 : l_r_P = l_r_P + l_r_M_plus;
                2'b10 : l_r_P = l_r_P + l_r_M_minus;
                2'b11 : l_r_P = l_r_P;
                default : l_r_P = l_r_P;
            endcase

            //TODO 3: Right arithmetic shift
            l_r_P = $signed(l_r_P) >>> 1;
        end
    end

    // TODO 4: Assign in o_w_out the product of M and R
    assign o_w_out = l_r_P[8:1];
endmodule