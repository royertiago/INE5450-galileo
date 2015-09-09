# Warning: ugly makefile ahead
#
# This piece of makefile handles the creation of the directory ide-stuff.
#
# This file defines three things useful for the external world.
# 1. A variable named ide_stuff_files.
# 	 This variable is the list of all files that come inside $(arduino_ide)
# 	 that we extract to the directory ide-stuff.
# 2. A rule to build each of these files.
# 	 We use GNU Makefile "magic commands" to have a single common rule
# 	 for all files, so only one long tar invocation is performed.
# 	 However, if a single file is deleted,
# 	 the same tar command must be run again...
# 3. A utility phony target "ide-stuff",
# 	 which simply depends on $(ide_stuff_files).
#
# This file assumes $(arduino_ide) is already defined.

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

# To perform the magic described in item 2,
# we will use a feature from pattern rules.
# Pattern rules are of the form
# %.o: %.c
# 	#code
# For GNU Makefiles, there is a special exception that,
# if a pattern rule have more than one target,
# then the recipe is considered to generate every target of that pattern.
# This special treatment is exactly what we need here,
# so we will forge a pattern rule to match exactly the files of ide-stuff.
#
# Pattern rules are made with percent signs.
# Every target must share a common pattern that will match the percent sign;
# since the files are very diverse, they have no obvious common pattern...
# except that they all reside within ide-stuff.
# Thus, we will forge our percent-sign-list from the list $(ide_stuff_files)
# so that the percent sign matches the directory name.
# More precisely, we will substitute ide-stuff for ide-stuf%,
# so that the percent matches exactly only the last 'f' of "stuff".
ide_stuff_files_with_wildcard := $(subst ide-stuff,ide-stuf%,$(ide_stuff_files))

# Now, to the rule itself.
# Since GNU Makefile does variable expansion first and pattern matching last,
# it is valid make the variable expand to a pattern.
#
# The last `touch` is to override the `tar`-generated timestamps,
# wich will likely be before $(arduino_ide)'s timestamp.
$(ide_stuff_files_with_wildcard): $(arduino_ide)
	mkdir -p ide-stuff
	tar -Jxf $(arduino_ide) --directory ide-stuff \
		arduino-1.6.0+Intel/hardware/intel/i586-uclibc/cores/arduino/ \
		--strip-components=6
	touch $(ide_stuff_files)

.PHONY: ide-stuff
ide-stuff: $(ide_stuff_files)
