# Detect operational system
ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

# Detect sources and set build flags.
ifeq ($(detected_OS),Windows)
SRCS = $(wildcard x86/*/windows.s)
endif
ifeq ($(detected_OS),Darwin)
SRCS = $(wildcard x86/*/darwin.s)
ARCH = macho64
LDFLAGS = -macosx_version_min 10.7.0 -lSystem -no_pie
endif
ifeq ($(detected_OS),Linux)
ARCH = elf64
SRCS = $(wildcard x86/*/linux.s)
endif

# Generic variables
PROGS = $(patsubst %.s,%,$(SRCS))
CLEAR = $(wildcard x86/*/*.o) $(wildcard x86/*/*.exe) $(wildcard x86/*/*.out)
CLEAR += $(wildcard x86/*/linux) $(wildcard x86/*/darwin) $(wildcard x86/*/windows)

# Settings
.PHONY: clean
all: $(PROGS)

# Compile target
%: %.s
	nasm -f $(ARCH) -o $@.o $@.s
	ld $(LDFLAGS) -o $@ $@.o
	rm $@.o

# Clean Target
ifeq ($(strip $(CLEAR)),)
clean:
	@echo "nothing to clean!"
else 
clean:
	rm $(CLEAR)
endif
