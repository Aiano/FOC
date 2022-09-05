#include "stm32_mcu.h"
#ifdef STM32

#include "main.h"

void _init3PWM(){
    HAL_GPIO_WritePin(EN_GPIO_Port, EN_Pin, GPIO_PIN_SET);

    HAL_TIM_PWM_Start(&htim1, TIM_CHANNEL_1);
    HAL_TIM_PWM_Start(&htim1, TIM_CHANNEL_2);
    HAL_TIM_PWM_Start(&htim1, TIM_CHANNEL_3);
}

/**
 * @brief write duty cycle for 3 phase motor
 * @param dc_a [0,1]
 * @param dc_b [0,1]
 * @param dc_c [0,1]
 * @param params
 */
void _writeDutyCycle3PWM(float dc_a, float dc_b, float dc_c) {
    // transform duty cycle from [0,1] to [0,_PWM_RANGE]
    __HAL_TIM_SET_COMPARE(_STM32_TIMER_HANDLE, TIM_CHANNEL_1, _PWM_RANGE*dc_a);
    __HAL_TIM_SET_COMPARE(_STM32_TIMER_HANDLE, TIM_CHANNEL_2, _PWM_RANGE*dc_b);
    __HAL_TIM_SET_COMPARE(_STM32_TIMER_HANDLE, TIM_CHANNEL_3, _PWM_RANGE*dc_c);
}

#endif