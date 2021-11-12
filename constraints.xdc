set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets in1_IBUF]
# clock
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]


# led output
# JA1
set_property PACKAGE_PIN C17 [get_ports o1] 
set_property IOSTANDARD LVCMOS33 [get_ports o1]

# JB1
set_property PACKAGE_PIN D14 [get_ports in1]
set_property IOSTANDARD LVCMOS33 [get_ports in1]

# LED
set_property PACKAGE_PIN V11 [get_ports led15]
set_property IOSTANDARD LVCMOS33 [get_ports led15]

set_property PACKAGE_PIN H17 [get_ports led0]
set_property IOSTANDARD LVCMOS33 [get_ports led0]

set_property PACKAGE_PIN K15 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

set_property PACKAGE_PIN J13 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property PACKAGE_PIN N14 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]

set_property PACKAGE_PIN R18 [get_ports led4]
set_property IOSTANDARD LVCMOS33 [get_ports led4]

set_property PACKAGE_PIN V17 [get_ports led5]
set_property IOSTANDARD LVCMOS33 [get_ports led5]