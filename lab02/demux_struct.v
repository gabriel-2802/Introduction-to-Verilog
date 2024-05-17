`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: demux_struct
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


module demux_struct(output [3:0] out, input [1:0] sel, input in);
                
      wire n_sel_0, n_sel_1;

      not(n_sel_0, sel[0]);
      not(n_sel_1, sel[1]);
      
      and(out[0], in, n_sel_1, n_sel_0);
      and(out[1], in, n_sel_1, sel[0]);
      and(out[2], in, sel[1], n_sel_0);
      and(out[3], in, sel[1], sel[0]);
 
endmodule
