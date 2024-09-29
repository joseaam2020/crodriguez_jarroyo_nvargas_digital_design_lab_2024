module todoLleno_tb();

    logic [2:0][2:0][1:0] matriz;
    logic lleno;

    // Instancia
    todoLleno prueba (
        .juego(matriz),
        .lleno(lleno)
    );

    initial begin

        // Prueba 1: Vacía
        matriz = '{'{0, 0, 0}, '{0, 0, 0}, '{0, 0, 0}};
        #10;

        // Prueba 2: Media llena
        matriz = '{'{1, 0, 2}, '{0, 1, 0}, '{2, 0, 1}};
        #10;
        

        // Prueba 3: Llena
        matriz = '{'{1, 2, 1}, '{2, 1, 2}, '{1, 2, 1}};
        #10;
        

        // Prueba 4: Vacía en un espacio
        matriz = '{'{1, 2, 1}, '{2, 0, 2}, '{1, 2, 1}};
        #10;
        
		  
        // Prueba 5: Llena
        matriz = '{'{1, 1, 1}, '{1, 1, 1}, '{1, 1, 1}};
        #10;
        


    end

endmodule
