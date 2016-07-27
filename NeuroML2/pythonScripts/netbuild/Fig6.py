####################################################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
####################################################################################

###########  Main settings  ########################################################

ref =                   "Figure6eNoESS"

simConfig=              "TempSimConfig"

simDuration =           1000 # ms                                ##
simDt =                 0.025 # ms
neuroConstructSeed =    127439                                      ##

simulator =             None   ### "jNeuroML_NEURON"

defaultSynapticDelay =  0.05 

scaleCortex =             0.2                          ##
scaleThalamus =           0                              ##

gabaScaling =             0.1                          ##

l4ssAmpaScaling =         0.25                           ##

deepBiasCurrent =         0.1             #### 0.05 -> 0.15

from RunColumn import *

RunColumnSimulation(net_id=ref,
                    nml2_source_dir="../../../neuroConstruct/generatedNeuroML2/",
                    sim_config=simConfig,
                    scale_cortex=scaleCortex,
                    scale_thalamus=scaleThalamus,
                    default_synaptic_delay=defaultSynapticDelay,
                    gaba_scaling=gabaScaling,
                    l4ss_ampa_scaling=l4ssAmpaScaling,
	            deep_bias_current=deepBiasCurrent,
                    which_models='all',
                    dir_nml2="../../",
                    duration=simDuration,
                    dt=simDt,
                    max_memory='1000M',
                    seed=neuroConstructSeed,
                    simulator=simulator)

