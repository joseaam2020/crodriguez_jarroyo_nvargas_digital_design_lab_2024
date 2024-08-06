transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/genne/OneDrive/Escritorio/taller_digitales/sumador_vhdl/sumador_vhdl.vhd}

vcom -93 -work work {C:/Users/genne/OneDrive/Escritorio/taller_digitales/sumador_vhdl/sumador_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  sumador_tb

add wave *
view structure
view signals
run -all
