`timescale 1ns / 1ps

module mux_tb;

    // Parámetros del módulo
    parameter S = 4;
    parameter N = 4;

    // Señales de entrada y salida
    logic [S-1:0] s;
    logic [S-1:0][N-1:0] in;
    logic [N-1:0] out;

    // Instancia del módulo mux
    mux #(S, N) uut (
        .s(s),
        .in(in),
        .out(out)
    );

    // Procedimiento de prueba
    initial begin
        // Inicializar variables de prueba
        in = 64'hA1B2_C3D4_E5F6_1234; // Ejemplo de entrada de 16 bits por selección
        s = 0;

        // Imprimir encabezado para el testbench
        $display("Tiempo\t\t s\t\t in\t\t\t\t out");
        $monitor("%0t\t %0d\t %h\t %h", $time, s, in, out);

        // Probar cada valor de s y verificar la salida
        for (int i = 0; i < S; i++) begin
            s = i;
            #10;  // Esperar un tiempo para observar el cambio
        end

        // Terminar la simulación
        $finish;
    end
endmodule
