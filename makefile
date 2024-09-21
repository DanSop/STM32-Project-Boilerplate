# Project Name
TARGET = STM32_Project_Boilerplate

# Device Configuration
LINKER_SCRIPT_FLASH = STM32H743_FLASH.ld
CMSIS_DEVICE_AS = Third_Party/cmsis_device_h7/Source/Templates/gcc/startup_stm32h743xx.s
DEVICE_DEFINITION = -DSTM32H743xx

# Global definitions (if needed)
GLOBAL_MACRO = -DGLOBAL_DEFINE

# Compiler and tools
CC = arm-none-eabi-gcc
CXX = arm-none-eabi-g++
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# Compiler flags
BASE_CFLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Wall
ASFLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16
DEBUG_CFLAGS = -g -O0
RELEASE_CFLAGS = -O2
LDFLAGS = -specs=nosys.specs -mcpu=cortex-m7 -mthumb -mfloat-abi=hard -mfpu=fpv5-sp-d16 -Wl,--gc-sections
MAKEFLAGS += -s

# Libraries
LIB_DIRS = Libraries
LIBS = -lm

# Directories
BUILD_DIR = Build
STARTUP_SRC = Core/Startup
CORE_SRC = Core/Source
CMSIS_DEVICE_SRC = Third_Party/cmsis_device_h7/Source/Templates/system_stm32h7xx.c
COMPONENTS_SRC = Components
COMMON_SRC = Common

# Include directories
CORE_INC = Core/Include
CMSIS_CORE_INC = Third_Party/cmsis_core/Core/Include
CMSIS_DEVICE_INC = Third_Party/cmsis_device_h7/Include
HAL_DRIVER_INC = Third_Party/stm32h7xx_hal_driver/Inc
COMPONENTS_INC = Components
COMMON_INC = Common

# HAL driver source files
HAL_DRIVER_SRC = $(wildcard Third_Party/stm32h7xx_hal_driver/Src/*.c)

# Timebase selection
# Using a timer based implementation (stm32h7xx_hal_timebase_tim_template.c)
# Alternatives:
# 1. RTC Wakeup: Useful for low power applications or to wake up the device periodically
# 2. RTC Alarm: Good for scheduling specific wake up times
HAL_DRIVER_SRC := $(filter-out Third_Party/stm32h7xx_hal_driver/Src/stm32h7xx_hal_timebase_rtc_wakeup_template.c, $(HAL_DRIVER_SRC))
HAL_DRIVER_SRC := $(filter-out Third_Party/stm32h7xx_hal_driver/Src/stm32h7xx_hal_timebase_rtc_alarm_template.c, $(HAL_DRIVER_SRC))

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

# Targets
all: debug

debug: CFLAGS := -DFLASH_BUILD $(BASE_CFLAGS) $(DEBUG_CFLAGS) $(DEVICE_DEFINITION) $(MACRO_DEFINITIONS)
debug: $(BUILD_DIR)/$(TARGET)_DEBUG.elf

release: CFLAGS := -DFLASH_BUILD $(BASE_CFLAGS) $(RELEASE_CFLAGS) $(DEVICE_DEFINITION) $(MACRO_DEFINITIONS)
release: $(BUILD_DIR)/$(TARGET)_RELEASE.elf

# Linking for Debug and Release
$(BUILD_DIR)/$(TARGET)_DEBUG.elf: $(OBJ)
	@echo "\nLinking for Flash (Debug)... \n"
	@$(CC) $(OBJ) $(LDFLAGS) -T$(LINKER_SCRIPT_FLASH) -o $@ $(addprefix -L, $(LIB_DIRS)) $(LIBS)
	@$(SIZE) $@
	@$(MAKE) show_size ELF_FILE=$@

$(BUILD_DIR)/$(TARGET)_RELEASE.elf: $(OBJ)
	@echo "\nLinking for Flash (Release)... \n"
	@$(CC) $(OBJ) $(LDFLAGS) -T$(LINKER_SCRIPT_FLASH) -o $@ $(addprefix -L, $(LIB_DIRS)) $(LIBS)
	@$(SIZE) $@
	@$(MAKE) show_size ELF_FILE=$@

# Show the memory breakdown as extra
show_size:
	@echo ""
	@echo "---------------- Memory Usage Breakdown ----------------"
	@$(SIZE) -B $(ELF_FILE) | awk '{if (NR==2) {print "Text (Flash):\t" $$1 " bytes"; print "Data (RAM):\t" $$2 " bytes"; print "BSS (RAM):\t" $$3 " bytes"; print "Total Size:\t" $$4 " bytes"}}'
	@echo "--------------------------------------------------------\n"

# Compilation
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "Compiling $< ..."
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	@echo "Assembling $< ..."
	@$(AS) $(ASFLAGS) -c $< -o $@

# Cleanup
clean:
	@rm -rf $(BUILD_DIR)
	@echo "Build directory cleaned."

.PHONY: all clean debug release show_size
