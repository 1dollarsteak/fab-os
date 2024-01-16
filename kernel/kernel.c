#include "../drivers/screen.h"

void main() {
  //print_char('0', 1, 1, WHITE_ON_BLACK);
  //print_at("0", 1, 1);
  const char* a = "XXX";
  char* video_memory = (char*) 0xb8000; // 0x101b?
  video_memory[0] = a[0];
  video_memory[1] = 0x0f;
  //print("text");
  // b 0x1031 (bisschen eher 1023)
  // (watch write 0xb8000)
  // c
  // trace on
  // s s ...
  // x /2xb 0xb8000
  // XXX is instead at memory 0x222b but it is searched at 0x1212
}
