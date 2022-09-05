#ifndef SELF_BALANCE_CAR_RETARGET_H
#define SELF_BALANCE_CAR_RETARGET_H

#include "stm32f1xx_hal.h"
#include <sys/stat.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif
void RetargetInit(UART_HandleTypeDef *huart);
#ifdef __cplusplus
}
#endif


int _isatty(int fd);

int _write(int fd, char *ptr, int len);

int _close(int fd);

int _lseek(int fd, int ptr, int dir);

int _read(int fd, char *ptr, int len);

int _fstat(int fd, struct stat *st);

#endif //SELF_BALANCE_CAR_RETARGET_H
