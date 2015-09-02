# Directory that holds all the binaries needed in compiling
BIN_DIR = clanton-tiny/1.4.2/sysroots/x86_64-pokysdk-linux/usr/bin/i586-poky-linux-uclibc

CC = $(BIN_DIR)/i586-poky-linux-uclibc-gcc
CXX = $(BIN_DIR)/i586-poky-linux-uclibc-g++
AR = $(BIN_DIR)/i586-poky-linux-uclibc-ar
STRIP = $(BIN_DIR)/i586-poky-linux-uclibc-strip

CFLAGS = -m32 -march=i586 \
	--sysroot=/opt/clanton-tiny/1.4.2/sysroots/i586-poky-linux-uclibc \
	-Os -w -ffunction-sections -fdata-sections -D__ARDUINO_X86__ \
	-Xassembler -mquark-strip-lock=yes -march=i586 -m32 -DARDUINO=10600 \
	-I ide_stuff/
CXXFLAGS = $(CFLAGS) -fno-exceptions

LDFLAGS = ide_stuff/core.a \
	-Lide_stuff -lm -lpthread -lopencv_calib3d -lopencv_contrib \
	-lopencv_features2d -lopencv_flann -lopencv_legacy -lopencv_ml \
	-lopencv_nonfree -lopencv_objdetect -lopencv_photo -lopencv_video \
	-lopencv_highgui -lopencv_core -lopencv_highgui -lopencv_imgproc -lz

# The following rules compile things in ide_stuff.
# The rules assumes that we will not modify the code of that directory.
ide_stuff_c = $(wildcard ide_stuff/*.c)
ide_stuff_c_obj = $(ide_stuff_c:%.c=%.o)
ide_stuff_cpp = $(wildcard ide_stuff/*.cpp)
ide_stuff_cpp_obj = $(ide_stuff_cpp:%.cpp=%.o)
$(ide_stuff_c_obj): %.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(ide_stuff_cpp_obj): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

ide_stuff/core.a: $(ide_stuff_c_obj) $(ide_stuff_cpp_obj)
	$(warning $*)
	$(AR) rcs $@ $^

# Simplistic fake_main compiling and linking
fake_main.o: fake_main.cpp ide_stuff/core.a
	$(CXX) $(CXXFLAGS) -c -o $@ $<

fake_main.elf: fake_main.o
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)

.DEFAULT_GOAL := all
.PHONY: all
all: fake_main.elf

# Special target to strip fake_main.elf.
.PHONY: strip
strip: fake_main.elf
	$(STRIP) $<
