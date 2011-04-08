#
#
#   A file which generates a frequency vs current curve for various cells
#
#   Author: Padraig Gleeson
#
#   This file has been developed as part of the neuroConstruct project
#   This work has been funded by the Medical Research Council and the
#   Wellcome Trust
#
#

from sys import *

from java.io import File
from GenerateF_ICurve import FreqVsCurrentGenerator

from math import *

#simConfig="Cell3-supbask-FigA2a"
simConfig="Cell6-spinstell-FigA3-167"
#simConfig="Cell2-suppyrFRB-FigA1FRB"


preStimAmp = -0.6
preStimDel = 0
preStimDur = 400

stimAmpLow = -0.8
stimAmpInc = 0.2
stimAmpHigh = 1

stimDel = preStimDur
stimDur = 1400

simDuration = preStimDur + stimDur # ms

analyseStartTime = stimDel + 300 # So it's firing at a steady rate...
analyseStopTime = simDuration
analyseThreshold = -20 # mV

# Change this number to the number of processors you wish to use on your local machine
maxNumSimultaneousSims = 4

simulator = "GENESIS"
#simulator = "NEURON"


# Load neuroConstruct project

projFile = File("../Thalamocortical.ncx")

gen = FreqVsCurrentGenerator()

gen.generateF_ICurve(projFile,
                 simulator,
                 simConfig,
                 preStimAmp, preStimDel, preStimDur,
                 stimAmpLow, stimAmpInc, stimAmpHigh,
                 stimDel, stimDur,
                 simDuration,
                 analyseStartTime, analyseStopTime,
                 analyseThreshold,
                 maxNumSimultaneousSims)


