# Warning: ugly makefile ahead
#
# This piece of makefile handles the creation of the directory ide-stuff.

ide_stuff_files := \
	ide-stuff/AdvancedIO.h \
	ide-stuff/Stream.cpp \
	ide-stuff/AnalogIO.h \
	ide-stuff/wiring_analog.c \
	ide-stuff/interrupt.c \
	ide-stuff/WString.cpp \
	ide-stuff/IPAddress.cpp \
	ide-stuff/avr/pgmspace.h \
	ide-stuff/fast_gpio_sc.c \
	ide-stuff/Printable.h \
	ide-stuff/main.cpp \
	ide-stuff/sysfs.h \
	ide-stuff/TTYUART.h \
	ide-stuff/i2c-dev.h \
	ide-stuff/interrupt.h \
	ide-stuff/fast_gpio_nc.c \
	ide-stuff/BitsAndBytes.h \
	ide-stuff/HardwareSerial.h \
	ide-stuff/Tone.cpp \
	ide-stuff/Arduino.h \
	ide-stuff/RingBuffer.h \
	ide-stuff/Client.h \
	ide-stuff/wiring_digital.h \
	ide-stuff/fast_gpio_nc.h \
	ide-stuff/fast_gpio_common.c \
	ide-stuff/Stream.h \
	ide-stuff/Server.h \
	ide-stuff/OSAbstract.h \
	ide-stuff/wiring_digital.c \
	ide-stuff/Print.h \
	ide-stuff/WString.h \
	ide-stuff/UtilTime.cpp \
	ide-stuff/WMath.cpp \
	ide-stuff/RingBuffer.cpp \
	ide-stuff/TTYUART.cpp \
	ide-stuff/IPAddress.h \
	ide-stuff/WCharacter.h \
	ide-stuff/UtilMisc.cpp \
	ide-stuff/trace.c \
	ide-stuff/Udp.h \
	ide-stuff/fast_gpio_sc.h \
	ide-stuff/mux.c \
	ide-stuff/binary.h \
	ide-stuff/fast_gpio_common.h \
	ide-stuff/sysfs.c \
	ide-stuff/i2c.h \
	ide-stuff/trace.h \
	ide-stuff/UtilTime.h \
	ide-stuff/Mux.h \
	ide-stuff/i2c.c \
	ide-stuff/WMath.h \
	ide-stuff/Print.cpp \
	ide-stuff/pulseIn.cpp

ide_stuff_files_with_wildcard := $(subst ide-stuff,ide-stuf%,$(ide_stuff_files))

$(ide_stuff_files_with_wildcard): $(arduino_ide)
	mkdir -p ide-stuff
	tar -Jxf $(arduino_ide) --directory ide-stuff \
		arduino-1.6.0+Intel/hardware/intel/i586-uclibc/cores/arduino/ \
		--strip-components=6
	touch $(ide_stuff_files)

.PHONY: ide-stuff
ide-stuff: $(ide_stuff_files)
