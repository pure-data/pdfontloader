# pdloader

tiny TCL extension to load fonts into the Pure Data GUI on Windows

*not currently working*

To build, run `make`. You may need to specify the version and location of Tcl via:

    make TCL_VERSION=8.5 TCL_LIB_VERSION=85 TCL_INCLUDE=../path/to/tcl/include TCL_LIB=../path/to/tcl/lib

...or edit the variables above in the Makefile.

The result should be a pdloader.dll extension that can be opened in Tcl. There is currently one command:

    pdloader::loadfont FILENAME

It is intended to be used within the Pd GUI in order to load a local font via:

    catch {pdloader::loadfont ../font/DejaVuSansMono.ttf}

References:

* [Hello World TCL C extension](http://wiki.tcl.tk/11153)
* [extrafont](http://wiki.tcl.tk/48903)
* [Pd: DejaVu Sans Mono as default font crossplatform](https://github.com/pure-data/pure-data/pull/42)

