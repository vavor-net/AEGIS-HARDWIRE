/*
 * PROJECT: AEGIS-HARDWIRE (HSG-Protocol)
 * AUTHOR: Ahmed Mohamed Abdelmabood
 * ORGANIZATION: VAVOR.NET
 * LICENSE: Apache License 2.0
 * * ANY MODIFICATION OR DISTRIBUTION OF THIS FILE MUST RETAIN THIS HEADER.
 * FOR COMMERCIAL USE, ATTRIBUTION TO THE AUTHOR AND PLATFORM IS MANDATORY.
 * --------------------------------------------------------------------------
 */
 * Module: POWER_GATE_SHIELD
 * Description: Physical power-cut trigger. Once triggered, it sends a 
 * high-voltage pulse to blow the eFuse.
 */

module POWER_GATE_SHIELD (
    input  wire emergency_sensor,  // Signal from an independent physical hazard sensor
    input  wire watchdog_timeout,  // A signal from the "guard dog" in case the system freezes
    output wire burn_efuse_cmd,    // The command to blow the fuse (high voltage signal)
    output wire cut_main_power     // Main power cut order
);

    // // Emergency Logic: If the sensor detects a threat or the system stops responding
   // The "Power Path Self-Destruct Protocol" is activated
   
    assign burn_efuse_cmd = emergency_sensor | watchdog_timeout;
    assign cut_main_power = ~(emergency_sensor | watchdog_timeout);

endmodule
