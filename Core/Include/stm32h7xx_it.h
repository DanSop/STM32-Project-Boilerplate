/**
 *******************************************************************************
 * @file      stm32h7xx_it.h
 * @brief     This file contains the headers of the interrupt handlers.
 * @copyright Copyright (c) 2024 STMicroelectronics. All rights reserved.
 *******************************************************************************
 */

#ifndef __STM32H7xx_IT_H
#define __STM32H7xx_IT_H

#ifdef __cplusplus
extern "C" {
#endif

//******************************************************************************
//  Exported Functions Prototypes
//******************************************************************************
void NMI_Handler(void);
void HardFault_Handler(void);
void MemManage_Handler(void);
void BusFault_Handler(void);
void UsageFault_Handler(void);
void SVC_Handler(void);
void DebugMon_Handler(void);
void PendSV_Handler(void);
void SysTick_Handler(void);

#ifdef __cplusplus
}
#endif

#endif // __STM32H7xx_IT_H

/*********************************END OF FILE**********************************/
