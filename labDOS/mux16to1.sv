module mux16to1 #(parameter N = 4)(s,in,out);
    input logic [3:0] s;
    input logic [(N*16)-1:0] in;
    output logic [N-1:0] out;
    
    always_comb begin
        case(s)
            4'b0000 : out <= in [N-1:0];
            4'b0001 : out <= in [(N*2)-1:N];
            4'b0010 : out <= in [(N*3)-1:(N*2)];
            4'b0011 : out <= in [(N*4)-1:(N*3)];
            4'b0100 : out <= in [(N*5)-1:(N*4)];
            4'b0101 : out <= in [(N*6)-1:(N*5)];
            4'b0110 : out <= in [(N*7)-1:(N*6)];
            4'b0111 : out <= in [(N*8)-1:(N*7)];
            4'b1000 : out <= in [(N*9)-1:(N*8)];
            4'b1001 : out <= in [(N*10)-1:(N*9)];
            4'b1010 : out <= in [(N*11)-1:(N*10)];
            4'b1011 : out <= in [(N*12)-1:(N*11)];
            4'b1100 : out <= in [(N*13)-1:(N*12)];
            4'b1101 : out <= in [(N*14)-1:(N*13)];
            4'b1110 : out <= in [(N*15)-1:(N*14)];
            4'b1111 : out <= in [(N*16)-1:(N*15)];
			default : out <= 0;
        endcase
    end

endmodule