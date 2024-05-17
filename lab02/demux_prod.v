`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: SOC Team @ UPB
//
// Design Name: Demultiplexer 1:4
// Module Name: demux_prod
// Project Name: Laborator 2
// Target Devices: XC7A100T-1CSG324C
// 
// Dependencies: 
// 
// Revision:
// Revision 2023.03.10 - File Created
//////////////////////////////////////////////////////////////////////////////////

module demux_prod(
    output reg [3:0] out,
    input [1:0] sel, 
    input in
    );
    
    // la nivel procedural
    always @(*) begin
        case(sel)
            2'b00: out = {in, 3'b000};
            2'b01: out = {1'b0, in, 2'b00};
            2'b10: out = {2'b00, in, 1'b0};
            2'b11: out = {3'b000, in};
            default: out = 4'b0;
        endcase
    end
endmodule
