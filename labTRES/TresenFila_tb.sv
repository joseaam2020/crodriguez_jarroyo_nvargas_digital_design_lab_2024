module TresenFila_tb();

	logic [2:0][2:0][1:0] juego; 
	logic resultado; 
	
	// Instancia
	TresenFila prueba (
		.matriz_juego(juego),
		.ganador(resultado)

	);
	
	// Pruebas
	initial begin
	
		// Prueba 1
		juego = '{'{0,0,0},
					 '{0,0,0},
					 '{0,0,0}};
		#10;
		
		//////////////////
			// Prueba 2
		juego = '{'{1,1,1},
					 '{2,0,2},
					 '{2,0,1}};
		#10;
		
		//////////////////
			// Prueba 3
		juego = '{'{2,1,0},
					 '{2,0,1},
					 '{2,0,0}};
		#10;
		
		//////////////////
			// Prueba 4
		juego = '{'{1,1,0},
					 '{0,1,0},
					 '{0,0,1}};
		#10;
		
		//////////////////
			// Prueba 5
		juego = '{'{0,1,2},
					 '{1,2,1},
					 '{2,0,0}};
		#10;
		
		
	
	end
	
	
endmodule