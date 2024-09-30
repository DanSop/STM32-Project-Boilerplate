/**
 *******************************************************************************
 * @file      led.c
 * @author    Place your author name here
 * @brief     This is the main file for blinky!
 * @copyright Place your copyright here
 *******************************************************************************
 */

//******************************************************************************
//  Include Files
//******************************************************************************

// ASSOCIATED DEFINITION
#include "led.h"

//******************************************************************************
//  Functions
//******************************************************************************

/**
 *******************************************************************************
 * @brief  Initializes default GPIO for LEDs
 * @retval N/A
 *******************************************************************************
 */
void LED_GPIO_Init(void)
{
    GPIO_InitTypeDef GPIO_InitStruct = { 0 };

    __HAL_RCC_GPIOB_CLK_ENABLE();

    GPIO_InitStruct.Pin = LD1_Pin;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
}

/**
 *******************************************************************************
 * @brief  Toggles the LED on the dev board
 * @retval N/A
 *******************************************************************************
 */
void LED_GPIO_Toggle(void)
{
    HAL_GPIO_TogglePin(LD1_GPIO_Port, LD1_Pin);
    HAL_Delay(LED_DELAY);
}

/*********************************END OF FILE**********************************/
