// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Fri Oct 23 20:35:48 2026
// Host        : DESKTOP-HMHP2BT running 64-bit major release  (build 9200)
// Command     : write_verilog -force D:/Engineering/Sensor_Status_Decision_Unit/reports/sensor_decision_unit_netlist.v
// Design      : sensor_decision_unit
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NORMAL_UPPER_BOUND = "8'b00110001" *) (* WARNING_UPPER_BOUND = "8'b01001111" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module sensor_decision_unit
   (sensor_val,
    normal_led,
    warning_led,
    critical_led,
    alarm);
  input [7:0]sensor_val;
  output normal_led;
  output warning_led;
  output critical_led;
  output alarm;

  wire alarm;
  wire alarm_OBUF;
  wire critical_led;
  wire normal_led;
  wire normal_led_OBUF;
  wire normal_led_OBUF_inst_i_2_n_0;
  wire [7:0]sensor_val;
  wire [7:1]sensor_val_IBUF;
  wire warning_led;
  wire warning_led_OBUF;

  OBUF alarm_OBUF_inst
       (.I(alarm_OBUF),
        .O(alarm));
  OBUF critical_led_OBUF_inst
       (.I(alarm_OBUF),
        .O(critical_led));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hEEEA)) 
    critical_led_OBUF_inst_i_1
       (.I0(sensor_val_IBUF[7]),
        .I1(sensor_val_IBUF[6]),
        .I2(sensor_val_IBUF[5]),
        .I3(sensor_val_IBUF[4]),
        .O(alarm_OBUF));
  OBUF normal_led_OBUF_inst
       (.I(normal_led_OBUF),
        .O(normal_led));
  LUT3 #(
    .INIT(8'h02)) 
    normal_led_OBUF_inst_i_1
       (.I0(normal_led_OBUF_inst_i_2_n_0),
        .I1(sensor_val_IBUF[7]),
        .I2(sensor_val_IBUF[6]),
        .O(normal_led_OBUF));
  LUT5 #(
    .INIT(32'h7777777F)) 
    normal_led_OBUF_inst_i_2
       (.I0(sensor_val_IBUF[5]),
        .I1(sensor_val_IBUF[4]),
        .I2(sensor_val_IBUF[2]),
        .I3(sensor_val_IBUF[3]),
        .I4(sensor_val_IBUF[1]),
        .O(normal_led_OBUF_inst_i_2_n_0));
  IBUF \sensor_val_IBUF[1]_inst 
       (.I(sensor_val[1]),
        .O(sensor_val_IBUF[1]));
  IBUF \sensor_val_IBUF[2]_inst 
       (.I(sensor_val[2]),
        .O(sensor_val_IBUF[2]));
  IBUF \sensor_val_IBUF[3]_inst 
       (.I(sensor_val[3]),
        .O(sensor_val_IBUF[3]));
  IBUF \sensor_val_IBUF[4]_inst 
       (.I(sensor_val[4]),
        .O(sensor_val_IBUF[4]));
  IBUF \sensor_val_IBUF[5]_inst 
       (.I(sensor_val[5]),
        .O(sensor_val_IBUF[5]));
  IBUF \sensor_val_IBUF[6]_inst 
       (.I(sensor_val[6]),
        .O(sensor_val_IBUF[6]));
  IBUF \sensor_val_IBUF[7]_inst 
       (.I(sensor_val[7]),
        .O(sensor_val_IBUF[7]));
  OBUF warning_led_OBUF_inst
       (.I(warning_led_OBUF),
        .O(warning_led));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0010001F)) 
    warning_led_OBUF_inst_i_1
       (.I0(sensor_val_IBUF[5]),
        .I1(sensor_val_IBUF[4]),
        .I2(sensor_val_IBUF[6]),
        .I3(sensor_val_IBUF[7]),
        .I4(normal_led_OBUF_inst_i_2_n_0),
        .O(warning_led_OBUF));
endmodule
