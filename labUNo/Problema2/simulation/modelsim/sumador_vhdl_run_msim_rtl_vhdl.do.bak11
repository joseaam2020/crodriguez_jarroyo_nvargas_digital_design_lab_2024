transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labUNo/Problema2/seven_segment.vhd}
vcom -93 -work work {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labUNo/Problema2/sumador_vhdl.vhd}

vcom -93 -work work {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labUNo/Problema2/sumador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  sumador_tb

add wave *
view structure
view signals
run -all
