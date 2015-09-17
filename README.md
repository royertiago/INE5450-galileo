INE5450 - C para Drivers para Dispositivos
==========================================
(_C for device drivers_)

Project of the INE5450 course.

Building
========

You need to have the cross-compiles for Clanton Tiny installed.
See the section "Installation of Clanton Tiny" bellow to see how to do this.

Also, you need some files from the Intel's Arduino SDK,
which are downloaded by the makefile to the file `IntelArduino-1.6.0-Linux.txz`.
(This file is also needed for the Clanton installation,
so if you followed the steps below, this file should be already there.)

Installation of Clanton Tiny
============================
To build our project,
you need to install the Clanton's cross-compiler and its friends.
To do so, run

    sudo make install-clanton-tiny-sdk

Don't worry: this will just download two files from Intel
and extract them to `/opt/clanton-tiny/1.4.2/sysroots`.

(Note that you also need OpenCV installed to do this.)

I do _not_ trust your makefile!
-------------------------------

I agree with you, I wouldn't either.
Here is how to do more or less without root privileges.
(You actually need root privileges to make this work,
you just do not need to trust our makefile with these privileges.)

First, run

    make download

to donwload the two files from Intel's site.
This will create the files `IntelArduino-1.6.0-Linux64.txz`
and `SDCard.1.0.4.tar.bz2`.

Some of the libraries needed to cross-compile actually reside inside
`SDCard...`, in an `.ext3` file.
The file is `image-full-galileo/image-full-galileo-clanton.ext3`;
you need to mount this file somewhere
and copy the files directly inside `(image)/usr/lib/`
to a file named `sdcard-libraries.tar.gz`.

Running

    sudo make sdcard-libraries.tar.gz

does exactly this;
the file `sdcard-libraries.mk` handles the creation of this file,
so you might want to look there to see exactly what commands are run.

(Actually, this purpose of making this file as an intermediate step
was to isolate the need for root privileges to only two phases of the makefile,
now (for the mounting) and in the last copy.)

Almost there!
There is a variable named `CLANTON_DIR`
which points to where the files are installed.
If you run

    make CLANTON_DIR=./sysroots install-clanton-tiny-sdk

all the extraction process will take place without accessing /opt,
so we do not need root privileges.
And finally,
copy the generated directory `sysroots` to `/opt/clanton-tiny/1.4.2/sysroots`.
(Now you need root access again.)
