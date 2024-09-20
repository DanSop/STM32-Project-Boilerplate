# Project Name
TARGET = STM32_Project_Boilerplate

# Device Configuration, please change this as needed
LINKER_SCRIPT_FLASH = STM32H743_FLASH.ld
CMSIS_DEVICE_AS = Third_Party/cmsis_device_h7/Source/Templates/gcc/startup_stm32h743xx.s
DEVICE_DEFINITION = -DSTM32H743xx

# Add the global definitions here if needed
GLOBAL_MACRO = -DGLOBAL_DEFINE

# Compiler and flags
CC = arm-none-eabi-gcc
CXX = arm-none-eabi-g++
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# Base Compiler flags
BASE_CFLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Wall
ASFLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16

# Debug and Release flags
DEBUG_CFLAGS = -g -O0
RELEASE_CFLAGS = -O2

# Linker flags
LDFLAGS = -specs=nosys.specs -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Wl,--gc-sections

# Library directories and flags, -lm as an example for the math library
LIB_DIRS = Libraries
LIBS = -lm

# Directories Build:
BUILD_DIR = Build

# Directories Source:
STARTUP_SRC = Core/Startup
CORE_SRC = Core/Source
CMSIS_DEVICE_SRC = Third_Party/cmsis_device_h7/Source/Templates/system_stm32h7xx.c
HAL_DRIVER_SRC = Third_Party/stm32h7xx_hal_driver/Inc
COMPONENTS_SRC = Components
COMMON_SRC = Common

# Directories Include:
CORE_INC = Core/Include
CMSIS_CORE_INC = Third_Party/cmsis_core/Core/Include
CMSIS_DEVICE_INC = Third_Party/cmsis_device_h7/Include
HAL_DRIVER_INC = Third_Party/stm32h7xx_hal_driver/Include
COMPONENTS_INC = Components
COMMON_INC = Common

# Source files
SRC_C = $(wildcard $(CORE_SRC)/*.c) \
        $(wildcard $(COMPONENTS_SRC)/*.c) \
        $(wildcard $(COMMON_SRC)/*.c) \
        $(wildcard $(HAL_DRIVER_SRC)/*.c) \
		$(wildcard $(STARTUP_SRC)/*.s) \
		$(wildcard $(STARTUP_SRC)/*.c) \
        $(CMSIS_DEVICE_SRC) \
	    $(CMSIS_DEVICE_AS)

# Include directories
INCLUDES = -I$(CORE_INC) \
           -I$(CMSIS_CORE_INC) \
           -I$(CMSIS_DEVICE_INC) \
           -I$(HAL_DRIVER_INC) \
           -I$(COMMON_INC) \
           -I$(COMPONENTS_INC)

# Object files
OBJ = $(SRC_C:%.c=$(BUILD_DIR)/%.o)
OBJ += $(SRC_S:%.s=$(BUILD_DIR)/%.o)

# Default target (Flash build)
all: debug

# Build for Flash (Debug)
debug: CFLAGS := -DFLASH_BUILD $(BASE_CFLAGS) $(DEBUG_CFLAGS) $(DEVICE_DEFINITION) $(MACRO_DEFINITIONS)
debug: $(BUILD_DIR)/$(TARGET)_DEBUG.elf

# Build for Flash (Release)
release: CFLAGS := -DFLASH_BUILD $(BASE_CFLAGS) $(RELEASE_CFLAGS) $(DEVICE_DEFINITION) $(MACRO_DEFINITIONS)
release: $(BUILD_DIR)/$(TARGET)_RELEASE.elf

# Flash build rule (Debug)
$(BUILD_DIR)/$(TARGET)_DEBUG.elf: $(OBJ)
	@echo "Linking for Flash (Debug)..."
	$(CC) $(OBJ) $(LDFLAGS) -T$(LINKER_SCRIPT_FLASH) -o $@ $(addprefix -L, $(LIB_DIRS)) $(LIBS)
	$(SIZE) $@

# Flash build rule (Release)
$(BUILD_DIR)/$(TARGET)_RELEASE.elf: $(OBJ)
	@echo "Linking for Flash (Release)..."
	$(CC) $(OBJ) $(LDFLAGS) -T$(LINKER_SCRIPT_FLASH) -o $@ $(addprefix -L, $(LIB_DIRS)) $(LIBS)
	$(SIZE) $@

# Build rules for C source files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Build rules for Assembly source files
$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean debug release
