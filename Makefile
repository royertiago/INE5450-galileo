SDCard.1.0.4.tar.bz2:
	wget http://downloadmirror.intel.com/24355/eng/SDCard.1.0.4.tar.bz2

IntelArduino-1.6.0-Linux64.txz:
	wget http://downloadmirror.intel.com/24783/eng/IntelArduino-1.6.0-Linux64.txz

.DEFAULT_GOAL := all
.PHONY: all
all: SDCard.1.0.4.tar.bz2 IntelArduino-1.6.0-Linux64.txz
