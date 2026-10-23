# ==============================================================================
# Vivado Project Creation Script
# Target Design: Sensor Status Decision Unit
# Device: AMD/Xilinx Artix-7 (xc7a35tcpg236-1)
# ==============================================================================

# Use space-free junction path if available, else normalize script path
if {[file exists "D:/Engineering/Sensor_Status_Decision_Unit"]} {
    set proj_root "D:/Engineering/Sensor_Status_Decision_Unit"
} else {
    set script_dir [file dirname [file normalize [info script]]]
    set proj_root  [file normalize [file join $script_dir ".."]]
}

set proj_dir   [file join $proj_root "vivado_project"]
set proj_name  "sensor_decision_unit"

puts "=============================================================================="
puts "Creating Vivado Project: $proj_name"
puts "Project Location:        $proj_dir"
puts "=============================================================================="

# Create project directory if needed
file mkdir $proj_dir

# Create project (overwrite if exists)
create_project $proj_name $proj_dir -part xc7a35tcpg236-1 -force

# Set project properties
set_property target_language Verilog [current_project]
set_property simulator_language Verilog [current_project]
set_property default_lib work [current_project]

# Add Design Sources (wrapped in list to prevent space issues)
puts "Adding design source files..."
set src_file [file join $proj_root "src" "sensor_decision_unit.v"]
add_files -norecurse [list $src_file]
set_property top sensor_decision_unit [current_fileset]

# Add Constraints
puts "Adding constraint files..."
set xdc_file [file join $proj_root "constrs" "sensor_decision_unit_basys3.xdc"]
add_files -fileset constrs_1 -norecurse [list $xdc_file]

# Add Simulation Sources
puts "Adding simulation testbench..."
set tb_file [file join $proj_root "tb" "tb_sensor_decision_unit.v"]
add_files -fileset sim_1 -norecurse [list $tb_file]
set_property top tb_sensor_decision_unit [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

# Configure Simulation Settings
set_property -name {xsim.simulate.runtime} -value {2000ns} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.log_all_signals} -value {true} -objects [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "=============================================================================="
puts "Vivado Project Created Successfully: [file join $proj_dir ${proj_name}.xpr]"
puts "=============================================================================="
exit
