#include <curses.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DELAY (80000)

int main() {
  initscr();
  noecho();
  cbreak();
  keypad(stdscr, TRUE);
  curs_set(FALSE);
  clear();

  char *test = "Hallo Ela, wie geht's? Schau mal hier ...";

  char buf;
  while ((buf = *test++) != '\0') {
    addch(buf);
    refresh();
    usleep(80000);
  }

  sleep(3);

  size_t x = 0, y = 2, max_y, max_x, next_x;
  int direction = 1;

  getmaxyx(stdscr, max_y, max_x);

  while (1) {
    clear();
    mvprintw(y, x, "o_O");
    refresh();
    usleep(DELAY);

    next_x = x + direction;

    if (next_x >= max_x - 2 || next_x < 0) {
      direction *= -1;
    } else {
      x += direction;
    }
  }

  endwin();

  return EXIT_SUCCESS;
}
