OS := $(shell uname)

CPPFLAGS = -I./brotli/dec/ -I./brotli/enc/ -I./src

CC ?= /home/vagrant/touch_of_death/AFL/afl-clang-fast
CXX ?= /home/vagrant/touch_of_death/AFL/afl-clang-fast++

COMMON_FLAGS = -O0 -g

ifeq ($(OS), Darwin)
  CPPFLAGS += -DOS_MACOSX
else
  COMMON_FLAGS += 
endif

CFLAGS += $(COMMON_FLAGS)
CXXFLAGS += $(COMMON_FLAGS) 

SRCDIR = src

OUROBJ = font.o glyph.o normalize.o table_tags.o transform.o \
         woff2_dec.o woff2_enc.o woff2_common.o woff2_out.o \
         variable_length.o

BROTLI = brotli
ENCOBJ = $(BROTLI)/enc/*.o
DECOBJ = $(BROTLI)/dec/*.o

OBJS = $(patsubst %, $(SRCDIR)/%, $(OUROBJ))
EXECUTABLES=woff2_compress woff2_decompress

EXE_OBJS=$(patsubst %, $(SRCDIR)/%.o, $(EXECUTABLES))

ifeq (,$(wildcard $(BROTLI)/*))
  $(error Brotli dependency not found : you must initialize the Git submodule)
endif

all : $(OBJS) $(EXECUTABLES)

$(EXECUTABLES) : $(EXE_OBJS) deps
	$(CXX) $(LFLAGS) $(OBJS) $(ENCOBJ) $(DECOBJ) $(SRCDIR)/$@.o -o $@

deps :
	$(MAKE) -C $(BROTLI)/dec
	$(MAKE) -C $(BROTLI)/enc

clean :
	rm -f $(OBJS) $(EXE_OBJS) $(EXECUTABLES)
	$(MAKE) -C $(BROTLI)/dec clean
	$(MAKE) -C $(BROTLI)/enc clean
