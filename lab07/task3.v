`timescale 1ns / 1ps
`include "defines.vh"

module task3(
		output wire o_w_digit_point,
		output wire [0:6] o_w_segment,
		output wire [3:0] o_w_digit,
		output reg [7:0] o_r_leds,
		input wire [3:0] i_w_operand1,
		input wire [3:0] i_w_operand2,
		input wire i_w_add_button,
		input wire i_w_sub_button,
		input wire i_w_op_ready_button,
		input wire i_w_reset,
		input wire i_w_clk
    );
	
	// TODO 4.1: declarati stariile FSM
	localparam STATE_0 = 0;
    localparam STATE_1 = 1;
    localparam STATE_2 = 2;
    localparam STATE_3 = 3;
	
	// TODO 4.2: folositi debouncere pentru butoane
	wire l_w_add_btn_debounced, l_w_sub_btn_debounced, l_w_op_ready_btn_debounced;
    debouncer operands1(.o_w_out(l_w_op_ready_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_op_ready_button), .i_w_sel(5'd3));
    debouncer operands2(.o_w_out(l_w_add_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_add_button), .i_w_sel(5'd3));
    debouncer operands3(.o_w_out(l_w_sub_btn_debounced), .i_w_clk(i_w_clk), .i_w_reset(i_w_reset), .i_w_in(i_w_sub_button), .i_w_sel(5'd3));
	
	// TODO 4.4: declarati alte variabile utile
	reg [9:0] l_r_message;
    wire [7:0] l_w_sum;
    wire [7:0] l_w_dif;
    wire l_w_sum_carry, l_w_dif_carry;
    
    reg [3:0] l_r_A;
    reg [3:0] l_r_B;
    
    reg [1:0] l_r_current_state;
    reg [1:0] l_r_next_state;
    
    wire    [3:0]   l_w_S;
    wire l_w_Cout1, l_w_Cout2;
    wire    [3:0]   l_w_D;

    task0 adder(l_w_S, l_w_Cout1, l_r_A, l_r_B, 1'b0);
    task1 subst(l_w_D, l_w_Cout2, l_r_A, l_r_B);
    
    //pentru fiecare buton
    reg l_r_op_ready_button_pressed, l_r_add_button_pressed, l_r_sub_button_pressed;
    
    // TODO 4.3: folositi modulul de 7 segment display
    display_7_segment_driver display(
        .o_r_segment(o_w_segment),
        .o_r_digit_point(o_w_digit_point),
        .o_r_digit(o_w_digit),
        .i_w_message(l_r_message),
        .i_w_reset(i_w_reset),
        .i_w_clk(i_w_clk)
    );

	
	// TODO 4.5: implementati tranzitiile intre stari
	always @(posedge i_w_clk) begin
        if (i_w_reset == 0) begin
            l_r_current_state <= STATE_0;
            l_r_op_ready_button_pressed <= 0;
        end else begin
            if(l_r_current_state == STATE_0) begin
                if(l_w_op_ready_btn_debounced) begin
                    if(!l_r_op_ready_button_pressed) begin
                        l_r_A = i_w_operand1;
                        l_r_B = i_w_operand2;
                    end                    
                    l_r_current_state <= l_r_next_state;
                    l_r_op_ready_button_pressed <= 1;
                end else begin
                    l_r_op_ready_button_pressed <= 0;
                end 
                
                if(l_w_add_btn_debounced || l_w_sub_btn_debounced) begin
                    l_r_current_state <= l_r_next_state;                        
                end          
            end 
            if(l_r_current_state == STATE_1 || l_r_current_state == STATE_2) begin
                if(l_w_add_btn_debounced || l_w_sub_btn_debounced) begin                        
                    l_r_current_state <= l_r_next_state;
                end
            end        
         end
	end
		
	// TODO 4.6: implementati logica de functionare
	always @(*) begin
		l_r_message = `MESSAGE_DEFAULT;
                
        case (l_r_current_state)
            STATE_0: begin
                l_r_message = `MESSAGE_DEFAULT;
                o_r_leds[7:4] = i_w_operand2;
                o_r_leds[3:0] = i_w_operand1;
                
                
                if (l_w_add_btn_debounced) begin
                    l_r_next_state = STATE_1;
                end else begin
                    if (l_w_sub_btn_debounced) begin
                        l_r_next_state = STATE_2;
                    end else begin
                        l_r_next_state = STATE_0;
                    end
                end
                
                
                
            end
            
            STATE_1: begin
                l_r_message = {6'b000000, l_w_S};
                if (l_w_sub_btn_debounced) begin
                    l_r_next_state = STATE_2;
                end else begin
                    l_r_next_state = STATE_1;
                end
            end
            
            STATE_2: begin
                l_r_message = {6'b000000, l_w_D};
                if (l_w_add_btn_debounced) begin
                    l_r_next_state = STATE_1;
                end else begin
                    l_r_next_state = STATE_2;
                end
            end
            
            default: begin
                l_r_message = `MESSAGE_ERROR;
                l_r_next_state = `STATE_ERROR;
            end
        endcase
	end

endmodule
