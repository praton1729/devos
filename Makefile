CFLAGS = -nostdlib -ffreestanding -nostartfiles
OUTPUT = out

all: $(OUTPUT)/kernel.elf

$(OUTPUT)/boot.o: boot.S
	aarch64-linux-gnu-gcc -c $^ -o $@

$(OUTPUT)/kernel.o: kernel.c
	aarch64-linux-gnu-gcc -c $^ -o $@

$(OUTPUT)/kernel.elf: $(OUTPUT)/kernel.o $(OUTPUT)/boot.o
	aarch64-linux-gnu-gcc -T linker.ld $(CFLAGS) $^ -o $@
	aarch64-linux-gnu-objcopy -O binary $@ $(OUTPUT)/kernel.bin

clean:
	@rm out/*
