module random_number_position (
    input logic [2:0][2:0][1:0] juego,  
    output logic [3:0] position   
);

    logic valido;            
    logic [3:0] random_num;  
    logic [3:0] new_position = 4'd0;

  
    valido validador (
        .juego(juego),
        .posicion(new_position),
        .valido(valido)
    );

  
    always_ff @(posedge valido) begin
        if (valido) begin
            position <= new_position;
        end else begin
            random_num <= $random % 10;  // Genera número aleatorio entre 0 y 9
            new_position <= random_num; // Asigna el número aleatorio a la posición indicada
        end
    end

endmodule