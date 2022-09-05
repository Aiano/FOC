/**
 * @file FOC.c
 * @author Aiano_czm
 */

#include <math.h>
#include "FOC.h"
#include "FOC_conf.h"
#include "FOC_utils.h"
#include "hardware_api.h"

void FOC_init() {
    _init3PWM();
}

void FOC_SVPWM(float Uq, float Ud, float angle) {

    int sector;

    // Nice video explaining the SpaceVectorModulation (FOC_SVPWM) algorithm
    // https://www.youtube.com/watch?v=QMSWUMEAejg

    // the algorithm goes
    // 1) Ualpha, Ubeta
    // 2) Uout = sqrt(Ualpha^2 + Ubeta^2)
    // 3) angle_el = atan2(Ubeta, Ualpha)
    //
    // equivalent to 2)  because the magnitude does not change is:
    // Uout = sqrt(Ud^2 + Uq^2)
    // equivalent to 3) is
    // angle_el = angle_el + atan2(Uq,Ud)

    float Uout = _sqrt(Ud * Ud + Uq * Uq) / VOLTAGE_LIMIT; // Actually, Uout is a ratio
    angle = _normalizeAngle(angle + atan2(Uq, Ud));

    // find the sector we are in currently
    sector = floor(angle / _PI_3) + 1;
    // calculate the duty cycles
    float T1 = _SQRT3 * _sin(sector * _PI_3 - angle) * Uout;
    float T2 = _SQRT3 * _sin(angle - (sector - 1.0f) * _PI_3) * Uout;
    // two versions possible
//    float T0 = 0; // pulled to 0 - better for low power supply voltage
    float T0 = 1 - T1 - T2; // modulation_centered around driver->voltage_limit/2


    // calculate the duty cycles(times)
    float Ta, Tb, Tc;
    switch (sector) {
        case 1:
            Ta = T1 + T2 + T0 / 2;
            Tb = T2 + T0 / 2;
            Tc = T0 / 2;
            break;
        case 2:
            Ta = T1 + T0 / 2;
            Tb = T1 + T2 + T0 / 2;
            Tc = T0 / 2;
            break;
        case 3:
            Ta = T0 / 2;
            Tb = T1 + T2 + T0 / 2;
            Tc = T2 + T0 / 2;
            break;
        case 4:
            Ta = T0 / 2;
            Tb = T1 + T0 / 2;
            Tc = T1 + T2 + T0 / 2;
            break;
        case 5:
            Ta = T2 + T0 / 2;
            Tb = T0 / 2;
            Tc = T1 + T2 + T0 / 2;
            break;
        case 6:
            Ta = T1 + T2 + T0 / 2;
            Tb = T0 / 2;
            Tc = T1 + T0 / 2;
            break;
        default:
            // possible error state
            Ta = 0;
            Tb = 0;
            Tc = 0;
    }

    // Ta, Tb, Tc range [0,1]

    _writeDutyCycle3PWM(Ta, Tb, Tc);
}
