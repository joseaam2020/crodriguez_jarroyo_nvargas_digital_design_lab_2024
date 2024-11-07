module vgaTest(

	input logic MAX10_CLK1_50,
	input logic [2:0][7:0] rgb,
	input logic reset,

//////////// VGA //////////
	output logic VGA_CLK,
	output logic [7:0] VGA_B,
	output logic [7:0] VGA_G,
	output logic [7:0] VGA_R,
	output logic VGA_HS,
	output logic VGA_VS,
	output logic VGA_BLANK,
	output logic VGA_SYNC,
	output logic [18:0] x,
	output logic [18:0] y

);

parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;

logic VGA_CTRL_CLK;
//logic reset = 0;
//logic [2:0][2:0][1:0]		matriz_juego;

vga_pll u1(
	.rst(reset),
	.refclk(MAX10_CLK1_50),
	.outclk_0(VGA_CTRL_CLK),
	.locked()
);
	

vga_controller vga_ins(
	.iRST_n(reset),
    .iVGA_CLK(VGA_CTRL_CLK),
	.oBLANK_n(VGA_BLANK),
	.oHS(VGA_HS),
	.oVS(VGA_VS),
    .oVGA_B(VGA_B),
    .oVGA_G(VGA_G),
    .oVGA_R(VGA_R),
    .rgb(rgb),
	.x(x),
	.y(y)
);	

always_comb begin
	
	VGA_SYNC = ~VGA_BLANK;
	VGA_CLK = MAX10_CLK1_50;
	
end
							 

endmodule 