
În acest laborator, vom explora modurile în care putem descrie module în Verilog, facilitând crearea eficientă și simplă a acestora.

## Tipuri de Descriere
Descrierea unui modul în Verilog poate fi realizată în trei moduri principale:

1. **La nivel structural**
2. **La nivel de flux de date**
3. **La nivel procedural**

### Descrierea la Nivel Structural
- Aceasta implică utilizarea primitivelor și modulelor pentru a specifica structura internă a modulului, inclusiv elementele de circuit și conexiunile dintre ele.
- utilizeaza `PORTI`

#### Exemplu: Multiplexor 4:1
```verilog
module mux_4_to_1(
    output out,
    input in0,
    input in1,
    input in2,
    input in3,
    input sel0,
    input sel1
);
    wire notsel0;
    wire notsel1;
    wire y0;
    wire y1;
    wire y2;
    wire y3;

    not(notsel0, sel0);
    not(notsel1, sel1);

    and(y0, in0, notsel1, notsel0);
    and(y1, in1, notsel1, sel0);
    and(y2, in2, sel1, notsel0);
    and(y3, in3, sel1, sel0);

    or(out, y0, y1, y2, y3);
endmodule
```

### Descrierea la Nivel de Flux de Date
Specifica relațiile dintre intrări și ieșiri printr-o serie de expresii, folosind atribuiri continue.

#### Exemplu: Multiplexor 4:1
```verilog
module mux_4_to_1(
    output out,
    input in0,
    input in1,
    input in2,
    input in3,
    input sel0,
    input sel1
);
assign out = 
    (in0 & ~sel1 & ~sel0) |
    (in1 & ~sel1 & sel0)  |
    (in2 & sel1 & ~sel0)  |
    (in3 & sel1 & sel0);
endmodule
```

### Descrierea la Nivel Procedural
Folosește blocuri `initial` și `always` pentru a specifica funcționalitatea modulului într-un mod algoritmic.

#### Exemplu: Multiplexor 4:1
```verilog
module mux_4_to_1(
    output reg out,
    input in0,
    input in1,
    input in2,
    input in3,
    input sel0,
    input sel1
);
    always @(*)
    begin
        case ({sel1, sel0})
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 1'bx;
        endcase
    end
endmodule
```

### Blocurile `initial` și `always`
- `initial`: Executat o singură dată, utilizat pentru inițializări.
- `always`: Executat continuu, similar unei bucle infinite.

#### Exemplu de utilizare:
```verilog
input clk;
reg a;
reg b;

always @(posedge clk)
begin
   a <= b;
end
```

### Construcții de Control în Blocurile Procedurale
```verilog
if (sig == 0) 
begin
    a = 2;
end else begin
    a = 1;
end

case (sig)
    1’b0: a = 2;
    1’b1: a = 1;
    default: a = 0;
endcase
```

### Atribuiri Blocante și Non-Blocante
- Atribuiri blocante (`=`): Se execută secvențial, folosite pentru logica combinațională.
- Atribuiri non-blocante (`<=`): Se execută în paralel, folosite pentru logica secvențială.

```verilog
// Blocante
a = b;  // a ia valoarea lui b.
b = a;  // b ia valoarea lui a.

// Non-blocante
a <= b;  // Valoarea lui b este evaluată, dar nu atribuită imediat