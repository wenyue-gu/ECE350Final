set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets in1_IBUF]
# clock


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

set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { led6 }]; #IO_L17P_T2_A14_D30_14 Sch=led[6]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { led7 }]; #IO_L18P_T2_A12_D28_14 Sch=led[7]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { led8 }]; #IO_L16N_T2_A15_D31_14 Sch=led[8]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { led9 }]; #IO_L14N_T2_SRCC_14 Sch=led[9]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { led10 }]; #IO_L22P_T3_A05_D21_14 Sch=led[10]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { led11 }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[11]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { LED[12] }]; #IO_L16P_T2_CSI_B_14 Sch=led[12]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { LED[13] }]; #IO_L22N_T3_A04_D20_14 Sch=led[13]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { LED[14] }]; #IO_L20N_T3_A07_D23_14 Sch=led[14]



# VGA
# Clock on E3
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Rest Signal
set_property PACKAGE_PIN N17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# VGA Port
set_property PACKAGE_PIN D8 [get_ports {VGA_B[3]}]
set_property PACKAGE_PIN D7 [get_ports {VGA_B[2]}]
set_property PACKAGE_PIN C7 [get_ports {VGA_B[1]}]
set_property PACKAGE_PIN B7 [get_ports {VGA_B[0]}]
set_property PACKAGE_PIN A6 [get_ports {VGA_G[3]}]
set_property PACKAGE_PIN B6 [get_ports {VGA_G[2]}]
set_property PACKAGE_PIN A5 [get_ports {VGA_G[1]}]
set_property PACKAGE_PIN C6 [get_ports {VGA_G[0]}]
set_property PACKAGE_PIN A4 [get_ports {VGA_R[3]}]
set_property PACKAGE_PIN C5 [get_ports {VGA_R[2]}]
set_property PACKAGE_PIN B4 [get_ports {VGA_R[1]}]
set_property PACKAGE_PIN A3 [get_ports {VGA_R[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[0]}]

# Sync Ports
set_property PACKAGE_PIN B11 [get_ports hSync]
set_property PACKAGE_PIN B12 [get_ports vSync]
set_property IOSTANDARD LVCMOS33 [get_ports hSync]
set_property IOSTANDARD LVCMOS33 [get_ports vSync]

# PS2 Stuff
set_property PACKAGE_PIN F4 [get_ports ps2_clk]
set_property PACKAGE_PIN B2 [get_ports ps2_data]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_data]

set_property MARK_DEBUG true [get_nets {score_reg[13]}]
set_property MARK_DEBUG true [get_nets {score_reg[2]}]
set_property MARK_DEBUG true [get_nets {score_reg[9]}]
set_property MARK_DEBUG true [get_nets {score_reg[15]}]
set_property MARK_DEBUG true [get_nets {score_reg[16]}]
set_property MARK_DEBUG true [get_nets {score_reg[18]}]
set_property MARK_DEBUG true [get_nets {score_reg[20]}]
set_property MARK_DEBUG true [get_nets {score_reg[21]}]
set_property MARK_DEBUG true [get_nets {score_reg[30]}]
set_property MARK_DEBUG true [get_nets {score_reg[1]}]
set_property MARK_DEBUG true [get_nets {score_reg[3]}]
set_property MARK_DEBUG true [get_nets {score_reg[4]}]
set_property MARK_DEBUG true [get_nets {score_reg[17]}]
set_property MARK_DEBUG true [get_nets {score_reg[27]}]
set_property MARK_DEBUG true [get_nets {score_reg[29]}]
set_property MARK_DEBUG true [get_nets {score_reg[5]}]
set_property MARK_DEBUG true [get_nets {score_reg[7]}]
set_property MARK_DEBUG true [get_nets {score_reg[8]}]
set_property MARK_DEBUG true [get_nets {score_reg[14]}]
set_property MARK_DEBUG true [get_nets {score_reg[22]}]
set_property MARK_DEBUG true [get_nets {score_reg[24]}]
set_property MARK_DEBUG true [get_nets {score_reg[28]}]
set_property MARK_DEBUG true [get_nets {score_reg[19]}]
set_property MARK_DEBUG true [get_nets {score_reg[0]}]
set_property MARK_DEBUG true [get_nets {score_reg[6]}]
set_property MARK_DEBUG true [get_nets {score_reg[10]}]
set_property MARK_DEBUG true [get_nets {score_reg[31]}]
set_property MARK_DEBUG true [get_nets {score_reg[11]}]
set_property MARK_DEBUG true [get_nets {score_reg[12]}]
set_property MARK_DEBUG true [get_nets {score_reg[23]}]
set_property MARK_DEBUG true [get_nets {score_reg[25]}]
set_property MARK_DEBUG true [get_nets {score_reg[26]}]

set_property MARK_DEBUG true [get_nets in1m]
set_property MARK_DEBUG true [get_nets in1_IBUF]
set_property MARK_DEBUG false [get_nets score]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {score_reg[0]} {score_reg[1]} {score_reg[2]} {score_reg[3]} {score_reg[4]} {score_reg[5]} {score_reg[6]} {score_reg[7]} {score_reg[8]} {score_reg[9]} {score_reg[10]} {score_reg[11]} {score_reg[12]} {score_reg[13]} {score_reg[14]} {score_reg[15]} {score_reg[16]} {score_reg[17]} {score_reg[18]} {score_reg[19]} {score_reg[20]} {score_reg[21]} {score_reg[22]} {score_reg[23]} {score_reg[24]} {score_reg[25]} {score_reg[26]} {score_reg[27]} {score_reg[28]} {score_reg[29]} {score_reg[30]} {score_reg[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list in1_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list in1m]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
