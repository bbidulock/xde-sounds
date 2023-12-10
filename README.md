[xde-sounds -- read me first file.  2022-01-27]: #

xde-sounds
===============

Package `xde-sounds-1.1.2` was released under GPLv3 license
2022-01-27.

This is a set of sounds, primarily window manager sounds and sounds for
shutdown and reboot of the system on logout, for the XDE (_X Desktop
Environment_).

Release
-------

This is the `xde-sounds-1.1.2` package, released 2022-01-27.
This release, and the latest version, can be obtained from [GitHub][1],
using a command such as:

    $> git clone https://github.com/bbidulock/xde-sounds.git

Please see the [RELEASE][3] and [NEWS][4] files for release notes and
history of user visible changes for the current version, and the
[ChangeLog][5] file for a more detailed history of implementation
changes.  The [TODO][6] file lists features not yet implemented and
other outstanding items.

Please see the [INSTALL][8] file for installation instructions.

When working from `git(1)`, please use this file.  An abbreviated
installation procedure that works for most applications appears below.

This release is published under GPLv3.  Please see the license in the
file [COPYING][10].


Quick Start
-----------

The quickest and easiest way to get `xde-sounds` up and
running is to run the following commands:

    $> git clone https://github.com/bbidulock/xde-sounds.git
    $> cd xde-sounds
    $> ./autogen.sh
    $> ./configure
    $> make
    $> make DESTDIR="$pkgdir" install

This will configure, compile and install `xde-sounds` the
quickest.  For those who like to spend the extra 15 seconds reading
`./configure --help`, some compile time options can be turned on and off
before the build.

For general information on GNU's `./configure`, see the file
[INSTALL][8].


Dependencies
------------

To build and install the package you will need a basic development
installation.  To build and install the package you will also need the
`flite(1)` speech synthesizer from CMU with a full set of `.flitevox`
voices installed in the /usr/lib/flite directory.

The build and install the package you will also need the `sox(1)`
program to manipulate and apply effects to the resulting synthesized
speech files.


Running
-------

Read the manual page after installation:

    $> man 7 sound

The package currently installs four sound themes:

- `freedesktop`  
It supplements the `freedesktop` sound theme by adding a full
set of standard and enhanced `.sound` data files.
- `flite-F`  
This sound there contains a sound theme of spoken words spoken (by
default) by the CMU US SLT female voice.
- `flite-M`  
This sound there contains a sound theme of spoken words spoken (by
default) by the CMU US RMS male voice.
- `XDE`  
The default sound theme for the X Desktop Environment.
- `Incredibles`  
A fun theme that includes funny clips and sound effects from the
animated movie, "The Incredibles."

To use any of these themes, set your gtk-sound-theme-name to one of the
names above in either your ~/.gtkrc-2.0 file or your
~/.config/gtk-3.0/settings.ini file (or both).


Enjoy!


Issues
------

Report issues on GitHub [here][2].



[1]: https://github.com/bbidulock/xde-sounds
[2]: https://github.com/bbidulock/xde-sounds/issues
[3]: https://github.com/bbidulock/xde-sounds/blob/master/RELEASE
[4]: https://github.com/bbidulock/xde-sounds/blob/master/NEWS
[5]: https://github.com/bbidulock/xde-sounds/blob/master/ChangeLog
[6]: https://github.com/bbidulock/xde-sounds/blob/master/TODO
[7]: https://github.com/bbidulock/xde-sounds/blob/master/COMPLIANCE
[8]: https://github.com/bbidulock/xde-sounds/blob/master/INSTALL
[9]: https://github.com/bbidulock/xde-sounds/blob/master/LICENSE
[10]: https://github.com/bbidulock/xde-sounds/blob/master/COPYING

[ vim: set ft=markdown sw=4 tw=72 nocin nosi fo+=tcqlorn spell: ]: #
