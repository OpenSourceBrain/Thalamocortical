#define _GNU_SOURCE 1
#include "/home/hines/neuron/nrn/src/scopmath/f2c.h"
#include <fenv.h>

/* from web example: static void __attribute__ ((constructor)) */
int trapfpe_()
{
  /* Enable some exceptions.  At startup all exceptions are masked.  */
  feenableexcept (FE_INVALID|FE_DIVBYZERO|FE_OVERFLOW);
}
/* compile and link with

gcc -o libtrapfpe.a trapfpe.c
and then use it by adding -trapfpe to the g77 command line when linking */

