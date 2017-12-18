# pdloader

tiny TCL extension to load fonts into the Pure Data GUI on Windows

*not currently working*

![test window](https://github.com/pure-data/pdloader/raw/master/docs/test.png)

To build, run `make`. You may need to specify the version and location of Tcl via:

    make TCL_VERSION=8.5 TCL_LIB_VERSION=85 TCL_INCLUDE=../path/to/tcl/include TCL_LIB=../path/to/tcl/lib

...or edit the variables above in the Makefile.

The version of Tcl this is compiled against should match the version that is used by the Pd gui. The easiest method is to point this Makefile to use the Tcl included with the Pd Windows release or unpack the pdprototype.tgz in the `msw` folder from the Pd source Git repo. 

The result should be a pdloader.dll extension that can be opened in Tcl. There is currently one command:

    pdloader::loadfont FILENAME

It is intended to be used within the Pd GUI in order to load a local font via:

    catch {
        load pdloader.dll 
        pdloader::loadfont ../font/DejaVuSansMono.ttf
    }

This should add the following font family name to the list of available fonts returned by `[font families]`: "DejaVu Sans Mono."

References:

* [Hello World TCL C extension](http://wiki.tcl.tk/11153)
* [extrafont](http://wiki.tcl.tk/48903)
* [Pd: DejaVu Sans Mono as default font crossplatform](https://github.com/pure-data/pure-data/pull/42)

