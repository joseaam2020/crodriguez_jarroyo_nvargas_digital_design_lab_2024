project_new -overwrite spi_master
set_global_assignment -name "FAMILY" "Cyclone V"
set_global_assignment -name "DEVICE" "5CSXFC6D6F31C6"
set_global_assignment -name "QIP_FILE" "C:/Users/noemi/OneDrive/Documentos/Git_Repos/crodriguez_jarroyo_nvargas_digital_design_lab_2024/labTRES/spi_master/synthesis/spi_master.qip"
load_package flow
if { [catch {execute_module -tool map -args "--ini=greybox_disable_cut_checks=on --ini=cut_skip_ddr_atoms_legality_check=on --ini=disable_check_quartus_compatibility_qsys_only=on " } result] } {
	puts "Greybox netlist generation failed : $result"
	exit 1
} else {
	if { [catch {execute_module -tool eda -args "--greybox_verilog --netlist=spi_master_syn.v"} result] } {
		puts "Greybox netlist generation failed: $result"
		exit 1
	}
}
