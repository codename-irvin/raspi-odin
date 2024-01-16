package uart

import "core:intrinsics"

Word :: u32

UART0_BASE_ADDR :: 0x3F201000
UART0_DR :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR)
UART0_FR :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x18)
UART0_IBRD :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x24)
UART0_FBRD :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x28)
UART0_LCRH :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x2c)
UART0_CR :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x30)
UART0_IMSC :: cast(^Word)cast(uintptr)(UART0_BASE_ADDR + 0x38)

write_char :: proc "contextless" (c: byte) {
    for intrinsics.volatile_load(UART0_FR) & (1 << 5) != 0 { }
    intrinsics.volatile_store(UART0_DR, cast(u32)c);
}

write_string :: proc "contextless" (s: string) {
    for c in s {
        write_char(byte(c));
    }
}

uart_init :: proc "contextless" () {
    intrinsics.volatile_store(UART0_CR, 0);
    intrinsics.volatile_store(UART0_IBRD, 26);
    intrinsics.volatile_store(UART0_FBRD, 0);
    intrinsics.volatile_store(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
    intrinsics.volatile_store(UART0_IMSC, 0);
    intrinsics.volatile_store(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9));
}