C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

all: os-image

run: all
	bochs -q

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > os-image

kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ $^ -T link.ld

%.o : %.c ${HEADERS}
	gcc -m32 -fno-builtin -ffreestanding -Wall -Werror -O0 -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I './boot/tools/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image *.map
	rm -rf kernel/*.o boot/*.bin drivers/*.o
