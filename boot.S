.section ".text.boot"

.global system_start

// LOAD address of the kernel
.org 0x80000

// x0 has physical address of FDT blob passed from the bootloader
system_start:
	ldr x5, =kernel_stack_top
	mov sp, x5
	b clear_bss
	bl start_kernel

system_stop:
	wfe
	b system_stop

clear_bss:
	ldr x5, =bss_start
	ldr x6, =bss_end
1:
	str xzr, [x5], #8
	cmp x5, x6
	b.ne 1b
	ret
