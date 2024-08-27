## Generated SDC file "aluPara.out.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

## DATE    "Tue Aug 27 01:28:58 2024"

##
## DEVICE  "5CSXFC6D6F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {selector} -period 10.000 -waveform { 0.000 5.000 } [get_ports {selector}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {selector}] -rise_to [get_clocks {selector}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {selector}] -rise_to [get_clocks {selector}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {selector}] -fall_to [get_clocks {selector}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {selector}] -fall_to [get_clocks {selector}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {selector}] -rise_to [get_clocks {selector}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {selector}] -rise_to [get_clocks {selector}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {selector}] -fall_to [get_clocks {selector}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {selector}] -fall_to [get_clocks {selector}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

