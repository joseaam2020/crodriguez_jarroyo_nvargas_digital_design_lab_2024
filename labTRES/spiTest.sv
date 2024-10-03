module spiTest(

input logic reset,
input logic message, 
input logic clk50Mhz,
input logic miso,
output logic sclk, // 16Mhz spi clock
output logic mosi,
output logic cs,
output logic [3:0] received // Change to logic to avoid the net assignment issue

);

logic desclk;
int received_i = '0;
logic [3:0] received_reg; // Internal register to store received data

// Clock generation for 16MHz SPI clock
clk16Mhz iclk16Mhz (
	.refclk(clk50Mhz),
	.rst(reset),
	.outclk_0(sclk),
	.locked()
);

// Deserialization clock at 16MHz
desclk16Mhz idesclk16Mhz(
	.refclk(clk50Mhz),
	.rst(reset),
	.outclk_0(desclk),
	.locked()
);

// Drive MOSI with message at deserialization clock

always_comb begin
    if (reset)
        mosi = 1'b0; // Set mosi to a known state during reset
    else if (cs == 0)
		mosi = desclk && message;
    else 
		mosi = 0;
end

// Main control logic
always@(posedge sclk or posedge reset) begin
	if(reset) begin
		cs = 0;
		received_i = 0;
		received_reg = 4'b0; // Clear received register on reset
	end else begin
		if(cs == 0) begin
			if(received_i > 3) begin
				received_i = 0;
				cs = 1; // Chip select set high after 4 bits received
			end else begin
				received_reg[received_i] = miso; // Store received bits in the register
				received_i++;
			end
		end
	end
end

// Assign the internal register to the output
assign received = received_reg;

endmodule
