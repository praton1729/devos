ENTRY(system_start)

SECTIONS
{
	. = 0x80000;
	kernel_image_start = .;
	text_start = .;
	.text :
	{
		*(.text.boot)
		*(.text)
	}
	text_end = .;

	.rodata : { *(.rodata) }
	.data : { *(.data) }

	bss_start = .;
	.bss : { *(.bss) }
	bss_end = .;

	. = . + 4K;
	kernel_stack_top = .;

	/* can have irq stack here as well */
	kernel_image_end = .;
}
