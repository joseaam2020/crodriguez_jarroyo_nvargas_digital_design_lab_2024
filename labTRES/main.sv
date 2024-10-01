module main (
	 input logic [1:0] PC,
    
    input logic [3:0] interrupt,
	 input logic Reset,
    
    output logic [2:0] Arduino,
    output logic Actualizar,
    output logic [1:0] Gano,
    output logic Reiniciar,
    output logic Reset_timer,
    input logic clk,
	 
	  
	 output logic                 VGA_CLK,
	 output logic	     [7:0]		VGA_B,
	 output logic		  [7:0]		VGA_G,
	 output logic		  [7:0]		VGA_R,
	 output logic		            VGA_HS,
	 output logic		          	VGA_VS,
	 output logic						VGA_BLANK,
	 output logic 					   VGA_SYNC,

	 

//--------------------------------------------------

//--------------------------------------------------

	
	input logic [3:0] posicion 
	
//--------------------------------------------------
	


);

logic [3:0] seconds;
logic ganador;
logic valido;
logic lleno;
logic clk_2Mhz;
logic t0;
logic [2:0][2:0][1:0] matriz_juego;
logic [2:0][2:0][1:0] old_juego;
logic jug;





//////////// VGA //////////

assign t0 = seconds ==  4'd15;

assign old_juego = matriz_juego;


FSM_Gato FSMins (

	.PC( PC),
	.t0(seconds),
	.interrupt(interrupt),
	.valido(valido),
	.todoLleno(lleno),
	.enfila(ganador),
	.Reset(Reset),
	
	.Arduino(Arduino),
	.Actualizar(Actualizar),
	.Gano(Gano),
	.Reiniciar(Reiniciar),
	.Reset_timer(Reset_timer),
	.Jug(jug),
	.clk(clk)
	
	
);	
	
TresenFila TresenFilains(

	.matriz_juego(matriz_juego),
	.ganador(ganador)

);


second_clk secs (
	.refclk(clk),
	.rst(Reset),
	.outclk_0(clk_2Mhz),
	.locked()
);

cronometer cronometerins(

	.clock(clk),
	.reset(Reset_timer),
	.seconds(seconds)


);

valido validoins(

	.juego(matriz_juego),
	.posicion(posicion),
	.valido(valido)

);

actualizar actualizarins(
	.matriz_juego(old_juego),
	.posicion(posicion),
	.Jug(jug),
	.actualizar(Actualizar)

);


vgaTest vgaTestins(

	//Input
	.MAX10_CLK1_50(clk),
	.matriz_juego(matriz_juego),
	.reset(Reset),
	
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




	
mux2to1 #(4) nuevo_mux (	
        .s(jug),
        .in(mux_in),  
        .out(resultado) 
    );






endmodule 


