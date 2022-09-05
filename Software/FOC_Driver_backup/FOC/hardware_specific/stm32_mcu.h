#ifndef FOC_DRIVER_STM32_MCU_H
#define FOC_DRIVER_STM32_MCU_H

#include "hardware_api.h"
#include "tim.h"

// default pwm parameters
#define _PWM_RESOLUTION 12 // 12bit
#define _PWM_RANGE 4095.0 // 2^12 -1 = 4095
#define _PWM_FREQUENCY 25000 // 25khz
#define _PWM_FREQUENCY_MAX 50000 // 50khz

#define _STM32_TIMER_HANDLE &htim1

#endif //FOC_DRIVER_STM32_MCU_H
