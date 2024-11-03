module tb_Sumador_ins;

    
    parameter N = 4;

 
    logic [N-1:0] a;
    logic [N-1:0] b;
    logic cin;
    logic cout_sumador;
    logic [N-1:0] s_sumador;


    Sumador_estructural #(N) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .cout_sumador(cout_sumador),
        .s_sumador(s_sumador)
    );

    initial begin
      
        a = 4'b0000; b = 4'b0000; cin = 0;
        #10;
		  
		  
        a = 4'b0001; b = 4'b0001; cin = 0;
        #10;
		  
		  
        a = 4'b0010; b = 4'b0011; cin = 1;
        #10;
		  
		  
        a = 4'b1111; b = 4'b1111; cin = 1;
        #10;
         
  
    end
endmodule
