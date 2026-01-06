ENTRY(_start)

RAM_PER_CORE = 512M;

PHDRS
{
  text PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(6);
}

MEMORY
{
  RAM (rwx) : ORIGIN = 0x40000000 + RAM_PER_CORE, LENGTH = RAM_PER_CORE
  PERIPHERALS (rwx) : ORIGIN = 0x00000000, LENGTH = 0x10000
}

SECTIONS
{

  .tohost_section 0x00002FF8 (NOLOAD) :
  {
    . = ALIGN(4);
    tohost = .;
    WORD(0);
  } > PERIPHERALS : data

  .fromhost_section 0x00002FFC (NOLOAD) :
  {
    . = ALIGN(4);
    fromhost = .;
    WORD(0);
  } > PERIPHERALS : data

  . = ORIGIN(RAM);

  .text :
  {
    _start = .;
    *(.text)
    *(.text.*)
    . = ALIGN(8);
    *(.rodata)
    *(.rodata.*)
  } > RAM : text

  .data :
  {
    *(.data)
    *(.data.*)
  } > RAM : data

  .bss :
  {
    *(.bss)
    *(.bss.*)
    *(COMMON)
  } > RAM : data

  _end = ALIGN(8);

  __stack_top = ORIGIN(RAM) + LENGTH(RAM);
}
