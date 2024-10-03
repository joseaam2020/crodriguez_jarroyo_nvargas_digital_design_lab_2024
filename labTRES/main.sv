`timescale 1 ns / 1 ns
module main (

	input  logic          [1:0]     PC, //botones para seleccionar comportamiento arduino
	input  logic 					Reset,
	input  logic 					clk, //50Mhz clock
	input  logic          [8:0]		switches, //switches de la FPGA
		 
	//////////// VGA //////////
	output logic                    VGA_CLK,
	output logic	      [7:0]		VGA_B,
	output logic		  [7:0]		VGA_G,
	output logic		  [7:0]		VGA_R,
	output logic		            VGA_HS,
	output logic		          	VGA_VS,
	output logic					VGA_BLANK,
	output logic 				    VGA_SYNC,
	 
	//////////// SPI //////////
	input  logic                    MISO,
	output logic 					MOSI,
	output logic 					SCLK,
	output logic 					CS,

	//////////// Siete Segmentos //////////
	output logic 		  [6:0]		display1,
	output logic 		  [6:0]		display2

);

//////////// Logic variables //////////
logic ganador;
logic [3:0] posicion;
logic t0;
logic valido;
logic [2:0] Arduino;
logic [2:0][2:0][1:0] matriz_juego = '{default: 2'b00}; // Initializing all elements to '00'

//////////// Switches //////////
logic [3:0] posicion_FPGA;

switches iswitches(
    .switchs(switches),       // Entrada de switches (del 1 al 9)
    .pos(posicion_FPGA)        // Salida para la posición (del 1 al 9)
); 

//////////// SPI instance //////////
logic spiReset;
logic spiMessage;
logic [3:0] posicion_Arduino;	

always@(posedge clk) begin
	if(Arduino == 0) begin
		spiReset = 0;
	end else if (Arduino == 1) begin
		spiReset = 1; #1;
		spiMessage = 0;
		spiReset = 0;
	end else begin  
		spiReset = 1; #1;
		spiMessage = 1;
		spiReset = 0;
	end
end

spiTest ispiTest(
	//input	
	.reset(spiReset),
	.message(spiMessage), 
	.clk50Mhz(clk),
	.miso(MISO),

	//output
	.sclk(SCLK), // 16Mhz spi clock
	.mosi(MOSI),
	.cs(CS),
	.received(posicion_Arduino) 

);


//////////// TodoLleno //////////
logic lleno;

todoLleno itodoLleno (
	.juego(matriz_juego), //input
	.lleno(lleno) //output
);


//////////// FSM //////////
logic Actualizar;
logic jug;
logic [1:0] Gano;
logic Reiniciar;
logic Reset_timer;

FSM_Gato FSMins (

	//Input
	.clk(clk),
	.PC(!PC),
	.t0(t0),
	.interrupt(posicion),
	.valido(valido),
	.todoLleno(lleno),
	.enfila(ganador),
	.Reset(!Reset),
	
	//Ouput
	.Arduino(Arduino),
	.Actualizar(Actualizar),
	.Gano(Gano),
	.Reiniciar(Reiniciar),
	.Reset_timer(Reset_timer),
	.Jug(jug)
	
	
);	
	
//////////// tresEnFila //////////

TresenFila TresenFilains(

	.matriz_juego(matriz_juego), //input
	.ganador(ganador) //output

);


//////////// Cronometro //////////
logic [3:0] seconds;
logic clk_2Mhz;

assign t0 = seconds == 4'd15;

second_clk secs (
	.refclk(clk), //input
	.rst(Reset), //input
	.outclk_0(clk_2Mhz), //output
	.locked()
);

cronometer cronometerins(

	.clock(clk_2Mhz), //input
	.reset(Reset_timer), //input
	.seconds(seconds) //output


);

//////////// Valido //////////

valido validoins(

	.juego(matriz_juego), //input
	.posicion(posicion), //input 
	.valido(valido) //output

);

//////////// Actualizar //////////
logic [2:0][2:0][1:0] old_juego = '{default: '0};

always_comb begin
	for(int i = 0; i < 3; i++) begin
		for(int j = 0; j < 3; j++) begin
			old_juego[i][j] = matriz_juego[i][j];
		end
	end 
end

actualizar actualizarins(
	//inputs
	.clk(clk),
	.reset(!Reset),
	.matriz_juego(old_juego),
	.posicion(posicion),
	.Jug(jug),
	.actualizar(Actualizar),		

	//outputs
	.new_juego(matriz_juego)
);


//////////// VGA Instancia //////////
vgaTest vgaTestins(

	//Input
	.MAX10_CLK1_50(clk),
	.matriz_juego(matriz_juego),
	.reset(!Reset),
	
	//Output
	.VGA_CLK(VGA_CLK),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK(VGA_BLANK),
	.VGA_SYNC(VGA_SYNC)

);

//////////// MUX Posicion //////////
logic [1:0][3:0] posicion_in;
assign posicion_in[0] = posicion_FPGA; 
assign posicion_in[1] = posicion_Arduino;

	
mux2to1 #(4) nuevo_mux (	
	.s(jug),
	.in(posicion_in),  
	.out(posicion) 
);	

//////////// Siete Segmentos Instancias //////////
logic [3:0] bin_in1;
logic [3:0] bin_in2;

assign bin_in1 = seconds % 10;
assign bin_in2 = seconds / 10;
	
SevenSegmentDisplay seven1 (.binary_input(bin_in1), .display_output(display1));
SevenSegmentDisplay seven2 (.binary_input(bin_in2), .display_output(display2));

endmodule 


