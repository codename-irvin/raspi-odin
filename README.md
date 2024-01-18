# Odin Raspi

A minimal example showing how to boot Odin code on a Raspberry PI 3 Model B. The kernel boots in QEMU and uses the Raspberry Pi UART to print a message to the console.

## Instructions (Linux)

1. Install QEMU on your system
2. Install the Odin compiler on your system
3. Make sure clang v14.x.x is installed on your system
4. Run build.sh to compile and link the kernel image or
5. Run run.sh to build and boot the kernel in QEMU

## Warning

This example is _just_ enough to get things up and running and does not necessarily follow best practices.