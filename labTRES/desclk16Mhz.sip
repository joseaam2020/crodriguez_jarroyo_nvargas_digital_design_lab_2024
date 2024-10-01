set_global_assignment -entity "desclk16Mhz" -library "lib_desclk16Mhz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "desclk16Mhz" -library "lib_desclk16Mhz" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "desclk16Mhz" -library "lib_desclk16Mhz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_desclk16Mhz" -name SPD_FILE [file join $::quartus(sip_path) "desclk16Mhz.spd"]

set_global_assignment -library "lib_desclk16Mhz" -name MISC_FILE [file join $::quartus(sip_path) "desclk16Mhz_sim/desclk16Mhz.vo"]
