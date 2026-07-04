#include <stdio.h>
#include "counter.h"

/* Persists across calls for the lifetime of the simulation. */
static int counter = 0;

int increment_counter(char data)
{
    counter++;
    printf("[C] increment_counter() called with data=0x%02X, counter now=%d\n",
           (unsigned char)data, counter);
    return counter;
}
