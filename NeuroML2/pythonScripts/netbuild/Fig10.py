##############################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
##############################################################

###########  Main settings  ###########

ref =                   "Figure10"

simConfig=              "TempSimConfig"
simDuration =           800 # ms                                ##
simDt =                 0.025 # ms
neuroConstructSeed =    1333                                   ##

simulator =             "jNeuroML_NEURON"   # "jNeuroML_NEURON"

defaultSynapticDelay =  0.05 

scaleCortex =             0.1                               ##
scaleThalamus =           0                                     ##

gabaScaling =             0.2                               ##
l4ssAmpaScaling =         0.25                              ##

l5PyrGapScaling =         0

inNrtTcrNmdaScaling =    0.2
pyrSsNmdaScaling =       2.5

deepBiasCurrent =         0.4 #######################################  0.35 -> 0.45                               ##

from RunColumn import *

RunColumnSimulation(net_id=ref,
                    nml2_source_dir="../../../neuroConstruct/generatedNeuroML2/",
                    sim_config=simConfig,
                    scale_cortex=scaleCortex,
                    scale_thalamus=scaleThalamus,
                    default_synaptic_delay=defaultSynapticDelay,
                    gaba_scaling=gabaScaling,
                    l4ss_ampa_scaling=l4ssAmpaScaling,
                    l5pyr_gap_scaling=l5PyrGapScaling,
	            in_nrt_tcr_nmda_scaling=inNrtTcrNmdaScaling,
	            pyr_ss_nmda_scaling=pyrSsNmdaScaling,
	            deep_bias_current=deepBiasCurrent,
                    which_models='all',
                    dir_nml2="../../",
                    duration=simDuration,
                    dt=simDt,
                    max_memory='8000M',
                    seed=neuroConstructSeed,
                    simulator=simulator)

