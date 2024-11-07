module mantenimiento_tb ();

// Entradas
logic clk;
logic rst;
logic M;
logic rst_manual;

//Salida
logic [7:0] status;

mantenimiento mante_tb(.clk(clk), 
							  .rst(rst), 
							  .M(M), 
							  .rst_manual(rst_manual), 
							  .status(status));

							  
initial begin
	
	rst = 1;
	rst_manual = 1;
	#1;
	
	rst = 0;
	rst_manual = 0;
	M = 0;
	
	for (int i = 0; i <= 200; i++) begin
		
		clk = 0; 
		#1; 
		
		clk = 1;
		#1;
		
		
	end
	
	#2;
	
	rst_manual = 1;
	rst = 1;
	#1;
	
	rst_manual = 0;
	rst = 0;
	#1;
	
	for (int i = 0; i < 100; i++) begin
		
		M = 1;
		
		clk = 0; 
		#1; 
		
		clk = 1;
		#1;
		
		M = 0;
		
		
	end
	
	rst = 1;

end 


endmodule
