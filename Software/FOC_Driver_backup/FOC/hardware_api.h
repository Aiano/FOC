#ifndef FOC_DRIVER_HARDWARE_API_H
#define FOC_DRIVER_HARDWARE_API_H

#include "FOC_utils.h"

#define STM32

void _init3PWM();

/**
 * Function setting the duty cycle to the pwm pin (ex. analogWrite())
 * - BLDC driver - 3PWM setting
 * - hardware specific
 *
 * @param dc_a  duty cycle phase A [0, 1]
 * @param dc_b  duty cycle phase B [0, 1]
 * @param dc_c  duty cycle phase C [0, 1]
 */
void _writeDutyCycle3PWM(float dc_a, float dc_b, float dc_c);

#endif //FOC_DRIVER_HARDWARE_API_H
