################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../utilities/fsl_assert.c \
../utilities/fsl_debug_console.c \
../utilities/fsl_str.c 

C_DEPS += \
./utilities/fsl_assert.d \
./utilities/fsl_debug_console.d \
./utilities/fsl_str.d 

OBJS += \
./utilities/fsl_assert.o \
./utilities/fsl_debug_console.o \
./utilities/fsl_str.o 


# Each subdirectory must supply rules for building sources it contributes
utilities/%.o: ../utilities/%.c utilities/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DCPU_LPC55S69JBD100 -DCPU_LPC55S69JBD100_cm33_nodsp -DCPU_LPC55S69JBD100_cm33_core1 -DSDK_OS_BAREMETAL -DSERIAL_PORT_TYPE_UART=1 -DSDK_DEBUGCONSOLE=1 -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -D__NEWLIB__ -D__MULTICORE_M33SLAVE -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\board" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\utilities" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\drivers" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\uart" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\serial_manager" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\device" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\CMSIS" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\lists" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\startup" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\source" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\lcd" -O0 -fno-common -g3 -gdwarf-4 -Wall -c -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -fmerge-constants -fmacro-prefix-map="$(<D)/"= -mcpu=cortex-m33+nodsp -mthumb -D__NEWLIB__ -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-utilities

clean-utilities:
	-$(RM) ./utilities/fsl_assert.d ./utilities/fsl_assert.o ./utilities/fsl_debug_console.d ./utilities/fsl_debug_console.o ./utilities/fsl_str.d ./utilities/fsl_str.o

.PHONY: clean-utilities

