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

projFile = File(os.getcwd(), "../Thalamocortical.ncx")

simConfigs = []
simConfigs.append("TestNML2")


if len(sys.argv)==2 and sys.argv[1] == "-v1":
    
    print("Generating NeuroML v1.8.1 files...")
    nc.generateNeuroML1(projFile, simConfigs)
    
else:
    
    nc.generateNeuroML2(projFile, simConfigs)

    # Some extra files have been committed for testing or to provide other LEMS/NeuroML 2 examples
    # This just pulls them from the repository, since they get wiped by the generateNeuroML2 function 
    extra_files = ['.test.*', 'channel_summary', 'LEMS_SomaTest.xml', 'Test.net.nml']
    if len(sys.argv)==2 and sys.argv[1] == "-f":
        extra_files.append('Thalamocortical.net.nml')
        #extra_files.append('LEMS_GranuleCell.xml')

    from subprocess import call
    for f in extra_files:
        call(["git", "checkout", "../generatedNeuroML2/%s"%f])

quit()
