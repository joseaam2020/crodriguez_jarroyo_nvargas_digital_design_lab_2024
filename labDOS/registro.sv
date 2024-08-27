module registro #(parameter int N = 8) 

(  
    input logic clk, reset, 
	 
    input logic [N-1:0] D, X, Y, 
	 
														 // Entrada de datos
    output logic [N-1:0] Q, Z, U               // Salida de datos
);
    always_ff @(posedge clk or posedge reset) 
	 
	 begin
        
		  if (reset)
          
			 Q <= '0;     
			 
												// Si reset está en el flanco positivo, la salida se pone en 0
        else
		  
		  
            Q <= D;  // a
				Z <= X; // b
				U <= Y; // selector											  // Si no, la salida toma el valor de D
    end
	 
endmodule