file=hello
bits=64
$(file): $(file).o
ifeq ($(bits),32)
	ld -m elf_i386 -o $(file) $(file).o
else
	ld -o $(file) $(file).o
endif
	./$(file)

	
$(file).o: $(file).asm
ifeq ($(bits),32)
	nasm -f elf -F dwarf -g $(file).asm
else
	nasm -f elf64 -F dwarf -g $(file).asm
endif
	