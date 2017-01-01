ARCH=386
ROOTDIR=/home/freyr/Documents/soft/dev/kernel

LIBDIR=$(ROOTDIR)/$(ARCH)/lib
BINDIR=$(ROOTDIR)/$(ARCH)/bin
INCARCH=$(ROOTDIR)/$(ARCH)/include
INCPORT=$(ROOTDIR)/sys/include

CC=gcc -m32
AS=as --32
LD=ld -melf_i386

SFLAGS=
CFLAGS=-std=c89 -fno-pic -static -fno-builtin -fno-strict-aliasing -MD -ggdb -Werror -fno-omit-frame-pointer -fno-stack-protector -Wall -Wextra
LFLAGS=
CPPFLAGS=-D__is_kernel -Iinclude

OSSRC=$(ROOTDIR)/sys/src/os
CSRC=$(ROOTDIR)/sys/src/libc
