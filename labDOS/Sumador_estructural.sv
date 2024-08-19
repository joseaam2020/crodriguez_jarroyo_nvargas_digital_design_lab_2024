
module sumador (

	input logic a,b,c,
	output logic s_sumador,cout_sumador


);	 
    assign s_sumador= a ^ b ^ c;
    assign cout_sumador = (a & b) | (a & c) | (b & c);
	 

endmodule 


module Sumador_estructural

		#(parameter N = 4)
		(
			input logic [N-1: 0] a,
			input logic [N-1: 0] b,
			input logic cin,
			output logic cout_sumador,
			output logic [N-1:0]s_sumador
	
		);

    logic  [N:0] c ; 
	 genvar i;
	 assign c[0] = cin;
	  
	 generate
				
				for(i = 0 ; i < N ; i++ ) 
				
				begin : instacias 
				
				sumador nuevo (		
				.a(a[i]),
				.b(b[i]),
				.c(c[i]),
				.s_sumador(s_sumador[i]),
				.cout_sumador(c[i + 1])
				
				);
						
				end 			
	 endgenerate 
	  
	 assign cout_sumador	= c[N];	

endmodule


