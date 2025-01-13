#!/usr/bin/env make

RESULT = pdfontloader.dll
SOURCES = pdfontloader.c

TCL_VERSION = 8.6

TCL_INCLUDE = /usr/include/tcl$(TCL_VERSION)
TCL_LIB = /usr/lib

TCL_CFLAGS = -I$(TCL_INCLUDE)
TCL_LIBS = -L$(TCL_LIB) -ltclstub$(subst .,,$(TCL_VERSION))

have_tclpkg=$(shell pkg-config --exists tcl$(TCL_VERSION) && echo true)
ifeq ($(have_tclpkg), true)
	TCL_CFLAGS=$(shell pkg-config --cflags tcl$(TCL_VERSION))
	TCL_LIBS=$(shell pkg-config --libs tcl$(TCL_VERSION))
endif

# build for Tcl 8.5.10 distributed with Pd,
# use local tcl headers as the headers are *not* with Pd
ifneq ($(PDDIR),)
	TCL_CFLAGS=-Ilibs/tcl/include
	TCL_LIB_VERSION = 85
# the headers are 8.5, but let's just search for any tclstub, and hope it is compatible
	TCL_LIB_VERSION = *
	TCL_LIBS=$(firstword $(wildcard $(PDDIR)/bin/libtclstub$(TCL_LIB_VERSION).a $(PDDIR)/lib/libtclstub$(TCL_LIB_VERSION).a))
endif

CFLAGS += -DUSE_TCL_STUBS $(TCL_CFLAGS)
LDFLAGS = $(TCL_LIBS) -lgdi32

.PHONY: strip clean

all: $(RESULT)

$(RESULT): $(SOURCES)
	$(CC) -Wall -shared -o $(RESULT) $(CFLAGS) $^ $(LDFLAGS)

strip:
	strip $(RESULT)

clean:
	rm -rf $(RESULT)

test:
	@echo TCL_CFLAGS: $(TCL_CFLAGS)
	@echo TCL_LIBS: $(TCL_LIBS)
	@echo CFLAGS: $(CFLAGS)
	@echo LDFLAGS: $(LDFLAGS)
	@echo ""
	@echo TCL_VERSION = $(TCL_VERSION)
	@echo "TCL_INCLUDE: $(TCL_INCLUDE) -> $(wildcard $(TCL_INCLUDE))"
