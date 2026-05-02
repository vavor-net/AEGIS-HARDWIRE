/* * --------------------------------------------------------------------------
 * PROJECT: AEGIS-HARDWIRE (HSG-Protocol)
 * AUTHOR: Ahmed Mohamed Abdelmabood
 * ORGANIZATION: VAVOR.NET
 * LICENSE: Apache License 2.0
 * * ANY MODIFICATION OR DISTRIBUTION OF THIS FILE MUST RETAIN THIS HEADER.
 * FOR COMMERCIAL USE, ATTRIBUTION TO THE AUTHOR AND PLATFORM IS MANDATORY.
 * --------------------------------------------------------------------------
 * Module: L2_VITAL_CONTROL - Actuator Guard
 * Author: Ahmed M. Abdelmabood (VAVOR.NET)
 */

#include "Vitals.h"

// حدود فيزيائية صارمة لا يمكن تجاوزها برمجياً
const float MAX_VELOCITY = 1.5; // متر في الثانية
const float MAX_TORQUE = 50.0;  // نيوتن متر

void execute_safe_movement(float requested_speed, float requested_torque) {
    
    // فحص المحاذاة مع منطق L0 (الفيوز المادي)
    if (!check_l0_integrity()) {
        hard_stop_all_motors();
        return;
    }

    // فلترة الأوامر: إذا طلب الـ AI سرعة جنونية، يتم تقييدها فوراً
    float safe_speed = (requested_speed > MAX_VELOCITY) ? MAX_VELOCITY : requested_speed;
    float safe_torque = (requested_torque > MAX_TORQUE) ? MAX_TORQUE : requested_torque;

    // إرسال النبضات للمحركات (PWM Control)
    apply_pwm_signal(safe_speed, safe_torque);
}