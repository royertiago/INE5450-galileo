sdimage = SDCard.1.0.4.tar.bz2
arduino_ide = IntelArduino-1.6.0-Linux64.txz

include ide-stuff.mk

$(sdimage):
	wget http://downloadmirror.intel.com/24355/eng/SDCard.1.0.4.tar.bz2

$(arduino_ide):
	wget http://downloadmirror.intel.com/24783/eng/IntelArduino-1.6.0-Linux64.txz

.PHONY: download
download: $(sdimage) $(arduino_ide)

# Directory that contains things like cross-compilers and libraries for Galileo
sysroots: $(arduino_ide)
	mkdir sysroots
	tar --directory sysroots -xJf $(arduino_ide) \
		arduino-1.6.0+Intel/hardware/tools/i586/sysroots/ --strip-components=5

.PHONY: all
.DEFAULT_GOAL := all
all: download
