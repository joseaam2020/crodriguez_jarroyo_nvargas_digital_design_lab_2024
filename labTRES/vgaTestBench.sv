`timescale 1ns / 1ps  // 1 nanosecond time unit, 1 picosecond precision

module vgaTestBench();

//	parameter VIDEO_W	= 640;
//	parameter VIDEO_H	= 480;

	logic		          		MAX10_CLK1_50;
	logic [2:0][2:0][1:0]		matriz_juego = '{default:0};
	//logic							reset;

//////////// VGA //////////
	logic                VGA_CLK;
	logic	     [7:0]		VGA_B;
	logic		  [7:0]		VGA_G;
	logic		  [7:0]		VGA_R;
	logic		            VGA_HS;
	logic		          	VGA_VS;
	logic						VGA_BLANK;
	logic 					VGA_SYNC;
	
	

 vgaTest vga(
 
	//.reset(reset),
	.MAX10_CLK1_50(MAX10_CLK1_50),
	.VGA_CLK(VGA_CLK),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK(VGA_BLANK),
	.VGA_SYNC(VGA_SYNC)
//	.matriz_juego(matriz_juego)
	
);

always #20 MAX10_CLK1_50 = ~MAX10_CLK1_50;

initial begin 
matriz_juego[0][0] = 1;
MAX10_CLK1_50 = 0;
//reset = 0;

end


endmodule


