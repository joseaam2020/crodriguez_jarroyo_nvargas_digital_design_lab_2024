module TresenFila(
	input logic [2:0][2:0][1:0] matriz_juego, // Matriz de entrada
	output logic ganador // Devuelve si hay ganador o aún no
);
	
	// Variables para verificar si hay ganador
	logic fila, columna, diagonal;
	
	
   
	
	always_comb begin // Para que se ejecuten cada que cambia las entradas
	
		ganador = 0;
		fila = 0;
		columna = 0;
		diagonal = 0;
		
		
		for (int i = 0; i < 3; i++) begin
		
		// Verificar ganador por fila (Horizontal)
			if ((matriz_juego[i][0] > 0) && (matriz_juego[i][0] == matriz_juego[i][1]) && (matriz_juego[i][1] == matriz_juego[i][2])) begin
				fila = 1;
			end
			
		// Verificar ganador por columna	(Vertical)
			else if ((matriz_juego[0][i] > 0) && (matriz_juego[0][i] == matriz_juego[1][i]) && (matriz_juego[1][i] == matriz_juego[2][i])) begin
				columna = 1;
			end
			
		// Verificar ganador por diagonal
			
			// Diagonal 1
			else if ((matriz_juego[0][0] > 0) && (matriz_juego[0][0] == matriz_juego[1][1]) && (matriz_juego[1][1] == matriz_juego[2][2])) begin
				diagonal = 1;
			end
			
			// Diagonal 2
			else if ((matriz_juego[0][2] > 0) && (matriz_juego[0][2] == matriz_juego[1][1]) && (matriz_juego[1][1] == matriz_juego[2][0])) begin
				diagonal = 1;
			end
			
		end
		
		if ( fila || columna || diagonal) begin
			ganador = 1;
		end
		
	end
	
	
endmodule 