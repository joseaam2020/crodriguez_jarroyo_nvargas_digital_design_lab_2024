module tb_restador();

    parameter int N = 4;

    logic [N-1:0] a, b;
    
    logic cout_restador;
    logic [N-1:0] s_restador;

    restador #(N) uut (
        .a(a),
        .b(b), 
        .cout_restador(cout_restador),
        .s_restador(s_restador)
    );

	 
   initial begin
	 
			for(int i = 0 ; i < 16 ; i++ ) 
	 
				begin 
		
					for(int j = 0 ; j < 16 ; j++ ) 
					
						begin 
						
							a = i;
							b = j;
							
							#2;
						
						 end
						
					
				end
          
	end

endmodule

