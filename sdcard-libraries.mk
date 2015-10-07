# This piece of makefile handles the creation of sdcard-libraries.tar.gz.
# These libraries are needed in order to
# cross-compile applications that use OpenCV.
#
# This is the only part of the makefile that needs root privileges to run.
# The recipe needs to mount an .ext3 file from inside the $(sdimage) file,
# and only the root may mount arbitrary filesystems.
#
# If you are sceptic about what we do here,
# you may run the commands of this recipe manually.
# The rest of the makefile should be able to handle this generation.

sdcard-libraries := sdcard-libraries.tar.gz

$(sdcard-libraries): $(sdimage)
	@if [ 0 -ne $$(id -u) ]; then \
		echo You must be root to build $(sdcard-libraries).; \
		echo See sdcard-libraries.mk for more details.; \
		exit 1; \
	fi; \
	dir=$$(mktemp -d); \
	echo Using temporary directory $$dir; \
	\
	trap 'umount $$dir/image; rm -rf $$dir' TERM INT; \
	\
	echo Extracting $(sdimage)...; \
	tar -jxf $(sdimage) --directory=$$dir \
		image-full-galileo/image-full-galileo-clanton.ext3 \
		--strip-components=1; \
	\
	echo Mounting ext3 file...; \
	mkdir $$dir/image; \
	mount -o loop $$dir/image-full-galileo-clanton.ext3 $$dir/image; \
	\
	echo Compressing libraries...; \
	libs=$$(find $$dir/image/usr/lib/ -maxdepth 1 \! -type d -printf '%f '); \
	tar zcf $(sdcard-libraries) --directory $$dir/image/usr/lib/ $$libs; \
	\
	echo Cleaning up...; \
	umount $$dir/image; \
	rm -rf $$dir; \
	\
	echo File $(sdcard-libraries) created.
