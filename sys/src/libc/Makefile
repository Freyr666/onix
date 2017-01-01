include ../../../def.mk

SRC = ./port/libc.c \
      ./$(ARCH)/print.c

OBJ = $(subst .c,.o, $(SRC))

.c.o: 
	$(CC) $(CFLAGS) -c $< -o $@

libc.a: $(OBJ)
	$(AR) rcs $@ $^
	mv libc.a $(ROOTDIR)/$(ARCH)/lib/

all: libc.a

clean:
	rm $(OBJ)

.PHONY: all libc.a
