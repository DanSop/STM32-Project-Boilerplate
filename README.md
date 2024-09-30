# STM32 Boilerplate Project

This project provides a boilerplate setup for various STM32 MCUs using submodules to incorporate the ST HAL, CMSIS Device, and CMSIS Core libraries. 
I created this template to provide a simple and lightweight starting point for embedded development, free from the overheads of IDE specific configurations and files.
It simply uses a Makefile for compilation in either debug or release mode.

The goal is to support multiple STM32 series devices (H7, F7, L4, etc.) within each branch. The project is currently set up with an example for the STM32H743x, but additional MCU series will be supported in the future.

## Features

- **Makefile Build System**: Easily build in Debug or Release modes.
- **Git Submodules**: Pull in STM32 HAL, CMSIS Core, and CMSIS Device files from their source.
- **Structured Project Layout**: Separate common files, components, and third-party libraries.
- **Startup & Linker Script**: Flexibility in choosing the correct startup assembly file and linker script for your device via the CMSIS files.

## Project Structure

- Consists of a Common folder for storing commonly used or shared files.
- Components folder for structure modularity when multiple systems are present.
- Core folder for the main application files.
- Third_Party folder to include HAL, CMSIS Core, and CMSIS Device files as submodules.


```
stm32-boilerplate/
├── Common/
├── Components/
├── Core/
│   ├── Include/
│       └── stm32xxxx_hal_conf.h
├── Libraries/
├── Third_Party/
│   ├── cmsis_core/
│   ├── cmsis_device_hxx/
│   │   └── Source/
│   │       └── Templates/
│   │           └── gcc/
│   │               ├── startup files
│   │               └── linker scripts
│   └── stm32h7xx_hal_driver/
├── Makefile
```

## Getting Started

1. Clone the branch corresponding to your MCU.
2. Initialize and update submodules:
   ```
   git submodule update --init --recursive
   ```

## Configuration

### Linker Script
- Select an appropriate linker script for your device
- Template linker scripts are available in `Third_Party/cmsis_device_h7/Source/Templates/gcc/`

### Startup File
- Choose the correct startup file for your device in `Third_Party/cmsis_device_h7/Source/Templates/gcc/`

### HAL Configuration
- The STM32 HAL provides standard functionality
- Enable specific layers via the `stm32xxxx_hal_conf.h` file

### Device Definition
- Ensure the device is global definition in the makefile via `DEVICE_DEFINITION = -DSTM32XXXXxx`

## Compilation

Use the provided Makefile to compile the project:

- Debug mode: `make debug`
- Release mode: `make release`

Ensure you run `make clean` before switching builds to ensure the object files are cleaned up.

## Current Status

- Only one branch available with STM32H743x example
- Planning to expand support for Hxxx, Fxxx, and Lxxx series MCUs

## Future Plans

- Implement unit testing via Ceedling.

## Note
- This template is a work in progress. 
