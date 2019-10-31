set_global_assignment -entity "clk_wizard" -library "lib_clk_wizard" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clk_wizard" -library "lib_clk_wizard" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "clk_wizard" -library "lib_clk_wizard" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clk_wizard" -name SPD_FILE [file join $::quartus(sip_path) "clk_wizard.spd"]

set_global_assignment -library "lib_clk_wizard" -name MISC_FILE [file join $::quartus(sip_path) "clk_wizard_sim/clk_wizard.vo"]
