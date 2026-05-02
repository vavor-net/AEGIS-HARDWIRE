/* * --------------------------------------------------------------------------
 * PROJECT: AEGIS-HARDWIRE (HSG-Protocol)
 * AUTHOR: Ahmed Mohamed Abdelmabood
 * ORGANIZATION: VAVOR.NET
 * LICENSE: Apache License 2.0
 * * ANY MODIFICATION OR DISTRIBUTION OF THIS FILE MUST RETAIN THIS HEADER.
 * FOR COMMERCIAL USE, ATTRIBUTION TO THE AUTHOR AND PLATFORM IS MANDATORY.
 * --------------------------------------------------------------------------
 * Description: Hardware-level gate to prevent motor execution if the 
 * physical safety fuse is blown or tampered with.
 */

module CORE_FUSE_LOGIC (
    input  wire clk,               //   (System Clock)
    input  wire rst_n,             //  (Active Low Reset)
    input  wire ai_drive_request,  //The movement request coming from the artificial intelligence unit
    input  wire physical_fuse_in,  // Physical fuse status (1: intact / 0: blown)
    output reg  safe_motor_out     // Final signal for engines
);

// Strict physical logic:

// The signal only comes out if the fuse is intact (1) and the AI ​​is requesting movement (1)

// Once the fuse blows (0), the result is always (0) regardless of the AI's request.
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            safe_motor_out <= 1'b0;
        end else begin
            //Integrated silicon AND logic gate
            safe_motor_out <= ai_drive_request & physical_fuse_in;
        end
    end

endmodule
