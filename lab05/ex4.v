module ex4(
    output reg o_r_AN0,
    output reg o_r_AN1,
    output reg o_r_AN2,
    output reg o_r_AN3,
    output reg o_r_CA,
    output reg o_r_CB,
    output reg o_r_CC,
    output reg o_r_CD,
    output reg o_r_CE,
    output reg o_r_CF,
    output reg o_r_CG,
    output reg o_r_DP,
    input wire i_w_clk,
    input wire i_w_reset
    );
                                                                               
    localparam STATE_0 = 0;
    localparam STATE_1 = 1;
    localparam STATE_2 = 2;
    localparam STATE_3 = 3;

    reg [1:0]  l_r_currentState;
    reg [1:0]  l_r_nextState;

    reg [15:0] l_r_displayDelay;
    reg [15:0] l_r_countSeconds;
    reg [15:0] l_r_countMinutes;

    reg [31:0] l_r_incrementDelay;

    always @(posedge i_w_clk) begin
        if (i_w_reset == 0) begin
            l_r_currentState <= STATE_0;
            l_r_displayDelay <= 0;
            l_r_incrementDelay <= 0;
            l_r_countSeconds <= 0;
            l_r_countMinutes <= 0;
        end else begin
            // TODO: Delay digits change to prevent bleeding
            l_r_displayDelay <= l_r_displayDelay + 1;

            if (l_r_displayDelay == 100000) begin
                l_r_displayDelay <= 0;
                l_r_currentState <= l_r_nextState;
            end

            // TODO: Increment local time variables
            l_r_incrementDelay <= l_r_incrementDelay + 1;
            
            if (l_r_incrementDelay == 100000000) begin
                l_r_incrementDelay <= 0;
                l_r_countSeconds <= l_r_countSeconds + 1;
            end
            
            if (l_r_countSeconds == 60) begin
                l_r_countSeconds <= 0;
                l_r_countMinutes <= l_r_countMinutes + 1;
            end
            
            if (l_r_countMinutes == 60) begin
                l_r_countSeconds <= 0;
                l_r_countMinutes <= 0;
            end
        end
    end

    always @(*) begin
        case(l_r_currentState)
        // TODO: Display digits
            STATE_0: begin
                o_r_AN0 = 1;
                o_r_AN1 = 1;
                o_r_AN2 = 1;
                o_r_AN3 = 0;
                
                t_display(l_r_countMinutes/10);
                
                l_r_nextState = STATE_1;
            end
            
            STATE_1: begin
                o_r_AN0 = 1;
                o_r_AN1 = 1;
                o_r_AN2 = 0;
                o_r_AN3 = 1;
                
                t_display(l_r_countMinutes%10);

                l_r_nextState = STATE_2;
            end
            
            STATE_2: begin
                o_r_AN0 = 1;
                o_r_AN1 = 0;
                o_r_AN2 = 1;
                o_r_AN3 = 1;
                
                t_display(l_r_countSeconds/10);
                
                l_r_nextState = STATE_3;
            end
            STATE_3: begin
                o_r_AN0 = 1;
                o_r_AN1 = 0;
                o_r_AN2 = 1;
                o_r_AN3 = 1;
               
                t_display(l_r_countSeconds%10);

                l_r_nextState = STATE_0;
            end
        endcase
    end
    
    // A task that you can use to display any digit
    task t_display;
        input   [15:0]  i_w_digit;
        begin
            case (i_w_digit)
                // TODO: Add outputs for digits 0-3
                0: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 0;
                    o_r_CF = 0;
                    o_r_CG = 1;
                    o_r_DP = 1;
                end

                1: begin
                    o_r_CA = 1;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 1;
                    o_r_CE = 1;
                    o_r_CF = 1;
                    o_r_CG = 1;
                    o_r_DP = 1;
                end

                2: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 1;
                    o_r_CD = 0;
                    o_r_CE = 0;
                    o_r_CF = 1;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                3: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 1;
                    o_r_CF = 1;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                4: begin
                    o_r_CA = 1;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 1;
                    o_r_CE = 1;
                    o_r_CF = 0;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                5: begin
                    o_r_CA = 0;
                    o_r_CB = 1;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 1;
                    o_r_CF = 0;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                6: begin
                    o_r_CA = 0;
                    o_r_CB = 1;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 0;
                    o_r_CF = 0;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                7: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 1;
                    o_r_CE = 1;
                    o_r_CF = 1;
                    o_r_CG = 1;
                    o_r_DP = 1;
                end

                8: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 0;
                    o_r_CF = 0;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                9: begin
                    o_r_CA = 0;
                    o_r_CB = 0;
                    o_r_CC = 0;
                    o_r_CD = 0;
                    o_r_CE = 1;
                    o_r_CF = 0;
                    o_r_CG = 0;
                    o_r_DP = 1;
                end

                default: begin
                    o_r_CA = 1;
                    o_r_CB = 1;
                    o_r_CC = 1;
                    o_r_CD = 1;
                    o_r_CE = 1;
                    o_r_CF = 1;
                    o_r_CG = 1;
                    o_r_DP = 1;
                end
            endcase
        end
    endtask
endmodule