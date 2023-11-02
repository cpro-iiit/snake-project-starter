#include "unit_tests.h"

int main(int argc, char* argv[]) {
  bool MEMCHECK_MODE = false;

  // Parse arguments
  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-m") == 0) {
      MEMCHECK_MODE = true;
      continue;
    }
    fprintf(stderr, "Usage: %s [-m]\n", argv[0]);
    return 1;
  }

  init_colors();

  printf("%s\n", "Reminder: These tests are not comprehensive, and passing them does not guarantee that your implementation is working.");

  if (MEMCHECK_MODE) {
    printf("\nTesting free_state...\n");
    if (!test_free_state()) {
      exit(1);
    }
  } else {
   
    if (!test_and_print("find_head (Task 6)", test_find_head)) {
      exit(1);
    }
    if (!test_and_print("initialize_snakes (Task 6)", test_initialize_snakes)) {
      exit(1);
    }
  }
}
