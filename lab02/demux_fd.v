`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: demux_fd
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


module demux_proc(output [3:0] out, input [1:0] sel, input in);
     assign out[0] = in & ~sel[1] & ~sel[0];
     assign out[1] = in & ~sel[1] & sel[0];
     assign out[2] = in & sel[1] & ~sel[0];
     assign out[3] = in & sel[1] & sel[0];
endmodule
