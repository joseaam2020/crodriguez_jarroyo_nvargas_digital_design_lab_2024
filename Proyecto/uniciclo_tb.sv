`timescale 1ns/1ps 
module uniciclo_tb;

    // Declarar señales de prueba
    logic clk;
    logic rst;
    logic [1:0] switch;

    logic VGA_CLK;
    logic [7:0] VGA_B;
    logic [7:0] VGA_G;
    logic [7:0] VGA_R;
    logic VGA_HS;
    logic VGA_VS;
    logic VGA_BLANK;
    logic VGA_SYNC;

    // Instanciar el DUT (Device Under Test)
    uniciclo uut (
        .clk(clk),
        .rst(rst),
        .switch(switch),
        .VGA_CLK(VGA_CLK),
        .VGA_B(VGA_B),
        .VGA_G(VGA_G),
        .VGA_R(VGA_R),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_BLANK(VGA_BLANK),
        .VGA_SYNC(VGA_SYNC)
    );

    // Generar reloj
    always #10 clk = ~clk; // Periodo de 10 unidades de tiempo

    // Proceso de prueba
    initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;
        switch = 2'b00;

        // Tiempo inicial de reset
        #20;
        rst = 0;

        // Simular un cambio en el interruptor
        #50 switch = 2'b10;

        // Observar comportamiento durante múltiples ciclos de reloj
        #600000;

        // Finalizar simulación
        //$stop;
    end

    // Monitorear cambios en señales clave
    initial begin
        $monitor("Time: %0t | PC: %h | VGA_R: %h, VGA_G: %h, VGA_B: %h | VGA_HS: %b, VGA_VS: %b",
                 $time, uut.pc, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS);
    end

endmodule