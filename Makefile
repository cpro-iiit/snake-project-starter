CC = gcc
CFLAGS = -Wall -Wno-unused-function -Wconversion -std=c99 -g
LDFLAGS =
SNAKE_DEPS = src/snake.o src/snake_utils.o src/state.o
INTERACTIVE_DEPS = src/interactive_snake.o src/snake_utils.o src/state.o
UNIT_TESTS_DEPS = src/snake_utils.o src/unit_tests.o src/asserts.o
UNIT_TESTS_1_DEPS = src/snake_utils.o src/unit_tests_1.o src/asserts.o
UNIT_TESTS_3_DEPS = src/snake_utils.o src/unit_tests_3.o src/asserts.o
UNIT_TESTS_4_DEPS = src/snake_utils.o src/unit_tests_4.o src/asserts.o
UNIT_TESTS_5_DEPS = src/snake_utils.o src/unit_tests_5.o src/asserts.o
UNIT_TESTS_6_DEPS = src/snake_utils.o src/unit_tests_6.o src/asserts.o
CUSTOM_TESTS_DEPS = src/snake_utils.o src/custom_tests.o src/asserts.o
SHORTER_TESTS = 01-simple 02-direction 03-tail 04-food 05-wall 06-small 07-medium 08-multisnake 09-everything 10-filled 11-manyclose 12-corner 13-sus 14-orochi 15-hydra
LONGER_TESTS = 16-huge 17-wide 18-tall 19-101-127 20-long-line 21-bigL

COLOR_GREEN =
COLOR_RESET =
ifeq (,${NO_COLOR})
	ifneq (,$(findstring xterm,${TERM}))
		override COLOR_GREEN := $(shell tput setaf 2)
		override COLOR_RESET := $(shell tput sgr0)
	endif
endif

help:
	@echo Usage:
	@echo make run-unit-tests: Compiles and runs unit tests.
	@echo make run-custom-tests: Compiles and runs custom tests.
	@echo make debug-unit-tests: Compiles unit tests and starts the debugger.
	@echo make debug-custom-tests: Compiles custom tests and starts the debugger.
	@echo make valgrind-test-free-state: Runs the test_free_state unit test under Valgrind.
	@echo make run-nonexistent-input-file-test: Checks that your program returns -1 on a nonexistent input file.
	@echo make run-integration-tests: Compiles and runs integration tests.
	@echo make snake: Compiles the snake executable.
	@echo make unit-tests: Compiles the unit tests.
	@echo make custom-tests: Compiles the custom tests.
	@echo make interactive-snake: Compiles the interactive snake executable.
	@echo make clean: Removes executables and output files.

.PHONY: all
all: interactive-snake snake unit-tests custom-tests

snake: $(SNAKE_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

interactive-snake: $(INTERACTIVE_DEPS)
	$(CC) -o $@ $^ -pthread $(CFLAGS) $(LDFLAGS)

unit-tests: $(UNIT_TESTS_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

unit-tests-1: $(UNIT_TESTS_1_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

unit-tests-3: $(UNIT_TESTS_3_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

unit-tests-4: $(UNIT_TESTS_4_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

unit-tests-5: $(UNIT_TESTS_5_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

unit-tests-6: $(UNIT_TESTS_6_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

custom-tests: $(CUSTOM_TESTS_DEPS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

src/unit_tests_%.o: src/unit_tests_%.c src/state.c src/asserts.c
	$(CC) -c -o $@ $< $(CFLAGS)

src/unit_tests.o: src/unit_tests.c src/state.c src/asserts.c
	$(CC) -c -o $@ $< $(CFLAGS)

src/custom-tests.o: src/custom_tests.c src/state.c src/asserts.c
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: check-hashes
check-hashes:
	@bash tools/run_python.sh tools/check_hashes.py

.PHONY: clean
clean:
	rm -f interactive-snake snake unit-tests unit-tests-* custom-tests unit-test-*.snk *.exe *.o src/*.o tests/*-out.snk

.PHONY: debug-unit-tests
debug-unit-tests: unit-tests check-hashes
	cgdb ./unit-tests

.PHONY: run-unit-tests
run-unit-tests: unit-tests check-hashes
	./unit-tests

.PHONY: run-unit-tests-1
run-unit-tests-1: unit-tests-1 check-hashes
	./unit-tests-1

.PHONY: run-unit-tests-3
run-unit-tests-3: unit-tests-3 check-hashes
	./unit-tests-3

.PHONY: run-unit-tests-4
run-unit-tests-4: unit-tests-4 check-hashes
	./unit-tests-4

.PHONY: run-unit-tests-5
run-unit-tests-5: unit-tests-5 check-hashes
	./unit-tests-5

.PHONY: run-unit-tests-6
run-unit-tests-6: unit-tests-6 check-hashes
	./unit-tests-6

.PHONY: debug-custom-tests
debug-custom-tests: custom-tests
	cgdb ./custom-tests

.PHONY: run-custom-tests
run-custom-tests: custom-tests
	./custom-tests

.PHONY: valgrind-test-free-state
valgrind-test-free-state: unit-tests
	valgrind --leak-check=full --track-origins=yes ./unit-tests -m

.PHONY: run-integration-tests
run-integration-tests: $(SHORTER_TESTS) $(LONGER_TESTS) run-nonexistent-input-file-test

.PHONY: run-nonexistent-input-file-test
run-nonexistent-input-file-test: snake
	@bash tools/test_nonexistent_input_file.sh

.PHONY: $(SHORTER_TESTS)
$(SHORTER_TESTS): snake check-hashes
	@sed 's/\r$$//g' "tests/$(@F)-in.snk" > "tests/.$(@F)-in.snk.tmp"
	@mv "tests/.$(@F)-in.snk.tmp" "tests/$(@F)-in.snk"
	@sed 's/\r$$//g' "tests/$(@F)-ref.snk" > "tests/.$(@F)-ref.snk.tmp"
	@mv "tests/.$(@F)-ref.snk.tmp" "tests/$(@F)-ref.snk"
	@rm -f "tests/$(@F)-out.snk"
	./snake -i "tests/$(@F)-in.snk" -o "tests/$(@F)-out.snk"
	diff "tests/$(@F)-ref.snk" "tests/$(@F)-out.snk"
	@echo "${COLOR_GREEN}Passed $(@F)${COLOR_RESET}"

.PHONY: $(LONGER_TESTS)
$(LONGER_TESTS): snake check-hashes
	@sed 's/\r$$//g' "tests/$(@F)-in.snk" > "tests/.$(@F)-in.snk.tmp"
	@mv "tests/.$(@F)-in.snk.tmp" "tests/$(@F)-in.snk"
	@sed 's/\r$$//g' "tests/$(@F)-ref.snk" > "tests/.$(@F)-ref.snk.tmp"
	@mv "tests/.$(@F)-ref.snk.tmp" "tests/$(@F)-ref.snk"
	@rm -f "tests/$(@F)-out.snk"
	./snake -i "tests/$(@F)-in.snk" -o "tests/$(@F)-out.snk"
	diff -q "tests/$(@F)-ref.snk" "tests/$(@F)-out.snk"
	@echo "${COLOR_GREEN}Passed $(@F)${COLOR_RESET}"
