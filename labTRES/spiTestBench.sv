`timescale 1 ns / 1 ns
module spiTestBench();

 logic reset;
 logic message; 
 logic clk50Mhz;
 logic miso;

 logic sclk; //16Mhz spi clock
 logic mosi;
 logic cs;
 logic  [3:0] received;

spiTest ispi_test (

		.reset(reset),
		.message(message),
		.clk50Mhz(clk50Mhz),
		.mosi(mosi),
		.miso(miso),
		.sclk(sclk),
		.cs(cs),
		.received(received)

);

 always #10 clk50Mhz = ~clk50Mhz; //

  // Proceso de prueba
  initial begin
    // Inicialización de señales
    clk50Mhz = 0;
    reset = 0;
    message = 0;
    miso = 0;
	 mosi = 0;

    // Aplicar reset
    reset = 1;
    #100; // Espera 100 ns
    reset = 0;

    // Simulación de mensajes
    message = 1;
    miso = 1;
    #100;
    
    message = 0;
    miso = 0;
    #100;

    // Cambiar valores de message y miso para observar el comportamiento
    message = 1;
    miso = 1;
    #100;

  
  end

   
  

endmodule