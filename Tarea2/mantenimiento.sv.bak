module mantenimiento (input clk, rst, M, rst_manual,
							output [7:0] status):
							

logic to, error, en_count, rst_timer;
logic[7:0] out_mantenimiento, out_ciclos, out_mux;

FSM control(clk, rst, M, to, rst_manual, error, en_count_rst_timer);
counter mant(clk, rst, en_count, out_mantenimiento);
count ciclos(clk, rst | rst_timer, 1'b1, out_ciclos);
Mux_2_to_1 mux21 (out_mantenimiento, 8'hFF, error, out_mux);
comparator cmp(out_ciclos, 8'd200, to);
register state_reg(clk, tst, out_mux, status);