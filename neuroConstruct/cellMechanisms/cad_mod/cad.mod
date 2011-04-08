TITLE Calcium dynamics for RD Traub, J Neurophysiol 89:909-921, 2003

COMMENT

	Implemented by Maciej Lazarewicz 2003 (mlazarew@seas.upenn.edu)

ENDCOMMENT

NEURON {
    SUFFIX %Name%
	USEION ca READ ica WRITE cai
	RANGE  phi, beta
	GLOBAL ceiling
}

UNITS {
	(mA)	= (milliamp)
	(mM) = (milli/liter)
}

PARAMETER {
    :: Below are original lines. PG added default values for testing
	:::::::::phi		(100/coulomb meter)
	:::::::::beta		(/ms)
	:::::::::ceiling		(mM)
    
    phi = 26000     (100/coulomb meter)
    beta =0.01      (/ms)
    ceiling = 1000000  (mM) 
}

STATE {	cai (mM) }

INITIAL { 
	cai = 0 : 50e-6 
}

ASSIGNED { 
	ica		(mA/cm2) 
}
	
BREAKPOINT {
	SOLVE state METHOD cnexp
	if( cai < 0 ){ cai = 0 }
	if( cai > ceiling ){ cai = ceiling }
}

DERIVATIVE state { 
:	cai' = - phi * ica - beta * (cai - 50e-6) 
	cai' = - phi * ica - beta * (cai) 
}
