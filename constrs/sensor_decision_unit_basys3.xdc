## ============================================================================
## Vivado Constraints (XDC) - Sensor Status Decision Unit
## Target Board: Digilent Basys 3 (FPGA: Artix-7 xc7a35tcpg236-1)
## ============================================================================

## ----------------------------------------------------------------------------
## Switches (8-bit Sensor Value: SW[7:0])
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN V17 [get_ports {sensor_val[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[0]}]

set_property PACKAGE_PIN V16 [get_ports {sensor_val[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[1]}]

set_property PACKAGE_PIN W16 [get_ports {sensor_val[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[2]}]

set_property PACKAGE_PIN W17 [get_ports {sensor_val[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[3]}]

set_property PACKAGE_PIN W15 [get_ports {sensor_val[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[4]}]

set_property PACKAGE_PIN V15 [get_ports {sensor_val[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[5]}]

set_property PACKAGE_PIN W14 [get_ports {sensor_val[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[6]}]

set_property PACKAGE_PIN W13 [get_ports {sensor_val[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sensor_val[7]}]

## ----------------------------------------------------------------------------
## LEDs
## Normal LED   -> LED0 (U16)
## Warning LED  -> LED1 (E19)
## Critical LED -> LED2 (U19)
## Alarm Output -> LED3 (V19)
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN U16 [get_ports {normal_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {normal_led}]

set_property PACKAGE_PIN E19 [get_ports {warning_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {warning_led}]

set_property PACKAGE_PIN U19 [get_ports {critical_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {critical_led}]

set_property PACKAGE_PIN V19 [get_ports {alarm}]
set_property IOSTANDARD LVCMOS33 [get_ports {alarm}]

## Configuration Bank Voltage Select
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
