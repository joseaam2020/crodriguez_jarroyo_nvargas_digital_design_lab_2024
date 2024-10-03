module mux2to1 #(parameter N = 4)(s,in,out);
    input logic [2:0] s; //Selecciona cuál jugador
    input logic [3:0][N-1:0] in; //Jugador
    output logic [N-1:0] out; // posicion
    
    always_comb begin
        case(s)
            2'b00 : out <= in [0];
            2'b01 : out <= in [1];
            2'b10 : out <= in [2];
            2'b11 : out <= in [3];
			default : out <= 0;
        endcase
    end

endmodule