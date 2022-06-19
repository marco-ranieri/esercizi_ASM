AS_FLAGS = --32 
DEBUG = -gstabs
LD_FLAGS = -m elf_i386

all: bin/div_int

bin/div_int: obj/div_int.o obj/itoa.o
	ld $(LD_FLAGS) obj/div_int.o obj/itoa.o -o bin/div_int


obj/div_int.o: src/div_int.s
	as $(AS_FLAGS) $(DEBUG) src/div_int.s -o obj/div_int.o

obj/itoa.o: src/itoa.s
	as $(AS_FLAGS) $(DEBUG) src/itoa.s -o obj/itoa.o


clean:
	rm -f obj/* bin/div_int