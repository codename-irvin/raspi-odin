# Clean
rm -rf out
mkdir out

# Compile Odin code
odin build src \
    -no-crt \
    -disable-assert \
    -no-bounds-check \
    -no-thread-local \
    -no-entry-point \
    -disable-red-zone \
    -default-to-nil-allocator \
    -build-mode:object \
    -foreign-error-procedures \
    -out:out/kernel.o \
    -target:freestanding_arm64

# Compile boot assembly
clang --target=aarch64-none-elf -c src/boot.s -o out/boot.o

# Link using custom linker script
ld.lld -T src/kernel.ld -o out/kernel out/boot.o out/kernel.o

# Create kernel image
llvm-objcopy-14 -O binary out/kernel out/kernel8.img
