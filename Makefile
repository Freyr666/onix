ARCH=386
CC=gcc
AS=as
LD=ld

SFLAGS=--32
CFLAGS=-m32 -std=c89 -fno-pic -static -fno-builtin -fno-strict-aliasing -MD -ggdb -Werror -fno-omit-frame-pointer -fno-stack-protector -Wall -Wextra -c 
LFLAGS=-melf_i386
CPPFLAGS=-D__is_kernel -Iinclude

OSSRC=./sys/src/os
OSDEP=./sys/src/os/$(ARCH)

CSRC=./sys/src/libc
CDEP=./sys/src/libc/$(ARCH)

all: boot.o kernel.o term.o libc.o print.o crti.o crtn.o
	$(LD) $(LFLAGS) -T $(OSDEP)/loader.ld /tmp/boot.o /tmp/kernel.o /tmp/term.o /tmp/libc.o /tmp/print.o /tmp/crti.o /tmp/crtn.o -o myos.bin

boot.o:
	$(AS) $(SFLAGS) $(OSDEP)/boot.S -o /tmp/boot.o 

kernel.o:
	$(CC) $(CFLAGS) $(OSSRC)/kernel.c -o /tmp/kernel.o

term.o:
	$(CC) $(CFLAGS) $(OSDEP)/term.c -o /tmp/term.o

crti.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) $(OSDEP)/crti.S -o /tmp/crti.o

crtn.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) $(OSDEP)/crtn.S -o /tmp/crtn.o

libc.o:
	$(CC) $(CFLAGS) $(CSRC)/libc.c -o /tmp/libc.o

print.o:
	$(CC) $(CFLAGS) $(CDEP)/print.c -o /tmp/print.o

clean:
	rm *.o
