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
simConfigs.append("Cell2-suppyrFRB-FigA1FRB")   # use maxElecLens = 0.01
#simConfigs.append("Cell3-supbask-FigA2a")
#simConfigs.append("Cell4-supaxax-FigA2a")
#simConfigs.append("Cell5-supLTS-FigA2b")
#simConfigs.append("Cell6-spinstell-FigA3-333")
#simConfigs.append("Cell7-tuftIB-FigA4-1500")
#simConfigs.append("Cell8-tuftRS-Fig5A-1400")
#simConfigs.append("Cell9-nontuftRS-FigA6-1000")
#simConfigs.append("Cell12-deepLTS-FigA2b")
#simConfigs.append("Cell13-TCR-FigA7-600")
#simConfigs.append("Cell14-nRT-FigA8-00")

#simConfigs.append("Cell1-supppyrRS-10ms")
#simConfigs.append("Cell2-suppyrFRB-10ms")   
#simConfigs.append("Cell3-supbask-10ms")
#simConfigs.append("Cell4-supaxax-10ms")
#simConfigs.append("Cell5-supLTS-10ms")
#simConfigs.append("Cell6-spinstell-10ms")
#simConfigs.append("Cell7-tuftIB-10ms")
#simConfigs.append("Cell8-tuftRS-10ms")
#simConfigs.append("Cell9-nontuftRS-10ms")
#simConfigs.append("Cell10-deepbask-10ms")
#simConfigs.append("Cell11-deepaxax-10ms")
#simConfigs.append("Cell12-deepLTS-10ms")
#simConfigs.append("Cell13-TCR-10ms")
#simConfigs.append("Cell14-nRT-10ms")
#
##########################################################################

simDt =                 0.005
#simDt=                   0.01   # for newly added mep tests which will be used for omv tests with jNeuroML_NEURON

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
    
    
    if simDt==0.005:

       if "Default Simulation Configuration" in simConfigs:
      
          # These were discovered using analyseSims = True above.
          # They need to hold for all simulators
          spikeTimesToCheck = {'CG_CML_0': nc.loadMepFile('.test.mep')['Current clamp']}

          spikeTimeAccuracy = 0.0751  # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON

          report0 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
				    spikeTimeAccuracy = spikeTimeAccuracy)

          print report0
          report = report + report0+"\n"
    
       if "Cell2-suppyrFRB-FigA1FRB" in simConfigs:
	
          # These were discovered using analyseSims = True above.
          # They need to hold for all simulators
          spikeTimesToCheck = {'CGsuppyrFRB_0': nc.loadMepFile('.test.l23frb.mep')['L23FRB']}

          spikeTimeAccuracy = 2.32 #  # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON

          report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
				    spikeTimeAccuracy = spikeTimeAccuracy)

          print report2
          report = report + report2+ '\n'
      
       if "Cell4-supaxax-FigA2a" in simConfigs:
	
          spikeTimesToCheck = {'CGsupaxax_0': nc.loadMepFile('.test.supaxax.mep')['SupAxAx']}

          spikeTimeAccuracy = 0.711 # ms # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON

          report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
				    spikeTimeAccuracy = spikeTimeAccuracy)

          print report2
          report = report + report2+"\n"
      
       if "Cell14-nRT-FigA8-00" in simConfigs:
	
          spikeTimesToCheck = {'CGnRT_0': nc.loadMepFile('.test.nrt.mep')['nRT']}

          spikeTimeAccuracy = 0.271 # ms  # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON

          report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
				    spikeTimeAccuracy = spikeTimeAccuracy)

          print report2
          report = report + report2+"\n"
       ###### the .mep tests below are NEURON specific - not tested on other simulators   
       if "NEURON"==simulators[0]:
          
          if "Cell1-supppyrRS-FigA1RS" in simConfigs:
             
              print("Tests for default project simulation for %s with 0.005 dt in NEURON"%("Cell1-supppyrRS-FigA1RS"))
	
      
              spikeTimesToCheck = {'CGsuppyrRS_0': nc.loadMepFile('.test.FigA1RS0005.mep')['FigA1RS']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'
              
          if "Cell2-suppyrFRB-FigA1FRB" in simConfigs:
              
          
              print("Tests for default project simulation for %s with 0.005 dt in NEURON"%("Cell2-suppyrFRB-FigA1FRB"))
	
             
              spikeTimesToCheck = {'CGsuppyrFRB_0': nc.loadMepFile('.test.FigA1FRB0005.mep')['FigA1FRB']}

              spikeTimeAccuracy = 0 #  # could be more accurate with var time step in nrn, but need to compare these to jNeuroML_NEURON

              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,
				    spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
          
          
      
      
    ######## added by Rokas Stanislovas : tests for all figures with 0.01 dt and default project spatial discretization in NEURON
    
    
    if "NEURON"==simulators[0]:
    
       if simDt==0.01:
          
             
          if "Cell1-supppyrRS-FigA1RS" in simConfigs:
             
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell1-supppyrRS-FigA1RS"))
	
      
              spikeTimesToCheck = {'CGsuppyrRS_0': nc.loadMepFile('.test.FigA1RS.mep')['FigA1RS']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell2-suppyrFRB-FigA1FRB" in simConfigs:
          
             
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell2-suppyrFRB-FigA1FRB"))
	 
      
              spikeTimesToCheck = {'CGsuppyrFRB_0': nc.loadMepFile('.test.FigA1FRB.mep')['FigA1FRB']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if  "Cell3-supbask-FigA2a" in simConfigs:
          
             
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell3-supbask-FigA2a"))
	 
      
              spikeTimesToCheck = {'CGsupbask_0': nc.loadMepFile('.test.supbaskFigA2a.mep')['supbaskFigA2a']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
              
          if  "Cell4-supaxax-FigA2a" in simConfigs:
          
          
             
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell4-supaxax-FigA2a"))
	 
      
              spikeTimesToCheck = {'CGsupaxax_0': nc.loadMepFile('.test.supaxaxFigA2a.mep')['supaxaxFigA2a']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
              
          if  "Cell5-supLTS-FigA2b" in simConfigs:
          
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell5-supLTS-FigA2b"))
	 
     
              spikeTimesToCheck = {'CGsupLTS_0': nc.loadMepFile('.test.supLTSFigA2b.mep')['supLTSFigA2b']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if  "Cell6-spinstell-FigA3-333" in simConfigs:
          
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell6-spinstell-FigA3-333"))
	 
     
              spikeTimesToCheck = {'CGspinstell_0': nc.loadMepFile('.test.spinstellFigA3_333.mep')['spinstellFigA3_333']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          
          if  "Cell7-tuftIB-FigA4-1500" in simConfigs:
          
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell7-tuftIB-FigA4-1500"))
	 
     
              spikeTimesToCheck = {'CGtuftIB_0': nc.loadMepFile('.test.tuftIBFigA4_1500.mep')['tuftIBFigA4_1500']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
         
          if  "Cell7-tuftIB-FigA4-1500" in simConfigs:
          
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell7-tuftIB-FigA4-1500"))
	 
     
              spikeTimesToCheck = {'CGtuftIB_0': nc.loadMepFile('.test.tuftIBFigA4_1500.mep')['tuftIBFigA4_1500']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
              
          if  "Cell8-tuftRS-Fig5A-1400" in simConfigs:
          
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell8-tuftRS-Fig5A-1400"))
	 
     
              spikeTimesToCheck = {'CGtuftRS_0': nc.loadMepFile('.test.tuftRSFig5A_1400.mep')['tuftRSFig5A_1400']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
              
          if "Cell9-nontuftRS-FigA6-1000" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell9-nontuftRS-FigA6-1000"))
	 
     
              spikeTimesToCheck = {'CGnontuftRS_0': nc.loadMepFile('.test.nontuftRSFigA6_1000.mep')['nontuftRSFigA6_1000']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
              
          if "Cell12-deepLTS-FigA2b" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell12-deepLTS-FigA2b"))
	 
     
              spikeTimesToCheck = {'CGdeepLTS_0': nc.loadMepFile('.test.deepLTSFigA2b.mep')['deepLTSFigA2b']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell13-TCR-FigA7-600" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell13-TCR-FigA7-600"))
	 
     
              spikeTimesToCheck = {'CGTCR_0': nc.loadMepFile('.test.TCRFigA7_600.mep')['TCRFigA7_600']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          
          if "Cell14-nRT-FigA8-00" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell14-nRT-FigA8-00"))
	 
     
              spikeTimesToCheck = {'CGnRT_0': nc.loadMepFile('.test.nRTFigA8_00.mep')['nRTFigA8_00']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'      
              
              
          if  "Cell1-supppyrRS-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell1-supppyrRS-10ms"))
	 
     
              spikeTimesToCheck = {'CGsuppyrRS_0': nc.loadMepFile('.test.suppyrRS10ms.mep')['suppyrRS10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if  "Cell2-suppyrFRB-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell2-suppyrFRB-10ms"))
	 
     
              spikeTimesToCheck = {'CGsuppyrFRB_0': nc.loadMepFile('.test.suppyrFRB10ms.mep')['suppyrFRB10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if  "Cell3-supbask-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell3-supbask-10ms"))
	 
     
              spikeTimesToCheck = {'CGsupbask_0': nc.loadMepFile('.test.supbask10ms.mep')['supbask10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if  "Cell4-supaxax-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell4-supaxax-10ms"))
	 
     
              spikeTimesToCheck = {'CGsupaxax_0': nc.loadMepFile('.test.supaxax10ms.mep')['supaxax10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if "Cell5-supLTS-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell5-supLTS-10ms"))
	 
     
              spikeTimesToCheck = {'CGsupLTS_0': nc.loadMepFile('.test.supLTS10ms.mep')['supLTS10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
               
           
              
          if "Cell6-spinstell-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell6-spinstell-10ms"))
	 
     
              spikeTimesToCheck = {'CGspinstell_0': nc.loadMepFile('.test.spinstell10ms.mep')['spinstell10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if "Cell7-tuftIB-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell7-tuftIB-10ms"))
	 
     
              spikeTimesToCheck = {'CGtuftIB_0': nc.loadMepFile('.test.tuftIB10ms.mep')['tuftIB10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'  
              
          if "Cell8-tuftRS-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell8-tuftRS-10ms"))
	 
     
              spikeTimesToCheck = {'CGtuftRS_0': nc.loadMepFile('.test.tuftRS10ms.mep')['tuftRS10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'
              
              
          if "Cell9-nontuftRS-10ms" in simConfigs:
       
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell9-nontuftRS-10ms"))
	 
     
              spikeTimesToCheck = {'CGnontuftRS_0': nc.loadMepFile('.test.nontuftRS10ms.mep')['nontuftRS10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n'
              
              
          if "Cell10-deepbask-10ms" in simConfigs:
      
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell10-deepbask-10ms"))
	 
     
              spikeTimesToCheck = {'CGdeepbask_0': nc.loadMepFile('.test.deepbask10ms.mep')['deepbask10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell11-deepaxax-10ms" in simConfigs:
      
          
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell11-deepaxax-10ms"))
	 
     
              spikeTimesToCheck = {'CGdeepaxax_0': nc.loadMepFile('.test.deepaxax10ms.mep')['deepaxax10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell12-deepLTS-10ms" in simConfigs:
      
         
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell12-deepLTS-10ms"))
	 
     
              spikeTimesToCheck = {'CGdeepLTS_0': nc.loadMepFile('.test.deepLTS10ms.mep')['deepLTS10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell13-TCR-10ms" in simConfigs:
      
         
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell13-TCR-10ms"))
	 
     
              spikeTimesToCheck = {'CGTCR_0': nc.loadMepFile('.test.TCR10ms.mep')['TCR10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
              
          if "Cell14-nRT-10ms" in simConfigs:
      
         
              print("Tests for default project simulation for %s with 0.01 dt in NEURON"%("Cell14-nRT-10ms"))
	 
     
              spikeTimesToCheck = {'CGnRT_min75init_0': nc.loadMepFile('.test.nRT10ms.mep')['nRT10ms']}

              spikeTimeAccuracy = 0
  
              report2 = simManager.checkSims(spikeTimesToCheck = spikeTimesToCheck,spikeTimeAccuracy = spikeTimeAccuracy)

              print report2
              report = report + report2+ '\n' 
          
              
              
         
              
               
          
              
              
             
 
      

    return report


if __name__ == "__main__":
    testAll()
