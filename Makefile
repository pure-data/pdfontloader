# TODO: handle the TCL paths & version better

CC = gcc

SOURCES = pdloader.c

TCL_VERSION = 8.6
TCL_LIB_VERSION = 86
TCL_INCLUDE = /usr/include/tcl$(TCL_VERSION)
TCL_LIB = /usr/lib

CFLAGS = -DUSE_TCL_STUBS -I$(TCL_INCLUDE)
LDFLAGS = -L$(TCL_LIB) -ltclstub$(TCL_LIB_VERSION) -lgdi32

all: pdloader.dll

pdloader.dll:
	$(CC) -Wall -shared -o pdloader.dll $(CFLAGS) $(SOURCES) $(LDFLAGS)

clean:
	rm -rf pdloader.dll
