# STM32H743 Blinky Example

This branch contains a simple blinky example for a H743 dev board. The project demonstrates how to set up and use the project template to blink an LED.

Please read through the makefile as it shows how a different device can be ran via file and macro definitions. The makefile also has an easy way to add global definitions, new libraries, new source or include directories, or adjust the compiler flags as needed.

## Project Structure

```
STM32H7xx-Blinky-Example/
├── Common/
├── Components/
├── Core/
│   ├── Inc/
│   │   ├── main.h
│   │   └── stm32h7xx_hal_conf.h
│   └── Src/
│       ├── main.c
├── Third_Party/
│   ├── cmsis_core/
│   ├── cmsis_device_h7/
│   │   └── Source/
│   │       └── Templates/
│   │           └── gcc/
│   │               ├── startup_stm32h743xx.s
│   │               └── linker scripts
│   └── stm32h7xx_hal_driver/
├── STM32H743_FLASH.ld
├── makefile
└── README.md
```

## Configuration

This project should work as is. The following configurations were set from the blank project:

#### Linker Script
* Select the appropriate linker script for STM32H743 and ensure the makefile references it correctly.
* Template linker scripts are available in `Third_Party/cmsis_device_h7/Source/Templates/gcc/`
* I choose a generated one via CubeMX `STM32H743_FLASH.ld`

#### Startup File
* Use the correct startup file for STM32H743: `startup_stm32h743xx.s`
* Located in `Third_Party/cmsis_device_h7/Source/Templates/gcc/`

#### HAL Configuration
* STM32 HAL provides standard functionality
* Enable specific layers via the `stm32h7xx_hal_conf.h` file in the `Core/Inc/` directory

#### Device Definition
* The device is globally defined in the Makefile via `DEVICE_DEFINITION = -DSTM32H743xx`
* This is already set for this application example

#### Timebase
* Ensure the correct timebase file is selected for STM32H743 via the makefile
* For a default build the `stm32h7xx_hal_timebase_tim_template.c` is selected

### Building and Running

1. Make sure you have the necessary toolchain installed (arm-none-eabi-gcc)
2. Navigate to the project directory
3. Run `make debug` or `make release` to build the project 
4. Flash the resulting binary to your STM32H743 development board via any method (I recommend using the STM32-CLI)

## Expected Behavior

Once flashed, the example will cause an LED on the STM32H743 development board to blink at a regular interval.

## Future Plans

* Unit testing implementation is planned for a future update

## Note

This is a simple project structure designed to demonstrate basic functionality with the project template. It serves as a starting point for more complex applications if desired.

If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.
