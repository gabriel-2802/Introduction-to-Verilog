`timescale 1ns / 1ps

//Instruction memory
module task21(
    output	wire	[15:0]	o_w_data,    // here goes the instruction 
	input	wire	[7:0]	i_w_address, //here comes the program counter
	input	wire	i_w_clk
);
    localparam NONE_OPERATION  = 5'd0;
    localparam AND_OPERATION   = 5'd1;
    localparam XOR_OPERATION   = 5'd2;
    localparam OR_OPERATION    = 5'd3;
    localparam NEG_OPERATION   = 5'd4;
    localparam ADD_OPERATION   = 5'd5;
    localparam SUB_OPERATION   = 5'd6;
    localparam MUL_OPERATION   = 5'd7;
    localparam DIV_OPERATION   = 5'd8;
    localparam MOD_OPERATION   = 5'd9;

    // 16-bit instruction
    reg [15:0] l_r_data;
 
    // First bit marks if it's a ALU operation (1 if TRUE)
    // Next 5-bits represent the operation
    // Next 5-bits represent the register of the first operand
    // Last 5-bits represent the register of the second operand

    // We will take in consideration only ALU operations
    // The operation's result is stored in the first operand register
    // e.g. 16'b1_00001_00000_00010 -> ADD R[0] R[2] ---> R[0] <- R[0] + R[1]

    // TODO: implement algorithm to store 32'd1234 in R[0] 
	always @(negedge i_w_clk) begin
		case (i_w_address)
            // TODO: fill out the instruction memory
            //MUL R[1] R[10]      R[1] <- 10
            8'd0:    l_r_data = {1'b1, MUL_OPERATION,    5'd1, 5'd10};
            //MUL R[2] R[10]      R[2] <- 20
            8'd1:    l_r_data = {1'b1, MUL_OPERATION,    5'd2, 5'd10};
            //MUL R[3] R[10]      R[3] <- 30
            8'd2:    l_r_data = {1'b1, MUL_OPERATION,    5'd3, 5'd10};
            //MUL R[1] R[10]      R[1] <- 100
            8'd3:    l_r_data = {1'b1, MUL_OPERATION,    5'd1, 5'd10};
            //MUL R[2] R[10]      R[2] <- 200
            8'd4:    l_r_data = {1'b1, MUL_OPERATION,    5'd2, 5'd10};
            //MUL R[1] R[10]      R[1] <- 1000
            8'd5:    l_r_data = {1'b1, MUL_OPERATION,    5'd1, 5'd10};
            //ADD R[0] R[1]      R[0] <- 1000
            8'd6:    l_r_data = {1'b1, ADD_OPERATION,    5'd0, 5'd1};
            //ADD R[0] R[2]      R[0] <- 1200
            8'd7:    l_r_data = {1'b1, ADD_OPERATION,    5'd0, 5'd2};
            //ADD R[0] R[3]      R[0] <- 1230
            8'd8:    l_r_data = {1'b1, ADD_OPERATION,    5'd0, 5'd3};
            //ADD R[0] R[4]      R[0] <- 1234
            8'd9:    l_r_data = {1'b1, ADD_OPERATION,    5'd0, 5'd4}; 
			default:	l_r_data =  {1'b0, NONE_OPERATION,	5'd0, 5'd0};
		endcase
	end

    assign o_w_data = l_r_data;


endmodule
