# ==============================================================================
# Vivado Synthesis & Implementation Script (Batch Mode)
# Target Design: Sensor Status Decision Unit
# Device: AMD/Xilinx Artix-7 (xc7a35tcpg236-1)
# ==============================================================================

if {[file exists "D:/Engineering/Sensor_Status_Decision_Unit"]} {
    set proj_root "D:/Engineering/Sensor_Status_Decision_Unit"
} else {
    set script_dir [file dirname [file normalize [info script]]]
    set proj_root  [file normalize [file join $script_dir ".."]]
}

set rpt_dir [file join $proj_root "reports"]
file mkdir $rpt_dir

puts "=============================================================================="
puts "Synthesizing Sensor Status Decision Unit..."
puts "Project Root:            $proj_root"
puts "Reports will be saved to: $rpt_dir"
puts "=============================================================================="

# Read design sources
set src_file [file join $proj_root "src" "sensor_decision_unit.v"]
set xdc_file [file join $proj_root "constrs" "sensor_decision_unit_basys3.xdc"]

read_verilog [list $src_file]
read_xdc     [list $xdc_file]

# Run synthesis
synth_design -top sensor_decision_unit -part xc7a35tcpg236-1 -flatten_hierarchy rebuilt

# Generate reports
report_utilization -file [file join $rpt_dir "utilization_synth.rpt"]
report_timing_summary -file [file join $rpt_dir "timing_synth.rpt"]

# Write synthesized gate-level netlist
write_verilog -force [file join $rpt_dir "sensor_decision_unit_netlist.v"]

puts "=============================================================================="
puts "Synthesis Completed Successfully!"
puts "Utilization Report: [file join $rpt_dir "utilization_synth.rpt"]"
puts "Netlist:            [file join $rpt_dir "sensor_decision_unit_netlist.v"]"
puts "=============================================================================="
exit
