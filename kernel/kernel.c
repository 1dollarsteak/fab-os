#include "../drivers/screen.h"

void main() {
  print_char('0', 0, 5, WHITE_ON_BLACK);
  //print_at("X", 1, 1);
  char* video_memory = (char*) 0xb8000;
  //*video_memory = 'X';
}
