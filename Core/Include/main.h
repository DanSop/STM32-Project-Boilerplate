/**
 *******************************************************************************
 * @file      main.h
 * @author    Place your author name here
 * @brief     This is the main header file for the STM32-Project-Boilerplate.
 * @copyright Place your copyright here
 *******************************************************************************
 */

//******************************************************************************
// Define to prevent recursive inclusion
//******************************************************************************
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

//******************************************************************************
//  Include Files
//******************************************************************************
#include "stm32h7xx_hal.h"

#define LD1_Pin GPIO_PIN_0
#define LD1_GPIO_Port GPIOB

#ifdef __cplusplus
}
#endif

#endif // __MAIN_H

/*********************************END OF FILE**********************************/
