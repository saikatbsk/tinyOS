CFLAGS := -fno-stack-protector -fno-builtin -nostdinc -O -g -Wall -I./ -c -m32

all: kernel.bin

iso: kernel.bin
	cp -v kernel.bin fs/boot/
	mkisofs -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o tinyOS.iso fs

kernel.bin: boot.o main.o scrn.o
	ld -T link.ld -m elf_i386 -o kernel.bin boot.o main.o scrn.o
	@echo Done!

boot.o: boot.asm
	nasm -f elf -o boot.o boot.asm

main.o: main.c
	gcc $(CFLAGS) -o main.o main.c

scrn.o: scrn.c
	gcc $(CFLAGS) -o scrn.o scrn.c

clean:
	rm -fv *.o

cleanall:
	rm -fv *.o *.iso *.bin fs/boot/*.bin
