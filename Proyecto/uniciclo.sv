module uniciclo(
    input logic clk,
    input logic rst
);

//Creacion PC
logic [31:0] pc;

//Creacion de memorio de instrucciones
logic [31:0] instruccionActual;


//Creacion archivo de Registros
logic regWrite;
logic [31:0] srcA;
logic [31:0] writeData;

//Creacion extensor
logic [31:0] extImm;

//Creacion de la ALU
logic [3:0] aluControl;
logic [31:0] aluResult;

//Creacion de la memoria de datos
logic dataWrite;
logic [31:0] readData;

//Creacion sumadorPD
logic [31:0] pc_4;
logic pc4_overflow;

//Creacion sumadorPD
logic [31:0] pc_8;
logic pc8_overflow;

//Creacion de muxPC 
logic pcSrc;
logic [31:0] pc_;

//Creacion aluMemMux
logic memtoReg;
logic [31:0] result;

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
    .a2(instruccionActual[15:12]), 
    .a3(instruccionActual[15:12]),
    .wd3(result),
    .r15(pc_8),
    
    .rd1(srcA),
    .rd2(srcB)
);

extensor #(.M(12), .N(32)) extend (
    .in(instruccionActual[11:0]),
    .sign_extend(1'b1),
    .out(extImm)
);

aluPara #(.N(32)) ALU (
	.a(srcA),
	.b(extImm),	
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
    .wren(dataWrite),
    .q(readData)   
);

Sumador_estructural #(32) sumadorPC4 (
    .a(pc),
    .b(32'd4),
    .cin(32'd0),
    .cout_sumador(pc4_overflow),
    .s_sumador(pc_4)
);

Sumador_estructural #(32) sumadorPC8 (
    .a(pc_4),
    .b(32'd4),
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
        pc = pc_; //En cada clock actualice pc
    end else begin
        pc = 0;  //Si hay overflow reinicie
    end 
end

endmodule
