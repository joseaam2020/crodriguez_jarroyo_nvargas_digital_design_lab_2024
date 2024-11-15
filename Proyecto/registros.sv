module registros (
    input  logic clk, 
    input  logic rst, 
    input  logic we3,
    input  logic [3:0] a1, 
    input  logic [3:0] a2, 
    input  logic [3:0] a3,
    input  logic [31:0] wd3,
    input  logic [31:0] r15,
    
    output logic [31:0] rd1,
    output logic [31:0] rd2
);


logic [15:0][31:0] regs;

//Leer combinacional 
always_comb begin
	case (a1)
		4'b0000: rd1 = regs[0];
		4'b0001: rd1 = regs[1];
		4'b0010: rd1 = regs[2];
		4'b0011: rd1 = regs[3];
		4'b0100: rd1 = regs[4];
		4'b0101: rd1 = regs[5];
		4'b0110: rd1 = regs[6];
		4'b0111: rd1 = regs[7];
		4'b1000: rd1 = regs[8];
		4'b1001: rd1 = regs[9];
		4'b1010: rd1 = regs[10]; 
		4'b1011: rd1 = regs[11];
		4'b1100: rd1 = regs[12];
		4'b1101: rd1 = regs[13];
		4'b1110: rd1 = regs[14];
		4'b1111: rd1 = regs[15];
		default: rd1 = regs[0];  // Valor por defecto si se sale del rango de 4 bits
	endcase

	case (a2)
		4'b0000: rd2 = regs[0];
		4'b0001: rd2 = regs[1];
		4'b0010: rd2 = regs[2];
		4'b0011: rd2 = regs[3];
		4'b0100: rd2 = regs[4];
		4'b0101: rd2 = regs[5];
		4'b0110: rd2 = regs[6];
		4'b0111: rd2 = regs[7];
		4'b1000: rd2 = regs[8];
		4'b1001: rd2 = regs[9];
		4'b1010: rd2 = regs[10]; 
		4'b1011: rd2 = regs[11];
		4'b1100: rd2 = regs[12];
		4'b1101: rd2 = regs[13];
		4'b1110: rd2 = regs[14];
		4'b1111: rd2 = regs[15];
		default: rd2 = regs[0];  // Valor por defecto si se sale del rango de 4 bits
	endcase
end

//Escribir Sequencial
always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		for (int i = 0; i < 16; i++) begin
			for (int j = 0; j < 32; j++) begin
				regs[i][j] = 0;
			end
		end
	end else if (we3) begin
		case (a3)
			4'b0000: regs[0] = wd3;
			4'b0001: regs[1] = wd3;
			4'b0010: regs[2] = wd3;
			4'b0011: regs[3] = wd3;
			4'b0100: regs[4] = wd3;
			4'b0101: regs[5] = wd3;
			4'b0110: regs[6] = wd3;
			4'b0111: regs[7] = wd3;
			4'b1000: regs[8] = wd3;
			4'b1001: regs[9] = wd3;
			4'b1010: regs[10] = wd3; 
			4'b1011: regs[11] = wd3;
			4'b1100: regs[12] = wd3;
			4'b1101: regs[13] = wd3;
			4'b1110: regs[14] = wd3;
			4'b1111: regs[15] = wd3;
			default: regs[0] = regs[0];  // Valor por defecto si se sale del rango de 4 bits
		endcase
		regs[15] = r15;
	end	else begin
		regs[15] = r15;
	end
end

endmodule