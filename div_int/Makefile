AS_FLAGS = --32 
DEBUG = -gstabs
LD_FLAGS = -m elf_i386

all: bin/div_int_params

bin/div_int_params: obj/div_int_params.o obj/num2str.o obj/str2num.o
	ld $(LD_FLAGS) obj/div_int_params.o obj/num2str.o obj/str2num.o -o bin/div_int_params


obj/div_int_params.o: src/div_int_params.s
	as $(AS_FLAGS) $(DEBUG) src/div_int_params.s -o obj/div_int_params.o

obj/num2str.o: src/num2str.s
	as $(AS_FLAGS) $(DEBUG) src/num2str.s -o obj/num2str.o

obj/str2num.o: src/str2num.s
	as $(AS_FLAGS) $(DEBUG) src/str2num.s -o obj/str2num.o

clean:
	rm -f obj/* bin/div_int_params