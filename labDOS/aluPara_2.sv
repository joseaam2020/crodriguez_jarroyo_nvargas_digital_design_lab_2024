module aluPara_2 #(parameter N = 8)(
 

	input logic clk,
	input logic [N-1:0] a,
   input logic [N-1:0] b,	
   input logic selector,
	input logic reset,
	
	
	output out_reg2
	 

); 
   
	 	 
    
    
	 logic [N-1:0] resultado;
    logic [6:0] display_selector1;
    logic [6:0] display_selector2;
    logic [6:0] display_resultado1;
    logic [6:0] display_resultado2;
    logic zero_flag;
    logic carry_flag;
    logic overflow_flag;
    logic negative_flag;
	 
	 logic out_reg1_a;
	 logic out_reg1_b;
	 logic out_reg1_selector;
	 
	 
	 
	 registro #(N) reg1(
	 
			.clk(clk),
			.reset(reset),
			.D(a),
			.X(b),
			.Y(selector),
			
			.Q(out_reg1_a),
			.Z(out_reg1_b),
			.U(out_reg1_selector)
	 	 
	 );
	 

    aluPara #(N) nueva_alu (	
        
		  .a(out_reg1_a),
        .b(out_reg1_b),
        .selector(out_reg1_selector),
		  
        .reset(reset),
        .resultado(resultado),
        .display_selector1(display_selector1),
        .display_selector2(display_selector2),
        .display_resultado1(display_resultado1),
        .display_resultado2(display_resultado2),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag),
        .negative_flag(negative_flag) 
    );
	 
	 
	 
	 
	registro_S #(N) reg2(
	 
		.clk(clk),
		.reset(reset),
		.D(resultado),
		.Q(out_reg2)	 
	 	 
	);
	  
	  


endmodule