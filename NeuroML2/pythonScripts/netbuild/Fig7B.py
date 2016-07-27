####################################################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
####################################################################################

###########  Main settings  ########################################################

ref =                   "Figure7BeLoSS5NoESS"

simConfig=              "TempSimConfig"

simDuration =           1000 # ms                                ##
simDt =                 0.025 # ms
neuroConstructSeed =     1333                                     ##

simulator =             None   ### "jNeuroML_NEURON"

defaultSynapticDelay =  0.05 

scaleCortex =             0.2                           ##
scaleThalamus =           0                                  ##

gabaScaling =             0.1                           ##

l4ssAmpaScaling =         2                            ##

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
                    max_memory='1000M',
                    seed=neuroConstructSeed,
                    simulator=simulator)

