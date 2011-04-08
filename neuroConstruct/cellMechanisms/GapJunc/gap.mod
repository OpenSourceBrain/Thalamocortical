NEURON {
    POINT_PROCESS %Name%
    NONSPECIFIC_CURRENT i
    RANGE g, i
    RANGE weight
    POINTER vgap
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
