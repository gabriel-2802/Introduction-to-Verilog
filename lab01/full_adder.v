`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 10:36:49 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    output sum,  
    output c_out,
    input a,
    input b,
    input c_in 
    );    
    wire sum_0, c_0, c_1;
   
    // instantiem 2 module half_adder
    
    // sum_0 = a ^ b
    // c_0 = a*b
    half_adder h_a_1(.sum(sum_0), .c_out(c_0), .a(a), .b(b));
    
    // sum = sum_0 ^ c_in = a ^ b ^ c_in
    // c_1 = sum_0 * c_in = (a^b)*c_in
    half_adder h_a_2(.sum(sum), .c_out(c_1), .a(sum_0), .b(c_in));
    
    // c_out = c_0 + c_1 = (a*b) + (a^b)*c_in
    or(c_out, c_0, c_1);
endmodule
