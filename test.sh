#!/bin/bash

function usage {
	printf "usage: $0 [options] kernel.img\n"
	printf "\t-d\tenable debug mode via gdb\n"
}

QEMU_GDB_OPT="-S -gdb tcp::26000"
DEBUG=""
KERNEL=""

if [ -z $1 ]
then
	usage; exit -1;
fi

for i in $@
do
	case $i in
	-d) 
		DEBUG=$QEMU_GDB_OPT;;
	-*) 
		printf "unrecognized option: %s\n" $i; 
		usage; exit -1;;
	*)  
		KERNEL=$i;;
	esac
done

exec qemu-system-i386 -m 32 $DEBUG -kernel $KERNEL
