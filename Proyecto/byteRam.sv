module byteRam(
    input logic clk,
    input logic [31:0] address,       // Corregí el ancho de bits de `address` (32 bits en lugar de 33)
    input logic [7:0] byteData,
    input logic [31:0] wordData,
    input logic byteWriteEnable,
    input logic writeEnable, 

    output logic [31:0] q
);

    logic [31:0] oldQ;                // Almacena el valor leído previamente
    logic [31:0] writeMux_out;        // Salida del mux de escritura
    logic [15:0] newAddress;          // Dirección en palabras (división por 4)
    logic [31:0] newByteData;         // Dato actualizado en la escritura por byte

    // Calcular si es escritura de byte o palabra
    assign newAddress = address / 4; // Dirección en palabras (división por 4)

    // Crear un nuevo dato para la escritura por byte
    assign newByteData = (oldQ & ~(32'hFF << (address[1:0] * 8))) | (byteData << (address[1:0] * 8));

    // Mux para seleccionar el dato a escribir
    assign writeMux_out = (byteWriteEnable) ? newByteData : wordData;

    // Instancia de la RAM
    ram newRam (
        .clock(clk),
        .address(newAddress),
        .data(writeMux_out),
        .wren(writeEnable),
        .q(q)
    );

    // Guardar el valor leído previamente para actualizaciones por byte
    always_ff @(posedge clk) begin
        oldQ <= q;
    end

endmodule
