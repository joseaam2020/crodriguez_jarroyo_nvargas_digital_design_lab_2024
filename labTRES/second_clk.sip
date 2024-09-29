set_global_assignment -entity "second_clk" -library "lib_second_clk" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "second_clk" -library "lib_second_clk" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "second_clk" -library "lib_second_clk" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_second_clk" -name SPD_FILE [file join $::quartus(sip_path) "second_clk.spd"]

set_global_assignment -library "lib_second_clk" -name MISC_FILE [file join $::quartus(sip_path) "second_clk_sim/second_clk.vo"]
