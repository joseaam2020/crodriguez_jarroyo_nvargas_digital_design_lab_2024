module random_number_position (
    input logic [2:0][2:0][1:0] juego,  
    input clk,
    output logic [3:0] position   
);

    logic valido;            
    logic [3:0] random_num = 4'b1111;  
    logic [3:0] new_position = 4'd0;

  
    valido validador (
        .juego(juego),
        .posicion(new_position),
        .valido(valido)
    );

  
    always_ff @(negedge clk) begin
        if (valido) begin
            position <= new_position;
        end else begin
            random_num <= {random_num[2:0], random_num[3]^random_num[2]^random_num[1]^random_num[0]};  // Genera número aleatorio entre 0 y 9
            new_position <= random_num; // Asigna el número aleatorio a la posición indicada
        end
    end

endmodule