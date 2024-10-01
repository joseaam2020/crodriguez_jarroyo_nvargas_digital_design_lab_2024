set_global_assignment -entity "clk16Mhz" -library "lib_clk16Mhz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk16Mhz" -library "lib_clk16Mhz" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "clk16Mhz" -library "lib_clk16Mhz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk16Mhz" -name SPD_FILE [file join $::quartus(sip_path) "clk16Mhz.spd"]

set_global_assignment -library "lib_clk16Mhz" -name MISC_FILE [file join $::quartus(sip_path) "clk16Mhz_sim/clk16Mhz.vo"]
