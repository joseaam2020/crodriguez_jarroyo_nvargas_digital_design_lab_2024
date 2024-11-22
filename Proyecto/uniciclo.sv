module uniciclo(
    input logic clk,
    input logic rst,
    input logic [1:0] switch,

	output logic VGA_CLK,
	output logic [7:0] VGA_B,
	output logic [7:0] VGA_G,
	output logic [7:0] VGA_R,
	output logic VGA_HS,
	output logic VGA_VS,
	output logic VGA_BLANK,
	output logic VGA_SYNC
);

//Creacion PC
logic [31:0] pc = 0;

//Creacion de instrRegMux
logic [3:0] regSrc;
logic [3:0] ra1;
logic [3:0] ra2;
logic [3:0] ra3;


//Creacion de memorio de instrucciones
logic [31:0] instruccionActual;
logic instruccionClk;

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
logic [3:0] aluFlags;

//Creacion de la memoria de datos
logic memWrite;
logic byteWrite;
logic memClk;
logic [2:0] vgaSignal;
logic [31:0] readData;

//Creacion de modulo VGA
logic vgaSelector;
logic x_cond;
logic y_cond;
logic [31:0] address;
logic [18:0] x;
logic [18:0] y;
logic [2:0][7:0] rgb;


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

unidadControl uc (
    //Inputs
    .clk(clk),
    .reset(rst),
    .cond(instruccionActual[31:28]),
    .op(instruccionActual[27:26]),
    .funct(instruccionActual[25:20]),
    .rd(instruccionActual[15:12]),
    .mulBits(instruccionActual[7:4]),
    .aluFlags(aluFlags),

    //outputs
    .pcSrc(pcSrc),
    .regSrc(regSrc),
    .memtoReg(memtoReg),
    .memWrite(memWrite),
    .byteWrite(byteWrite),
    .aluControl(aluControl),
    .aluSrc(aluSrc),
    .regWrite(regWrite)
);

logic [1:0][3:0] instrRegMux_in;
assign instrRegMux_in[0] = instruccionActual[3:0];
assign instrRegMux_in[1] = instruccionActual[15:12];
mux #(.S(1),.N(4)) instrRegMux(
    .s(regSrc[2]),
    .in(instrRegMux_in),
    .out(ra2)
);


logic [3:0][3:0] instrRegMux1_in;
assign instrRegMux1_in[0] = instruccionActual[19:16];
assign instrRegMux1_in[1] = 4'b1111;
assign instrRegMux1_in[2] = instruccionActual[11:8];
mux #(.S(2),.N(4)) instrRegMux1(
    .s(regSrc[1:0]),
    .in(instrRegMux1_in),
    .out(ra1)
);

logic [1:0][3:0] instrRegMux2_in;
assign instrRegMux2_in[0] = instruccionActual[15:12];
assign instrRegMux2_in[1] = instruccionActual[19:16];
mux #(.S(1),.N(4)) instrRegMux2(
    .s(regSrc[3]),
    .in(instrRegMux2_in),
    .out(ra3)
);

instrClk desfase (
    .refclk(clk),
    .rst(rst),
    .outclk_0(instruccionClk)
);

rom memoriaInstrucciones (
    .clock(instruccionClk),
    .address(pc[8:0]),
    .q(instruccionActual)
);

registros archivoRegistros(
    .clk(instruccionClk), 
    .rst(rst), 
    .we3(regWrite),
    .a1(ra1), 
    .a2(ra2), 
    .a3(ra3),
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
assign regExtAluMux_in[1] = extImm;
assign regExtAluMux_in[0] = writeData;
mux #(.S(4),.N(32)) regExtAluMux (
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
	.zero_flag(aluFlags[3]),
	.carry_flag(aluFlags[1]),
	.overflow_flag(aluFlags[0]),
	.negative_flag(aluFlags[2]) 
);

instrClk desfase2 (
    .refclk(instruccionClk),
    .rst(rst),
    .outclk_0(memClk)
);

assign vgaSelector = (vgaSignal > 3'd0); 

logic [1:0][31:0] muxVGAaddress_in;
logic [31:0] muxVGAaddress_out;
assign muxVGAaddress_in[0] = aluResult; 
assign muxVGAaddress_in[1] = address;
mux #(.S(1),.N(32)) muxVGAaddress(
    .s(vgaSelector),
    .in(muxVGAaddress_in),
    .out(muxVGAaddress_out)
);


logic [1:0] muxVGAaddress1_in;
logic muxVGAaddress1_out;
assign muxVGAaddress1_in[0] = byteWrite; 
assign muxVGAaddress1_in[1] = 0;
mux #(.S(1),.N(1)) muxVGAaddress1(
    .s(vgaSelector),
    .in(muxVGAaddress1_in),
    .out(muxVGAaddress1_out)
);

logic [1:0] muxVGAaddress2_in;
logic muxVGAaddress2_out;
assign muxVGAaddress2_in[0] = memWrite; 
assign muxVGAaddress2_in[1] = 0;
mux #(.S(1),.N(1)) muxVGAaddress2(
    .s(vgaSelector),
    .in(muxVGAaddress2_in),
    .out(muxVGAaddress2_out)
);

byteRam memoriaDatos(
    .clk(memClk),
    .rst(rst),
    .switch(switch),
    .address(muxVGAaddress_out),
    .byteData(writeData[7:0]),
    .wordData(writeData),
    .byteWriteEnable(muxVGAaddress1_out),
    .writeEnable(muxVGAaddress2_out),
    .vgaSignal(vgaSignal),
    .q(readData)
);

vgaTest vga (
	.MAX10_CLK1_50(memClk),
	.rgb(rgb),
	.reset(rst),

	.VGA_CLK(VGA_CLK),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK(VGA_BLANK),
	.VGA_SYNC(VGA_SYNC),
	.x(x),
	.y(y)
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
mux #(.S(4),.N(32)) muxPC (
    .s(pcSrc),
    .in(muxPC_in), //puede ser que los valores de los muxes esten mal y haya que darles vuelta
    .out(pc_)
);

logic [1:0][31:0] aluMemMux_in;
assign aluMemMux_in[0] = aluResult;
assign aluMemMux_in[1] = readData;
mux #(.S(4),.N(32)) aluMemMux (
    .s(memtoReg),
    .in(aluMemMux_in),
    .out(result)
);

always_ff @(posedge clk) begin
    if (rst) begin
        pc <= -1;  //reset
    end else begin
        if(~pc4_overflow) begin
            pc <= pc_; //En cada clock actualice pc
        end else begin
            pc <= 0;  //Si hay overflow reinicie
        end 
    end 

end

always_ff @(posedge memClk) begin 
    if (rst) begin
        address = 0;
    end else begin
        x_cond = (207 <= x) && (x <= 432);
        y_cond = (127 <= y) && (y <= 352);

        if(x_cond && y_cond && vgaSelector) begin
            if (switch == 0) begin
                address = ((x-207) + (y-127)*225)*4+16;
            end else begin
                address = ((x-207) + (y-127)*225)*4+202624;
            end
            rgb[0] = readData[7:0];
            rgb[1] = readData[15:8];
            rgb[2] = readData[23:16];
        end else begin
            rgb[0] = 8'd0;
            rgb[1] = 8'd0;
            rgb[2] = 8'd0;
            address = 0;
        end
    end 
end


endmodule
