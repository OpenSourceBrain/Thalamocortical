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
#   Author: Padraig Gleeson; Modified by: Rokas Stanislovas GSoC 2016 project Cortical Networks
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
from java.lang.management import ManagementFactory


projFile = File(os.getcwd(), "../Thalamocortical.ncx")



##############  Main settings  ##################

mpiConfig =               MpiSettings.MATLEM_1PROC
mpiConfig =               MpiSettings.LOCAL_SERIAL

simConfigs = []

#simConfigs.append("Default Simulation Configuration")

##########################################################################
#
#          Note: any of the sim configs below will need a small dt and
#          a fine spatial discretisation (maxElecLens) to have a close
#          match between NEURON, MOOSE & GENESIS
#
#simConfigs.append("Cell1-supppyrRS-FigA1RS")
#simConfigs.append("Cell2-suppyrFRB-FigA1FRB")   # use maxElecLens = 0.01
#simConfigs.append("Cell3-supbask-FigA2a")
#simConfigs.append("Cell4-supaxax-FigA2a")
#simConfigs.append("Cell5-supLTS-FigA2b")
#simConfigs.append("Cell6-spinstell-FigA3-333")
#simConfigs.append("Cell7-tuftIB-FigA4-1500")
#simConfigs.append("Cell7-tuftIB-FigA4-1300")
#simConfigs.append("Cell8-tuftRS-Fig5A-1400")
#simConfigs.append("Cell9-nontuftRS-FigA6-1000")
#simConfigs.append("Cell12-deepLTS-FigA2b")
#simConfigs.append("Cell13-TCR-FigA7-600")
#simConfigs.append("Cell14-nRT-FigA8-00")

simConfigs.append("Cell1-supppyrRS-10ms")
simConfigs.append("Cell2-suppyrFRB-10ms")   
simConfigs.append("Cell3-supbask-10ms")
simConfigs.append("Cell4-supaxax-10ms")
simConfigs.append("Cell5-supLTS-10ms")
simConfigs.append("Cell6-spinstell-10ms")
simConfigs.append("Cell7-tuftIB-10ms")
simConfigs.append("Cell8-tuftRS-10ms")
simConfigs.append("Cell9-nontuftRS-10ms")
simConfigs.append("Cell10-deepbask-10ms")
simConfigs.append("Cell11-deepaxax-10ms")
simConfigs.append("Cell12-deepLTS-10ms")
simConfigs.append("Cell13-TCR-10ms")
simConfigs.append("Cell14-nRT-10ms")

##########################################################################

#simDt =                 0.005
simDt=                   0.01   # for newly added mep tests which will be used for omv tests with jNeuroML_NEURON

neuroConstructSeed =    12345
simulatorSeed =         11111
#simulators =            ["NEURON", "GENESIS_PHYS",  "MOOSE_PHYS", "MOOSE_SI"]  #"GENESIS_SI",
#simulators =            ["NEURON", "GENESIS_PHYS"]  #"GENESIS_SI",
#simulators =            ["GENESIS", "MOOSE"]
simulators =            ["NEURON"]


#maxElecLens =           [0.01]  # 0.01 will give ~700 in FRB & RS
#maxElecLens =            [-1]  # -1 means don't recompartmentalise use settings in proj
#maxElecLens =           [0.025, 0.01,0.005, 0.0025, 0.001,0.0005, 0.00025, 0.0001]
#### Note: the function testAll() below does not recompartmentalise the cells

numConcurrentSims =     ManagementFactory.getOperatingSystemMXBean().getAvailableProcessors() -1

if mpiConfig != MpiSettings.LOCAL_SERIAL: 
  numConcurrentSims = 60
suggestedRemoteRunTime = 80   # mins

varTimestepNeuron =     False  # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON
varTimestepTolerance =  0.00001

analyseSims =           True
plotSims =              True
plotVoltageOnly =       True


simAllPrefix =          ""   # Adds a prefix to simulation reference

runInBackground =       True #(mpiConf == MpiSettings.LOCAL_SERIAL)

suggestedRemoteRunTime = 233

verbose =               True

#############################################


def testAll(argv=None):
    if argv is None:
        argv = sys.argv

    print "Loading project from "+ projFile.getCanonicalPath()


    simManager = nc.SimulationManager(projFile,
                                      numConcurrentSims = numConcurrentSims,
                                      verbose = verbose)

    simManager.runMultipleSims(simConfigs =              simConfigs,
                               simDt =                   simDt,
                               simulators =              simulators,
                               runInBackground =         runInBackground,
                               varTimestepNeuron =       varTimestepNeuron,
                               varTimestepTolerance =    varTimestepTolerance,
                               mpiConfig =               mpiConfig,
                               suggestedRemoteRunTime =  suggestedRemoteRunTime)

    simManager.reloadSims(plotVoltageOnly =   plotVoltageOnly,
                          plotSims =          plotSims,
                          analyseSims =       analyseSims)
                          
    report= ""
    
    
    

    return report


if __name__ == "__main__":
    testAll()
