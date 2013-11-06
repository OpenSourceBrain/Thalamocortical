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

// more excerpts from hoc.c

execerror(s, t)	/* recover from run-time error */
	char *s, *t;
{
	extern int hoc_in_yyparse;
	hoc_in_yyparse = 0;
	yystart = 1;
      	hoc_menu_cleanup();
	hoc_errno_check();
#if 0
	hoc_xmenu_cleanup();
#endif
	if (debug_message_ || hoc_execerror_messages) {
		warning(s, t);
		frame_debug();
#if defined(__GO32__)
		{extern int egagrph;
		if (egagrph) {
			hoc_outtext("Error:");
			hoc_outtext(s);
			if (t) {
				hoc_outtext(" ");
				hoc_outtext(t);
			}
			hoc_outtext("\n");
		}}
#endif
	}
	if (oc_jump_target_) {
		(*oc_jump_target_)();
	}
	if (nrnmpi_numprocs &gt; 1) {
		nrnmpi_abort(-1);
	}
	hoc_execerror_messages = 1;
	if (pipeflag == 0)
		IGNORE(fseek(fin, 0L, 2));	/* flush rest of file */
	hoc_oop_initaftererror();
	if (hoc_oc_jmpbuf) {
		longjmp(hoc_oc_begin, 1);
	}
	longjmp(begin, 1);
}

SIG_RETURN_TYPE
onintr(sig) int sig;	/* catch interrupt */
{
	/*ARGSUSED*/
	stoprun = 1;
	if (intset++)
		execerror("interrupted", (char *) 0);
	IGNORE(signal(SIGINT, onintr));
}

static int coredump;

hoc_coredump_on_error() {
	coredump = 1;
	ret();
	pushx(1.);
}

int matherr1() {
	/* above gives the signal but for some reason fegetexcept returns 0 */
	switch(fegetexcept()) {
	case FE_DIVBYZERO:
		fprintf(stderr, "Floating exception: Divide by zero\n");
		break;
	case FE_INVALID:
		fprintf(stderr, "Floating exception: Invalid (no well defined result\n");
		break;
	case FE_OVERFLOW:
		fprintf(stderr, "Floating exception: Overflow\n");
		break;
	}
}

SIG_RETURN_TYPE
fpecatch(sig) int sig;	/* catch floating point exceptions */
{
#if NRN_FLOAT_EXCEPTION &amp;&amp; linux
	matherr1();
#endif
	if (coredump) {
		abort();
	}
	signal(SIGFPE, fpecatch);
	execerror("floating point exception", (char *) 0);
}

#if HAS_SIGSEGV
SIG_RETURN_TYPE
sigsegvcatch(sig) int sig;	/* segmentation violation probably due to arg type error */
{
	/*ARGSUSED*/
	if (coredump) {
		abort();
	}
	execerror("Segmentation violation", "See $NEURONHOME/lib/help/oc.help");
}
#endif

#if HAS_SIGBUS
SIG_RETURN_TYPE
sigbuscatch(sig) int sig;
{
	/*ARGSUSED*/
	if (coredump) {
		abort();
	}
	execerror("Bus error", "See $NEURONHOME/lib/help/oc.help");
}
#endif

