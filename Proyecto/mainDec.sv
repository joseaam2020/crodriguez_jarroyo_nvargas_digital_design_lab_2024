module mainDec(
    input logic [1:0] op,
    input logic [5:0] funct,

    output logic branch,
    output logic regW,
    output logic memW,
    output logic [3:0] memtoReg,
    output logic [3:0] aluSrc,
    output logic [3:0] regSrc,
    output logic aluOp
);
 
always_comb begin
    branch = 0;
    regW = 0;
    memW = 0;
    memtoReg = 0;
    aluSrc = 0;
    regSrc = 0;
    aluOp = 0;

    if (op == 2'b00) begin // instrucciones de datos
        if (funct[5] == 0) begin 
            aluSrc = 4'b0000; 
        end else begin 
            aluSrc = 4'b0001; 
        end
        branch = 0;
        memtoReg = 4'b0000;
        memW = 0;
        regW = 1;
        regSrc = 4'b0000;
        aluOp = 1;
    end else if (op == 2'b01) begin // instrucciones de memoria
        if (funct[0] == 1'b0) begin
            // STR
            memW = 1;
            regW = 0;
        end else begin
            // LDR
            memW = 0;
            regW = 1;
        end
        branch = 0;
        memtoReg = 4'b0001; 
        aluSrc = 4'b0001;
        regSrc = 4'b0010;
        aluOp = 0;
    end else if (op == 2'b10) begin //branch
        branch = 1;
        memtoReg = 0;
        memW = 0;
        aluSrc = 1;
        regW = 0;
        regSrc = 4'b0001;
        aluOp = 0;
    end
end
endmodule