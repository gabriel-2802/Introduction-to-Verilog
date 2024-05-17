`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 10:00:35 PM
// Design Name: 
// Module Name: task_02
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


module task_02(
    output out,
    input a,
    input b
    );
    wire w1, w2, w3;
    
    and(w1, a, b);
    not(w3, w1);
    or(w2, a, b);
    and(out, w2, w3);
endmodule
