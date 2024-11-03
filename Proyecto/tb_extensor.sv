module tb_extensor;

    parameter M = 4;
    parameter N = 8;

    logic [M-1:0] in;
    logic sign_extend;
    logic [N-1:0] out;

   
    extensor #(M, N) uut (
        .in(in),
        .sign_extend(sign_extend),
        .out(out)
    );

    initial begin
        
        in = 4'b0011;        
        sign_extend = 0;      
        #10;
        
        in = 4'b1100;         
        sign_extend = 0;      
        #10;
       
        in = 4'b0011;    
		  
        sign_extend = 1;      
        #10;
		  
       
        in = 4'b1100;         
        sign_extend = 1;      
        #10;
		  
        in = 4'b0111;         
        sign_extend = 0;      
        #10;
       
		 
        in = 4'b0111;         
        sign_extend = 1;      
        #10;
       
    end
endmodule
