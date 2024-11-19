module byteRam(
    input logic clk,
    input logic [31:0] address,       // Dirección en bytes
    input logic [7:0] byteData,       // Dato de 1 byte para escritura
    input logic [31:0] wordData,      // Dato de palabra completa (32 bits)
    input logic byteWriteEnable,      // Habilitación de escritura por byte
    input logic writeEnable,          // Habilitación de escritura completa
    output logic [31:0] q             // Salida de datos
);

    parameter MAX = (2 ** 16);

    logic [31:0] writeMux_out;        // Salida del mux de escritura
    logic [15:0] newAddress;          // Dirección en palabras (división por 4)
    logic [31:0] newByteData;         // Dato actualizado en la escritura por byte
    logic [31:0] wordQ1;               // Salida completa de la RAM
    logic [31:0] wordQ2;
    logic [7:0] byteQ;                // Salida de un solo byte
    logic mayorAMax; 
    logic wren1;
    logic wren2;

    // Calcular dirección en palabras (divide por 4 al ignorar los 2 bits LSB)
    assign newAddress = address[31:2];
    assign mayorAMax = newAddress >= MAX;
    assign wren1 = writeEnable & ~mayorAMax;
    assign wren2 = writeEnable & mayorAMax;

    // Crear un nuevo dato para la escritura por byte

    // Mux para seleccionar el dato a escribir
    assign writeMux_out = (byteWriteEnable) ? newByteData : wordData;

    // Instancia de la RAM
    ram newRam (
        .clock(clk),
        .address(newAddress),
        .data(writeMux_out),
        .wren(wren1),
        .q(wordQ1)
    );

    ram2 newRam2 (
        .clock(clk),
        .address(newAddress),
        .data(writeMux_out),
        .wren(wren2),
        .q(wordQ2)
    );

    // Selección dinámica del byte para lectura por byte
    always_comb begin
        q = 0;
        newByteData = 0;

        if (mayorAMax) begin
            newByteData = 
                (wordQ2 & ~(32'hFF << (address[1:0] * 8))) | (byteData << (address[1:0] * 8));           

            case (address[1:0])
                2'b00: byteQ = wordQ2[7:0];    // Primer byte
                2'b01: byteQ = wordQ2[15:8];   // Segundo byte
                2'b10: byteQ = wordQ2[23:16];  // Tercer byte
                2'b11: byteQ = wordQ2[31:24];  // Cuarto byte
                default: byteQ = 8'h00;       // Default (no debería ocurrir)
            endcase
        end else begin
            newByteData = 
                (wordQ1 & ~(32'hFF << (address[1:0] * 8))) | (byteData << (address[1:0] * 8));  
            case (address[1:0])
                2'b00: byteQ = wordQ1[7:0];    // Primer byte
                2'b01: byteQ = wordQ1[15:8];   // Segundo byte
                2'b10: byteQ = wordQ1[23:16];  // Tercer byte
                2'b11: byteQ = wordQ1[31:24];  // Cuarto byte
                default: byteQ = 8'h00;       // Default (no debería ocurrir)
            endcase 
        end

        if (byteWriteEnable) begin
            q = {24'b0, byteQ};
        end else begin
            if (mayorAMax) begin
                q = wordQ2;
            end else begin
                q = wordQ1;
            end
        end
    end


endmodule
