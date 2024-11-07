module imagenPrintTest(
    input logic clk,
    input logic rst,

	output logic VGA_CLK,
	output logic [7:0] VGA_B,
	output logic [7:0] VGA_G,
	output logic [7:0] VGA_R,
	output logic VGA_HS,
	output logic VGA_VS,
	output logic VGA_BLANK,
	output logic VGA_SYNC
);

logic [15:0] address;
logic [31:0] pixel; 
logic [18:0] x;
logic [18:0] y;
logic [2:0][7:0] rgb;


ram memoriaDatos(
    .address(address),
    .clock(clk),
    .data(32'd0),
    .wren(1'b0),
    .q(pixel)   
);

vgaTest vga (
	.MAX10_CLK1_50(clk),
	.rgb(rgb),
	.reset(rst),

	.VGA_CLK(VGA_CLK),
	.VGA_B(VGA_B),
	.VGA_G(VGA_G),
	.VGA_R(VGA_R),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_BLANK(VGA_BLANK),
	.VGA_SYNC(VGA_SYNC),
	.x(x),
	.y(y)
);

parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;
logic x_cond;
logic y_cond;

always_ff @(posedge clk) begin
	x_cond = (207 <= x) && (x <= 432);
	y_cond = (127 <= y) && (y <= 352);
	if(x_cond && y_cond) begin
		address <= (x-207) + (y-127)*VIDEO_H;
		rgb[0] <= pixel[15:8];
		rgb[1] <= pixel[23:16];
		rgb[2] <= pixel[31:23];
	end else begin
		rgb[0] <= 8'h4d;
		rgb[1] <= 8'd0;
		rgb[2] <= 8'd0;
	end
end

endmodule