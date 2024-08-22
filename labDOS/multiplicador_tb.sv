module multiplicador_tb;
	
	// Para N = 2
	// Estos son los cables
	logic [2-1: 0] a; 
	logic [2-1: 0] b; 
	logic [(2*2)-1:0] s_m;
	
	
	multiplicador #(2)multi
		(
			// Estas son las puertas (nombres)
			.a(a), 
			.b(b), 
			.s_multiplicador(s_m)

		);
		
	initial begin
		int i, j;
		for(i = 0 ; i < 4 ; i++ ) begin
			for (j = 0; j < 4; j++) begin
				a = i;
				b = j;
				#3; 
			end
		end
				
	end			
		

endmodule
