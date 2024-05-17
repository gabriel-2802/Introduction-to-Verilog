`timescale 1ns / 1ps
module task2(
    output wire o_w_out,
    input wire i_w_in,
    input wire i_w_clk,
    input wire i_w_reset,
    input wire[4:0] i_w_sel
);
    // counter pentru perioada dintre doua schimbari ale semnalului
    // cu acest reg vom numara efectiv pana la o anumita valoare pe
    // care o marcam prin i_w_sel
    // in cazul de fata avem un counter pe 32 de biti
    reg[31:0] l_r_counter;
    
    // ca sa pot accesa bitii sai, pot face l_r_counter[0], l_r_counter[1] etc
    // pot merge pana la l_r_counter[31] => am nevoie de un index pentru
    // a itera prin acest counter, index ce poate lua valori de la 0 la 31
    // ca sa pot reprezenta numerele de la 0 la 31 am nevoie de un numar pe 5 biti
    // si de aceea primim in lista de porturi **i_w_sel** - il vom folosi pe post de index
    
    // retine starea butonului (daca este pe 0 sau pe 1)
    reg l_r_button;
    always @(posedge i_w_clk) begin
        // daca primim reset, atunci punem pe 0 atat counter-ul, cat si valoarea butonului
        if(i_w_reset) begin
        	l_r_counter <= 0;
        	l_r_button <= 0;
        end else begin
        	// starea butonului a ajuns sa fie egala cu inputul pe care l-am dat
        	if (i_w_in == l_r_button) begin
        	   // resetez counter-ul pentru o viitoare stabilizare
        	   l_r_counter <= 0;
        	end else begin
        	   // i_w_sel va primi la inceput o valoare (pe parcursul acestui modul nu ii vom schimba valoarea)
        	   // Ce face acest i_w_sel?
        	   // R: ne spune cand sa ne oprim cu stabilizarea
        	   // Daca eu trimit din exterior aka la instantierea modulului un i_w_sel = 2,
        	   // atunci eu voi astepta sa ajung cu numaratul lui l_r_counter pana cand l_r_counter[2] = 1.
        	   // Adica voi avea initial:
        	   // l_r_counter = 0,
        	   // l_r_counter = 1,
        	   // l_r_counter = 01,
        	   // l_r_counter = 10,
        	   // l_r_counter = 11,
        	   // l_r_counter = 100 <=> l_r_counter[2] = 1
        	   // In acest moment ma opresc din a creste contorul, deoarece sunt sigura ca s-a stabilizat
        	   
        	   // De unde stiu ca s-a stabilizat?
        	   // R: cineva din exterior mi-a zis ca i_w_sel = 2 va stabiliza semnalul
        	   
        	   // Cine decide ca i_w_sel = 2?
        	   // R: i_w_sel va lua valoarea pe care cel din exterior o va considera suficienta ca sa
        	   // zica intr-adevar, am obtinut o apasare corecta si semnalul meu e stabilizat
        	   if (l_r_counter[i_w_sel] == 1'b1) begin
        	       // problema de nestabilizare a semnalului apare doar la comutari (din 0 pe 1, din 1 pe 0)
        	       // cand am gasit un "prag" pentru stabilizare, atunci fac toggle la semnal si ma opresc
        	       // din a creste contorul
        	       l_r_button <= ~l_r_button;
        	       // counter se face 0 pentru o alta stabilizare
        	       l_r_counter <= 0;
        	   end else begin
        	       // daca nu am atins pragul, continui sa numar (sa cresc counter-ul)
        	       l_r_counter <= l_r_counter + 1;
        	   end
        	end
        end
    end

    assign o_w_out = l_r_button;
endmodule
