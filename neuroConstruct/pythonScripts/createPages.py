#!/usr/bin/env python
'''
This is a Python script to generate a number of HTML pages displaying F-I curves of cells in this project. Work in progress
Author Yates Buckley 
'''
import sys
import os
import time
import math
import shlex
import subprocess
import datetime
import re

fullbatchFlag = 0
debugFlag = 0
helpFlag = 0
for arg in sys.argv:
    if (arg == "-fullbatch"):
        fullbatchFlag = 1
    if (arg == "-debug"):
        debugFlag = 1
    if (arg == "-help"):
        helpFlag = 1

if (helpFlag == 1):
    print "run this command with ./createPages.py to batch create html pages for this project\n"+ \
    "(assuming F-I curve and V-I curve has already been generated) otherwise:\n"+ \
    "-fullbatch will run all the actual commands.. please take care it will take a long time\n"+ \
    "-debug will run the first few commands so you can test if they work\n"
    "\nnote that the script needs to be cusomised by changing actual source values..\n"
    quit()

scriptDir = "/_work/2012/neuroconstruct/neuroconstruct_svn/pythonNeuroML/nCUtils"
outputDir = "/_work/2012/neuroconstruct/neuroconstruct_svn/nCmodels/Thalamocortical/simulations"

cellArrayOutput = [\
"Cell1-supppyrRS-F-I", "Cell1-supppyrRS-V-I", \
"Cell2-suppyrFRB-F-I", "Cell2-suppyrFRB-V-I", \
"Cell3-supbask-F-I", "Cell3-supbask-V-I", \
"Cell4-supaxax-F-I", "Cell4-supaxax-V-I", \
"Cell5-supLTS-F-I", "Cell5-supLTS-V-I", \
"Cell6-spinstell_F-I", "Cell6-spinstell_V-I", \
"Cell7-tuftIB_F-I", "Cell7-tuftIB_V-I", \
"Cell8-tuftRS_F-I", "Cell8-tuftRS_V-I", \
"Cell9-nontuftRS_F-I", "Cell9-nontuftRS_V-I", \
"Cell10-deepbask_F-I", "Cell10-deepbask_V-I", \
"Cell11-deepaxax_F-I", "Cell11-deepaxax_V-I", \
"Cell12-deepLTS_F-I", "Cell12-deepLTS_V-I", \
"Cell13-TCR_F-I", "Cell13-TCR_V-I", \
"Cell14-nRT_F-I", "Cell14-nRT_V-I", ]

commandList = []

# F-I regenerate Cell1-supppyrRS-FigA1RS
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell1-supppyrRS-FigA1RS" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell1-supppyrRS-FigA1RS" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell1-supppyrRS-FigA1RS
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell1-supppyrRS-FigA1RS" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell1-supppyrRS-FigA1RS" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell2-suppyrFRB-FigA1FRB
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell2-suppyrFRB-FigA1FRB" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell2-suppyrFRB-FigA1FRB" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell2-suppyrFRB-FigA1FRB
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell2-suppyrFRB-FigA1FRB" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell2-suppyrFRB-FigA1FRB" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell3-supbask-FigA2a
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell3-supbask-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell3-supbask-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell3-supbask-FigA2a
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell3-supbask-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell3-supbask-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell4-supaxax-FigA2a
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell4-supaxax-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell4-supaxax-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell4-supaxax-FigA2a
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell4-supaxax-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell4-supaxax-FigA2a" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell5-supLTS-FigA2b
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell5-supLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell5-supLTS-FigA2b" "MpiSettings.MATLEM_1PROC"  4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell5-supLTS-FigA2b
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell5-supLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell5-supLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell6-spinstell-FigA3-333
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell6-spinstell-FigA3-333" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell6-spinstell-FigA3-333" "MpiSettings.MATLEM_1PROC" 4 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell6-spinstell-FigA3-333
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell6-spinstell-FigA3-333" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell6-spinstell-FigA3-333" "MpiSettings.MATLEM_1PROC" 4 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell7-tuftIB-FigA4-900
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell7-tuftIB-FigA4-900" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell7-tuftIB-FigA4-900" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell7-tuftIB-FigA4-900
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell7-tuftIB-FigA4-900" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell7-tuftIB-FigA4-900" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell8-tuftRS-FigA5-800
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell8-tuftRS-FigA5-800" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell8-tuftRS-FigA5-800" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell8-tuftRS-FigA5-800
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell8-tuftRS-FigA5-800" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell8-tuftRS-FigA5-800" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell9-nontuftRS-FigA6-500
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell9-nontuftRS-FigA6-500" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell9-nontuftRS-FigA6-500" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell9-nontuftRS-FigA6-500
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell9-nontuftRS-FigA6-500" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell9-nontuftRS-FigA6-500" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell10-deepbask-10ms
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell10-deepbask-10ms" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell10-deepbask-10ms" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell10-deepbask-10ms
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell10-deepbask-10ms" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell10-deepbask-10ms" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell11-deepaxax-10ms
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell11-deepaxax-10ms" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell11-deepaxax-10ms" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell11-deepaxax-10ms
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell11-deepaxax-10ms" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell11-deepaxax-10ms" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell12-deepLTS-FigA2b
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell12-deepLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell12-deepLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell12-deepLTS-FigA2b
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell12-deepLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell12-deepLTS-FigA2b" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell13-TCR-FigA7-100
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell13-TCR-FigA7-100" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell13-TCR-FigA7-100" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell13-TCR-FigA7-100
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell13-TCR-FigA7-100" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell13-TCR-FigA7-100" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

# F-I regenerate Cell14-nRT-FigA8-00
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell14-nRT-FigA8-00" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell14-nRT-FigA8-00" "MpiSettings.MATLEM_1PROC" 12 33  0.0 2.0 0.25 0 2000 2000  500 2000 -20  "F-I" 1 ')
# SS-I regenerate Cell14-nRT-FigA8-00
commandList.append('./nCreport.sh 0 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell14-nRT-FigA8-00" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 "none"')
commandList.append('./nCreport.sh 1 1 1 "NEURON" "/nCmodels/Thalamocortical/Thalamocortical.ncx" "Cell14-nRT-FigA8-00" "MpiSettings.MATLEM_1PROC" 7 33 -3.0 0.5  0.5 0 2000 2000 1000 2000   2 "SS-I" 1 ')

def a_HTML(linkText,
               linkLocation):
    html = '<a href="'+linkLocation+'">'+linkText+'</a>\n'
    return html

pageFiles = []
indexFiles = []
linkHTML = ""
imageHTML = ""

if (fullbatchFlag == 1):
    print "Running big batch of commands..."
    for i in range(len(commandList)):
        if (i % 2 == 0):
            if (debugFlag == 1 and i > 6): break
            #Popen(["/bin/bash",scriptDir+"/"+commandList[i]], cwd=scriptDir)
            cmd = commandList[i]+" \""+cellArrayOutput[i/2]+"\" "
            p = subprocess.call([cmd], cwd=scriptDir, shell=True)
            # out, err = p.communicate()
            print cmd

for i in range(len(commandList)):
    if (i % 2 == 1):
        if (debugFlag == 1 and i > 8): break
        #Popen(["/bin/bash",scriptDir+"/"+commandList[i]], cwd=scriptDir)
        cmd = commandList[i]+" \""+cellArrayOutput[i/2]+"\" "
        p = subprocess.call([cmd], cwd=scriptDir, shell=True)
        # out, err = p.communicate()
        print cmd, scriptDir
        pageFiles.append(outputDir+"/"+cellArrayOutput[i/2]+"/plot.html")
        indexFiles.append(outputDir+"/"+cellArrayOutput[i/2]+"/index.html")
        if (i % 4 == 1):
            linkHTML += '<br />'
        linkHTML += a_HTML(cellArrayOutput[i/2],"../"+cellArrayOutput[i/2]+"/index.html")

linkHTML += '<br />'

for i in range(len(pageFiles)):
    print pageFiles[i]
    plotHTML = open(pageFiles[i],'r')
    indexHTML = open(indexFiles[i],'w')
    filteredHTML = plotHTML.read()
    imageHTML = '<img src="plot.png" align="centre"/><br />'
    if (i % 2 == 1):
        imageHTML += '<img src="../'+cellArrayOutput[i-1]+'/plot.png" align="centre"/><br />'
    else:
        imageHTML += '<img src="../'+cellArrayOutput[i+1]+'/plot.png" align="centre"/><br />'

    refilteredHTML = re.sub(r'<img src="plot.png" align="centre"/>',linkHTML+imageHTML,filteredHTML)
    # re.sub(r'def\s+([a-zA-Z_][a-zA-Z_0-9]*)\s*\(\s*\):', r'static PyObject*\npy_\1(void)\n{', 'def myfunc():')

    indexHTML.write(refilteredHTML)
    indexHTML.close()
    plotHTML.close()


