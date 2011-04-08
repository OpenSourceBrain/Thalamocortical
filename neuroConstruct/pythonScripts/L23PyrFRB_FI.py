#
#
#   A file which generates a frequency vs current curve for cell in Thalamocortical project
#
#   Author: Padraig Gleeson
#
#   This file has been developed as part of the neuroConstruct project
#   This work has been funded by the Medical Research Council and the
#   Wellcome Trust
#
#

import sys
import os
import datetime

try:
	from java.io import File
except ImportError:
	print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
	print "See http://www.neuroconstruct.org/docs/python.html for more details"
	quit()

from math import *

sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")

import ncutils as nc
from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings


simConfig="Cell2-suppyrFRB-FigA1FRB"


#preStimAmp = -0.6
#preStimDel = 0
#preStimDur = 0

stimAmpLow = -1
stimAmpInc = 0.05
stimAmpHigh = 1

stimDel = 0
stimDur = 2000

simDuration = stimDur # ms

analyseStartTime = stimDel + 500 # So it's firing at a steady rate...
analyseStopTime = simDuration
analyseThreshold = -20 # mV


#mpiConfig =            MpiSettings.LOCAL_SERIAL    # Default setting: run on one local processor
mpiConfig =            MpiSettings.MATLEM_1PROC    # Run on one processor on UCL cluster

numConcurrentSims = 4
if mpiConfig != MpiSettings.LOCAL_SERIAL: numConcurrentSims = 30
suggestedRemoteRunTime = 33   # mins



# Load neuroConstruct project

projFile = File("../Thalamocortical.ncx")

simManager = nc.SimulationManager(projFile,
                                  numConcurrentSims)

start = "\nSimulations started at: %s"%datetime.datetime.now()

simManager.generateFICurve("NEURON",
                           simConfig,
                           stimAmpLow,
                           stimAmpInc,
                           stimAmpHigh,
                           stimDel,
                           stimDur,
                           simDuration,
                           analyseStartTime,
                           analyseStopTime,
                           analyseThreshold,
                           mpiConfig =                mpiConfig,
                           suggestedRemoteRunTime =   suggestedRemoteRunTime)

finish = "Simulations finished at: %s\n"%datetime.datetime.now()

print start
print finish

