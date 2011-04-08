#
#
#   File to test current config of Thalamocortical project. 
#
#   Author: Padraig Gleeson
#
#   This file has been developed as part of the neuroConstruct project
#   This work has been funded by the Medical Research Council and the
#   Wellcome Trust
#
#

import sys
import time

from java.io import File
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

#simConfigs.append("Default Simulation Configuration")

#simConfigs.append("Cell1-supppyrRS-FigA1RS")

#simConfigs.append("Cell2-suppyrFRB-FigA1FRB")

#simConfigs.append("Cell5-supLTS-FigA2b")

#simConfigs.append("Cell6-spinstell-FigA3-333")

#simConfigs.append("Cell9-nontuftRS-FigA6-1000")

simConfigs.append("Cell14-nRT-FigA8-00")


simulators =            ["N", "G", "M"]
#maxElecLens =           [0.01,0.005, 0.0025]
#maxElecLens =           [0.01,0.0075, 0.005, 0.0025, 0.001, 0.00075, 0.0005]
maxElecLens =           [0.025, 0.01, 0.0075, 0.005, 0.0025, 0.001, 0.00075, 0.0005, 0.00025, 0.0001]
maxElecLens =           [0.025, 0.01, 0.0075, 0.005, 0.0025]
#maxElecLens =           [.025, 0.01,  0.005, 0.0025]  
#maxElecLens =           [0.01, 0.005, 0.0025, 0.001]

#simAllPrefix =          ""
simAllPrefix =          "Lodt_"
simAllPrefix =          "Looodt_"

numSpikes =             3

verbose = True

#############################################

print "Loading project from "+ projFile.getCanonicalPath()

pm = ProjectManager()
project = pm.loadProject(projFile)

allFinishedSims = []

plotVoltageOnly = True
plotSomaOnly = True
plotSims = False


allSpikeTimeDataSets = {}

for simConfigName in simConfigs:
    
  totNumSpikes = -1

  for maxElecLenIndex in range(0,len(maxElecLens)):
      
    maxElecLen = maxElecLens[maxElecLenIndex]


    for sim in simulators:


        recompSuffix = "_"+str(maxElecLen)

        simRefPrefix = (simAllPrefix+simConfigName+"_").replace(' ', '')

        simRef = simRefPrefix+"_"+sim+recompSuffix

        simDir = File(projFile.getParentFile(), "/simulations/"+simRef)
        timeFile = File(simDir, "time.dat")


        if not timeFile.exists():
            print "\n-------     Error loading data from simulation in directory: %s\n"%simDir.getCanonicalPath()
        else:
            if verbose: print "--- Reloading data from simulation in directory: %s"%simDir.getCanonicalPath()
            time.sleep(1) # wait a while...

            try:
                simData = SimulationData(simDir)
                simData.initialise()
                times = simData.getAllTimes()


                cellSegmentRef = simData.getAllLoadedDataStores().get(0).getCellGroupName()+"_0"
                print "Looking for voltages of "+cellSegmentRef
                volts = simData.getVoltageAtAllTimes(cellSegmentRef)

                if verbose: print "Got "+str(len(volts))+" data points on cell seg ref: "+cellSegmentRef

                analyseStartTime = 0
                analyseStopTime = 2000
                analyseThreshold = -20 # mV

                spikeTimes = SpikeAnalyser.getSpikeTimes(volts, times, analyseThreshold, analyseStartTime, analyseStopTime)

                #print "Spike times in %s for sim %s: %s"%(cellSegmentRef, simRef, str(spikeTimes))
                
                if totNumSpikes <0: totNumSpikes = len(spikeTimes)
                
                for spikeIndex in range(max(totNumSpikes-numSpikes, 0), totNumSpikes):
                        
                    spikeTimeTrace = "Times_"+sim+"_"+simConfigName+"_"+str(spikeIndex)
        
                    if not allSpikeTimeDataSets.has_key(spikeTimeTrace):
                        ds = DataSet(spikeTimeTrace, spikeTimeTrace, "", "ms", "Number of compartments", "Spike time")
                        allSpikeTimeDataSets[spikeTimeTrace] = ds
                    
                    
                    spikeTrace = allSpikeTimeDataSets[spikeTimeTrace]
                    print "Adding point to "+spikeTimeTrace
                    #pointNum = spikeTrace.addPoint(1/maxElecLen, spikeTimes[-1])
                    ##pointNum = spikeTrace.addPoint(1/maxElecLen, spikeTimes[spikeIndex])
                    morphProp = simData.getSimulationProperties().getProperty("Morph summary nRT")
                    comps = morphProp.split(":")[-1]

                    pointNum = spikeTrace.addPoint(float(comps), spikeTimes[spikeIndex])

                    #spikeTrace.setCommentOnPoint(pointNum, "Point for electrotonic len: "+str(maxElecLen))
                    spikeTrace.setCommentOnPoint(pointNum, morphProp)
    
                    if plotSims:
                        simConfigName = simData.getSimulationProperties().getProperty("Sim Config")
    
                        if simConfigName.find('(')>=0:
                            simConfigName = simConfigName[0:simConfigName.find('(')]
    
                        for dataStore in simData.getAllLoadedDataStores():
    
                            ds = simData.getDataSet(dataStore.getCellSegRef(), dataStore.getVariable(), False)
                            
    
                            if not plotVoltageOnly or dataStore.getVariable() == SimPlot.VOLTAGE:
                                if not plotSomaOnly or dataStore.getAssumedSegmentId() == 0:
    
                                    plotFrame = PlotManager.getPlotterFrame("Behaviour of "+dataStore.getVariable() \
                                        +" on: %s for sim config: %s"%(str(simulators), simConfigName))
                                        
    
                                    plotFrame.addDataSet(ds)



            except:
                print "Error analysing simulation data from: %s"%simDir.getCanonicalPath()
                print sys.exc_info()


for simConfigName in simConfigs:
    frame = PlotManager.getPlotterFrame("Times of "+simConfigName)
    
    frame.setKeepDataSetColours(True)
                                    
    for dsRef in allSpikeTimeDataSets.keys():
        if simConfigName in dsRef:

            ds = allSpikeTimeDataSets[dsRef]

            if  '_N_' in dsRef: ds.setGraphColour(Color.black)
            elif '_G_' in dsRef: ds.setGraphColour(Color.red)
            elif '_M_' in dsRef: ds.setGraphColour(Color.green)
            
            #ds.setGraphFormat(PlotCanvas.USE_CIRCLES_FOR_PLOT)
                            
            print ds
            frame.addDataSet(ds)




