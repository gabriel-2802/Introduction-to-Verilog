`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 10:28:45 PM
// Design Name: 
// Module Name: task_04
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


module task_04(
    output c,
    input a,
    input b, 
    input sel_1,
    input sel_0
    );    
    wire nand_ab, and_ab, or_ab, xor_ab;
    
    nand(nand_ab, a, b);
    and(and_ab, a, b);
    or(or_ab, a, b);
    xor(xor_ab, a, b);
    
    // instantiere multiplexor 4:1
    task_03 mux_instance(.out(c), 
                         .in_0(nand_ab),
                         .in_1(and_ab),
                         .in_2(or_ab), 
                         .in_3(xor_ab), 
                         .sel_1(sel_1),
                         .sel_0(sel_0));
    
endmodule
