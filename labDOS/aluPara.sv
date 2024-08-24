module aluPara #(parameter N = 4) (	
	
	input logic [N-1:0] a,
	input logic [N-1:0] b,	
	input logic selector,
	input logic reset,

	output logic [N-1:0] resultado,
	output logic [6:0] display_selector1,
	output logic [6:0] display_selector2,
	output logic [6:0] display_resultado1,
	output logic [6:0] display_resultado2,
	output logic zero_flag,
	output logic carry_flag,
	output logic overflow_flag,
	output logic negative_flag 
);

	//Se define Contador
	logic we_selector;
	logic [3:0] wq_selector = 9; //write q 
	logic [3:0] q_selector;
	
	restPara #(4) contador_selector(
		.clk(selector),
		.reset(reset),
		.we(we_selector),
		.wq(wq_selector),
		.q(q_selector),
		.display1(display_selector1),
		.display2(display_selector2)
	); 

	//Se define Mux 
    logic [15:0][N-1:0] mux_in;
	
	mux16to1 #(N) nuevo_mux (	
        .s(q_selector),
        .in(mux_in),  
        .out(resultado) 
    );

	//Se define sumador	
	logic cout_sumador;
	Sumador_estructural #(N) nuevo_sumandor (
		.a(a),
		.b(b),
		.cin(1'b0),
		.cout_sumador(cout_sumador), //Hay que pegarlo a flag de carry 
		.s_sumador(mux_in[0])
	);

	//Se define restador
	logic cout_restador;
	restador #(N) nuevo_restador (
		.a(a),
		.b(b),
		.cin(1'b0),
		.cout_restador(cout_restador), //Hay que pegarlo a flag de carry 
		.s_restador(mux_in[1])
	); 

	//Se define multiplicador
	logic [(2*N)-1:0] resulto_multiplicador; 
	
	multiplicador #(N) nuevo_multiplicador(
		.a(a),
		.b(b),
		.s_multiplicador(resulto_multiplicador)
	);

	assign mux_in[2] = resulto_multiplicador[N-1:0];

	//Se definen los resultados de las otras operaciones
	assign mux_in[3] = a / b;
	assign mux_in[4] = a % b;
	assign mux_in[5] = a & b;
	assign mux_in[6] = a | b;
	assign mux_in[7] = a ^ b; 
	assign mux_in[8] = a << 1;
	assign mux_in[9] = a >> 1;

	//Se definene valores para overflow y carry
	logic cout;
	logic sumador_restador_seleccionado; 
	logic a_and_s_opuestos; 
	logic a_and_b_mismo_signo;
	logic a_and_b_opuestos;
	
	assign cout = cout_sumador | cout_restador;
	assign sumador_restador_seleccionado = (q_selector == 1 | q_selector == 0); 
	assign a_and_s_opuestos = (a[N-1] ^ mux_in[0][N-1]) | (a[N-1] ^ mux_in[1][N-1]); 
	assign a_and_b_mismo_signo = (a[N-1] ~^ b[N-1]) & (q_selector == 0);
	assign a_and_b_opuestos = (a[N-1] ^ b[N-1]) & (q_selector == 1);
	
	//Se definen flags
	assign zero_flag = (resultado == 0);
	assign carry_flag = cout & sumador_restador_seleccionado;
	assign negative_flag = resultado[N-1];
	assign overflow_flag = sumador_restador_seleccionado & a_and_s_opuestos & (a_and_b_mismo_signo | a_and_b_opuestos); 

	//Se define comportamiento para el funcionamiento del selector de operaciones 
	always_comb begin
		if (q_selector > 9) begin
			we_selector = 1;
		end else begin
			we_selector = 0;
		end	
	end
	
	//Se escribe resultado en 7 segmentos
	logic [3:0] bin_in1;
	logic [3:0] bin_in2;

	assign bin_in1 = resultado / 10;
	assign bin_in2 = resultado % 10;
		
	SevenSegmentDisplay seven1 (.binary_input(bin_in1), .display_output(display_resultado1));
	SevenSegmentDisplay seven2 (.binary_input(bin_in2), .display_output(display_resultado2));

endmodule	