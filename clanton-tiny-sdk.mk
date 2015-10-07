# This piece of makefile handles the creation of the directory /opt/clanton-tiny,
# which contains cross-compilers and libraries.
#
# The variable CLANTON_DIR holds the directory in which the cross-compilers
# and its friends will be installed.
# By default, it points to /opt/clanton-tiny/1.4.2/sysroots,
# and thus to run the rule for 'install-clanton-tiny-sdk' we need root privileges.
# However, the user may set this to (say) ./sysroots
# and copy the directory afterwards,
# so in this case the rule can run without root privileges.

CLANTON_DIR := /opt/clanton-tiny/1.4.2/sysroots

.PHONY: install-clanton-tiny-sdk
install-clanton-tiny-sdk: $(arduino_ide) $(sdcard-libraries)
	if [ ! -d /usr/include/opencv2 -a ! -d /usr/local/include/opencv2 ]; then \
		echo The makefile uses the OpenCV headers from your distribution; \
		echo to setup the build environment. Please install them,; \
		echo either in /usr/include or /usr/local/include.; \
		exit 1;\
	fi
	mkdir -p $(CLANTON_DIR)
	tar -Jxf $(arduino_ide) --directory $(CLANTON_DIR) \
		arduino-1.6.0+Intel/hardware/tools/i586/sysroots/ --strip-components=5
	tar -zxf $(sdcard-libraries) \
		--directory $(CLANTON_DIR)/i586-poky-linux-uclibc/usr/lib
	if [ ! -d /usr/include/opencv2 ]; then \
		cp -r /usr/local/include/opencv /usr/local/include/opencv2 \
			$(CLANTON_DIR)/i586-poky-linux-uclibc/usr/include; \
	else \
		cp -r /usr/include/opencv /usr/include/opencv2 \
			$(CLANTON_DIR)/i586-poky-linux-uclibc/usr/include; \
	fi
	echo Adjusting symbolic links; \
	cd $(CLANTON_DIR)/i586-poky-linux-uclibc/usr/lib; \
	for file in libopencv_*.2.4.3 libz.so.1.2.7; do \
		link=$$(echo $$file | sed 's/.[0-9].[0-9].[0-9]$$//'); \
		if [ ! -e "$$link" ]; then \
			ln -s $$file $$link; \
		fi; \
	done
