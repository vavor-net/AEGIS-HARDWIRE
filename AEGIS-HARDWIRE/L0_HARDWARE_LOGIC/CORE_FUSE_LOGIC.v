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
    input  wire clk,               // ساعة النظام (System Clock)
    input  wire rst_n,             // إعادة تشغيل النظام (Active Low Reset)
    input  wire ai_drive_request,  // طلب الحركة القادم من وحدة الذكاء الاصطناعي
    input  wire physical_fuse_in,  // حالة الفيوز المادي (1: سليم / 0: محروق)
    output reg  safe_motor_out     // الإشارة النهائية للمحركات
);

    // المنطق الفيزيائي الصارم:
    // الإشارة تخرج فقط إذا كان الفيوز سليماً (1) والذكاء الاصطناعي يطلب الحركة (1)
    // بمجرد احتراق الفيوز (0)، تصبح النتيجة دائماً (0) بغض النظر عن طلب الـ AI.
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            safe_motor_out <= 1'b0;
        end else begin
            // بوابة AND منطقية مدمجة في السليكون
            safe_motor_out <= ai_drive_request & physical_fuse_in;
        end
    end

endmodule