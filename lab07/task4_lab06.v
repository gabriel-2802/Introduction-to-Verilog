`timescale 1ns / 1ps
`include "defines.vh"

module task4(
		output wire       o_w_digit_point, // DP
		output reg  [7:0] o_r_progress,
		output wire [0:6] o_w_segment,     // CA, CB, ...
		output wire [7:0] o_w_digit,       // AN0, AN1, ...
		input  wire [7:0] i_w_operand,
		input  wire       i_w_add_button,
		input  wire       i_w_sub_button,
		input  wire       i_w_op_button,
		input  wire       i_w_reset,
		input  wire       i_w_clk
    );

	localparam STATE_INITIAL = 0;       // starea de idle
	localparam STATE_OP1_READ = 1;      // starea dupa ce am citit primul operand
	localparam STATE_OP2_READ = 2;      // starea dupa ce am citit al doilea operand
	localparam STATE_RESULT_SELECT = 3; // starea in care afisez rezultatul operatiei
	
	wire l_w_add_btn_debounced, l_w_sub_btn_debounced, l_w_op_btn_debounced;
	
	debouncer l_m_operands(.o_w_out(l_w_op_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_op_button), .i_w_sel(5'd3));
	
	// TODO 4.1: Treceti prin debouncer butoanele pentru operatiile de adunare si scadere
	debouncer l_m_add(.o_w_out(l_w_add_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_add_button), .i_w_sel(5'd3));
	debouncer l_m_sub(.o_w_out(l_w_sub_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_sub_button), .i_w_sel(5'd3));
	
	reg [9:0] l_r_message;

    	wire [7:0] l_w_sum;
    	wire [7:0] l_w_dif;
    	wire l_w_sum_carry, l_w_dif_carry;
    
   	reg [7:0] l_r_A; // retinem valoarea primului operand
    	reg [7:0] l_r_B; // retinem valoarea celui de-al doilea operand
    
    	reg [1:0] l_r_current_state;
    	reg [1:0] l_r_next_state;
    
    	reg l_r_button_pressed; // flag folosit pentru a semnala faptul ca butonul a fost apasat
	
	// TODO 4.2: Instantiati modulele pentru sumator si scazator
	// HINT: Folositi task-urile precedente
	task2 l_m_task2(.o_w_carry_out(l_w_sum_carry), .o_w_sum(l_w_sum), .i_w_A(l_r_A), .i_w_B(l_r_B), .i_w_carry_in(1'b0));
	task3 l_m_task3(.o_w_barrow(l_w_dif_carry), .o_w_diff(l_w_dif), .i_w_A(l_r_A), .i_w_B(l_r_B), .i_w_barrow(1'b0));

	// Modul pentru afisajul cu 7 segmente
	display_7_segment_driver l_m_display(
		.o_r_segment(o_w_segment),
		.o_r_digit_point(o_w_digit_point),
		.o_r_digit(o_w_digit),
		.i_w_message(l_r_message),
		.i_w_reset(i_w_reset),
		.i_w_clk(i_w_clk)
	);
	
	always @(posedge i_w_clk) begin
		if (i_w_reset) begin
            l_r_current_state <= STATE_INITIAL;
            l_r_button_pressed <= 0;
        end else begin
            // Daca 'push-button' a fost apasat sau daca ma aflu in starea in care
            // trebuie sa afisez rezultatul (aka sunt in starea in care am citit al 
            // doilea operand si unul dintre butoanele de adunare sau scadere este apasat)
            if (l_w_op_btn_debounced || (l_r_current_state == STATE_OP2_READ && (i_w_add_button | i_w_sub_button))) begin
                // TODO 4.3: Verific ca flag-ul l_r_button_pressed sa nu fie setat
                // ca sa execut codul o singura data

                // TODO 4.4: Aici trebuie retinuti operanzii in registre.
                // In ce stari trebuie sa ma aflu ca sa salvez valorile lor?
                
                // TODO 4.5: Aici comut in starea urmatoare
		if (!l_r_button_pressed) begin
			case (l_r_current_state)
				STATE_INITIAL:  l_r_A = i_w_operand;
				STATE_OP1_READ: l_r_B = i_w_operand;
			endcase
				l_r_current_state <= l_r_next_state;
				l_r_button_pressed <= 1;
		end

            end else begin
                // TODO 4.6: Resetez valoarea flag-ului care ma anunta ca butonul a fost apasat
		l_r_button_pressed <= 0;
            end
        end
	end
	
	always @(*) begin		
		l_r_message = `MESSAGE_DEFAULT; // vedem prin afisajul cu 7 segmente fie operanzii, fie rezultatul
        	o_r_progress = `PROGRESS_NONE; // vedem prin LED-uri in ce stare a FSM-ului ne aflam
        
        	// TODO 4.7: In functie de starea in care ne aflam, ce mesaj vrem sa avem,
        	// care e progresul si care este starea urmatoare?
        	// HINT: Cautati in fisierul defines.vh din Verilog Header macro-uri care sa
        	// va ajute sa afisati mesajele/progresul
        	case (l_r_current_state)
			STATE_INITIAL: begin
				l_r_message = {2'b00, i_w_operand};	
				o_r_progress = `PROGRESS_NONE;
				l_r_next_state = STATE_OP1_READ;
			end
			
			STATE_OP1_READ: begin
				l_r_message = {2'b00, i_w_operand};
				o_r_progress = `PROGRESS_ONE_OPERAND;
				l_r_next_state = STATE_OP2_READ;
			end
		
			STATE_OP2_READ: begin
				l_r_message = `PRESS_MESSAGE;
				o_r_progress = `PROGRESS_BOTH_OPERANDS;
				l_r_next_state = STATE_RESULT_SELECT;
			end

            		STATE_RESULT_SELECT: begin
                		// TODO: 4.7.1: REMINDER: mesajul trebuie afisat in functie de ce operatie
                		// se alege de executat
				if (l_w_add_btn_debounced)
					l_r_message = {1'b0, l_w_sum_carry, l_w_sum};
				else if (l_w_sub_btn_debounced)
					l_r_message = {1'b0, ~l_w_dif_carry, l_w_dif};
				else
					l_r_message = `PRESS_MESSAGE;

				o_r_progress = `PROGRESS_RESULT;
                		// TODO 4.7.2: ATENTIE: Care este next state din ultima stare? Vrem sa
                		// o luam de la capat dupa prima operatie facuta?
				l_r_next_state = STATE_RESULT_SELECT;
            		end
            
            		default: begin
                		l_r_message = `MESSAGE_ERROR;
                		l_r_next_state = `STATE_ERROR;
            		end
        	endcase
	end

endmodule
