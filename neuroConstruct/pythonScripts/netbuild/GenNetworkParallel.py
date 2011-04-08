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

from java.io import File

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.utils import NumberGenerator
from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings
from ucl.physiol.neuroconstruct.simulation import SimulationsInfo
from ucl.physiol.neuroconstruct.cell.utils import CellTopologyHelper

path.append(environ["NC_HOME"]+"/pythonNeuroML/nCUtils")
import ncutils as nc

projFile = File("../../Thalamocortical.ncx")


###########  Main settings  ###########

simConfig=              "TempSimConfig"
simDuration =           300 # ms                                ##
simDt =                 0.025 # ms
neuroConstructSeed =    13433                                   ##
simulatorSeed =         23234                                   ##

simulators =             ["NEURON"]

simRefPrefix =          "Fig6_"                               ##
suggestedRemoteRunTime = 1620                                     ##

defaultSynapticDelay =  0.05 

#mpiConf =               MpiSettings.LOCAL_SERIAL

#mpiConf =               MpiSettings.LEGION_8PROC
#mpiConf =               MpiSettings.LEGION_64PROC
#mpiConf =             MpiSettings.LEGION_16PROC               ##
#mpiConf =               MpiSettings.LEGION_32PROC
mpiConf =               MpiSettings.MATLEM_8PROC
mpiConf =               MpiSettings.MATLEM_DIRECT
#mpiConf =               MpiSettings.MATLEM_32PROC


scaleCortex =             0.1                               ##
scaleThalamus =           0                                     ##

gabaScaling =             0.1                               ##
l4ssAmpaScaling =         0.2                              ##

deepBiasCurrent =         1                               ##





# Maximum electronic length of compartments (adjusts nseg etc.)
maxElecLenFRB =         -1  # 0.01 will give ~700, -1 will leave as is
maxElecLenRS =          0.01  # 0.01 will give ~700, -1 will leave as is

maxElecLenIN =         0.01  # 0.01 will give ~570, -1 will leave as is

maxElecLenSS =         0.01  # 0.01 will give ~XXX, -1 will leave as is

somaNseg =              -1 # 12


varTimestepNeuron =     False
verbose =               True
runInBackground=        False

############################################

numFRB =                50       #   full model: 50
numRS =                 1000     #   full model: 1000
numSupBask =            90       #   full model: 90
numSupAxAx =            90       #   full model: 90
numSupLTS =             90       #   full model: 90
numL4SpinStell =        240      #   full model: 240
numL5TuftIB =           800      #   full model: 800
numL5TuftRS =           200      #   full model: 200
numDeepBask =           100      #   full model: 100
numDeepAxAx =           100      #   full model: 100
numDeepLTS =            100      #   full model: 100
numL6NonTuftRS =        500      #   full model: 500


numTCR =                100      #   full model: 100
numnRT =                100      #   full model: 100


#######################################


### Load neuroConstruct project


import datetime

start = datetime.datetime.now()

print "Loading project %s from at %s " % (projFile.getCanonicalPath(),start.strftime("%Y-%m-%d %H:%M"))

pm = ProjectManager()
project = pm.loadProject(projFile)


### Set duration & timestep & simulation configuration

project.simulationParameters.setDt(simDt)
simConfig = project.simConfigInfo.getSimConfig(simConfig)
simConfig.setSimDuration(simDuration)


### Set simulation reference

index = 0
simRef = "%s%i"%(simRefPrefix,index)


while File( "%s/simulations/%s_N"%(project.getProjectMainDirectory().getCanonicalPath(), simRef)).exists():
    simRef = "%s%i"%(simRefPrefix,index)
    index = index+1

project.simulationParameters.setReference(simRef)


### Change num in each cell group

numFRB = int(scaleCortex * numFRB)
numRS = int(scaleCortex * numRS)
numSupBask = int(scaleCortex * numSupBask)
numSupAxAx = int(scaleCortex * numSupAxAx)
numSupLTS = int(scaleCortex * numSupLTS)
numL4SpinStell = int(scaleCortex * numL4SpinStell)
numL5TuftIB = int(scaleCortex * numL5TuftIB)
numL5TuftRS = int(scaleCortex * numL5TuftRS)
numDeepBask = int(scaleCortex * numDeepBask)
numDeepAxAx = int(scaleCortex * numDeepAxAx)
numDeepLTS = int(scaleCortex * numDeepLTS)
numL6NonTuftRS = int(scaleCortex * numL6NonTuftRS)

numTCR = int(scaleThalamus * numTCR)
numnRT = int(scaleThalamus * numnRT)

project.cellGroupsInfo.getCellPackingAdapter("CG3D_L23PyrFRB").setMaxNumberCells(numFRB) # Note only works if RandomCellPackingAdapter
project.cellGroupsInfo.getCellPackingAdapter("CG3D_L23PyrRS").setMaxNumberCells(numRS)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_SupBask").setMaxNumberCells(numSupBask)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_SupAxAx").setMaxNumberCells(numSupAxAx)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_SupLTS").setMaxNumberCells(numSupLTS)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_L4SpinStell").setMaxNumberCells(numL4SpinStell)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_L5TuftIB").setMaxNumberCells(numL5TuftIB)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_L5TuftRS").setMaxNumberCells(numL5TuftRS)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_DeepBask").setMaxNumberCells(numDeepBask)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_DeepAxAx").setMaxNumberCells(numDeepAxAx)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_DeepLTS").setMaxNumberCells(numDeepLTS)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_L6NonTuftRS").setMaxNumberCells(numL6NonTuftRS)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_TCR").setMaxNumberCells(numTCR)
project.cellGroupsInfo.getCellPackingAdapter("CG3D_nRT").setMaxNumberCells(numnRT)



### Change weights in synapses/gap junctions

for netConnName in simConfig.getNetConns():

    if gabaScaling != 1:

        SimulationsInfo.addExtraSimProperty("gabaWeightScaling", str(gabaScaling))
        synList = project.morphNetworkConnectionsInfo.getSynapseList(netConnName)
        
        for index in range(0, len(synList)):
            synName = project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(index).getSynapseType()
            if synName.count("GABAA")>0:
                print "Changing synaptic weight for syn %s in net conn %s by factor %f"%(synName, netConnName, gabaScaling)
            
                project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(index).setWeightsGenerator(NumberGenerator(gabaScaling))
                
    if l4ssAmpaScaling !=1:
      
        SimulationsInfo.addExtraSimProperty("l4ssAmpaScaling", str(l4ssAmpaScaling))
        synList = project.morphNetworkConnectionsInfo.getSynapseList(netConnName)
        
        for index in range(0, len(synList)):
            synName = project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(index).getSynapseType()
            if synName.count("Syn_AMPA_L4SS_L4SS")>0:
                print "Changing synaptic weight for syn %s in net conn %s by factor %f"%(synName, netConnName, l4ssAmpaScaling)
            
                project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(index).setWeightsGenerator(NumberGenerator(l4ssAmpaScaling))


### Change bias currents

for inputName in simConfig.getInputs():
  
    stim = project.elecInputInfo.getStim(inputName)
  
    if deepBiasCurrent >= 0:
	
        if stim.getCellGroup()=="CG3D_L5TuftIB" or stim.getCellGroup()=="CG3D_L5TuftRS" or stim.getCellGroup()=="CG3D_L6NonTuftRS":
        
	  print "Changing offset current in %s to %f"%(stim.getCellGroup(), deepBiasCurrent)
	  
	  stim.setAmp(NumberGenerator(deepBiasCurrent))
	  project.elecInputInfo.updateStim(stim)
       


### Change spatial discretisation of some cells. This will impact accuracy & simulation speed

if maxElecLenFRB > 0:
    frbCell = project.cellManager.getCell("L23PyrFRB_varInit")
    info = CellTopologyHelper.recompartmentaliseCell(frbCell, maxElecLenFRB, project)
    print "Recompartmentalised FRB cell: "+info
    if somaNseg > 0:
        frbCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)

if maxElecLenRS > 0:
    rsCell = project.cellManager.getCell("L23PyrRS")
    info = CellTopologyHelper.recompartmentaliseCell(rsCell, maxElecLenRS, project)
    print "Recompartmentalised RS cell: "+info
    if somaNseg > 0:
        rsCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)

if maxElecLenIN > 0:
    inCells = ["SupBasket", "SupAxAx","SupLTSInter","DeepBasket", "DeepAxAx","DeepLTSInter"]

    for inCellName in inCells:
        inCell = project.cellManager.getCell(inCellName)
        info = CellTopologyHelper.recompartmentaliseCell(inCell, maxElecLenIN, project)
        print "Recompartmentalised "+inCellName+" cell: "+info
        if somaNseg > 0:
            inCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)


### Change parallel configuration

mpiSettings = MpiSettings()
simConfig.setMpiConf(mpiSettings.getMpiConfiguration(mpiConf))
print "Parallel configuration: "+ str(simConfig.getMpiConf())

if suggestedRemoteRunTime > 0:
    project.neuronFileManager.setSuggestedRemoteRunTime(suggestedRemoteRunTime)
    project.genesisFileManager.setSuggestedRemoteRunTime(suggestedRemoteRunTime)


### Change synaptic delay associated with each net conn

for netConnName in simConfig.getNetConns():
    if netConnName.count("gap")==0:
        print "Changing synaptic delay in %s to %f"%(netConnName, defaultSynapticDelay)
        delayGen = NumberGenerator(defaultSynapticDelay)
        for synProps in project.morphNetworkConnectionsInfo.getSynapseList(netConnName):
            synProps.setDelayGenerator(delayGen)

# defaultSynapticDelay will be recorded in simulation.props and listed in SimulationBrowser GUI
SimulationsInfo.addExtraSimProperty("defaultSynapticDelay", str(defaultSynapticDelay))


### Generate network structure in neuroConstruct

pm.doGenerate(simConfig.getName(), neuroConstructSeed)

while pm.isGenerating():
        print "Waiting for the project to be generated with Simulation Configuration: "+str(simConfig)
        sleep(2)


print "Generated %i cells in %i cell groups" % (project.generatedCellPositions.getNumberInAllCellGroups(), project.generatedCellPositions.getNumberNonEmptyCellGroups())
print "Generated %i instances in %i network connections" % (project.generatedNetworkConnections.getNumAllSynConns(), project.generatedNetworkConnections.getNumNonEmptyNetConns())
print "Generated %i instances in %i elect inputs" % (project.generatedElecInputs.getNumberSingleInputs(), project.generatedElecInputs.getNonEmptyInputRefs().size())


if simulators.count("NEURON")>0:
    
    simRefN = simRef+"_N"
    project.simulationParameters.setReference(simRefN)

    nc.generateAndRunNeuron(project,
                            pm,
                            simConfig,
                            simRefN,
                            simulatorSeed,
                            verbose=verbose,
                            runInBackground=runInBackground,
                            varTimestep=varTimestepNeuron)
        
    sleep(2) # wait a while before running GENESIS...
    
if simulators.count("GENESIS")>0:
    
    simRefG = simRef+"_G"
    project.simulationParameters.setReference(simRefG)

    nc.generateAndRunGenesis(project,
                            pm,
                            simConfig,
                            simRefG,
                            simulatorSeed,
                            verbose=verbose,
                            runInBackground=runInBackground)
                            
    sleep(2) # wait a while before running MOOSE...


if simulators.count("MOOSE")>0:

    simRefM = simRef+"_M"
    project.simulationParameters.setReference(simRefM)

    nc.generateAndRunMoose(project,
                            pm,
                            simConfig,
                            simRefM,
                            simulatorSeed,
                            verbose=verbose,
                            runInBackground=runInBackground)
                            
    sleep(2) # wait a while before running GENESIS...


print "Finished running all sims, shutting down..."


stop = datetime.datetime.now()
print
print "Started: %s, finished: %s" % (start.strftime("%Y-%m-%d %H:%M"),stop.strftime("%Y-%m-%d %H:%M"))
print


sleep(5)
exit()
