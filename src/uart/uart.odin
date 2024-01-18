package uart

import "core:intrinsics"

Word :: u32

UART0_BASE_ADDR : uintptr : 0x3F201000
UART0_DR    :: (^Word)(UART0_BASE_ADDR)
UART0_FR    :: (^Word)(UART0_BASE_ADDR + 0x18)
UART0_IBRD  :: (^Word)(UART0_BASE_ADDR + 0x24)
UART0_FBRD  :: (^Word)(UART0_BASE_ADDR + 0x28)
UART0_LCRH  :: (^Word)(UART0_BASE_ADDR + 0x2c)
UART0_CR    :: (^Word)(UART0_BASE_ADDR + 0x30)
UART0_IMSC  :: (^Word)(UART0_BASE_ADDR + 0x38)

UART_TARGET_BAUD  :: 115_200
UARTCLK           :: 48_000_000
UART_IBRD_VAL     :: UARTCLK / (16 * UART_TARGET_BAUD)

vstore :: intrinsics.volatile_store

write_char :: proc "contextless" (c: byte) {
    for intrinsics.volatile_load(UART0_FR) & (1 << 5) != 0 { }
    vstore(UART0_DR, u32(c))
}

write_string :: proc "contextless" (s: string) {
    for c in s {
        write_char(byte(c));
    }
}

uart_init :: proc "contextless" () {
    vstore(UART0_CR, 0); // Disable UART
    vstore(UART0_IBRD, UART_IBRD_VAL);
    vstore(UART0_FBRD, 0); // Technically this should not be 0 but is accurate enough for this example.
    vstore(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6));
    vstore(UART0_IMSC, 0);
    vstore(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9)); // Re-enable UART with rx and tx
}