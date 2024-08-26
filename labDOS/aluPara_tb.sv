module aluPara_tb(); 

    parameter int N = 4;

    logic [N-1:0] a;
    logic [N-1:0] b;	
    logic selector;
    logic reset;

    logic [N-1:0] resultado;
    logic [6:0] display_selector1;
    logic [6:0] display_selector2;
    logic [6:0] display_resultado1;
    logic [6:0] display_resultado2;
    logic zero_flag;
    logic carry_flag;
    logic overflow_flag;
    logic negative_flag; 
    
    aluPara #(N) nueva_alu (	
        .a(a),
        .b(b),
        .selector(selector),
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

    initial begin

        selector = 0; a = 0; b =0;

        reset = 1;
        #1;
        reset = 0;
        #1;
        for(int i = 0; i < 10; i++) begin

            for(int a_value = 0; a_value < 4; a_value++) begin 
                a = a_value;
                for (int b_value = 0; b_value < 4; b_value++) begin
                   b = b_value; 
                   #3;
                end
            end

            selector = 1;
            #1
            selector = 0;
            #3;

        end
    end

endmodule