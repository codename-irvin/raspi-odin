package kernel_start

import "uart"

MESSAGE :: "Hellope from Raspberry Pi!\n"

@(export, link_name="_kernel_start")
_kernel_start :: proc "c" () {
    uart.uart_init()
    uart.write_string(MESSAGE)
    for {}
}