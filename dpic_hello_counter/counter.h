#ifndef COUNTER_H
#define COUNTER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Imported into SystemVerilog via:
 *   import "DPI-C" function int increment_counter(input byte data);
 *
 * SV `byte` <-> C `char`, SV `int` <-> C `int` (standard DPI-C mapping,
 * both 2-state so no svLogicVecVal handling needed).
 */
int increment_counter(char data);

#ifdef __cplusplus
}
#endif

#endif /* COUNTER_H */
