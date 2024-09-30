module actualizar(
	input logic [2:0][2:0][1:0] matriz_juego,
	input logic [3:0] posicion,
	input logic Jug,
	input logic actualizar,

	
	output logic [2:0][2:0][1:0] new_juego
	
);

	
	always_comb begin
	
		if (actualizar == 1) begin 
		
			new_juego = matriz_juego;
		
			// Case para llenar la matriz
		
		
			case(posicion)
				4'd1: new_juego[0][0] = Jug + 1; 
				4'd2: new_juego[0][1] = Jug + 1;
				4'd3: new_juego[0][2] = Jug + 1;
				4'd4: new_juego[1][0] = Jug + 1;
				4'd5: new_juego[1][1] = Jug + 1;
				4'd6: new_juego[1][2] = Jug + 1;
				4'd7: new_juego[2][0] = Jug + 1;
				4'd8: new_juego[2][1] = Jug + 1;
				4'd9: new_juego[2][2] = Jug + 1;
				default:  new_juego= matriz_juego; 
			
			endcase
			
		end 
	
	
	
	
		
		
	end 
		
	

endmodule
