transcript on
if ![file isdirectory tictac_iputf_libs] {
	file mkdir tictac_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES/vga_pll_sim/vga_pll.vo"      
vlog "C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES/second_clk_sim/second_clk.vo"

vlog -sv -work work +incdir+C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES {C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES/actualizar.sv}

vlog -sv -work work +incdir+C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES {C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES/tb_actualizar.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_actualizar

add wave *
view structure
view signals
run -all
