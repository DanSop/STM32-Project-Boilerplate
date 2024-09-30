/**
 *******************************************************************************
 * @file      stm32h7xx_it.c
 * @brief     Interrupt Service Routines.
 * @copyright Copyright (c) 2024 STMicroelectronics. All rights reserved.
 *******************************************************************************
 */

#include "main.h"
#include "stm32h7xx_it.h"

/**
 *******************************************************************************
 * @brief  This function handles Non maskable interrupt.
 * @retval None
 *******************************************************************************
 */
void NMI_Handler(void)
{
    while (1)
    {
    }
}

/**
 *******************************************************************************
 * @brief  This function handles Hard fault interrupt.
 * @retval None
 *******************************************************************************
 */
void HardFault_Handler(void)
{
    while (1)
    {
    }
}

/**
 *******************************************************************************
 * @brief  This function handles Memory management fault.
 * @retval None
 *******************************************************************************
 */
void MemManage_Handler(void)
{
    while (1)
    {
    }
}

/**
 *******************************************************************************
 * @brief  This function handles Pre-fetch fault, memory access fault.
 * @retval None
 *******************************************************************************
 */
void BusFault_Handler(void)
{
    while (1)
    {
    }
}

/**
 *******************************************************************************
 * @brief  This function handles Undefined instruction or illegal state.
 * @retval None
 *******************************************************************************
 */
void UsageFault_Handler(void)
{
    while (1)
    {
    }
}

/**
 *******************************************************************************
 * @brief  This function handles System service call via SWI instruction.
 * @retval None
 *******************************************************************************
 */
void SVC_Handler(void)
{
}

/**
 *******************************************************************************
 * @brief  This function handles Debug monitor.
 * @retval None
 *******************************************************************************
 */
void DebugMon_Handler(void)
{
}

/**
 *******************************************************************************
 * @brief  This function handles Pendable request for system service.
 * @retval None
 *******************************************************************************
 */
void PendSV_Handler(void)
{
}

/**
 *******************************************************************************
 * @brief  This function handles System tick timer.
 * @retval None
 *******************************************************************************
 */
void SysTick_Handler(void)
{
    HAL_IncTick();
}
