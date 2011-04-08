

try:
    from java.io import File
    from java.util import Vector
    from java.lang import Float
except ImportError:
    print "Note: this file should be run using nC.bat -python XXX.py' or 'nC.sh -python XXX.py'"
    print "See http://www.neuroconstruct.org/docs/python.html for more details"
    quit()

from ucl.physiol.neuroconstruct.project import ProjectManager
from ucl.physiol.neuroconstruct.project import SynapticProperties
from ucl.physiol.neuroconstruct.project import SearchPattern
from ucl.physiol.neuroconstruct.project import MaxMinLength
from ucl.physiol.neuroconstruct.project import ConnectivityConditions
from ucl.physiol.neuroconstruct.utils import NumberGenerator

netConnListFilename = "netConnList"

print "\nPython utility for adding NetConns to Thalamocortical project from text file "+netConnListFilename



### Load neuroConstruct project

projFile = File("../../Thalamocortical.ncx")

print "Loading project from "+ projFile.getCanonicalPath()

pm = ProjectManager()
project = pm.loadProject(projFile)

netConnInfo = project.morphNetworkConnectionsInfo  # Simple/morph based net conns only

print "Currently there are %i morph based net conns"%netConnInfo.getNumSimpleNetConns()


netConnList = open(netConnListFilename, 'r')



for line in netConnList:
    line = line.strip()

    if len(line)>0 and not line.startswith("#"):
        
        print "\n\n---- Deciphering line: "+ line
        words = line.split()
        source = words[0]
        target = words[1]
        syns = words[2].strip("[]").split(",")
        numPre = float(words[3])
        postGroup = words[4]
        preGroup = "distal_axon"
        default_syn_delay=0.05

        netConnName = "NC3D_"+source[5:]+"_"+target[5:]

        if("Elect" in syns[0]):
            netConnName = netConnName + "_Gap"
            default_syn_delay = 0
            preGroup = postGroup

        print "Creating a net conn: %s where points in %s of %g cells of %s contact each cell in %s with syns: %s on group %s" % (netConnName, preGroup, numPre, source, target, syns, postGroup)

        existed = netConnInfo.deleteNetConn(netConnName)
        print "Did it already exist? %s"%existed

        synList = Vector()
        cellMechNames = project.cellMechanismInfo.getAllCellMechanismNames()

        for syn in syns:
            if not syn in cellMechNames:
                print "Synapse mechanism %s not found in project!"%syn
                exit()
                
            synProp = SynapticProperties(syn)
            synProp.setThreshold(0)
            synProp.setFixedDelay(default_syn_delay)
            synList.add(synProp)

        searchPattern = SearchPattern.getRandomSearchPattern()
        maxMinLength = MaxMinLength()

        connectivityConditions = ConnectivityConditions()
        connectivityConditions.setGenerationDirection(ConnectivityConditions.TARGET_TO_SOURCE)
        
        connectivityConditions.setNumConnsInitiatingCellGroup(NumberGenerator(numPre))

        if "axon" in postGroup:
            connectivityConditions.getPrePostAllowedLoc().setAxonsAllowedPost(1)
        if "dend" in preGroup:
            connectivityConditions.getPrePostAllowedLoc().setDendritesAllowedPre(1)

        connectivityConditions.setAllowAutapses(0)
            
        if("Elect" in syns[0]):
            connectivityConditions.setNoRecurrent(1)


        netConnInfo.addNetConn(netConnName,
                               source,
                               target,
                               synList,
                               searchPattern,
                               maxMinLength,
                               connectivityConditions,
                               Float.MAX_VALUE)

        print netConnInfo.getSummary(netConnName)

        preCell = project.cellManager.getCell(project.cellGroupsInfo.getCellType(source))
        postCell = project.cellManager.getCell(project.cellGroupsInfo.getCellType(target))

        #print "Syns vs groups: %s"%preCell.getSynapsesVsGroups()

        for syn in syns:

            if not preGroup in preCell.getAllGroupNames():
                print "Group %s not found in PRE cell %s"%(preGroup, preCell)
                exit()

            res = preCell.associateGroupWithSynapse(preGroup, syn)
            print "Associated %s with PRE group %s: %s" % (preGroup, syn, res)

            if not postGroup in postCell.getAllGroupNames():
                print "Group %s not found in POST cell %s"%(postGroup, postCell)
                exit()
            res = postCell.associateGroupWithSynapse(postGroup, syn)
            print "Associated %s with POST group %s: %s" % (postGroup, syn, res)

        #print "Syns vs groups: %s"%preCell.getSynapsesVsGroups()

        #print project.simConfigInfo.getAllSimConfigNames()
        
        project.simConfigInfo.getSimConfig("TempSimConfig").addNetConn(netConnName)
        project.simConfigInfo.getSimConfig("Demo3D").addNetConn(netConnName)


print "Currently there are %i morph based net conns. \n"%netConnInfo.getNumSimpleNetConns()

ans = raw_input("Save the project (yes/no)? ")


if "yes" in ans:
    print "Saving the project..."
    project.saveProject()
else:
    print "Not saving the project..."
    exit()


print "Done!"