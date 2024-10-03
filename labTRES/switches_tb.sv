module switches_tb();

    // Señales del testbench
    logic [3:0]     tb_pos;      // Entrada de 1 bit
    logic [8:0]  tb_switchs;  // Entrada de 9 bits

    // Instancia del DUT (Device Under Test)
    switches uut (
        .pos(tb_pos),
        .switchs(tb_switchs)
    );

    // Proceso inicial de testbench
    initial begin
		 tb_switchs = 0;
       for (int i = 0; i < 9; i++) begin
			tb_switchs[i]= 1;
			#10;
			tb_switchs[i]= 0;
		 end

       
    end
endmodule
