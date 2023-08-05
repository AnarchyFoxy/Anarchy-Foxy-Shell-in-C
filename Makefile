CFLAGs=-Wall -Wextra -ggdb

all: shell shell.i shell.s

shell.o: AnarchyFoxyShell.c
		gcc -o shell.o $(CFLAGS) -Wa,-a=shell.lst -c AnarchyFoxyShell.c

shell: shell.o
		gcc $(CFLAGS) -Bstatic -Wl,-Map=shell.map -o shell shell.o

shell.i: AnarchyFoxyShell.c
		gcc -E AnarchyFoxyShell.c >shell.i

shell.s: AnarchyFoxyShell.c
		gcc -S -o shell AnarchyFoxyShell.c

# adding verbose for seeing all command line
verbose:
		gcc -v $(CFLAGS) -Wextra -c AnarchyFoxyShell.c

# cleaning after compilation
clean:
		rm -f shell shell.i shell.s shell.o shell.map
