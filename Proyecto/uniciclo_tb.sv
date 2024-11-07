`timescale 1ns / 1ps

module uniciclo_tb;

    // Señales del testbench para conectar al módulo `uniciclo`
    logic clk;
    logic rst;

    // Instancia del módulo `uniciclo`
    uniciclo uut (
        .clk(clk),
        .rst(rst)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Período de reloj de 10 ns
    end

    // Proceso de reset y casos de prueba
    initial begin
        // Inicialización de señales
        rst = 1;

        // Aplicar reset al inicio
        #10;
        rst = 0;

        // Caso de prueba 1: Iniciar el sistema
        //#20;
        //rst = 1;  // Salir de reset
        //#20;
        //rst = 0;

        // Otros casos de prueba
        #100;

        // Caso de prueba 2: Simular operación normal
        // Aquí puedes agregar más lógica para observar las salidas
        // o aplicar entradas específicas si fuera necesario.

        // Simulación por un tiempo fijo
        #200;
        
        // Finaliza la simulación
        $finish;
    end

    // Monitor para observar las señales importantes
    initial begin
        $monitor("Time: %0t | PC: %h | Instruccion: %h | ALU Result: %h | Read Data: %h", 
                 $time, uut.pc, uut.instruccionActual, uut.aluResult, uut.readData);
    end

endmodule
