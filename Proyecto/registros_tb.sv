module registros_tb;

    // Señales de entrada y salida para el módulo `registros`
    logic clk;
    logic rst;
    logic we3;
    logic [3:0] a1, a2, a3;
    logic [31:0] wd3;
    logic [31:0] r15;
    logic [31:0] rd1;
    logic [31:0] rd2;

    // Instancia del módulo `registros`
    registros uut (
        .clk(clk),
        .rst(rst),
        .we3(we3),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .r15(r15),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    // Procedimiento de prueba
    initial begin
        // Inicialización de las señales
        clk = 0;
        rst = 1;
        we3 = 0;
        a1 = 4'b0000;
        a2 = 4'b0001;
        a3 = 4'b0000;
        wd3 = 32'h00000000;
        r15 = 32'h00000000;

        // Reset del módulo
        #10;
        rst = 0;

        // Escritura en regs[0]
        we3 = 1;
        a3 = 4'b0000;      // Dirección 0
        wd3 = 32'hAAAA5555; // Dato a escribir
        #10;

        // Escritura en regs[1]
        a3 = 4'b0001;      // Dirección 1
        wd3 = 32'h12345678;
        #10;

        // Escritura en regs[15] (se usará r15 después)
        a3 = 4'b1111;      // Dirección 15
        wd3 = 32'hDEADBEEF;
        #10;

        // Deshabilitar escritura y leer valores
        we3 = 0;
        a1 = 4'b0000;      // Leer regs[0]
        a2 = 4'b0001;      // Leer regs[1]
        #10;
        $display("Read rd1 (regs[0]): %h, expected: AAAA5555", rd1);
        $display("Read rd2 (regs[1]): %h, expected: 12345678", rd2);

        // Escribir un valor en r15 y verificar su actualización en regs[15]
        r15 = 32'hCAFEBABE;
        #10;
        a1 = 4'b1111; // Leer regs[15]
        #10;
        $display("Read rd1 (regs[15]): %h, expected: CAFEBABE", rd1);

        // Finalizar la simulación
        $finish;
    end

endmodule
