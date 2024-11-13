module aluDec(
    input logic [4:0] funct,
    input logic aluOp,

    output logic [3:0] aluControl,
    output logic [1:0] flagW
);
    
always_comb begin
    aluControl = 4'b0000;
    flagW = 2'b00;

    if (aluOp == 1) begin
        if(funct[4:1] == 4'b0100) begin //add
            if (funct[0] == 0) begin
                flagW = 2'b00;
            end else begin
                flagW = 2'b11;
            end
            aluControl = 4'b0000;
        end else if (funct[4:1] == 4'b0010) begin //sub
            if (funct[0] == 0) begin
                flagW = 2'b00;
            end else begin
                flagW = 2'b11;
            end
            aluControl = 4'b0001;
        end else if (funct[4:1] == 4'b0000) begin //and
            if (funct[0] == 0) begin
                flagW = 2'b00;
            end else begin
                flagW = 2'b10;
            end 
            aluControl = 4'b0101;
        end else if (funct[4:1] == 4'b1100) begin //or
            if (funct[0] == 0) begin
                flagW = 2'b00;
            end else begin
                flagW = 2'b10;
            end 
            aluControl = 4'b0110;
        end else if (funct[4:1] == 4'b1101) begin //mov
            if (funct[0] == 0) begin
                flagW = 2'b00;
            end else begin
                flagW = 2'b10;
            end 
            aluControl = 4'b1010;
        end
    end
end
endmodule