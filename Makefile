CC=tcc
CFLAGS=-I.
CLIBS=-lncurses
NAME=ncurses
SRCDIR=src
TESTDIR=test
# DEPS=$(SRCDIR)/$(NAME).h
OUTDIR=out
# OBJ_LIB=main.o
OBJ_MAIN=$(addprefix $(OUTDIR)/, $(OBJ_LIB) main.o)
# OBJ_TEST=$(addprefix $(OUTDIR)/, $(OBJ_LIB) tests.o)

$(OUTDIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	@[ -d "$(@D)" ] || mkdir -p "$(@D)"
	$(CC) -c -o $@ $< $(CFLAGS)

main: $(OUTDIR)/$(NAME)
$(OUTDIR)/$(NAME): $(OBJ_MAIN)
	$(CC) $(CFLAGS) -o $@ $^ $(CLIBS)

# $(OUTDIR)/%.o: $(TESTDIR)/%.c $(DEPS)
#     $(CC) -c -o $@ $< $(CFLAGS)

# test: $(OUTDIR)/$(NAME)_tests
# $(OUTDIR)/$(NAME)_tests: $(OBJ_TEST) $(OUTDIR)/tests.o
#     $(CC) $(CFLAGS) -o $@ $^ $(CLIBS)

watch:
	@command -v inotifywait > /dev/null || \
		{ \
			echo "Please install inotifywait"; exit 2; \
		}
	@while true ; do \
		NAME=$$(inotifywait \
			-e create,modify \
			--include '.*\.(c|h)' \
			--format '%w%f' \
			"$(SRCDIR)"); \
		($(MAKE)); \
	done
