module mainDec(
    input logic [1:0] op,
    input logic [5:0] funct,
    input logic [3:0] mulBits,

    output logic branch,
    output logic regW,
    output logic memW,
    output logic byteWrite,
    output logic [3:0] memtoReg,
    output logic [3:0] aluSrc,
    output logic [3:0] regSrc,
    output logic aluOp,
    output logic mulOp
);
 
always_comb begin
    branch = 0;
    regW = 0;
    memW = 0;
    memtoReg = 0;
    aluSrc = 0;
    regSrc = 0;
    aluOp = 0;
    mulOp = 0;
    byteWrite = 0;

    if (op == 2'b00) begin // instrucciones de datos
        if (funct[5] == 0) begin 
            aluSrc = 4'b0000; 
        end else begin 
            aluSrc = 4'b0001; 
        end
        if (funct == 0 && mulBits == 4'b1001) begin
            regSrc = 4'b1010;
            mulOp = 1;
        end else begin
            regSrc = 4'b0000;
            mulOp = 0;
        end
        branch = 0;
        memtoReg = 4'b0000;
        memW = 0;
        regW = 1;
        aluOp = 1;
        byteWrite = 0;
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
        
        if (funct[5] == 1) begin //inmediato negado
            //no inmediato
            regSrc = 4'b0000;
            aluSrc = 4'b0000;
        end else begin
            //si inmediato
            regSrc = 4'b0100;
            aluSrc = 4'b0001;
        end

        if(funct[2] == 1'b0) begin //si es solo un byte
            byteWrite = 0;
        end else begin
            byteWrite = 1;
        end
        branch = 0;
        memtoReg = 4'b0001; 
        aluOp = 0;
        mulOp = 0;
    end else if (op == 2'b10) begin //branch
        branch = 1;
        memtoReg = 0;
        memW = 0;
        aluSrc = 1;
        regW = 0;
        regSrc = 4'b0001;
        aluOp = 0;
        mulOp = 0;
        byteWrite = 0;
    end
end
endmodule