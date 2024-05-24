################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/fsl_clock.c \
../drivers/fsl_common.c \
../drivers/fsl_common_arm.c \
../drivers/fsl_ctimer.c \
../drivers/fsl_flexcomm.c \
../drivers/fsl_gpio.c \
../drivers/fsl_i2c.c \
../drivers/fsl_power.c \
../drivers/fsl_reset.c \
../drivers/fsl_spi.c \
../drivers/fsl_usart.c 

C_DEPS += \
./drivers/fsl_clock.d \
./drivers/fsl_common.d \
./drivers/fsl_common_arm.d \
./drivers/fsl_ctimer.d \
./drivers/fsl_flexcomm.d \
./drivers/fsl_gpio.d \
./drivers/fsl_i2c.d \
./drivers/fsl_power.d \
./drivers/fsl_reset.d \
./drivers/fsl_spi.d \
./drivers/fsl_usart.d 

OBJS += \
./drivers/fsl_clock.o \
./drivers/fsl_common.o \
./drivers/fsl_common_arm.o \
./drivers/fsl_ctimer.o \
./drivers/fsl_flexcomm.o \
./drivers/fsl_gpio.o \
./drivers/fsl_i2c.o \
./drivers/fsl_power.o \
./drivers/fsl_reset.o \
./drivers/fsl_spi.o \
./drivers/fsl_usart.o 


# Each subdirectory must supply rules for building sources it contributes
drivers/%.o: ../drivers/%.c drivers/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DCPU_LPC55S69JBD100 -DCPU_LPC55S69JBD100_cm33_nodsp -DCPU_LPC55S69JBD100_cm33_core1 -DSDK_OS_BAREMETAL -DSERIAL_PORT_TYPE_UART=1 -DSDK_DEBUGCONSOLE=1 -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -D__NEWLIB__ -D__MULTICORE_M33SLAVE -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\board" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\utilities" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\drivers" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\uart" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\serial_manager" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\device" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\CMSIS" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\component\lists" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\startup" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\source" -I"C:\Users\omara\Documents\MCUXpressoIDE_11.9.0_2144\workspace\lpc55s69_calc_starter_slave\lcd" -O0 -fno-common -g3 -gdwarf-4 -Wall -c -ffunction-sections -fdata-sections -ffreestanding -fno-builtin -fmerge-constants -fmacro-prefix-map="$(<D)/"= -mcpu=cortex-m33+nodsp -mthumb -D__NEWLIB__ -fstack-usage -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-drivers

clean-drivers:
	-$(RM) ./drivers/fsl_clock.d ./drivers/fsl_clock.o ./drivers/fsl_common.d ./drivers/fsl_common.o ./drivers/fsl_common_arm.d ./drivers/fsl_common_arm.o ./drivers/fsl_ctimer.d ./drivers/fsl_ctimer.o ./drivers/fsl_flexcomm.d ./drivers/fsl_flexcomm.o ./drivers/fsl_gpio.d ./drivers/fsl_gpio.o ./drivers/fsl_i2c.d ./drivers/fsl_i2c.o ./drivers/fsl_power.d ./drivers/fsl_power.o ./drivers/fsl_reset.d ./drivers/fsl_reset.o ./drivers/fsl_spi.d ./drivers/fsl_spi.o ./drivers/fsl_usart.d ./drivers/fsl_usart.o

.PHONY: clean-drivers

