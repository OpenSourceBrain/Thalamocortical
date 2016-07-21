
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


def SingleCellNML2generator(projString=" ",ConfigDict={},ElecLenList=[],somaNseg=None,savingDir=None):

    projFile=File(os.getcwd(),projString)
    pm=ProjectManager()
    compSummary={}
    for config in ConfigDict.keys():
    
        project=pm.loadProject(projFile)
        
        nmlfm = NeuroMLFileManager(project)
       
        compSummary[config]={}
        if " " in config:
           configPath=config.replace(" ","_")
        else:
           configPath=config
        
        for maxElecLen in ElecLenList:
            compSummary[config][str(maxElecLen)]={}
            cell=project.cellManager.getCell(ConfigDict[config])
            
            if maxElecLen > 0:

	       info = CellTopologyHelper.recompartmentaliseCell(cell, maxElecLen, project)
	       print "Recompartmentalising cell %s"%ConfigDict[config]
	       if somaNseg != None:
	          cell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)
	       if savingDir !=None: 
	          cellpath = r'../../NeuroML2/%s/%s/%s_%f'%(savingDir,configPath,configPath,maxElecLen)
	       else:
	          cellpath = r'../../NeuroML2/%s/%s_%f'%(configPath,configPath,maxElecLen)
	       
	    else:
	       if savingDir !=None:
	          cellpath = r'../../NeuroML2/%s/%s/%s_default'%(savingDir,configPath,configPath)
	       else:
	          cellpath = r'../../NeuroML2/%s/%s_default'%(configPath,configPath)
	       
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
              
               
            src_files = os.listdir("../generatedNeuroML2/")
            
            for file_name in src_files:
                full_file_name = os.path.join("../generatedNeuroML2/", file_name)
                if (os.path.isfile(full_file_name)):
                   print("Moving generated NeuroML2 to files to %s"%cellpath)
                   shutil.copy(full_file_name, cellpath)
                      
    #with open("compSummary.json",'w') as fout:
        #json.dump(compSummary, fout)    
                
    subprocess.call(["~/neuroConstruct/nC.sh -python RegenerateNml2.py -f"],shell=True)
    
    #subprocess.call(["cp compSummary.json ~/Thalamocortical/NeuroML2/"],shell=True)
   
    quit()



if __name__=="__main__":
   
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
            
            
   #SingleCellNML2generator(projString="../Thalamocortical.ncx",ConfigDict=configs,ElecLenList=[-1,0.05,0.025, 0.01,0.005, 0.0025, 0.001,0.0005, 0.00025, 0.0001])
   
   
   
   ######### regenerate specific configs from above if needed ...
   #SingleCellNML2generator(projString="../Thalamocortical.ncx",ConfigDict={"Default Simulation Configuration":"TestSeg_all","Cell1-supppyrRS-FigA1RS":"L23PyrRS"},ElecLenList=[-1])
   SingleCellNML2generator(projString="../Thalamocortical.ncx",ConfigDict={"Default Simulation Configuration":"TestSeg_all"},ElecLenList=[-1])
   
   
   
   
   
   
   
   
   
   
  
