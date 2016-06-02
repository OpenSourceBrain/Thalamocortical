#
#
#   File to obtain spike times for nC tests and omv tests 
#
#   Modified by: Rokas Stanislovas, from: SpikeTimes.py
# 
#   GSoC 2016 project Cortical Networks


import sys
import time

try:
    from java.io import File
except ImportError:
    print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
    print "See http://www.neuroconstruct.org/docs/python.html for more details"
    quit()

from java.awt import Color

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.simulation import SimulationData
from ucl.physiol.neuroconstruct.gui.plotter import PlotManager
from ucl.physiol.neuroconstruct.project import SimPlot
from ucl.physiol.neuroconstruct.simulation import SpikeAnalyser
from ucl.physiol.neuroconstruct.dataset import DataSet


projFile = File("../Thalamocortical.ncx")



##############  Main settings  ##################

simConfigs = []

simConfigs.append("Cell1-supppyrRS-FigA1RS")
simConfigs.append("Cell2-suppyrFRB-FigA1FRB")   
simConfigs.append("Cell3-supbask-FigA2a")
simConfigs.append("Cell4-supaxax-FigA2a")
simConfigs.append("Cell5-supLTS-FigA2b")
simConfigs.append("Cell6-spinstell-FigA3-333")
simConfigs.append("Cell7-tuftIB-FigA4-1500")
simConfigs.append("Cell8-tuftRS-Fig5A-1400")
simConfigs.append("Cell9-nontuftRS-FigA6-1000")
simConfigs.append("Cell12-deepLTS-FigA2b")
simConfigs.append("Cell13-TCR-FigA7-600")
simConfigs.append("Cell14-nRT-FigA8-00")


simulators =            ["N"]
maxElecLens =           [-1]


verbose = True

#############################################

print "Loading project from "+ projFile.getCanonicalPath()

pm = ProjectManager()
project = pm.loadProject(projFile)

allFinishedSims = []




allSpikeTimeDataSets = {}

if __name__=="__main__":
    
    
   for simConfigName in simConfigs:
    
       totNumSpikes = -1

       simRef = simConfigName+"__N"

       simDir = File(projFile.getParentFile(), "/simulations/"+simRef)
       timeFile = File(simDir, "time.dat")

       simData = SimulationData(simDir)
       simData.initialise()
       times = simData.getAllTimes()

       cellSegmentRef = simData.getAllLoadedDataStores().get(0).getCellGroupName()+"_0"
       print "Looking for voltages of "+cellSegmentRef
       volts = simData.getVoltageAtAllTimes(cellSegmentRef)

       if verbose:
          print "Got "+str(len(volts))+" data points on cell seg ref: "+cellSegmentRef

       analyseStartTime = 0
       analyseStopTime = 2000
       analyseThreshold = -20 # mV

       spikeTimes = SpikeAnalyser.getSpikeTimes(volts, times, analyseThreshold, analyseStartTime, analyseStopTime)
                
       print "Spike times in %s for sim %s: %s"%(cellSegmentRef, simRef, str(spikeTimes))
                
                




