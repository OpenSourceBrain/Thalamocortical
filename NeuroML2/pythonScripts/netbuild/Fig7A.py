####################################################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
####################################################################################

###########  Main settings  ########################################################

ref =                   "Figure7AeLoSS"

simConfig=              "TempSimConfig"

simDuration =           10 # ms          original duration 1000 ms                      ##
simDt =                 0.025 # ms
neuroConstructSeed =    134344                                  ##

simulator =             "jNeuroML_NEURON"   ### "jNeuroML_NEURON"

defaultSynapticDelay =  0.05 

scaleCortex =             0.2                           ##
scaleThalamus =           0                                  ##

gabaScaling =             0.05                               ##

l4ssAmpaScaling =         1                            ##

inNrtTcrNmdaScaling =    0.2

pyrSsNmdaScaling =       2.5

deepBiasCurrent =        -1

from RunColumn import *

RunColumnSimulation(net_id=ref,
                    nml2_source_dir="../../../neuroConstruct/generatedNeuroML2/",
                    sim_config=simConfig,
                    scale_cortex=scaleCortex,
                    scale_thalamus=scaleThalamus,
                    default_synaptic_delay=defaultSynapticDelay,
                    gaba_scaling=gabaScaling,
                    l4ss_ampa_scaling=l4ssAmpaScaling,
	            in_nrt_tcr_nmda_scaling=inNrtTcrNmdaScaling,
	            pyr_ss_nmda_scaling=pyrSsNmdaScaling,
	            deep_bias_current=deepBiasCurrent,
                    which_models='all',
                    dir_nml2="../../",
                    duration=simDuration,
                    dt=simDt,
                    max_memory='4000M',
                    seed=neuroConstructSeed,
                    simulator=simulator)


