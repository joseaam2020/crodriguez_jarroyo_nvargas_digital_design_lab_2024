module multiplicador 
    #(parameter N = 4)
		(
			input logic [N-1: 0] a, //10
			input logic [N-1: 0] b, //11
			output logic [(2*N)-1:0] s_multiplicador
	
		);


    
    assign product = a & b; // Compuerta AND
	 
	 logic [N-1:0][N-1:0] matriz_productos; 
	 logic [N-1:0][2*N-2:0] matriz_shift = '{default:0}; // Llena la matriz con ceros
	 
	 
	 
	 always_comb begin // a = 10, b = 11
	 int i, j;
	 
	 // Para guardar los productos
	 for(i = 0 ; i < N ; i++ ) begin // 0
	 
		for(j = 0 ; j < N ; j++ ) // 1
		
			matriz_productos[i][j] = a[i] & b[j]; //0 * 1
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
	 
	 
	 logic  [N-1:0] c ; 
	 genvar i;
	 assign c[0] = 0;
	 
	 //logic [2*N-2:0] suma_parcial;
	 
	 

	  
	 
	 
	 
	 
	 generate
        //genvar i;
		  
		  //if (N > 2) begin 
			 logic [N-1:0][2*N-2:0] matriz_sumaParcial;
		  //end else begin
			 //logic [1:0][2*N-2:0] matriz_sumaParcial;
	     //end
		  
			

        for (i = 0; i < N-1; i++) begin : instancias
            
            
           
				if (i == 0) begin
					// Instancia del sumador #1
					Sumador_estructural #(2*N-1) nuevo_sumador (
						 .a(matriz_shift[i]),
						 .b(matriz_shift[i+1]),
						 .cin(c[i]),
						 .s_sumador(matriz_sumaParcial[0]),
						 .cout_sumador(c[i + 1])
						 
						 /*
							000
							011
						*/
					);
				end else begin
					// Instancia del sumador #N
					Sumador_estructural #(2*N-1) nuevo_sumador (
						 .a(suma_parcial),
						 .b(matriz_shift[i+1]),
						 .cin(c[i]),
						 .s_sumador(matriz_sumaParcial[i+1]),
						 .cout_sumador(c[i + 1])
						 
					);
				end
				
				
				
					

             
        end
		  if (N <= 2) begin
			assign matriz_sumaParcial[1] = matriz_sumaParcial[0];
		  end
		  
	 endgenerate
	 
	 
	 
	 // Suma final
	 
	 
	 assign s_multiplicador[2*N-2:0] = matriz_sumaParcial[N-1]; 
	 assign s_multiplicador[2*N-1] = c[N-1];
	
	 
	 
	 
	 
	  
	  
 
endmodule
