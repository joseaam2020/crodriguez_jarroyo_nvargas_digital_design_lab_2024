module uniciclo(
    input logic clk,
    input logic rst
);

//Creacion PC
logic [31:0] pc = 0;

//Creacion de instrRegMux
logic [3:0] regSrc;
logic [3:0] ra2;


//Creacion de memorio de instrucciones
logic [31:0] instruccionActual;

//Creacion archivo de Registros
logic regWrite;
logic [31:0] srcA;
logic [31:0] writeData;

//Creacion extensor
logic [31:0] extImm;

//Creacion regExtAluMux
logic [3:0] aluSrc;
logic [31:0] srcB;

//Creacion de la ALU
logic [3:0] aluControl;
logic [31:0] aluResult;

//Creacion de la memoria de datos
logic memWrite;
logic [31:0] readData;

//Creacion sumadorPD
logic [31:0] pc_4;
logic pc4_overflow;

//Creacion sumadorPD
logic [31:0] pc_8;
logic pc8_overflow;

//Creacion de muxPC 
logic [3:0] pcSrc;
logic [31:0] pc_;

//Creacion aluMemMux
logic [3:0] memtoReg;
logic [31:0] result;

always_comb begin
    // Inicializar todas las señales a sus valores predeterminados
    aluControl = 4'b0000;
    regWrite = 0;
    memtoReg = 0;
    memWrite = 0;
    pcSrc = 0;

    if (instruccionActual[27:26] == 2'b00) begin // instrucciones de datos
        if (instruccionActual[24:21] == 4'b0100) begin // ADD
            aluControl = 4'b0000; // add
        end else if (instruccionActual[24:21] == 4'b0010) begin // SUB
            aluControl = 4'b0001; // sub
        end
        regWrite = 1;
        memtoReg = 0;
        memWrite = 0;
        pcSrc = 0;
    end else if (instruccionActual[27:26] == 2'b01) begin // instrucciones de memoria
        aluControl = 4'b0000; // add para calcular dirección
        memtoReg = 1;
        pcSrc = 0;

        if (instruccionActual[20] == 1'b0) begin
            // STR
            memWrite = 1;
            regWrite = 0;
        end else begin
            // LDR
            memWrite = 0;
            regWrite = 1;
        end
    end
end


logic [1:0][31:0] instrRegMux_in;
assign instrRegMux_in[0] = instruccionActual[3:0];
assign instrRegMux_in[1] = instruccionActual[15:12];
mux16to1 #(4) instrRegMux(
    .s(regSrc),
    .in(instrRegMux_in),
    .out(ra2)
);

rom memoriaInstrucciones (
    .clock(clk),
    .address(pc[8:0]),
    .q(instruccionActual)
);

registros archivoRegistros(
    .clk(clk), 
    .rst(rst), 
    .we3(regWrite),
    .a1(instruccionActual[19:16]), 
    .a2(ra2), 
    .a3(instruccionActual[15:12]),
    .wd3(result),
    .r15(pc_8),
    
    .rd1(srcA),
    .rd2(writeData)
);

extensor #(.M(12), .N(32)) extend (
    .in(instruccionActual[11:0]),
    .sign_extend(1'b1),
    .out(extImm)
);

logic [1:0][31:0] regExtAluMux_in;
assign regExtAluMux_in[0] = extImm;
assign regExtAluMux_in[1] = writeData;
mux16to1 regExtAluMux (
    .s(aluSrc),
    .in(regExtAluMux_in),
    .out(srcB)
);

aluPara #(.N(32)) ALU (
	.a(srcA),
	.b(srcB),	
	.selector(aluControl),
	.resultado(aluResult),
	.display_selector1(),
	.display_selector2(),
	.display_resultado1(),
	.display_resultado2(),
	.zero_flag(),
	.carry_flag(),
	.overflow_flag(),
	.negative_flag() 
);

ram memoriaDatos(
    .address(aluResult[15:0]),
    .clock(clk),
    .data(writeData),
    .wren(memWrite),
    .q(readData)   
);

Sumador_estructural #(32) sumadorPC4 (
    .a(pc),
    .b(32'd1),
    .cin(32'd0),
    .cout_sumador(pc4_overflow),
    .s_sumador(pc_4)
);

Sumador_estructural #(32) sumadorPC8 (
    .a(pc_4),
    .b(32'd1),
    .cin(32'd0),
    .cout_sumador(pc8_overflow),
    .s_sumador(pc_8)
);

logic [1:0][31:0] muxPC_in;
assign muxPC_in[0] = pc_4;
assign muxPC_in[1] = result;
mux16to1 #(.N(32)) muxPC (
    .s(pcSrc),
    .in(muxPC_in), //puede ser que los valores de los muxes esten mal y haya que darles vuelta
    .out(pc_)
);

logic [1:0][31:0] aluMemMux_in;
assign aluMemMux_in[0] = aluResult;
assign aluMemMux_in[1] = readData;
mux16to1 #(.N(32)) aluMemMux (
    .s(memtoReg),
    .in(aluMemMux_in),
    .out(result)
);

always_ff @(posedge clk) begin
    if(~pc4_overflow) begin
        pc <= pc_; //En cada clock actualice pc
    end else begin
        pc <= 0;  //Si hay overflow reinicie
    end 
end

endmodule
