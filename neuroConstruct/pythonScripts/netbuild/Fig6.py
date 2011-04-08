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

ref = "Figure6eNoESS"

simConfig=               "TempSimConfig"
simDuration =            1000 # ms                                ##
simDt =                  0.025 # ms
neuroConstructSeed =     127439                                   ##
simulatorSeed =          2314349                                  ##

simulators =             ["NEURON"]

simRefPrefix =           ref+"_"                               ##
suggestedRemoteRunTime = 1200                                     ##

defaultSynapticDelay =   0.05 

mpiConf =                MpiSettings.MATLEM_8PROC
mpiConf =               MpiSettings.MATLEM_DIRECT

scaleCortex =             0.2                               ##
scaleThalamus =           0                                     ##

gabaScaling =             0.1                               ##
l4ssAmpaScaling =         0.25                              ##

deepBiasCurrent =         0.1                               ##

###########  End of main settings  ###########


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
			deepBiasCurrent = 		deepBiasCurrent)



print "Finished setting simulation %s running..."%ref
sleep(5)
exit()
