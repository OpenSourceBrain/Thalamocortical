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

projFile = File("../Thalamocortical.ncx")


###########  Main settings  ###########

simConfig=              "CunninghamEtAl04_small"
simDuration =           250 # ms
simDt =                 0.005 # ms
neuroConstructSeed =    12345
simulatorSeed =         12345
#simulators =             ["NEURON", "GENESIS"]
#simulators =             ["NEURON", "GENESIS", "MOOSE"]
#simulators =             ["NEURON", "MOOSE"]
#simulators =             ["GENESIS"]
simulators =             ["NEURON"]
#simulators =             ["MOOSE"]
simRefPrefix =          "Fin_"
defaultSynapticDelay =  0.1
#mpiConf =               MpiSettings.CLUSTER_4PROC
#mpiConf =               MpiSettings.LEGION_8PROC
#mpiConf =               MpiSettings.LEGION_16PROC
mpiConf =               MpiSettings.LOCAL_SERIAL
mpiConf =               MpiSettings.MATLEM_8PROC
#mpiConf =               MpiSettings.LEGION_1PROC
#mpiConf =               MpiSettings.LEGION_16PROC
#mpiConf =               MpiSettings.LEGION_256PROC
#mpiConf =               'Matthau_6_8PROCS'
#mpiConf =               'Matthau_Lemmon_Test_56'
#mpiConf =                'Matthau_Lemmon_Test_ALL'

'''
numFRB =                3
numRS =                 3
numLTS =                0 
numBask =               0
numAxAx =               0
'''
numFRB =                6
numRS =                 20
numLTS =                10
numBask =               10
numAxAx =               10

# Maximum electronic length of compartments (adjusts nseg etc.)
maxElecLenFRB =         -1  # 0.01 will give ~700, -1 will leave as is
maxElecLenRS =          -1  # 0.01 will give ~700, -1 will leave as is
maxElecLenLTS =         -1  # 0.01 will give ~570, -1 will leave as is
maxElecLenAxAx =        -1  # 0.01 will give ~570, -1 will leave as is
maxElecLenBask =        -1  # 0.01 will give ~570, -1 will leave as is

somaNseg =              -1 # 12

# Scaling for electrical coupling weights
gapScaling =            0.7
# Scaling for all chemical synapse weights
synScaling =            1

varTimestepNeuron =     False
verbose =               True
runInBackground=        False

suggestedRemoteRunTime = 1430

'''
numFRB =                6
numRS =                 109
numLTS =                10
numBask =               10
numAxAx =               10
'''

#######################################


### Load neuroConstruct project

print "Loading project from "+ projFile.getCanonicalPath()

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

project.cellGroupsInfo.getCellPackingAdapter("CG_C04_FRB_sm").setMaxNumberCells(numFRB) # Note only works if RandomCellPackingAdapter
project.cellGroupsInfo.getCellPackingAdapter("CG_C04_RS_sm").setMaxNumberCells(numRS)
project.cellGroupsInfo.getCellPackingAdapter("CG_C04_LTS_sm").setMaxNumberCells(numLTS)
project.cellGroupsInfo.getCellPackingAdapter("CG_C04_Bask_sm").setMaxNumberCells(numBask)
project.cellGroupsInfo.getCellPackingAdapter("CG_C04_AxAx_sm").setMaxNumberCells(numAxAx)


### Change weights in synapses/gap junctions

for netConnName in simConfig.getNetConns():
    if netConnName.count("gap")==0:
        if synScaling != 1:
            SimulationsInfo.addExtraSimProperty("synapticWeightScaling", str(synScaling))
            print "Changing synaptic weight in %s by factor %f"%(netConnName, synScaling)
            project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(0).setWeightsGenerator(NumberGenerator(synScaling))
    else:
        if gapScaling != 1:
            SimulationsInfo.addExtraSimProperty("gapJunctionWeightScaling", str(gapScaling))
            print "Changing gap junction weight in %s by factor %f"%(netConnName, gapScaling)
            project.morphNetworkConnectionsInfo.getSynapseList(netConnName).get(0).setWeightsGenerator(NumberGenerator(gapScaling))


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

if maxElecLenLTS > 0:
    ltsCell = project.cellManager.getCell("SupLTSInter")
    info = CellTopologyHelper.recompartmentaliseCell(ltsCell, maxElecLenLTS, project)
    print "Recompartmentalised LTS cell: "+info
    if somaNseg > 0:
        ltsCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)

if maxElecLenAxAx > 0:
    axAxCell = project.cellManager.getCell("SupAxAx")
    info = CellTopologyHelper.recompartmentaliseCell(axAxCell, maxElecLenAxAx, project)
    print "Recompartmentalised AxAx cell: "+info
    if somaNseg > 0:
        axAxCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)

if maxElecLenBask > 0:
    baskCell = project.cellManager.getCell("SupBasket")
    info = CellTopologyHelper.recompartmentaliseCell(baskCell, maxElecLenBask, project)
    print "Recompartmentalised Bask cell: "+info
    if somaNseg > 0:
        baskCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)


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


print "Number of cells generated: " + str(project.generatedCellPositions.getNumberInAllCellGroups())
print "Number of network connections generated: " + str(project.generatedNetworkConnections.getNumAllSynConns())


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
sleep(5)
exit()
