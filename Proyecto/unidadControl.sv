module unidadControl (
    input logic clk,
    input logic reset,
    input logic [3:0] cond,
    input logic [1:0] op,
    input logic [5:0] funct,
    input logic [3:0] rd,
    input logic [3:0] aluFlags, //LSB VCNZ MSB
    
    output logic [3:0] pcSrc,
    output logic [3:0] regSrc,
    output logic [3:0] memtoReg,
    output logic memWrite,
    output logic [3:0] aluControl,
    output logic [3:0] aluSrc,
    output logic regWrite
);

logic branch;
logic regW;
logic memW;
logic aluOp;
logic [1:0] flagW;
logic [1:0] flagWrite;
logic [3:0] flags;
logic condEx;
logic pcS;

mainDec decoder (
    //inputs
    .op(op),
    .funct(funct),
    //outputs
    .branch(branch),
    .regW(regW),
    .memW(memW),
    .memtoReg(memtoReg),
    .aluSrc(aluSrc),
    .regSrc(regSrc),
    .aluOp(aluOp)
);

aluDec aluDecoder(
    //inputs
    .funct(funct[4:0]),
    .aluOp(aluOp),
    //outputs
    .aluControl(aluControl),
    .flagW(flagW)
);

assign pcS = ((rd == 15) & regW) | branch;
assign flagWrite = flagW & condEx;
assign regWrite = regW & condEx;
assign memWrite = memW & condEx;
assign pcSrc = pcS & condEx;

always_ff @(posedge clk or posedge reset) begin
    if(reset) begin
        flags <= aluFlags;
    end else begin
        if(flagWrite[1]) begin
            flags[3:2] <= aluFlags[3:2];
        end

        if (flagWrite[0])  begin
            flags[1:0] <= aluFlags[1:0];
        end
    end
end

always_comb begin
    condEx = 0;
    case (cond)
        4'b0000: condEx =   flags[3]; // Z    (equal)
        4'b0001: condEx =  ~flags[3]; //~Z    (not equal)
        4'b0010: condEx =   flags[1]; // C    (carry set)
        4'b0011: condEx =  ~flags[1]; //~C    (carry clear)
        4'b0100: condEx =   flags[2]; // N    (negative)
        4'b0101: condEx =  ~flags[2]; //~N    (positive)
        4'b0110: condEx =   flags[0]; // V    (overflow)
        4'b0111: condEx =  ~flags[0]; //~V    (notoverflow)
        4'b1000: condEx =  ~flags[3]  &   flags[1];                 //Unsigned higher
        4'b1001: condEx =   flags[3]  &  ~flags[1];                 //Unsigned lower
        4'b1010: condEx = ~(flags[2]  ^   flags[0]);                //Greater or equal
        4'b1011: condEx =   flags[2]  ^   flags[0];                 //Less than
        4'b1100: condEx =  ~flags[3]  & ~(flags[2] ^ flags[0]);     //Greater than
        4'b1101: condEx =   flags[3]  |  (flags[2] ^ flags[0]);     //Less than or equal
        4'b1110: condEx = 1;                                        //always
        default: condEx = 0;
    endcase
end

endmodule 