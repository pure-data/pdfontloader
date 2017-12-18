# TODO: handle the TCL paths & version better

CC = gcc

RESULT = pdfontloader.dll
SOURCES = pdfontloader.c

TCL_VERSION = 8.6
TCL_LIB_VERSION = 86
TCL_INCLUDE = /usr/include/tcl$(TCL_VERSION)
TCL_LIB = /usr/lib

# build for Tcl 8.5.10 distributed with Pd,
# use local tcl headers as the headers are *not* with Pd
ifneq ($(PDDIR),)
	CFLAGS = -m32
	TCL_VERSION = 8.5
	TCL_LIB_VERSION = 85
	TCL_INCLUDE = libs/tcl/include
	TCL_LIB = $(PDDIR)/bin
endif

CFLAGS += -DUSE_TCL_STUBS -I$(TCL_INCLUDE)
LDFLAGS = -L$(TCL_LIB) -ltclstub$(TCL_LIB_VERSION) -lgdi32

.PHONY: strip clean

all: $(RESULT)

$(RESULT): $(SOURCES)
	$(CC) -Wall -shared -o $(RESULT) $(CFLAGS) $^ $(LDFLAGS)

strip:
	strip $(RESULT)

clean:
	rm -rf $(RESULT)
