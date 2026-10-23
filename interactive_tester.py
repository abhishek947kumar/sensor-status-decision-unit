"""
Sensor Status Decision Unit - Interactive Hardware Tester
Simulates the combinational decision logic and provides live verification.
"""

import sys
import subprocess
import os

def classify(val: int):
    val = val & 0xFF
    if val <= 49:
        status = "NORMAL"
        normal_led = 1
        warning_led = 0
        critical_led = 0
        alarm = 0
    elif val <= 79:
        status = "WARNING"
        normal_led = 0
        warning_led = 1
        critical_led = 0
        alarm = 0
    else:
        status = "CRITICAL"
        normal_led = 0
        warning_led = 0
        critical_led = 1
        alarm = 1
    return status, normal_led, warning_led, critical_led, alarm

def display_card(val: int):
    status, n_led, w_led, c_led, alm = classify(val)
    bin_str = f"{val:08b}"
    hex_str = f"0x{val:02X}"
    
    n_icon = "🟢 [ON] " if n_led else "⚪ [OFF]"
    w_icon = "🟡 [ON] " if w_led else "⚪ [OFF]"
    c_icon = "🔴 [ON] " if c_led else "⚪ [OFF]"
    a_icon = "🚨 [ACTIVE]  " if alm else "🔕 [INACTIVE]"

    print("\n" + "=" * 65)
    print(f" SENSOR INPUT: {val} (Decimal) | {hex_str} (Hex) | {bin_str} (Binary)")
    print("=" * 65)
    print(f" Status Category : {status}")
    print(f" Normal LED      : {n_icon}  (Active for 0 to 49)")
    print(f" Warning LED     : {w_icon}  (Active for 50 to 79)")
    print(f" Critical LED    : {c_icon}  (Active for 80 to 255)")
    print(f" Alarm Output    : {a_icon}  (Active for 80 to 255)")
    print("=" * 65 + "\n")

def run_vivado_sim():
    print("\n[INFO] Launching Vivado Verilog Simulation Engine (xsim)...")
    script_path = os.path.join(os.path.dirname(__file__), "scripts", "run_sim.bat")
    subprocess.run(["cmd.exe", "/c", script_path], check=False)

def main():
    print("""
=================================================================
       SENSOR STATUS DECISION UNIT - INTERACTIVE TESTER
=================================================================
Logic Classification Rules:
  🟢 NORMAL   (0 - 49)   : Normal LED = 1, Alarm = 0
  🟡 WARNING  (50 - 79)  : Warning LED = 1, Alarm = 0
  🔴 CRITICAL (80 - 255) : Critical LED = 1, Alarm = 1
=================================================================
Commands:
  - Enter any number 0 to 255 to test that sensor reading
  - Type 'samples' to test all 5 specification sample cases
  - Type 'vivado' to run the actual Vivado Verilog simulator
  - Type 'exit' or 'q' to quit
=================================================================
""")

    while True:
        try:
            user_in = input("Enter sensor value (0-255) or command: ").strip()
            if not user_in:
                continue
            if user_in.lower() in ['exit', 'q', 'quit']:
                print("Exiting tester.")
                break
            if user_in.lower() == 'vivado':
                run_vivado_sim()
                continue
            if user_in.lower() == 'samples':
                sample_cases = [49, 65, 79, 80, 255]
                print("\n--- RUNNING SPECIFICATION SAMPLES ---")
                for s in sample_cases:
                    display_card(s)
                continue

            val = int(user_in)
            if 0 <= val <= 255:
                display_card(val)
            else:
                print(f"[ERROR] Value {val} is out of 8-bit range (0 to 255).")
        except ValueError:
            print("[ERROR] Please enter a valid integer between 0 and 255.")
        except (KeyboardInterrupt, EOFError):
            print("\nExiting.")
            break

if __name__ == "__main__":
    main()
