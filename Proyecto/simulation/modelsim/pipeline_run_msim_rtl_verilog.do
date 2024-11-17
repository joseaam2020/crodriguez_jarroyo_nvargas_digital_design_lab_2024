transcript on
if ![file isdirectory pipeline_iputf_libs] {
	file mkdir pipeline_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto/vga_pll_sim/vga_pll.vo"  
vlog "C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto/instrClk_sim/instrClk.vo"

vlog -vlog01compat -work work +incdir+C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto/ram.v}
vlog -sv -work work +incdir+C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto/byteRam.sv}

vlog -sv -work work +incdir+C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto {C:/Users/josea/Documents/SystemVerilog/crodriguez_jarroyo_nvargas_digital_design_lab_2024/Proyecto/byteRam_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  byteRam_tb

add wave *
view structure
view signals
run -all
