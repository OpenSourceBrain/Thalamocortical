TITLE Mod file for component: Component(id=DepCurr_L23RS_TO_CG3D_L23PyrRS_Pulse0_Cell0 type=pulseGenerator)

COMMENT

    This NEURON file has been generated by org.neuroml.export (see https://github.com/NeuroML/org.neuroml.export)
         org.neuroml.export  v1.5.0
         org.neuroml.model   v1.5.0
         jLEMS               v0.9.8.7

ENDCOMMENT

NEURON {
    POINT_PROCESS DepCurr_L23RS_TO_CG3D_L23PyrRS_Pulse0_Cell0
    ELECTRODE_CURRENT i
    RANGE weight                            : property
    RANGE delay                             : parameter
    RANGE duration                          : parameter
    RANGE amplitude                         : parameter
    
}

UNITS {
    
    (nA) = (nanoamp)
    (uA) = (microamp)
    (mA) = (milliamp)
    (A) = (amp)
    (mV) = (millivolt)
    (mS) = (millisiemens)
    (uS) = (microsiemens)
    (molar) = (1/liter)
    (kHz) = (kilohertz)
    (mM) = (millimolar)
    (um) = (micrometer)
    (umol) = (micromole)
    (S) = (siemens)
    
}

PARAMETER {
    
    weight = 1
    delay = 0 (ms)
    duration = 20000 (ms)
    amplitude = 0.077 (nA)
}

STATE {
    i (nA) 
    
}

INITIAL {
    rates()
    rates() ? To ensure correct initialisation.
    
}

BREAKPOINT {
    
    rates()
    if (t <  delay) {
        i = 0 ? standard OnCondition
    }
    
    if (t >=  delay  && t <  duration  +  delay) {
        i = weight  *  amplitude ? standard OnCondition
    }
    
    if (t >=  duration  +  delay) {
        i = 0 ? standard OnCondition
    }
    
    
}

PROCEDURE rates() {
    
    
     
    
}

