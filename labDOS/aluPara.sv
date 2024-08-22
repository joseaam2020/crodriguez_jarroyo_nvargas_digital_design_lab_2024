module aluP (
	
	
	logic [3:0] a;
	logic [3:0] b;
	
	input logic selector
	
	output logic s_restador,cout_restador
	output logic s_sumador,cout_rsumador
	output logic s_multiplicador
	output logic s_division
	
	output logic shift_l
	output logic shift_r
	output logic s_and
	output logic s_or
	output logic s_xor
	
	output logic shift_r
	output logic shift_r
	
	output logic f_C
	output logic f_N
	output logic f_Z
	output logic f_V
	

)


	mux16to1 implementado(
	
        .s(s),
        .in(selector),  
        .out(out) // no sé si se deba buscar tomar todas las salidas 
		  
		  
    );

	
endmodule	