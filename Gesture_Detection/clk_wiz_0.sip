set_global_assignment -entity "clk_wiz_0" -library "lib_clk_wiz_0" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_wiz_0" -library "lib_clk_wiz_0" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "clk_wiz_0" -library "lib_clk_wiz_0" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_wiz_0" -name SPD_FILE [file join $::quartus(sip_path) "clk_wiz_0.spd"]

set_global_assignment -library "lib_clk_wiz_0" -name MISC_FILE [file join $::quartus(sip_path) "clk_wiz_0_sim/clk_wiz_0.vo"]
