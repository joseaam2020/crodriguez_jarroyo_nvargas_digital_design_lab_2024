module spiTest(

input logic reset,
input logic message, 
input logic clk50Mhz,
input logic miso,
output logic sclk, //16Mhz spi clock
output logic mosi,
output logic cs,
output [3:0] recieved

);


logic desclk;
int recieved_i = '0;


clk16Mhz iclk16Mhz (
	.refclk(clk50Mhz),
	.rst(reset),
	.outclk_0(sclk),
	.locked()
);


desclk16Mhz idesclk16Mhz(
	.refclk(sclk),
	.rst(reset),
	.outclk_0(desclk),
	.locked()
);

always_comb begin 
	mosi = desclk && message;
end

always@(posedge sclk) begin

	if(reset) begin
		cs = 0;
	end
	
	if(recieved_i > 3) begin
		recieved_i = 0;
		cs = 1;
	end 
		
	recieved[recieved_i] = miso;
	recieved_i++;
	
end




endmodule 