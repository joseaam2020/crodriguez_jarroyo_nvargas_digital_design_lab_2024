module registro #(parameter int N = 8) 

(  
    input logic clk, reset, 
	 
    input logic [N-1:0] D,         
														 // Entrada de datos
    output logic [N-1:0] Q                // Salida de datos
);
    always_ff @(posedge clk or posedge reset) 
	 
	 begin
        
		  if (reset)
          
			 Q <= '0;     
			 
												// Si reset está en el flanco positivo, la salida se pone en 0
        else
		  
		  
            Q <= D;     
											  // Si no, la salida toma el valor de D
    end
	 
endmodule