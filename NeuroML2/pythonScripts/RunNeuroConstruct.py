
#  Script that generates a series of recompartmentalized cells in NeuroML2 and saves individual files to different NeuroML2 subfolders 
#
#  Author : Rokas Stanislovas 
#
#  GSoC 2016 project Cortical Networks
#


import sys
import os
import subprocess
import shutil
import json
import time

try:
    from java.io import File
except ImportError:
    print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
    print "See http://www.neuroconstruct.org/docs/python.html for more details"
    quit()

sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.cell.utils import CellTopologyHelper
import ncutils as nc 
from ucl.physiol.neuroconstruct.neuroml import NeuroMLFileManager
from ucl.physiol.neuroconstruct.cell.compartmentalisation import OriginalCompartmentalisation
from ucl.physiol.neuroconstruct.neuroml import NeuroMLConstants
from ucl.physiol.neuroconstruct.neuroml import LemsConstants
from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings
from java.lang.management import ManagementFactory
###### General settings ##################################
mpiConfig =               MpiSettings.MATLEM_1PROC
mpiConfig =               MpiSettings.LOCAL_SERIAL
neuroConstructSeed =    12345
simulatorSeed =         11111
simulators =            ["NEURON"]
numConcurrentSims =     ManagementFactory.getOperatingSystemMXBean().getAvailableProcessors() -1

if mpiConfig != MpiSettings.LOCAL_SERIAL: 
   numConcurrentSims = 60
suggestedRemoteRunTime = 80   

varTimestepNeuron =     False  
varTimestepTolerance =  0.00001

#analyseSims =           False
#plotSims =              False
#plotVoltageOnly =       False


simAllPrefix =          ""  

runInBackground =       True 

suggestedRemoteRunTime = 233

verbose =               True
##########################################################

####################################################################################################################

def RunConfigs(projString,simConfigs,simDt,argv=None):

    projFile = File(os.getcwd(), projString)

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

    #simManager.reloadSims(plotVoltageOnly =plotVoltageOnly,plotSims =plotSims,analyseSims =analyseSims)
                          
    

###################################################################################################################
 
def SingleCellNML2generator(projString=" ",ConfigDict={},ElecLenList=[],somaNseg=None,savingDir=None,shell=None):
    
    projFile=File(os.getcwd(),projString)
    
    pm=ProjectManager()
    
    for config in ConfigDict.keys():
    
        project=pm.loadProject(projFile)
        
        nmlfm = NeuroMLFileManager(project)
        
        compSummary={}
       
        compSummary[config]={}
        
        if " " in config:
           configPath=config.replace(" ","_")
        else:
           configPath=config
           
        if savingDir !=None:
        
           full_path_to_config=r'../%s/%s'%(savingDir,configPath)
           
        else:
        
           full_path_to_config=r'../%s'%(configPath)
        
        for maxElecLen in ElecLenList:
            compSummary[config][str(maxElecLen)]={}
            cell=project.cellManager.getCell(ConfigDict[config])
            
            if maxElecLen > 0:

	       info = CellTopologyHelper.recompartmentaliseCell(cell, maxElecLen, project)
	       print "Recompartmentalising cell %s"%ConfigDict[config]
	       if somaNseg != None:
	          cell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)
	       if savingDir !=None: 
	          cellpath = r'../%s/%s/%s_%f'%(savingDir,configPath,configPath,maxElecLen)
	       else:
	          cellpath = r'../%s/%s_%f'%(configPath,configPath,maxElecLen)
	       
	    else:
	       if savingDir !=None:
	          cellpath = r'../%s/%s/%s_default'%(savingDir,configPath,configPath)
	       else:
	          cellpath = r'../%s/%s_default'%(configPath,configPath)
	       
	    summary=str(cell.getMorphSummary()) 
	    summary_string=summary.split("_")
	    for feature in summary_string:
	        feature_split=feature.split(":")
	        compSummary[config][str(maxElecLen)][feature_split[0]]=feature_split[1]
	    # the format of summary :  Segs:122_Secs:61_IntDivs:1458
	    print("Will be printing a cell morphology summary")
	    print compSummary[config][str(maxElecLen)]
	    ######### it turns out that this does not save recompartmentalized cells - all saved cells have identical spatial discretization; 
	    ##### generateNeuroML2 receives the parent projFile but not the loaded project which is  modified by the CellTopologyHelper.recompartmentaliseCell()
	    
	    ##################### neuroConstruct block #############################################################################
	    
	    neuroConstructSeed=1234
	    verbose=True
	    pm.doGenerate(config, neuroConstructSeed)

            while pm.isGenerating():
                  if verbose: 
                     print("Waiting for the project to be generated with Simulation Configuration: "+config)
                     time.sleep(5)
                     
	    simConfig = project.simConfigInfo.getSimConfig(config)
	    
	    seed=1234
	    genDir = File(projFile.getParentFile(), "generatedNeuroML2")
            nmlfm.generateNeuroMLFiles(simConfig,
                                       NeuroMLConstants.NeuroMLVersion.getLatestVersion(),
                                       LemsConstants.LemsOption.LEMS_WITHOUT_EXECUTE_MODEL,
                                       OriginalCompartmentalisation(),
                                       seed,
                                       False,
                                       True,
                                       genDir,
                                       "GENESIS Physiological Units",
                                       False)
            
            ########################################################################################################################
            
            if not os.path.exists(cellpath):
               print("Creating a new directory %s"%cellpath)
               os.makedirs(cellpath)
            else:
               print("A directory %s already exists"%cellpath)
              
               
            src_files = os.listdir("../../neuroConstruct/generatedNeuroML2/")
            for file_name in src_files:
                full_file_name = os.path.join("../../neuroConstruct/generatedNeuroML2/", file_name)
                if (os.path.isfile(full_file_name)):
                   print("Moving generated NeuroML2 to files to %s"%cellpath)
                   shutil.copy(full_file_name, cellpath)
                      
        with open(os.path.join(full_path_to_config,"compSummary.json"),'w') as fout:
             json.dump(compSummary, fout)          
      
    if shell ==None:
       extension='sh'
    else:
       extension=shell      
    
    os.chdir("../../neuroConstruct/pythonScripts")  
      
    subprocess.call("%s/nC.%s -python ../../neuroConstruct/pythonScripts/RegenerateNml2.py -f"%(os.environ["NC_HOME"],extension),shell=True)
    
    os.chdir("../../NeuroML2/pythonScripts")
    
    

if __name__=="__main__":
   ##### all configs
   configs={"Default Simulation Configuration":"TestSeg_all",  
            "Cell1-supppyrRS-FigA1RS":"L23PyrRS",
            "Cell2-suppyrFRB-FigA1FRB":"L23PyrFRB",
            "Cell3-supbask-FigA2a":"SupBasket",
            "Cell1-supppyrRS-10ms":"L23PyrRS",
            "Cell2-suppyrFRB-10ms":"L23PyrFRB",
            "Cell3-supbask-10ms":"SupBasket",
            "Cell4-supaxax-10ms":"SupAxAx",
            "Cell4-supaxax-FigA2a":"SupAxAx",
            "Cell5-supLTS-10ms":"SupLTSInter",
            "Cell5-supLTS-FigA2b":"SupLTSInter",
            "Cell6-spinstell-10ms":"L4SpinyStellate",
            "Cell6-spinstell-FigA3-167":"L4SpinyStellate",
            "Cell6-spinstell-FigA3-250":"L4SpinyStellate",
            "Cell6-spinstell-FigA3-333":"L4SpinyStellate",
            "Cell7-tuftIB-10ms":"L5TuftedPyrIB",
            "Cell7-tuftIB-FigA4-900":"L5TuftedPyrIB",
            "Cell7-tuftIB-FigA4-1100":"L5TuftedPyrIB",
            "Cell7-tuftIB-FigA4-1300":"L5TuftedPyrIB",
            "Cell7-tuftIB-FigA4-1500":"L5TuftedPyrIB",
            "Cell8-tuftRS-10ms":"L5TuftedPyrRS",
            "Cell8-tuftRS-FigA5-800":"L5TuftedPyrRS",
            "Cell8-tuftRS-Fig5A-1000":"L5TuftedPyrRS",
            "Cell8-tuftRS-Fig5A-1200":"L5TuftedPyrRS",
            "Cell8-tuftRS-Fig5A-1400":"L5TuftedPyrRS",
            "Cell9-nontuftRS-10ms":"L6NonTuftedPyrRS",
            "Cell9-nontuftRS-FigA6-500":"L6NonTuftedPyrRS",
            "Cell9-nontuftRS-FigA6-800":"L6NonTuftedPyrRS",
            "Cell9-nontuftRS-FigA6-1000":"L6NonTuftedPyrRS",
            "Cell10-deepbask-10ms":"DeepBasket",
            "Cell11-deepaxax-10ms":"DeepAxAx",
            "Cell12-deepLTS-10ms":"DeepLTSInter",
            "Cell12-deepLTS-FigA2b":"DeepLTSInter",
            "Cell13-TCR-10ms":"TCR",
            "Cell13-TCR-FigA7-100":"TCR",
            "Cell13-TCR-FigA7-600":"TCR",
            "Cell14-nRT-10ms":"nRT",
            "Cell14-nRT-FigA8-00":"nRT",
            "Cell14-nRT-FigA8-300":"nRT",
            "Cell14-nRT-FigA8-500":"nRT"}
            
            
   elec_len_list=[-1,0.05,0.025, 0.01,0.005, 0.0025, 0.001,0.0005, 0.00025, 0.0001]    
   
   sim_dt=0.01
     
   #############################################        
            
   if os.path.exists("nc_parameters.json"):
      
      with open("nc_parameters.json",'r') as f:
           nc_parameters=json.load(f)
         
      if nc_parameters !=None:
         
         regenerate_nml2=nc_parameters['GenerateConfigs']
         
         comparison_to_neuroConstruct=nc_parameters['CompareToNeuroConstruct']
         
         if comparison_to_neuroConstruct:
         
            configs=nc_parameters['configsToCompare']
         
            sim_dt=nc_parameters['dt']
            
            RunConfigs(projString="../../neuroConstruct/Thalamocortical.ncx",simConfigs=configs,simDt=sim_dt)
            
         if regenerate_nml2:
         
            elec_len_list=nc_parameters['ElecLenList']
         
            configs=nc_parameters['configsToGenerate']
         
            SingleCellNML2generator(projString="../../neuroConstruct/Thalamocortical.ncx",ConfigDict=configs,ElecLenList=elec_len_list)
            
            
   else:
   
      pass
      ######### can be run directly as a main function
      #SingleCellNML2generator(projString="../../neuroConstruct/Thalamocortical.ncx",ConfigDict={"Default Simulation Configuration":"TestSeg_all","Cell1-supppyrRS- FigA1RS":"L23PyrRS"},ElecLenList=[-1])
      #SingleCellNML2generator(projString="../../neuroConstruct/Thalamocortical.ncx",ConfigDict={"Default Simulation Configuration":"TestSeg_all"},ElecLenList=[-1])
   quit()
   
   
   
   
   
   
   
   
   
  
