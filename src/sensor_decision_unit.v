// ============================================================================
// Module Name:  sensor_decision_unit
// Description:  Combinational logic-based decision unit that classifies an
//               8-bit sensor input into three status categories:
//               - NORMAL   (0  to 49)  : Normal LED ON
//               - WARNING  (50 to 79)  : Warning LED ON
//               - CRITICAL (80 to 255) : Critical LED ON + Alarm ON
//
// Target Tool:  AMD/Xilinx Vivado (Verilog HDL)
// Standard:     IEEE 1364-2001 / IEEE 1364-2005
// ============================================================================

`timescale 1ns / 1ps

module sensor_decision_unit (
    input  wire [7:0] sensor_val,    // 8-bit sensor reading (0 to 255)
    output reg        normal_led,    // Active-high LED for NORMAL condition
    output reg        warning_led,   // Active-high LED for WARNING condition
    output reg        critical_led,  // Active-high LED for CRITICAL condition
    output reg        alarm          // Active-high Alarm signal under CRITICAL condition
);

    // ========================================================================
    // Threshold Parameters
    // ========================================================================
    // 0  to 49  : NORMAL
    // 50 to 79  : WARNING
    // 80 to 255 : CRITICAL
    localparam [7:0] NORMAL_UPPER_BOUND  = 8'd49;
    localparam [7:0] WARNING_UPPER_BOUND = 8'd79;

    // ========================================================================
    // Pure Combinational Decision Logic
    // ========================================================================
    always @(*) begin
        // Default assignments to prevent inadvertent latch generation
        normal_led   = 1'b0;
        warning_led  = 1'b0;
        critical_led = 1'b0;
        alarm        = 1'b0;

        if (sensor_val <= NORMAL_UPPER_BOUND) begin
            // ----------------------------------------------------------------
            // Category: NORMAL (0 - 49)
            // Normal LED ON, other indicators OFF
            // ----------------------------------------------------------------
            normal_led   = 1'b1;
            warning_led  = 1'b0;
            critical_led = 1'b0;
            alarm        = 1'b0;
        end
        else if (sensor_val <= WARNING_UPPER_BOUND) begin
            // ----------------------------------------------------------------
            // Category: WARNING (50 - 79)
            // Warning LED ON, other indicators OFF
            // ----------------------------------------------------------------
            normal_led   = 1'b0;
            warning_led  = 1'b1;
            critical_led = 1'b0;
            alarm        = 1'b0;
        end
        else begin
            // ----------------------------------------------------------------
            // Category: CRITICAL (80 - 255)
            // Critical LED ON and Alarm ON, other indicators OFF
            // ----------------------------------------------------------------
            normal_led   = 1'b0;
            warning_led  = 1'b0;
            critical_led = 1'b1;
            alarm        = 1'b1;
        end
    end

endmodule
