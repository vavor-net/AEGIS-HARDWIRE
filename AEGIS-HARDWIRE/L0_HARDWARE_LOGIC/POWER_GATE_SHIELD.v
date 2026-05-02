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
    input  wire emergency_sensor,  // إشارة من مستشعر خطر مادي مستقل
    input  wire watchdog_timeout,  // إشارة من "كلب الحراسة" في حال تجمد النظام
    output wire burn_efuse_cmd,    // أمر حرق الفيوز (إشارة الجهد العالي)
    output wire cut_main_power     // أمر قطع الطاقة الرئيسي
);

    // منطق الطوارئ: إذا استشعر المستشعر خطراً أو توقف النظام عن الاستجابة
    // يتم تفعيل "بروتوكول التدمير الذاتي لمسار الطاقة"
    
    assign burn_efuse_cmd = emergency_sensor | watchdog_timeout;
    assign cut_main_power = ~(emergency_sensor | watchdog_timeout);

endmodule