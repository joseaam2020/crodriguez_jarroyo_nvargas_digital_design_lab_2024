module aluPara #(parameter N = 4) (	
	
	input logic [N-1:0] a;
	input logic [N-1:0] b;	
	input logic selector

	output logic [N-1:0] resultado;
	output logic [6:0] display_selector1;
	output logic [6:0] display_selector2;
)

	//Se define Contador
	logic reset_selector;
	logic we_selecetor;
	logic [N-1:0] wq_selector; //write q 
	logic [N-1:0] q_selector;
	
	restPara #(N) contador(
		.clk(selector),
		.reset(reset_selector),
		.we(we_selecetor)
		.wq(wq_selector),
		.q(q_selector),
		.display1(display_selector1),
		.display2(display_selector2)
	); 

	//Se define Mux 
    input logic [15:0][N-1:0] mux_in;
	
	mux16to1 #(N) nuevo_mux (	
        .s(q_selector),
        .in(mux_in),  
        .out(resultado) 
    );

	//Se define sumador	
	Sumador_estructural #(N) nuevo_sumandor (
		.a(a),
		.b(b),
		.cin(0),
		.cout_sumador(), //Hay que pegarlo a flag de carry 
		.s_sumador(mux_in[0]),
	);

	//Se define restador
	restador #(N) nuevo_restador (
		.a(a),
		.b(b),
		.cin(0),
		.cout_restador(), //Hay que pegarlo a flag de carry 
		.s_restador(mux_in[1]),
	); 

	//Se define multiplicador
	logic [(2*N)-1:0] resulto_multiplicador; 
	
	multiplicador #(N) nuevo_multiplicador(
		.a(a),
		.b(b),
		.s_multiplicador(resulto_multiplicador),
	);

	assign mux_in[2] = resulto_multiplicador[N-1:0];

	//Se definen los resultados de las otras operaciones
	assign mux_in[3] = a / b;
	assign mux_in[4] = a % b;
	assign mux_in[5] = a and b;
	assign mux_in[6] = a or b;
	assign mux_in[7] = a xor b; 
	assign mux_in[8] = a << 1;
	assign mux_in[9] = a >> 1;

	
endmodule	