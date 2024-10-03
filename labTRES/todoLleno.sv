module todoLleno(
    input logic [2:0][2:0][1:0] juego,  // Matriz de entrada
    output logic lleno // 1 -> completamante llena, 0 -> vacía al menos en un espacio
);

    always_comb begin
        lleno = 1;  // Matriz llena hasta que se indique lo contrario

        
        for (int i = 0; i < 3; i++) begin
            for (int j = 0; j < 3; j++) begin
                if (juego[i][j] == 0) begin
                    lleno = 0;  // Se busca al menos un espacio vacío
                end
            end
        end
    end

endmodule
