module switches(
    output  logic [3:0] pos,        // Salida para la posición (del 1 al 9)
    input   logic [8:0] switchs     // Entrada de switches (del 1 al 9)
);

    always_comb begin
        // Inicializamos todas las posiciones en 0
        pos = '0;

        // Recorremos cada bit del vector de switches (del 1 al 9)
        for (int i = 0; i < 9; i++) begin
            // Si el switch i-ésimo está activado, actualizamos la posición i
            if (switchs[i]) begin
                pos= i + 1;  // Activar la posición correspondiente
            end
        end
    end

endmodule
