# -*- coding: utf-8 -*-
#
#
#   File to generate network for execution on parallel NEURON
#   Note this script has only been tested with UCL's cluster!
#
#   Author: Padraig Gleeson
#
#   This file has been developed as part of the neuroConstruct project
#   This work has been funded by the Medical Research Council and the
#   Wellcome Trust
#
#

from sys import *
from time import *


from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings

print "Starting..."

###########  Main settings  ###########

ref = "Figure10"

simConfig=              "TempSimConfig"
simDuration =           800 # ms                                ##
simDt =                 0.025 # ms
neuroConstructSeed =    1333                                   ##
simulatorSeed =         2314                                   ##

simulators =             ["NEURON"]

simRefPrefix =          ref+"_"                               ##
suggestedRemoteRunTime = 1200                                     ##

defaultSynapticDelay =  0.05 

#mpiConf =               MpiSettings.LOCAL_SERIAL

#mpiConf =               MpiSettings.LEGION_32PROC
mpiConf =               MpiSettings.MATLEM_8PROC
mpiConf =               MpiSettings.MATLEM_DIRECT
#mpiConf =               MpiSettings.MATLEM_32PROC


scaleCortex =             0.1                               ##
scaleThalamus =           0                                     ##

gabaScaling =             0.2                               ##
l4ssAmpaScaling =         0.25                              ##

l5PyrGapScaling =         0

inNrtTcrNmdaScaling =    0.2
pyrSsNmdaScaling =       2.5

deepBiasCurrent =         0.4#######################################  0.35 -> 0.45                               ##


# Maximum electronic length of compartments (adjusts nseg etc.)
maxElecLenFRB =         -1  # 0.01 will give ~700, -1 will leave as is
maxElecLenRS =          0.01  # 0.01 will give ~700, -1 will leave as is

maxElecLenIN =         0.01  # 0.01 will give ~570, -1 will leave as is

maxElecLenSS =         0.01  # 0.01 will give ~XXX, -1 will leave as is

somaNseg =              -1 # 12


varTimestepNeuron =     False
verbose =               True
runInBackground=        False

print "Starting simulation of %s..."%ref

from RunColumn import runColumnSimulation



runColumnSimulation(simConfig=    		        simConfig,
		        simDuration = 			simDuration,
			simDt = 			simDt, 
			neuroConstructSeed = 		neuroConstructSeed,
			simulatorSeed = 		simulatorSeed,
			simulators = 			simulators,
			simRefPrefix =          	simRefPrefix,
			suggestedRemoteRunTime = 	suggestedRemoteRunTime,
			defaultSynapticDelay =  	defaultSynapticDelay,
			mpiConf = 			mpiConf,
			scaleCortex = 			scaleCortex,
			scaleThalamus = 		scaleThalamus,
			gabaScaling = 			gabaScaling,
			l4ssAmpaScaling = 		l4ssAmpaScaling,
			l5PyrGapScaling = 		l5PyrGapScaling,
			inNrtTcrNmdaScaling = 		inNrtTcrNmdaScaling,
			pyrSsNmdaScaling = 		pyrSsNmdaScaling,
			deepBiasCurrent = 		deepBiasCurrent,
			maxElecLenFRB = 		maxElecLenFRB,
			maxElecLenRS =          	maxElecLenRS,
			maxElecLenIN =         		maxElecLenIN,
			maxElecLenSS =         		maxElecLenSS,
			somaNseg =              	somaNseg,
			varTimestepNeuron =     	varTimestepNeuron,
			verbose =               	verbose,
			runInBackground = 		runInBackground)



print "Finished setting simulation %s running..."%ref
sleep(5)
exit()
