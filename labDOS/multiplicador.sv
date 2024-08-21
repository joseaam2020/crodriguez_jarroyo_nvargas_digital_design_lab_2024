module multiplicador (
    #(parameter N = 4)
		(
			input logic [N-1: 0] a, //10
			input logic [N-1: 0] b, //11
			output logic [(2*N)-1:0] s_multiplicador
	
		);
);

    
    assign product = a & b; // Compuerta AND
	 
	 logic [N-1:0][N-1:0] matriz_productos; 
	 logic [N-1:0][2*N-2:0] matriz_shift = '{default:0}; // Llena la matriz con ceros
	 
	 
	 
	 always_comb begin // a = 10, b = 11
	 
	 // Para guardar los productos
	 for(i = 0 ; i < N ; i++ ) begin // 0
	 
		for(j = 0 ; j < N ; j++ ) // 1
		
			matriz_productos[i][j] = a[i] * b[j]; //0 * 1
		/*
		00
		11
		*/
	 end
	
	 
	 
	 // Para el shift
	 for(i = 0 ; i < N ; i++ ) begin // 1
	 
		for(j = 0 ; j < 2*N-1 ; j++ ) begin // 2
			
			if (j < N & j+i < 2*N-1) //2 | 1 + 1 = 2
				matriz_shift[i][j+i] = matriz_productos[i][j]; //[1][2] | [1][1]
			
		end
	 end
		
		/*
		000
		011
		*/
			
	 end
	 
	 
	 logic  [N:0] c ; 
	 genvar i;
	 assign c[0] = 0;
	 
	 generate
				
				for(i = 0 ; i < N ; i++ ) 
				
				begin : instacias
			
			
			
				logic [N-1: 0] a,
				logic [N-1: 0] b,
				logic cin,
				logic cout_sumador,
				logic [N-1:0]s_sumador
				
				
				Sumador_estructural #(N)nuevo_sumador (	
				
				//Agregar confición if para que b no falle
				if (j < N & j+i < 2*N-1) // arreglar las condiciones
				.a(matriz_shift[i]),
				.b(matriz_shit[i+1]),
				.c(c[i]),  
				.s_sumador(s_sumador[i]), //El último sumador debe estar conectada a s_multiplicador, hacer condición exclusiva para el último sumador.
				.cout_sumador(c[i + 1])
				
				
				);
				
				
						
				end 			
	 endgenerate
	 
	 
	 
	 
	  
	  
 
endmodule
