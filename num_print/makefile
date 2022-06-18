EXE = num_print
AS = as --32
LD = ld -m elf_i386
FLAGS = -gstabs
OBJ = num_print.o

$(EXE): $(OBJ)
	$(LD) -o $(EXE) $(OBJ)

num_print.o: num_print.s
	$(AS) $(FLAGS) -o num_print.o num_print.s
clean:
	rm -f *.o $(EXE) core

