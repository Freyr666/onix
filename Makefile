include def.mk

all: boot.o kernel.o term.o libc
	$(LD) $(LFLAGS) -T $(OSDEP)/loader.ld /tmp/boot.o /tmp/kernel.o /tmp/term.o /tmp/libc.o /tmp/print.o /tmp/crti.o /tmp/crtn.o -o myos.bin

boot.o:
	$(AS) $(SFLAGS) $(OSDEP)/boot.S -o /tmp/boot.o 

kernel.o:
	$(CC) $(CFLAGS) $(OSSRC)/kernel.c -o /tmp/kernel.o

term.o:
	$(CC) $(CFLAGS) $(OSDEP)/term.c -o /tmp/term.o

libc:
	make -C $(CSRC)

rt:
	echo $(LIBDIR)
