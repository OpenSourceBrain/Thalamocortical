####################################################################################
### Author : Rokas Stanislovas & Padraig gleeson
###
### GSoC 2016 project: Cortical Networks
####################################################################################

###########  Main settings  ########################################################

ref =                   "TestL23"

simConfig=              "TempSimConfig"

simDuration =           200 # ms          original duration 1000 ms                      ##
simDt =                 0.025 # ms
seed =    134344                                  ##

simulator =             None

defaultSynapticDelay =  0.05 

scaleCortex =             0.01                           ##
scaleThalamus =           0                                  ##

gabaScaling =             1                               ##

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
                    which_cell_types_to_include=['L23PyrRS','SupBasket','SupAxAx','SupLTSInter'],
                    include_gap_junctions=False,
                    backgroundL23Rate=1000,
                    dir_nml2="../../",
                    duration=simDuration,
                    dt=simDt,
                    max_memory='4000M',
                    seed=seed,
                    simulator=simulator)


