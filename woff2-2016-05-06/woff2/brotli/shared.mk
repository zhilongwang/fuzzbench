OS := $(shell uname)

CC ?= gcc
CXX ?= g++

COMMON_FLAGS = -fno-omit-frame-pointer -no-canonical-prefixes -O0 -g

ifeq ($(OS), Darwin)
  CPPFLAGS += -DOS_MACOSX
endif

CFLAGS += $(COMMON_FLAGS) -Wmissing-prototypes
CXXFLAGS += $(COMMON_FLAGS) -Wmissing-declarations
