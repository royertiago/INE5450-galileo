sdimage = SDCard.1.0.4.tar.bz2
arduino_ide = IntelArduino-1.6.0-Linux64.txz

$(sdimage):
	wget http://downloadmirror.intel.com/24355/eng/SDCard.1.0.4.tar.bz2

$(arduino_ide):
	wget http://downloadmirror.intel.com/24783/eng/IntelArduino-1.6.0-Linux64.txz

.PHONY: download
download: $(sdimage) $(arduino_ide)

.PHONY: all
.DEFAULT_GOAL := all
all: download
