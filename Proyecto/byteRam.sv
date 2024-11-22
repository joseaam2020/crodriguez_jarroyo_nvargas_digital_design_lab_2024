(* keep = "true" *)
(* preserve = "true" *)
module byteRam(
    input logic clk,
    input logic rst,
    input logic [1:0] switch,
    input logic [31:0] address,       // Dirección en bytes
    input logic [7:0] byteData,       // Dato de 1 byte para escritura
    input logic [31:0] wordData,      // Dato de palabra completa (32 bits)
    input logic byteWriteEnable,      // Habilitación de escritura por byte
    input logic writeEnable,          // Habilitación de escritura completa
    output logic [2:0] vgaSignal,
    output logic [31:0] q             // Salida de datos
);


    logic [31:0] writeMux_out;        // Salida del mux de escritura
    logic [15:0] newAddress;          // Dirección en palabras (división por 4)
    logic [15:0] newAddress2;
    logic [31:0] newByteData;         // Dato actualizado en la escritura por byte
    logic [31:0] wordQ1;              // Salida completa de la RAM
    logic [31:0] wordQ2;
    logic [7:0] byteQ;                // Salida de un solo byte
    logic [31:0] address0;
    logic [31:0] address12 = 0;
    logic mayorAMax; 
    logic wren1;
    logic wren2;

    // Calcular dirección en palabras (divide por 4 al ignorar los 2 bits LSB)
    assign newAddress = address[31:2];

    // Constantes 
    parameter MAX = (2 ** 16) * 4; 
    parameter RAM1_START = 0;
    parameter RAM1_END = MAX - 1;
    parameter RAM2_START = MAX;
    parameter RAM2_END = MAX + 16'hc5c2 - 1;

    // synthesis keep
    logic inRange2;  
    assign inRange2 = (address >= RAM2_START && address <= RAM2_END);

      // Lógica de selección de RAM 
    always_comb begin
        wren1 = 0;
        wren2 = 0;
        mayorAMax = 0;
        
        if (writeEnable) begin
            if (address < MAX) begin
                wren1 = 1'b1;
            end else if (inRange2) begin
                wren2 = 1'b1;
                mayorAMax = 1'b1;
            end
        end
    end 

    assign address0 = {30'd0, switch};
    assign vgaSignal = address12[2:0];

    // Mux para seleccionar el dato a escribir
    assign writeMux_out = (byteWriteEnable) ? newByteData : wordData;

    always_comb begin
        newAddress2 = '0;
        if (mayorAMax) begin
                newAddress2 = address[31:2] - 16'h10000;  // Ajusta el cálculo si es necesario
            end
    end

    // Instancia de la RAM
    (* keep = "true" *)
    (* preserve = "true" *)
    ram newRam (
        .clock(clk),
        .address(newAddress),
        .q(wordQ1)
    );

    (* keep = "true" *)
    (* preserve = "true" *)
    ram2 newRam2 (
        .clock(clk),
        .address(newAddress2),
        .data(writeMux_out),
        .wren(wren2),
        .q(wordQ2)
    );

    // Control de actualización de address12
    always_ff @(posedge clk) begin
        if (rst) begin
            address12 <= 0;
        end else if (newAddress == 3 && writeEnable && ~mayorAMax) begin
            if (writeMux_out == 1 | writeMux_out == 0) begin
                address12 <= writeMux_out;
            end
        end
    end

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
            if (newAddress == 0) begin
                q = address0;
            end else begin
                q = (mayorAMax) ? wordQ2 : wordQ1;
            end
        end
    end

endmodule
