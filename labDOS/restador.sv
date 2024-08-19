
module restador_ins (

	input logic a,b,c,
	output logic s_restador,cout_restador


);	 
    assign s_restador= a ^ ~b ^ c;
    assign cout_restador = (a & ~b) | (a & c) | (~b & c);
	 

endmodule 


module restador

		#(parameter N = 4)
		(
			input logic [N-1: 0] a,
			input logic [N-1: 0] b,
			input logic cin,
			output logic cout_restador,
			output logic [N-1:0]s_restador
	
		);

    logic  [N:0] c ; 
	 genvar i;
	 assign c[0] = cin;
	  
	 generate
				
				for(i = 0 ; i < N ; i++ ) 
				
				begin : restados
				
				restador_ins nuevo (		
				.a(a[i]),
				.b(b[i]),
				.c(c[i]),
				.s_restador(s_restador[i]),
				.cout_restador(c[i + 1])
				
				);
						
				end 			
	 endgenerate 
	  
	 assign cout_restador	= c[N];	

endmodule