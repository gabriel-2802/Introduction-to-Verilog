module ex4(
	output reg o_r_mutant, // led H17
	input wire i_w_A,      // M18
	input wire i_w_G,      // P17
	input wire i_w_C,      // M17
	input wire i_w_T,      // P18
	input wire i_w_reset,  // N17
	input wire i_w_clk     // E3
);

	// INFO: Spre deosebire de celelalte FSM-uri din laborator,
	//       acesta are scopul de a identifica un pattern.
	//
	//       Asadar ne dorim sa inregistram progresul pe care
	//       il realizam cu fiecare intrare care contribuie la 
	//       o secventa completa. (ex. "GGTC")

	// INFO: FSM-ul trebuie sa fie mereu pregatit sa
	//       primeasca valori pe intrari, fie ele corecte sau gresite.
	//       Asadar va trebui sa gestionati corectitudinea
	//       secventei primite prin tranzitii in starile potrivite.
	//       (trebuie sa intrerupeti sau sa continuati secventa primita)

	// TODO: Definiti cate un parametru pentru fiecare
	//       stare necesara.
	localparam STATE_0 = 0;
	localparam STATE_G = 1;
	localparam STATE_GG = 2;
	localparam STATE_GGT = 3;
	localparam STATE_GGTC = 4;
	localparam STATE_PLACEHOLDER_1 = 5;
	localparam STATE_PLACEHOLDER_2 = 6;
	localparam STATE_PLACEHOLDER_3 = 7;

	reg [2:0] l_r_currentState;

	// TODO: Pregatiti semnalul primit de la butoane.
	wire      l_r_A_debounced;
	wire      l_r_G_debounced;
	wire      l_r_C_debounced;
	wire      l_r_T_debounced;
	
	debouncer db_A(l_r_A_debounced, i_w_clk, i_w_reset, i_w_A);
	debouncer db_G(l_r_G_debounced, i_w_clk, i_w_reset, i_w_G);
	debouncer db_C(l_r_C_debounced, i_w_clk, i_w_reset, i_w_C);
	debouncer db_T(l_r_T_debounced, i_w_clk, i_w_reset, i_w_T);

	always @(posedge i_w_clk) begin
		if (i_w_reset) begin
			l_r_currentState <= STATE_0;
			o_r_mutant <= 0;
		end else begin
			case (l_r_currentState)
				STATE_0: begin
					// TODO: Tratati fiecare intrare posibila si
               //       analizati in ce stare trebuie sa tranzitionati
					//       in functie de ce nucleotida a fost introdusa.
					//
					// HINT: Verificati l_r_*button*_debounced
					
					// if (l_r_*button*_debounced) begin
					//	  l_r_currentState <= TODO;
					// end
					if (l_r_A_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_G_debounced) begin
						  l_r_currentState <= STATE_G;
					end
					
					if (l_r_C_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_T_debounced) begin
						  l_r_currentState <= STATE_0;
					end
				end
                STATE_G: begin
			         if (l_r_A_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_G_debounced) begin
						  l_r_currentState <= STATE_GG;
					end
					
					if (l_r_C_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_T_debounced) begin
						  l_r_currentState <= STATE_0;
					end
			    end
			    STATE_GG: begin
			         if (l_r_A_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_G_debounced) begin
						  l_r_currentState <= STATE_GG;
					end
					
					if (l_r_C_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_T_debounced) begin
						  l_r_currentState <= STATE_GGT;
					end
			    end
                STATE_GGT: begin
			        if (l_r_A_debounced) begin
						  l_r_currentState <= STATE_0;
					end
					
					if (l_r_G_debounced) begin
						  l_r_currentState <= STATE_G;
					end
					
					if (l_r_C_debounced) begin
					      o_r_mutant <= 1;
						  l_r_currentState <= STATE_GGTC;
					end
					
					if (l_r_T_debounced) begin
						  l_r_currentState <= STATE_0;
					end
			    end
			    STATE_GGTC: begin
			        o_r_mutant <= 1;
			        if (l_r_A_debounced) begin
						  l_r_currentState <= STATE_GGTC;
					end
					
					if (l_r_G_debounced) begin
						  l_r_currentState <= STATE_GGTC;
					end
					
					if (l_r_C_debounced) begin
						  l_r_currentState <= STATE_GGTC;
					end
					
					if (l_r_T_debounced) begin
						  l_r_currentState <= STATE_GGTC;
					end
			    end
				default: begin
					o_r_mutant <= 1'bx;
					l_r_currentState <= STATE_0;
				end
			endcase
		end
	end
endmodule
