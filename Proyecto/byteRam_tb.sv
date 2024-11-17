`timescale 1ps / 1ps

module byteRam_tb;

    // Señales para el módulo
    logic clk;
    logic [32:0] address;
    logic [7:0] byteData;
    logic [31:0] wordData;
    logic byteWriteEnable;
    logic wordWriteEnable;
    logic [31:0] q;

    // Instancia del módulo bajo prueba
    byteRam uut (
        .clk(clk),
        .address(address),
        .byteData(byteData),
        .wordData(wordData),
        .byteWriteEnable(byteWriteEnable),
        .wordWriteEnable(wordWriteEnable),
        .q(q)
    );

    // Generador de reloj (20 ns de periodo)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock cada 10 ns
    end

    // Procedimiento principal de prueba
    initial begin
        // Inicialización de señales
        address = 0;
        byteData = 0;
        wordData = 0;
        byteWriteEnable = 0;
        wordWriteEnable = 0;

        // Esperar a que inicie el reloj
        @(posedge clk);

        // Prueba 1: Escribir una palabra completa (32 bits)
        wordWriteEnable = 1;
        address = 4;            // Dirección para la palabra
        wordData = 32'hDEADBEEF;
        @(posedge clk);
        wordWriteEnable = 0;    // Deshabilitar escritura
        @(posedge clk);
        $display("Read after word write: %h (expected: DEADBEEF)", q);

        // Prueba 2: Escribir un byte específico
        byteWriteEnable = 1;
        address = 5;            // Dirección del byte
        byteData = 8'hCA;       // Nuevo dato para el byte
        @(posedge clk);
        byteWriteEnable = 0;    // Deshabilitar escritura
        @(posedge clk);
        $display("Read after byte write: %h (expected: DEADCAEF)", q);

        // Prueba 3: Leer sin escritura
        address = 4;            // Leer la dirección original
        @(posedge clk);
        $display("Read without write: %h (expected: DEADCAEF)", q);

        // Terminar simulación
        $stop;
    end

endmodule
