# -*- coding: utf-8 -*-
#
#
#   File to test cells in Thalamocortical project.
#
#   To execute this type of file, type '..\..\..\nC.bat -python XXX.py' (Windows)
#   or '../../../nC.sh -python XXX.py' (Linux/Mac). Note: you may have to update the
#   NC_HOME and NC_MAX_MEMORY variables in nC.bat/nC.sh
#
#   NOTE: many of the cells will not match well between NEURON, GENESIS and MOOSE
#   until the spatial discretisation (maxElecLens below) is made finer and the
#   simDt is made smaller!!
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

try:
    from java.io import File
except ImportError:
    print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
    print "See http://www.neuroconstruct.org/docs/python.html for more details"
    quit()

sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")

import ncutils as nc # Many useful functions such as SimManager.runMultipleSims found here
from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings


projFile = File(os.getcwd(), "../Thalamocortical.ncx")



##############  Main settings  ##################

mpiConfig =               MpiSettings.LOCAL_SERIAL

simConfigs = []

simConfigs.append("TestNML2")


simDt =                 0.0005

neuroConstructSeed =    12345
simulatorSeed =         11111

simulators =            ["NEURON", "LEMS"]



varTimestepNeuron =     False
varTimestepTolerance =  0.00001

analyseSims =           True
plotSims =              True
plotVoltageOnly =       True


simAllPrefix =          ""   # Adds a prefix to simulation reference

runInBackground =       True #(mpiConf == MpiSettings.LOCAL_SERIAL)

suggestedRemoteRunTime = 233

verbose =               True

spike_times = []
mep_file = open('.test.mep')
for line in mep_file:
    line = line.strip()
    if line.startswith('spike times: ['):
        times = line[14:-1].split(',')
        for time in times:
            spike_times.append(float(time.strip()))

#############################################


def testAll(argv=None):
    if argv is None:
        argv = sys.argv

    print "Loading project from "+ projFile.getCanonicalPath()


    simManager = nc.SimulationManager(projFile,
                                      verbose = verbose)

    simManager.runMultipleSims(simConfigs =              simConfigs,
                               simDt =                   simDt,
                               simulators =              simulators,
                               runInBackground =         runInBackground,
                               varTimestepNeuron =       varTimestepNeuron,
                               varTimestepTolerance =    varTimestepTolerance,
                               mpiConfig =               mpiConfig)

    simManager.reloadSims(plotVoltageOnly =   plotVoltageOnly,
                          plotSims =          plotSims,
                          analyseSims =       analyseSims)
                          
    report= ""


    # These were discovered using analyseSims = True above.
    # They need to hold for all simulators
    spikeTimesToCheck = {'CG_tester_0': spike_times}

    spikeTimeAccuracy = 0.001

    report0 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
                  spikeTimeAccuracy = spikeTimeAccuracy)

    print report0
    report = report + report0+"\n"
    

    return report


if __name__ == "__main__":
    testAll()
