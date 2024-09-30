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

assign t0 = seconds ==  4'd15;


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




endmodule 


