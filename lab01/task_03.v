`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 10:22:42 PM
// Design Name: 
// Module Name: task_03
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module task_03(
    output out,
    input in_1,
    input in_2,
    input in_3,
    input in_4,
    input s1,
    input s0
    );
    wire w1, w2, w3, w4;
    wire not_s1, not_s0;
    
    not(not_s1, s1);
    not(not_s0, s0);
    
    and(w1, not_s0, not_s1, in_1);
    and(w2, s0, not_s1, in_2);
    and(w3, not_s0, s1, in_3);
    and(w4, s0, s1, in_4);
    
    or(out, w1, w2, w3, w4);
endmodule
