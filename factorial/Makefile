AS_FLAGS = --32 
DEBUG = -gstabs
LD_FLAGS = -m elf_i386

all: bin/factorial

bin/factorial: obj/factorial.o
	ld $(LD_FLAGS) obj/factorial.o -o bin/factorial


obj/factorial.o: src/factorial.s
	as $(AS_FLAGS) $(DEBUG) src/factorial.s -o obj/factorial.o


clean:
	rm -f obj/factorial.o bin/factorial