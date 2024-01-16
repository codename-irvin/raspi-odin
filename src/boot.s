.section .text._start

.global _start

_start:
    mov sp, 0x80000
    bl _kernel_start
    wfe