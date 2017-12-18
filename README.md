# pdfontloader

tiny TCL extension to load fonts into the Pure Data GUI on Windows

![test window](https://github.com/pure-data/pdfontloader/raw/master/test.png)

## Build

To build, run `make` and specify the location of a Pd release folder (aka build downloaded from Miller's site):

    make PDDIR=../path/to/pd-release
    make strip

The version of Tcl this is compiled against should match the version that is used by the Pd gui, currently Tcl/Tk 8.5.10.

Alternatively, if you want to test this extensions functionality without Pd, you may need to specify the version and location of Tcl via:

    make TCL_VERSION=8.5 TCL_LIB_VERSION=85 TCL_INCLUDE=../path/to/tcl/include TCL_LIB=../path/to/tcl/lib

...or edit the variables above in the Makefile.

The result should be a `pdfontloader.dll` extension that can be opened in Tcl. 

## Usage

There is currently one command:

    pdfontloader::load FILENAME

It is intended to be used within the Pd GUI in order to load a local font via something like:

    catch {
        load ./pdfontloader.dll 
        pdfontloader::load ../font/DejaVuSansMono.ttf
    }

The command above should add the following font family name to the list of available fonts returned by `[font families]`: "DejaVu Sans Mono."

## Testing with Pd

Build pdfontloader using mingw32 as the current Pd Windows release is 32 bit:

    make PDDIR=../path/to/pd-release

Once built:

1. copy `pdfontloader.dll` into the Pd `bin` folder
2. copy the `font` folder from the [Pd git repo](https://github.com/pure-data/pure-data/tree/master/font) into the Pd folder
3. edit `tcl/pd-gui.tcl` and add the following at the end of the "win32" section of "init_for_platform" procedure:

~~~
			# load local font
            if {[file exists [file join "$::sys_libdir" "font"]]} {
                catch {
                    load [file join "$::sys_libdir" "bin/pdfontloader.dll"]
                    set path [file join "$::sys_libdir" "font/DejaVuSansMono.ttf"]
                    pdfontloader::load $path
                    ::pdwindow::verbose 0 "pdfontloader loaded [file tail $path]\n"
                }
            }
~~~

References:

* [[TCLCORE] PRIVATE FONT-FILES IN TCLTK](http://code.activestate.com/lists/tcl-core/8159/)
* [Hello World TCL C extension](http://wiki.tcl.tk/11153)
* [extrafont](http://wiki.tcl.tk/48903)
* [Pd: DejaVu Sans Mono as default font crossplatform](https://github.com/pure-data/pure-data/pull/42)
