EXE = comp
AS = as --32
LD = ld -m elf_i386
FLAGS = -gstabs
OBJ = comp.o

$(EXE): $(OBJ)
	$(LD) -o $(EXE) $(OBJ)

comp.o: comp.s
	$(AS) $(FLAGS) -o comp.o comp.s
clean:
	rm -f *.o $(EXE) core

