module valido(

	input logic [2:0][2:0][1:0] juego,  // Matriz de entrada
	input logic [3:0] posicion,         // posición del jugador
	output logic valido                 // Devuelve si la jugada es válida o no

);

	always_comb begin 
		// Valor inicial
		valido = 0;
		
		// Case para verificar si la posición seleccionada está vacía
		case(posicion)
			4'd1: if (juego[0][0] == 2'd00) valido = 1;
			4'd2: if (juego[0][1] == 2'd00) valido = 1;
			4'd3: if (juego[0][2] == 2'd00) valido = 1;
			4'd4: if (juego[1][0] == 2'd00) valido = 1;
			4'd5: if (juego[1][1] == 2'd00) valido = 1;
			4'd6: if (juego[1][2] == 2'd00) valido = 1;
			4'd7: if (juego[2][0] == 2'd00) valido = 1;
			4'd8: if (juego[2][1] == 2'd00) valido = 1;
			4'd9: if (juego[2][2] == 2'd00) valido = 1;
			default: valido = 0;
		endcase
	end
	
endmodule

	