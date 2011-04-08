NEURON {
    POINT_PROCESS %Name%
    NONSPECIFIC_CURRENT i
    RANGE g, i
    RANGE weight
    RANGE vgap    ????    NOT POINTER, as in the serial case
}

PARAMETER {
    v (millivolt)
    vgap (millivolt)
    g = 1e-6 (microsiemens)
    weight = 1
}

ASSIGNED {
    i (nanoamp)
}

BREAKPOINT {
    i = weight * g * (v - vgap)
} 
