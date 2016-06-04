
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



def SingleCellNML2generator(projString=" ",ConfigDict={},ElecLenList=[],somaNseg=None):

    projFile=File(os.getcwd(),projString)
    pm=ProjectManager()
    project=pm.loadProject(projFile)
    
    for config in ConfigDict.keys():
   
        for maxElecLen in ElecLenList:


            if maxElecLen > 0:
	       Cell = project.cellManager.getCell(ConfigDict[config])
	       info = CellTopologyHelper.recompartmentaliseCell(Cell, maxElecLen, project)
	       print "Recompartmentalising cell %s"%ConfigDict[config]
	       if somaNseg != None:
	          Cell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)
	          
	       cellpath = r'../../NeuroML2/%s/%s_%f'%(config,config,maxElecLen)
	       
	    else:
	    
	       cellpath = r'../../NeuroML2/%s/%s_default'%(config,config)
	       
            nc.generateNeuroML2(projFile, [config])
            
            
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
                      
                     
    subprocess.call(["~/neuroConstruct/nC.sh -python RegenerateNml2.py"],shell=True)
   
    quit()



if __name__=="__main__":
   SingleCellNML2generator(projString="../Thalamocortical.ncx",ConfigDict={"Cell1-supppyrRS-FigA1RS":"L23PyrRS"},ElecLenList=[-1,0.025, 0.01,0.005, 0.0025, 0.001,0.0005, 0.00025, 0.0001])
  
