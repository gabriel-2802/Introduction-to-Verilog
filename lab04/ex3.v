`timescale 1ns / 1ps

module ex3(
	output reg [7:0] o_r_out,
	input wire       i_w_button,   // M18
	input wire       i_w_reset,    // N17
	input wire       i_w_clk       // E3
);

	localparam STATE_INITIAL = 0;
	localparam STATE_T00 = 1;
	localparam STATE_T01 = 2;
	localparam STATE_PLACEHOLDER = 3;

	reg l_r_button_pressed;
	wire l_w_button_debounced;

	debouncer db(l_w_button_debounced, i_w_clk, i_w_reset, i_w_button);

	// INFO: Folositi l_r_red si l_r_green pentru a monitoriza
	//       intervalele de timp care intarzie tranzitiile
	reg [31:0]  l_r_red;
	reg [31:0]  l_r_green;
	reg [1:0]   l_r_currentState;
	reg [1:0]   l_r_nextState;

	initial begin
		l_r_red = 0;
		l_r_green = 0;
		l_r_currentState = STATE_INITIAL;
		l_r_button_pressed = 0;
	end

	// INFO: Scopul acestui task este gestionarea aprinderii celor 8 LED-uri
	//       de pe FPGA. Fiecare LED este controlat de un bit din o_r_out.
	//       
	//       Blocul always va gestiona atat logica iesirilor si a tranzitiilor,
    //       cat si de efectuarea tranzitiilor cu delay-urile aferente.
	//       Asadar, va trebui sa setati atat valoarea iesirii, cat si
	//       valoarea starii urmatoare l_r_nextState la momentul potrivit.
		
	always @(posedge i_w_clk) begin
		case (l_r_currentState)
			STATE_INITIAL: begin
				o_r_out = 8'b00000000;
				l_r_nextState = STATE_T00;
			end
			STATE_T00: begin
				// TODO: Aprindeti primele 4 LED-uri din stanga.
				o_r_out = 8'b11110000;
				
				// TODO: Daca este apasat butonul, marcati acest lucru folosind
				//       flag-ul l_r_button_pressed si initializati timer-ul
				//       culorii rosii.
				//       O apasare ulterioara nu reseteaza timer-ul.
				if (l_w_button_debounced) begin
				    if (!l_r_button_pressed) begin
				        l_r_red <= 0;
				        l_r_button_pressed <= 1;
				    end
				end

				// TODO: Daca butonul a fost apasat, folositi timer-ul
				//       pentru a cronometra intervalul corespunzator culorii rosii.
				// HINT: Folositi counter-ele!
				if (l_r_button_pressed) begin
				    l_r_red <= l_r_red + 1;
				    
				    if (l_r_red == 200000000) begin
				        l_r_red <= 0;
				        l_r_nextState = STATE_T01;
				    end
				end
			end

			STATE_T01: begin
				// TODO: Aprindeti ultimele 4 LED-uri din dreapta.
				o_r_out = 8'b00001111;
				
				// TODO: Starea curenta nu mai este influentata de apasarea
				//       butonului, astfel trebuie resetat flag-ul care indica
				//       acest lucru.
				l_r_button_pressed <= 0;
				
				// TODO: Porniti timer-ul care trebuie sa cronometreze
				//       intervalul corespunzator culorii verzi.
				// HINT: Folositi counter-ele!
				
				l_r_green <= l_r_green + 1;
				
				if (l_r_green == 200000000) begin
				    l_r_green <= 0;
				    l_r_nextState = STATE_T00;
				end
				
			end
		endcase
		
		l_r_currentState = l_r_nextState;
	end
endmodule
