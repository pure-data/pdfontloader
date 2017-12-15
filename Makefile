# TODO: handle the TCL paths & version better

CC = gcc

TCL_VERSION = 8.6
TCL_LIB_VERSION = 86
TCL_INCLUDE = /usr/include/tcl$(TCL_VERSION)
TCL_LIB = /usr/lib

EXTENSION= dll
SOURCES = pdloader.c
CFLAGS = -DUSE_TCL_STUBS -I$(TCL_INCLUDE)
LDFLAGS = -L$(TCL_LIB) -ltclstub$(TCL_LIB_VERSION)

all: pdloader

pdloader:
	$(CC) -shared -o pdloader.$(EXTENSION) $(CFLAGS) $(LDFLAGS)

clean:
	rm -rf pdloader.$(EXTENSION)
