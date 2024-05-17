`timescale 1ns / 1ps

module task01(
    output wire [15:0] o_w_register_0,
    output wire [7:0] o_w_program_counter,
    input wire [15:0] i_w_instruction,
    input wire i_w_clk,
    input wire i_w_reset
);
    //CPU STATES
    localparam STATE_RESET  = 3'd0;
    localparam STATE_IF     = 3'd1;
    localparam STATE_ID     = 3'd2;
    localparam STATE_EX     = 3'd3;
    localparam STATE_MEM    = 3'd4;
    localparam STATE_WB     = 3'd5;

    //register for current state and next state
    reg[2:0] l_r_currentState;
    reg[2:0] l_r_nextState;

    // TODO: implement state transition logic
    always @(posedge i_w_clk or posedge i_w_reset) begin
		if (i_w_reset) begin
            l_r_currentState <= STATE_RESET;
		end else begin
            l_r_currentState <= l_r_nextState;
		end
	end

    // TODO: next state computation 
    always @(*) begin
		case (l_r_currentState)
//		    STATE_RESET: l_r_nextState = ;
//		    STATE_IF: l_r_nextState = ;
//		     ...
            STATE_RESET: l_r_nextState = STATE_IF;
		    STATE_IF:    l_r_nextState = STATE_ID;
		    STATE_ID:    l_r_nextState = STATE_EX;
            STATE_EX:    l_r_nextState = STATE_MEM;
            STATE_MEM:   l_r_nextState = STATE_WB;
            STATE_WB:    l_r_nextState = STATE_IF;
            default : l_r_nextState = STATE_RESET;
		endcase
	end

    // REGISTER FILE -- general registers
	reg	[15:0]	  	l_r_registers[31:0];
	integer		i;
    
    //  initialize registers
	always @(posedge i_w_reset) begin
		for (i = 0; i < 32; i = i + 1) begin
			l_r_registers[i] <= i;
		end
	end

    // R[0] used for debugging 
    // DEBUG: add o_w_register_0 to the Wave Window 
    assign o_w_register_0 = l_r_registers[0];

    // **IF state** START
    // PROGRAM COUNTER register
    reg [7:0] r_l_program_counter;

    // Send the current program counter to instruction memory to get current instruction
    assign o_w_program_counter = r_l_program_counter;

    // TODO: compute next program counter on WB State (you need it before IF)
    always @(posedge i_w_clk or posedge i_w_reset) begin
		if (i_w_reset) begin
            r_l_program_counter <= 0;
		end else begin
            if (l_r_currentState == STATE_WB) begin
                r_l_program_counter <= r_l_program_counter + 1;
            end
		end
	end
    // **IF state** END

    // **ID state** START
    // wires to decode operands' adresses and operation
    wire[4:0] l_w_op1;
    wire[4:0] l_w_op2;
    wire[4:0] l_w_op_sel;

    //TODO: use decoder module to find the operands' adresses and opsel
    decoder dec(l_w_op1, l_w_op2, l_w_op_sel, i_w_instruction);

    //ALU input values
    wire[15:0] l_w_alu_a;
    wire[15:0] l_w_alu_b;
    wire[4:0] l_w_alu_op_sel;

    //TODO: get a, b, op_sel
    // a <- register[op1]
    // b <- register[op2]
    assign l_w_alu_a = l_r_registers[l_w_op1];
    assign l_w_alu_b = l_r_registers[l_w_op2];
    assign l_w_alu_op_sel = l_w_op_sel;

    //WB adress
    wire[4:0] l_w_wb_adress;

    //TODO: WB adress is the first operand adress
    assign l_w_wb_adress = l_w_op1;

    // **ID state** END

    
    // **EX state** START
    //define alu_result
    wire[15:0] l_w_alu_result;

    //TODO: use alu module to get the result of the operation
    alu alu_(l_w_alu_result, l_w_alu_a, l_w_alu_b, l_w_alu_op_sel);

    // **EX state** END
    
    // **MEM state** START

    // curently no instruction uses memory
    
    // **MEM state** END

    
    // **WB state** START

    // TODO: if the current state is WB and we have a valid alu operation
    // write the result of alu in the first operand register
    always @(l_r_currentState) begin
		 if(l_r_currentState == STATE_WB) begin
             l_r_registers[l_w_wb_adress] = l_w_alu_result;
		 end
	end
    // **WB state** END
endmodule
