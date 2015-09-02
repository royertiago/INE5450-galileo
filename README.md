INE5450 - C para Drivers para Dispositivos
==========================================
(_C for device drivers_)

Project of the INE5450 course.

Building
========
The makefile assumes the existence of two directories:
- `clanton-tiny/1.4.2/sysroots/`,
    with the sysroot directory with tools like cross-compiler.
- `ide_stuff`,
    with the essential headers used by the IDE.

These directories should be mechanically obtainable
through the downloads in <http://www.intel.com/support/galileo/sb/CS-035101.htm>,
but I was not able to set a fully automated script to do this.
