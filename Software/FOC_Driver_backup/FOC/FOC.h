/**
 * @file FOC.h
 * @author Aiano_czm
 * @brief
 */

#ifndef FOC_DRIVER_FOC_H
#define FOC_DRIVER_FOC_H

void FOC_init();
void FOC_SVPWM(float Uq, float Ud, float angle);
#endif //FOC_DRIVER_FOC_H
