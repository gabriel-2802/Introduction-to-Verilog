`timescale 1ns / 1ps

module ex2(
	output reg [7:0] o_r_out,
	input wire       i_w_reset,    // N17
	input wire       i_w_clk       // E3
);

	localparam STATE_INITIAL = 0;
	localparam STATE_T00 = 1;
	localparam STATE_T01 = 2;
	localparam STATE_T02 = 3;
	localparam STATE_T03 = 4;
	localparam STATE_T04 = 5;
	localparam STATE_T05 = 6;
	localparam STATE_T06 = 7;
	localparam STATE_T07 = 8;
	localparam STATE_T08 = 9;
	localparam STATE_T09 = 10;
	localparam STATE_T10 = 11;
	localparam STATE_T11 = 12;
	localparam STATE_T12 = 13;
	localparam STATE_T13 = 14;
	localparam STATE_T14 = 15;

	// INFO: Folositi l_r_counter pentru a intarzia tranzitiile intre stari
	//       cu o secunda.
	reg [31:0] l_r_counter;
	reg [3:0]  l_r_currentState;
	reg [3:0]  l_r_nextState;
    
	always @(posedge i_w_clk) begin
		if (i_w_reset) begin // i_w_reset este legat la un butonul N17 
			l_r_counter <= 0;
			l_r_currentState <= STATE_INITIAL;
		end else begin
			// TODO: Efectuati tranzitia in starea urmatoare dupa o secunda.
			if (l_r_counter == 100000000) begin
				l_r_currentState <= l_r_nextState;
				l_r_counter <= 0;
			end

		end
	end

	always @(*) begin
		case (l_r_currentState)
			//TODO: stabiliti output-ul pentru fiecare stare
			//si legati starile intre ele prin tranzitii
			STATE_INITIAL: begin
				o_r_out = 8'b00000000;
				l_r_nextState = STATE_T00;
			end
			STATE_T00: begin
				o_r_out = 8'b10101010;
				l_r_nextState = STATE_T01;
			end
			STATE_T01: begin
				o_r_out = 8'b01010101;
				l_r_nextState = STATE_T02;
			end
			STATE_T02: begin
				o_r_out = 8'b10101010;
				l_r_nextState = STATE_T03;
			end
			STATE_T03: begin
				o_r_out = 8'b01010101;
				l_r_nextState = STATE_T04;
			end
			STATE_T04: begin
				o_r_out = 8'b10000001;
				l_r_nextState = STATE_T05;
			end
			STATE_T05: begin
				o_r_out = 8'b01000010;
				l_r_nextState = STATE_T06;
			end
			STATE_T06: begin
				o_r_out = 8'b00100100;
				l_r_nextState = STATE_T07;
			end
			STATE_T07: begin
				o_r_out = 8'b00011000;
				l_r_nextState = STATE_T08;
			end
			STATE_T08: begin
				o_r_out = 8'b00100100;
				l_r_nextState = STATE_T09;
			end
			STATE_T09: begin
				o_r_out = 8'b01000010;
				l_r_nextState = STATE_T10;
			end
			STATE_T10: begin
				o_r_out = 8'b10000001;
				l_r_nextState = STATE_T11;
			end
			STATE_T11: begin
				o_r_out = 8'b01101001;
				l_r_nextState = STATE_T12;
			end
			STATE_T12: begin
				o_r_out = 8'b10001101;
				l_r_nextState = STATE_T13;
			end
			STATE_T13: begin
				o_r_out = 8'b10001011;
				l_r_nextState = STATE_T14;
			end
			STATE_T14: begin
				o_r_out = 8'b01101001;
				l_r_nextState = STATE_T00;
			end

		endcase
	end
endmodule
