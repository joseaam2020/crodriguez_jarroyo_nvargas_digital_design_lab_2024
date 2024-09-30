module tb_actualizar;

  // Definir señales para entradas y salidas del módulo
  logic [2:0][2:0][1:0] matriz_juego;  // Matriz del juego (3x3), con dos bits por posición
  logic [3:0] posicion;                // Posición donde se quiere actualizar (1-9)
  logic Jug;                           // Jugador: 0 o 1
  logic actualizar;                    // Señal para actualizar la matriz
  logic [2:0][2:0][1:0] old_juego;     // Salida de la nueva matriz actualizada
  
  assign old_juego = matriz_juego;

  // Instanciar el módulo que vamos a probar
  actualizar uut (
    .matriz_juego(old_juego),
    .posicion(posicion),
    .Jug(Jug),
    .actualizar(actualizar),
    .new_juego(matriz_juego)
  );

  // Proceso inicial para definir el test
  initial begin
    // Inicializar la matriz vacía y las señales de control
    matriz_juego = '{ '{2'b00, 2'b00, 2'b00}, '{2'b00, 2'b00, 2'b00}, '{2'b00, 2'b00, 2'b00} };
    actualizar = 1;     // Activamos la señal de actualización

    // Llamada 1: Probar la posición 1 para Jugador 1 (0)
    Jug = 0;            // Jugador 1 (0)
    posicion = 4'd1;
    #5; // Esperar 5 unidades de tiempo
    

    // Llamada 2: Probar la posición 2 para Jugador 2 (1)
    Jug = 1;            // Jugador 2 (1)
    posicion = 4'd2;
    #5; // Esperar 5 unidades de tiempo
    
  end

endmodule
