// ============================================================================
// Testbench:    tb_sensor_decision_unit
// Description:  Verification testbench for the 8-bit combinational logic
//               sensor decision unit.
// Features:     1. Explicit targeted checks for specification sample test cases:
//                  - Input 49  -> NORMAL
//                  - Input 65  -> WARNING
//                  - Input 79  -> WARNING
//                  - Input 80  -> CRITICAL + Alarm
//                  - Input 255 -> CRITICAL + Alarm
//               2. Boundary conditions: 0, 49, 50, 79, 80, 255
//               3. Full exhaustive verification sweep across all 256 input values (0-255)
//               4. Self-checking assertions with automated pass/fail count
//               5. VCD waveform dumping for waveform viewer inspection
// ============================================================================

`timescale 1ns / 1ps

module tb_sensor_decision_unit;

    // ------------------------------------------------------------------------
    // Testbench Signals
    // ------------------------------------------------------------------------
    reg  [7:0] sensor_val;
    wire       normal_led;
    wire       warning_led;
    wire       critical_led;
    wire       alarm;

    // Verification counters
    integer i;
    integer pass_count;
    integer fail_count;
    reg exp_normal;
    reg exp_warning;
    reg exp_critical;
    reg exp_alarm;

    // ------------------------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // ------------------------------------------------------------------------
    sensor_decision_unit uut (
        .sensor_val   (sensor_val),
        .normal_led   (normal_led),
        .warning_led  (warning_led),
        .critical_led (critical_led),
        .alarm        (alarm)
    );

    // ------------------------------------------------------------------------
    // Task to verify and print individual test cases
    // ------------------------------------------------------------------------
    task check_case(
        input [7:0] val,
        input [255:0] expected_state_name
    );
        reg match;
        begin
            sensor_val = val;
            #10; // Allow combinational propagation delay

            // Compute expected boolean values
            exp_normal   = (val <= 8'd49);
            exp_warning  = (val >= 8'd50) && (val <= 8'd79);
            exp_critical = (val >= 8'd80);
            exp_alarm    = (val >= 8'd80);

            match = (normal_led   === exp_normal)   &&
                    (warning_led  === exp_warning)  &&
                    (critical_led === exp_critical) &&
                    (alarm        === exp_alarm);

            if (match) begin
                pass_count = pass_count + 1;
                $display("[PASS] Input: %3d (0x%02h) | Status: %-18s | LEDs [NORM:%b WARN:%b CRIT:%b] | ALARM: %b",
                         val, val, expected_state_name, normal_led, warning_led, critical_led, alarm);
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] Input: %3d (0x%02h) | Expected: %-18s | Act: [NORM:%b WARN:%b CRIT:%b ALARM:%b] | Exp: [NORM:%b WARN:%b CRIT:%b ALARM:%b]",
                         val, val, expected_state_name, normal_led, warning_led, critical_led, alarm,
                         exp_normal, exp_warning, exp_critical, exp_alarm);
            end
        end
    endtask

    // ------------------------------------------------------------------------
    // Main Stimulus Process
    // ------------------------------------------------------------------------
    initial begin
        // Setup waveform dump for Vivado xsim and GTKWave
        $dumpfile("sensor_decision_unit_tb.vcd");
        $dumpvars(0, tb_sensor_decision_unit);

        pass_count = 0;
        fail_count = 0;
        sensor_val = 8'd0;

        $display("\n===============================================================================");
        $display("   SENSOR STATUS DECISION UNIT - VERIFICATION SUITE (VIVADO SIMULATION)");
        $display("===============================================================================");
        $display("Classification Rules:");
        $display("   NORMAL   :  0 - 49  -> Normal LED ON");
        $display("   WARNING  : 50 - 79  -> Warning LED ON");
        $display("   CRITICAL : 80 - 255 -> Critical LED ON + Alarm ON");
        $display("-------------------------------------------------------------------------------\n");

        // --------------------------------------------------------------------
        // Phase 1: Targeted Verification of Specification Sample Test Cases
        // --------------------------------------------------------------------
        $display("--- PHASE 1: TARGETED SPECIFICATION SAMPLE TEST CASES ---");
        
        // Lower boundary of NORMAL
        check_case(8'd0,   "NORMAL (Min)");
        
        // Sample Test Case 1: Input 49 -> NORMAL (Upper boundary of NORMAL)
        check_case(8'd49,  "NORMAL (Sample)");

        // Boundary transition: Input 50 -> WARNING (Lower boundary of WARNING)
        check_case(8'd50,  "WARNING (Min)");

        // Sample Test Case 2: Input 65 -> WARNING
        check_case(8'd65,  "WARNING (Sample)");

        // Sample Test Case 3: Input 79 -> WARNING (Upper boundary of WARNING)
        check_case(8'd79,  "WARNING (Sample)");

        // Sample Test Case 4: Input 80 -> CRITICAL + Alarm (Lower boundary of CRITICAL)
        check_case(8'd80,  "CRITICAL + ALARM");

        // Mid-range CRITICAL
        check_case(8'd128, "CRITICAL + ALARM");

        // Sample Test Case 5: Input 255 -> CRITICAL + Alarm (Upper boundary of CRITICAL)
        check_case(8'd255, "CRITICAL + ALARM");

        // --------------------------------------------------------------------
        // Phase 2: Full Exhaustive Verification Sweep (All 256 values: 0 to 255)
        // --------------------------------------------------------------------
        $display("\n--- PHASE 2: EXHAUSTIVE SWEEP VERIFICATION (0 TO 255) ---");
        for (i = 0; i < 256; i = i + 1) begin
            sensor_val = i[7:0];
            #5;

            exp_normal   = (i <= 49);
            exp_warning  = (i >= 50) && (i <= 79);
            exp_critical = (i >= 80);
            exp_alarm    = (i >= 80);

            if ((normal_led   !== exp_normal)   ||
                (warning_led  !== exp_warning)  ||
                (critical_led !== exp_critical) ||
                (alarm        !== exp_alarm)) begin
                fail_count = fail_count + 1;
                $display("[ERROR] Mismatch at sensor_val = %d! Actual: [%b,%b,%b,%b], Expected: [%b,%b,%b,%b]",
                         i, normal_led, warning_led, critical_led, alarm,
                         exp_normal, exp_warning, exp_critical, exp_alarm);
            end
        end

        // --------------------------------------------------------------------
        // Final Summary Report
        // --------------------------------------------------------------------
        $display("\n===============================================================================");
        $display("   VERIFICATION SUMMARY");
        $display("===============================================================================");
        $display("Targeted Test Cases Checked : %0d", pass_count);
        $display("Exhaustive Input Sweep      : 256/256 values tested");
        $display("Total Failures Detected     : %0d", fail_count);
        
        if (fail_count == 0) begin
            $display("STATUS: >>> TEST SUITE PASSED SUCCESSFULLY! ALL OUTPUTS COMPLIANT <<<");
        end else begin
            $display("STATUS: >>> TEST SUITE FAILED! INVESTIGATE MISMATCHES <<<");
        end
        $display("===============================================================================\n");

        $finish;
    end

endmodule
