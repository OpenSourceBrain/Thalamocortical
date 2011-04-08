#
#
#   File to test reloading of network simulation dat & plotting NEURON, GENESIS, MOOSE
#   traces side by side
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
import time

from java.io import File
from java.awt import Color

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.simulation import SimulationData
from ucl.physiol.neuroconstruct.gui.plotter import PlotManager


sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")


projFile = File("../Thalamocortical.ncx")


simulators =            ["N", "G", "M"]
#simulators =            ["N"]


plotSims =              True
plotVoltageOnly =       True

print "Loading project from "+ projFile.getCanonicalPath()

pm = ProjectManager()
project = pm.loadProject(projFile)



#allSims = ["N_Hlodt_0_"]
allSims = ["Fin_11_"]

cellsegRefs = {}

cellsegRefs["CG_C04_FRB_sm_0"] = Color.black
cellsegRefs["CG_C04_FRB_sm_1"] = Color.black
cellsegRefs["CG_C04_RS_sm_0"] = Color.blue
cellsegRefs["CG_C04_RS_sm_1"] = Color.blue
cellsegRefs["CG_C04_LTS_sm_0"] = Color.red
cellsegRefs["CG_C04_LTS_sm_1"] = Color.red
'''
cellsegRefs["CG_C04_Bask_sm_0"] = Color.green
cellsegRefs["CG_C04_Bask_sm_1"] = Color.green
cellsegRefs["CG_C04_AxAx_sm_0"] = Color.yellow
cellsegRefs["CG_C04_AxAx_sm_1"] = Color.yellow
'''

print "Trying to reload sims: "+str(allSims)

for sim in simulators:

    for simRefPart in allSims:

        simRef = simRefPart + sim

        simDir = File(projFile.getParentFile(), "/simulations/"+simRef)
        timeFile = File(simDir, "time.dat")


        if timeFile.exists():
            print "--- Reloading data from simulation in directory: %s"%simDir.getCanonicalPath()
            time.sleep(1) # wait a while...

            try:
                simData = SimulationData(simDir)
                simData.initialise()
                times = simData.getAllTimes()


                if plotSims:


                    for dataStore in simData.getAllLoadedDataStores():

                        ds = simData.getDataSet(dataStore.getCellSegRef(), dataStore.getVariable(), False)

                        print dataStore.getCellSegRef()

                        if cellsegRefs.has_key(dataStore.getCellSegRef()):

                            ds.setGraphColour(cellsegRefs[dataStore.getCellSegRef()])

                            plotFrame = PlotManager.getPlotterFrame("Behaviour of "+dataStore.getVariable() \
                                +" on: %s for simulation ref: %s"%(sim, simRef))

                            plotFrame.setKeepDataSetColours(True)

                            plotFrame.addDataSet(ds)



            except:
                print "Error analysing simulation data from: %s"%simDir.getCanonicalPath()
                print sys.exc_info()









