@echo off

if not exist .build mkdir .build
if not exist bin mkdir bin

set compiler="tools\gcc\bin\i686-elf-gcc"
set mkisofs="tools\mkisofs"
set nasm="tools\nasm"

%nasm% -felf32 src\boot.asm -o .build\boot.o
%compiler% -std=gnu99 -c src\kernel.c -o .build\kernel.o -ffreestanding -O2 -Wall -Wextra
%compiler% -T linker.ld -o isofiles\boot\kernel.bin -ffreestanding -O2 -nostdlib .build\boot.o .build\kernel.o -lgcc

%mkisofs% -quiet -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -o bin\kernel.iso isofiles

rmdir /s /q .build
