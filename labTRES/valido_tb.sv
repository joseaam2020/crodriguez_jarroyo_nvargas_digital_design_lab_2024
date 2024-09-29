module valido_tb();

  logic [2:0][2:0][1:0] juego;
  logic [3:0] posicion;
  logic valido;

  // Instancia
  valido prueba (
    .juego(juego),
    .posicion(posicion),
    .valido(valido)
  );

  
  initial begin
  
    // Prueba 1, tablero vacío
	 
    juego = '{'{0, 0, 0}, '{0, 0, 0}, '{0, 0, 0}};
    juego[1][1] = 2;
	 juego[2][1] = 1; 
	 
    for (int i = 1; i <= 9; i++) begin
      posicion = i;
      #10;
    end

    /*// Prueba 2
    juego = '{'{1, 0, 2}, '{2, 1, 0}, '{1, 2, 0}};
	 
    
    for (int i = 1; i <= 9; i++) begin
      posicion = i;
      #10;
    end*/

  end

endmodule
