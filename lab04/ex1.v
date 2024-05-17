`timescale 1ns / 1ps

module ex1(
	output reg o_r_out,
	input wire i_w_reset,
	input wire i_w_clk
);

	localparam STATE_INITIAL = 0;
	localparam STATE_T00 = 1;

	reg [31:0]  l_r_count;
	reg         l_r_currentState;
	reg         l_r_nextState;

	always @(i_w_clk) begin
		// logica inversa daca legam i_w_reset la CPU Reset Button
		if (i_w_reset == 0) begin
			// TODO: Ce se intampla daca este apasat butonul de resetare
			//       in timpul functionarii automatului?
            		l_r_count <= 0;
            		l_r_currentState <= STATE_INITIAL;
		end else begin
			// TODO: Tranzitia de la l_r_currentState la l_r_nextState
			//       dupa 1 secunda.
		        l_r_count <= l_r_count + 1;
		    
		        if (l_r_count == 100000000) begin 
		        	l_r_count <= 0;
		        	l_r_currentState <= l_r_nextState;
		    	end
		end
	end

	always @(*) begin
		case (l_r_currentState)
			// TODO: Pentru fiecare stare stabiliti valoare iesirii (pe model Moore)
			//       si tranzitiile in stari ulterioare.
			STATE_INITIAL: begin
				o_r_out = 0;
				l_r_nextState = STATE_T00;
			end

			STATE_T00: begin
				o_r_out = 1;
				l_r_nextState = STATE_INITIAL;
			end
		endcase
	end
endmodule
