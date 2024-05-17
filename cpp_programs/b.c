//b.c ohhh yeahhh
#include "stdio.h"

int main(int argc, char *argv[])
{
  printf("format string\n\r");
  int i = 0;
  for (i = 0; i < 99; ++i) {
    printf("%d\n\r", i);
    if ( i == 66) {
      printf("devils number\n\r");
      return 0;
    }
  }
  return 0;
}
