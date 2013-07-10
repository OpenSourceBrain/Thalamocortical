# -*- coding: utf-8 -*-
#
#
#   File to test Thalamocortical project to ensure it is set up correctly for Traub et al based simulations
#
#   To execute this type of file, type '..\..\..\nC.bat -python XXX.py' (Windows)
#   or '../../../nC.sh -python XXX.py' (Linux/Mac). Note: you may have to update the
#   NC_HOME and NC_MAX_MEMORY variables in nC.bat/nC.sh
#
#   NOTE: many of the cells will not match well between NEURON, GENESIS and MOOSE
#   until the spatial discretisation (maxElecLens below) is made finer and the
#   simDt is made smaller!!
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

try:
    from java.io import File
except ImportError:
    print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
    print "See http://www.neuroconstruct.org/docs/python.html for more details"
    quit()

sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.project import Project
from ucl.physiol.neuroconstruct.neuron import NeuronSettings
from ucl.physiol.neuroconstruct.utils import Display3DProperties


projFile = File("../Thalamocortical.ncx")



def testAll(argv=None):
    if argv is None:
        argv = sys.argv

    print "Loading project from "+ projFile.getCanonicalPath()
    
    projectManager = ProjectManager()
    project = projectManager.loadProject(projFile)

    assert(len(project.getProjectDescription())>0)

    assert(len(project.cellManager.getAllCells())>=22)

    assert(len(project.cellGroupsInfo.getAllCellGroupNames())>=36)


    synSetupFile = open("netbuild/makeSyns.sh", 'r')

    for line in synSetupFile:
        line = line.strip()

        if len(line)>0 and not line.startswith("#"):
            words = line.split()
            if len(words)>=6 and words[2].startswith("Syn_"):
                synName = words[2]
                cm = project.cellMechanismInfo.getCellMechanism(synName)
                print "Checked syn %s"%cm.getInstanceName()


    netConnList = open("netbuild/netConnList", 'r')



    for line in netConnList:
        line = line.strip()

        if len(line)>0 and not line.startswith("#"):

            #print "\n\n---- Deciphering line: "+ line
            words = line.split()
            source = words[0]
            target = words[1]
            syns = words[2].strip("[]").split(",")
            netConnName = "NC3D_"+source[5:]+"_"+target[5:]
            assert(source == project.morphNetworkConnectionsInfo.getSourceCellGroup(netConnName))
            assert(target == project.morphNetworkConnectionsInfo.getTargetCellGroup(netConnName))
            print "Checked %s"%netConnName


    assert(project.proj3Dproperties.getDisplayOption() == Display3DProperties.DISPLAY_SOMA_SOLID_NEURITE_LINE)

    assert(abs(project.simulationParameters.getDt()-0.025)<=1e-9)

    assert(not project.neuronSettings.isVarTimeStep())

    assert(project.neuronSettings.isForceCorrectInit())

    assert(project.neuronSettings.getDataSaveFormat().equals(NeuronSettings.DataSaveFormat.TEXT_NC))

    assert(not project.genesisSettings.isSymmetricCompartments())

    assert(project.genesisSettings.isPhysiologicalUnits())

    print "\n**************************************"
    print "    All tests passed!"
    print "**************************************\n"

if __name__ == "__main__":
    testAll()
    exit()
