set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets in1_IBUF]
# clock
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]


# led output
# JA1
set_property PACKAGE_PIN C17 [get_ports o1] 
set_property IOSTANDARD LVCMOS33 [get_ports o1]
# JA2
set_property PACKAGE_PIN D18 [get_ports o2] 
set_property IOSTANDARD LVCMOS33 [get_ports o2]
# JD1
set_property PACKAGE_PIN H4 [get_ports o3] 
set_property IOSTANDARD LVCMOS33 [get_ports o3]
# JD2
set_property PACKAGE_PIN H1 [get_ports o4] 
set_property IOSTANDARD LVCMOS33 [get_ports o4]

# JD3
set_property PACKAGE_PIN G1 [get_ports o5] 
set_property IOSTANDARD LVCMOS33 [get_ports o5]


# button input
# JB1
set_property PACKAGE_PIN D14 [get_ports in1]
set_property IOSTANDARD LVCMOS33 [get_ports in1]
# JB2
set_property PACKAGE_PIN F16 [get_ports in2]
set_property IOSTANDARD LVCMOS33 [get_ports in2]
# JC1
set_property PACKAGE_PIN K1 [get_ports in3] 
set_property IOSTANDARD LVCMOS33 [get_ports in3]
# JC2
set_property PACKAGE_PIN F6 [get_ports in4] 
set_property IOSTANDARD LVCMOS33 [get_ports in4]

# JC3
set_property PACKAGE_PIN J2 [get_ports in5] 
set_property IOSTANDARD LVCMOS33 [get_ports in5]


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