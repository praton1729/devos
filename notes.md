# Important learnings and info

## Boot
- The kernel image needs to have a boot header to make it loadable with linux
  loaders.
- The format of the header is mentioned in booting.rst of arm64 and can be looked at in head.S
- kernel image should be placed on a 2MB aligned base address.
- The same file mentions the things bootloader needs to take care of like:-
	- setting up and initializing ram
	- setting up device tree blob
	- decompressing and loading kernel image
- dtb blob must be placed at an 8-byte boundary and its size should not exceed 2MB
- dtb blob will be mapped cacheable
- system registers initial value is also mentioned in the same document.
- Also mentions all the conditions to be met before jumping into the kernel.
- initrd should lie within 32 GB of the kernel image and should be less than 1
  GB of size(needs to be confirmed).

## Kernel elf

- Can convert elf to binary with objcopy. The binary file would just be a
  memory dump of the elf starting at the load address of the lowest section in
  the elf.

## Qemu Platform

- Choosing `virt` as the platform for now.(no reason)
- Can write a uart driver for pl011 to enable logging.
- Peripheral programming can be done by mmios to `mmio_base+reg` addresses.
- Can find out all physical addresses from qemu source or dts.
- Can use `qemu-system-aarch64 -machine virt,dumpdtb=virt.dtb -smp 1 -nographic` to dump the virt dtb.
	- Convert to dts with: `dtc -I dtb -O dts -o virt.dts virt.dtb`

## Linker

- Can have the kernel and irq stack at the end of the kernel image.

## Filesystem

- Can create a simple binary file with `dd if=/dev/zero of=fs.img count=10000`
- And write a ext2 filesystem on it with `mkfs.ext2 -d os_dev -v fs.img -b 1024`
- As per qemu docs I can use this img file to directly boot the kernel image.
