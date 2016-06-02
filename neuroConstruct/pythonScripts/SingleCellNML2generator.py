
#  Script that generates a series of recompartmentalized cells in NeuroML2
#
#  Author : Rokas Stanislovas 
#
#  GSoC 2016 project Cortical Networks
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

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.cell.utils import CellTopologyHelper
import ncutils as nc 

projFile = File(os.getcwd(), "../Thalamocortical.ncx")

pm = ProjectManager()
project = pm.loadProject(projFile)

simConfigs = []
simConfigs.append("Cell1-supppyrRS-FigA1RS")

maxElecLenRS=0.01
somaNseg=-1

if maxElecLenRS > 0:
	RSCell = project.cellManager.getCell("L23PyrRS")
	info = CellTopologyHelper.recompartmentaliseCell(RSCell, maxElecLenRS, project)
	print "Recompartmentalised RS cell"
	if somaNseg > 0:
	    RSCell.getSegmentWithId(0).getSection().setNumberInternalDivisions(somaNseg)


nc.generateNeuroML2(projFile, simConfigs)

    
quit()
