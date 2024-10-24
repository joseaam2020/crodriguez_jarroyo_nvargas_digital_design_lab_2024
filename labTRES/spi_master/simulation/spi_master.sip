set_global_assignment -entity "spi_master" -library "lib_spi_master" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "spi_master" -library "lib_spi_master" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "spi_master" -library "lib_spi_master" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_spi_master" -name SPD_FILE [file join $::quartus(sip_path) "../spi_master.spd"]
set_global_assignment -library "lib_spi_master" -name MISC_FILE [file join $::quartus(sip_path) "../../spi_master.qsys"]

set_global_assignment -library "lib_spi_master" -name MISC_FILE [file join $::quartus(sip_path) "spi_master.v"]
