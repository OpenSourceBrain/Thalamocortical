#!/usr/bin/env python

# For documentation of this script please see print message when run with -help
# And note inline comments that explain what to customise to run on a different platform / setup

# matplotlib is available for Linux, Mac and Windows from http://matplotlib.sourceforge.net

import sys
import os
import inspect
import time
import math
import shlex
import subprocess
import datetime
import re

import matplotlib.pyplot as plt
from pylab import *
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas


# defaults set
debugFlag = 0
helpFlag = 0
showFlag = 1
overlayFlag = 0

targetList = []

for arg in sys.argv:
    if (arg == "-debug"):
        DEBUG = True
        debugFlag = 1
    if (arg == "-help"):
        helpFlag = 1
    if (arg == "-noshow"):
        showFlag = 0
    if (arg == "-overlay"):
        overlayFlag = 1
    if (len(arg) > 1 and arg[0] != "-" and arg.count(".py") == 0):
        # file location argument
        targetList.append(arg)
        print "target queued: "+arg

if (helpFlag == 1):
    print "Call this script as follows:\n\
    ./plotDat.py [options] <file1> <file2> etc..  \n\
    -debug to debug and not do anything\n\
    -type=nm for neuromatic folders \n\
    -type=nc for neuroconstruct folders \n\
    -noshow to run silently \n\
    -help for this text \n\
    \n"
    quit()

DEBUG = True
def debugPrint(prStr):
    if (DEBUG):
        _, filename, linenumber, _, _, _ = inspect.stack()[1]
        print filename+" lineno:"+str(linenumber)+" : "+prStr
        

plotNum = 0

plotcolors=['#000000','#550000','#005500','#000055', \
            '#555555','#880000','#008800','#000088', \
            '#888888','#990000','#009900','#000099', \
]


# for each file sent as argument create a plot
for filidx in range(0,len(targetList)):
    targetFile = targetList[filidx]
    # read the x values
    if (os.path.exists(targetFile) ):
        # read the y values
        data_y = []
        data_x = []
        t = 0
        dt = 1
        file_y = open(targetFile,'rU')
        debugPrint("Reading file:"+targetFile)
        for line in file_y:
            if not line.strip().startswith('#') or not line.strip():
                try:
                    data = float(line)
                    data_y.append(data)
                    data_x.append(t)
                    t=t+dt
                except:
                    debugPrint("problem with value!:"+str(line))
                    continue
    
                
        file_y.close()                    
        debugPrint("imported last data dat_y:"+str(data)+" records: "+str(t))
        # !! need to check for size differences in dimension

        if (overlayFlag == 0):
            fig = plt.figure(facecolor='#FFFFFF', edgecolor='#FFFFFF')
            ax = fig.add_subplot(111, autoscale_on=True, frame_on=True)
            ax.spines['top'].set_color('none')
            ax.spines['right'].set_color('none')
            #    ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker='o', markerfacecolor='None', markeredgecolor='#000000' )
            #ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            ax.plot(data_x, data_y, color='#000000', linestyle='-', marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            title('Plot of file: '+targetFile)
            ax.set_ylabel('Y-Label Title (units)', fontsize=14)
            ax.set_xlabel('X-Label Title (units)', fontsize=14)
            ax.xaxis.set_ticks_position('bottom')
            ax.yaxis.set_ticks_position('left')
            # draw()
            canvas = FigureCanvas(fig)
            graphicsFilename = targetFile
            graphicsFilename = graphicsFilename.replace('.txt','')
            #canvas.print_eps(graphicsFilename+'.eps')
            #canvas.print_pdf(graphicsFilename+'.pdf')
            canvas.print_png(graphicsFilename+'.png')
            plt.close(fig)
            
        else:
            if (plotNum == 0):
                debugPrint("creating plot...")
                fig = plt.figure(facecolor='#FFFFFF', edgecolor='#FFFFFF')
                ax = fig.add_subplot(111, autoscale_on=True, frame_on=True)
                ax.spines['top'].set_color('none')
                ax.spines['right'].set_color('none')
                title('Plot of merged data...')
                ax.set_ylabel('Y-Label Title (units)', fontsize=14)
                ax.set_xlabel('X-Label Title (units)', fontsize=14)
                ax.xaxis.set_ticks_position('bottom')
                ax.yaxis.set_ticks_position('left')
            #    ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker='o', markerfacecolor='None', markeredgecolor='#000000' )
            #ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            debugPrint("plotting data_x data_y")
            ax.plot(data_x, data_y, color=plotcolors[plotNum % len(plotcolors)], linestyle='-', marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            plotNum += 1
            

if (showFlag == 1):
    # show graphs for a certain amount of time then exit
    plt.show(1) # pass 0 to show and move on - 1 blocks and waits
    time.sleep(6)

# can I lay out the windows for the graphs or better to consolidate all sources in one graph?
# the idea is to create a workflow while I an working in neuron to try different values?

                
                


