CC = gcc
RM = rm

INCLUDE_DIR = include/

SOURCES = src/mach_gettime.c
OBJECTS = $(patsubst %.c,obj/%.o,$(SOURCES))

CFLAGS = -O2 -Wall -Wextra -march=native -I${INCLUDE_DIR}
DYLDFLAGS = -dynamiclib -undefined suppress -flat_namespace

LIBRARY = bin/libgettime.dylib

$(OBJS): | obj

obj:
	@test -d $@ || mkdir $@
	@mkdir obj/src

.PHONY: all

all: libgettime

libgettime: ${SOURCES} ${LIBRARY}

${LIBRARY}: ${OBJECTS}
	@mkdir bin/
	${CC} ${DYLDFLAGS} ${OBJECTS} -o $@

obj/%.o: %.c
	@mkdir -p $(@D)
	${CC} ${CFLAGS} -c $< -o $@

clean:
	${RM} -rf ${OBJECTS} obj/ ${LIBRARY} bin/
