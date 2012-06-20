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

import numpy as np
import matplotlib.pyplot as plt
from pylab import *
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas


# defaults set
debugFlag = 0
helpFlag = 0
showFlag = 0
overlayFlag = 0
alphaFlag = 0
dtFlag = 0
dtParams = 0
colorFlag = 0
colorParams = 0
dtfileFlag = 0
dtfileParams = []
windowFlag = 0
windowParams = []
xlabelFlag = 0
ylabelFlag = 0
glabelFlag = 0
targetList = []
arg_parms = []
onlylegendFlag = 0
onlylegendParams = []

xlabelParams = "X-Label Title (units)"
ylabelParams = "Y-Label Title (units)"
glabelParams = "G-Label Title (units)"

#  ./plotDat.py -win:'0,-80,500,120' -xlabel:'hello there' -ylabel:'my friend' -glabel:'hi there graph' -alpha batchdata/batchdata_v_2012-05-25_1814-29.dat 


for arg in sys.argv:
    # handle parameters with options like -win:'n,n,n,n'
    if (arg.count(":")):
        arg_parms = arg.split(":",2)
        arg = arg_parms[0].strip("'")        
        
    if (arg == "-dt"):
        dtFlag = 1
        dtParams = arg_parms[1]
    if (arg == "-color"):
        colorFlag = 1
        colorParams = int(arg_parms[1])
    if (arg == "-onlylegend"):
        # -onlylegend:1,2,3,4,5,i_1,i_2,i_3,i_4,i_5
        print "creating a legend for a null plot..."
        onlylegendFlag = 1
        onlylegendParams = arg_parms[1].split(",")
        # p1 = Rectangle((0, 0), 1, 1, fc="r")
        # p2 = Rectangle((0, 0), 1, 1, fc="g")
        # p3 = Rectangle((0, 0), 1, 1, fc="b")
        # p4 = Rectangle((0, 0), 1, 1, fc="y")
        # legend([p1, p2, p3, p4], ["test 1", "test 2", "test 3", "test 4"])
    if (arg == "-win"):
        windowFlag = 1
        windowParams = arg_parms[1].split(",",4)
    if (arg == "-winx"):
        windowFlag = 2
        windowParams = arg_parms[1].split(",",2)
    if (arg == "-xlabel"):
        xlabelFlag = 1
        xlabelParams = arg_parms[1].replace("_"," ")
    if (arg == "-ylabel"):
        ylabelFlag = 1
        ylabelParams = arg_parms[1].replace("_"," ")
    if (arg == "-glabel"):
        glabelFlag = 1
        glabelParams = arg_parms[1].replace("_"," ")
    if (arg == "-dtfile"):
        dtfileFlag = 1
        dtfileParams = arg_parms[1]
    if (arg == "-debug"):
        DEBUG = True
        debugFlag = 1
    if (arg == "-help"):
        helpFlag = 1
    if (arg == "-show"):
        showFlag = 1
    if (arg == "-alpha"):
        alphaFlag = 1
    if (arg == "-overlay"):
        overlayFlag = 1
    if (len(arg) > 1 and arg[0] != "-" and arg.count(".py") == 0):
        # file location argument
        targetList.append(arg)
        print "target queued: "+arg

if (helpFlag == 1):
    print "Call this script as follows: -- need to update -- \n\
    ./plotDat.py [options] <file1> <file2> <file3> ...  \n\
    -debug to debug and not do anything\n\
    -show to show \n\
    -alpha to draw background transparent \n\
    -overlay to draw multiple files on one graph as overlay \n\
    -help for this text \n\
    -dtfile:filename\n\
    -win:<minx,miny,maxx,maxy> to control output range \n\
    -xlabel:'<text_on_xlabel>'\n\
    -ylabel:'<text_on_ylabel>'\n\
    -glabel:'<text_on_glabel> text on graph overall'\n\
    \n\
    NOTE: the script is not 100% stable, some combinations do not work\n\
    \n"
    quit()

#    -type=nm for neuromatic folders \n\
#    -type=nc for neuroconstruct folders \n\

 
DEBUG = True
def debugPrint(prStr):
    if (DEBUG):
        _, filename, linenumber, _, _, _ = inspect.stack()[1]
        print filename+" lineno:"+str(linenumber)+" : "+prStr
        

plotNum = 0

#Black or  000000	 Gray or   808080	 Silver or C0C0C0	 White or   FFFFFF
#Navy or   000080	 Blue or   0000FF	 Teal or   008080	 Aqua or    00FFFF
#Purple or 800080	 Maroon or 800000	 Red or    FF0000	 Fuschia or FF00FF
#Green or  008000	 Lime or   00FF00	 Olive or  808000	 Yellow or  FFFF00

plotcolors=['#000000','#EE9090','#90EE90','#9090EE', \
            '#000080','#0000FF','#008080','#00FFFF', \
            '#800080','#800000','#FF0000','#FF00FF', \
            '#008000','#00FF00','#808000','#FFFF00' \
]


if (onlylegendFlag):
    # onlylegendParams = arg_parms[1].split(",")
    # p1 = Rectangle((0, 0), 1, 1, fc="r")
    # p2 = Rectangle((0, 0), 1, 1, fc="g")
    # p3 = Rectangle((0, 0), 1, 1, fc="b")
    # p4 = Rectangle((0, 0), 1, 1, fc="y")
    # legend([p1, p2, p3, p4], ["test 1", "test 2", "test 3", "test 4"])
    fig = plt.figure(facecolor='#FFFFFF', edgecolor='#FFFFFF')
    ax = fig.add_subplot(111, autoscale_on=True, frame_on=True)
    if (alphaFlag):
        #fig = plt.figure()
        fig.patch.set_alpha(0.0)
        #ax = fig.add_subplot(111)
        ax.patch.set_alpha(0.0)
    ax.spines['top'].set_color('none')
    ax.spines['right'].set_color('none')
    # for loop over colors
    # legendColors = onlylegendParams (first half of list, all converted to integer)
    # legendText = onlylegendParams (second half of list, all as string)
    legendColors =[]
    legendText =[]
    for colidx in range(0,len(onlylegendParams)):
        if ( onlylegendParams[colidx].isdigit() ):
            legendColors.append(int(onlylegendParams[colidx]))
        else:
            legendText.append(onlylegendParams[colidx])
    pArr = []
    data_x = np.arange(0.0, 100.0, 1)
    data_y = np.arange(0.0, 100.0, 1)
    for alab in legendColors:
        # p = Rectangle((0, 0), 1, 1, fc="r")
        # l = Line2D(ax, data_x, data_y , color=plotcolors[alab % len(plotcolors)], ls='-', lw=2)
        l = Rectangle((0, 0), 1, 1, fc=plotcolors[alab % len(plotcolors)])
        pArr.append(l)
        #pArr.append(  ax.plot(data_x, data_y, color=plotcolors[colorParams % len(plotcolors)], linestyle='-', marker='', markerfacecolor='None', markeredgecolor='#000000' )  )
    legend(pArr, legendText)
    canvas = FigureCanvas(fig)
    targetFile = targetList[0]
    graphicsFilename = targetFile
    graphicsFilename = graphicsFilename.replace('.txt','')
    #canvas.print_eps(graphicsFilename+'.svg')
    canvas.print_eps(graphicsFilename+'.eps')
    #canvas.print_pdf(graphicsFilename+'.pdf')
    canvas.print_png(graphicsFilename+'.png')
    plt.close(fig)

# for each file sent as argument create a plot
for filidx in range(0,len(targetList)):
    targetFile = targetList[filidx]
    # read the x values
    if (os.path.exists(targetFile) ):
        # read the y values
        data_y = []
        data_x = []
        t = 0
        if (dtfileFlag and os.path.exists(dtfileParams)):
            file_x = open(dtfileParams,'rU')
            debugPrint("Reading X vals from file:"+dtfileParams)
            for line in file_x:
                if not line.strip().startswith('#') or not line.strip():
                    try:
                        data = float(line)
                        data_x.append(data)
                    except:
                        debugPrint("skipping line (bad format):"+str(line))
                        continue
            file_x.close()
        else:
            if (dtFlag):
                dt = float(dtParams)
            else:
                dt = 1
        file_y = open(targetFile,'rU')
        debugPrint("Reading file:"+targetFile)
        for line in file_y:
            if not line.strip().startswith('#') or not line.strip():
                try:
                    data = float(line)
                    data_y.append(data)
                    if (not dtfileFlag):
                        data_x.append(t)
                        t=t+dt
                except:
                    if (not str(line).isspace()):
                        debugPrint("skipping line (bad format):"+str(line))
                    continue
                
        file_y.close()                    
        debugPrint("imported last data dat_y:"+str(data)+" records/time: "+str(t))
        # !! need to check for size differences in dimension

        if (overlayFlag == 0):
            fig = plt.figure(facecolor='#FFFFFF', edgecolor='#FFFFFF')
            if (windowFlag==1):
                ax = fig.add_subplot(111, autoscale_on=False, frame_on=True)
                ax.axis([float(windowParams[0]),float(windowParams[2]), float(windowParams[1]),float(windowParams[3])])
            elif(windowFlag==2):
                # x-scale entered, y-automatic
                # ax = fig.add_subplot(111, autoscale_on=True, frame_on=True)
                ax = fig.add_subplot(111)
                ax.autoscale(enable=True,axis='y')
            else:
                ax = fig.add_subplot(111, autoscale_on=True, frame_on=True)
            if (alphaFlag):
                #fig = plt.figure()
                fig.patch.set_alpha(0.0)
                #ax = fig.add_subplot(111)
                ax.patch.set_alpha(0.0)
            ax.spines['top'].set_color('none')
            ax.spines['right'].set_color('none')
            #    ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker='o', markerfacecolor='None', markeredgecolor='#000000' )
            #ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            #  todo: could catch if count of data_x and data_y is different
            print "plotting:",(plotcolors[colorParams % len(plotcolors)])
            ax.plot(data_x, data_y, color=plotcolors[colorParams % len(plotcolors)], linestyle='-', marker='', markerfacecolor='None', markeredgecolor='#000000' )
            #ax.plot(data_x, data_y, color='#FF0000', linestyle='-', marker='', markerfacecolor='None', markeredgecolor='#000000' )
            if (glabelFlag):
                ttl1 = title(glabelParams)
            else:
                title('Plot of file: '+targetFile)
            ttl1xy = ttl1.get_position()
            ttl1.set_position([ttl1xy[0],ttl1xy[1]+0.03])
            ax.set_ylabel(ylabelParams, fontsize=14)
            ax.set_xlabel(xlabelParams, fontsize=14)
            ax.xaxis.set_ticks_position('bottom')
            ax.yaxis.set_ticks_position('left')
            # draw()
            canvas = FigureCanvas(fig)
            graphicsFilename = targetFile
            graphicsFilename = graphicsFilename.replace('.txt','')
            #canvas.print_eps(graphicsFilename+'.svg')
            canvas.print_eps(graphicsFilename+'.eps')
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
                title(glabelParams)
                ax.set_ylabel(ylabelParams, fontsize=14)
                ax.set_xlabel(xlabelParams, fontsize=14)
                ax.xaxis.set_ticks_position('bottom')
                ax.yaxis.set_ticks_position('left')
            #    ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker='o', markerfacecolor='None', markeredgecolor='#000000' )
            #ax.plot(data_x, data_y, color='#000000', linestyle='None', solid_joinstyle ='round', solid_capstyle ='round',  marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            debugPrint("plotting data_x data_y as overlay")
            ax.plot(data_x, data_y, color=plotcolors[plotNum % len(plotcolors)], linestyle='-', marker=',', markerfacecolor='None', markeredgecolor='#000000' )
            plotNum += 1
            

if (showFlag == 1):
    # show graphs for a certain amount of time then exit
    plt.show(1) # pass 0 to show and move on - 1 blocks and waits
    time.sleep(6)

# can I lay out the windows for the graphs or better to consolidate all sources in one graph?
# the idea is to create a workflow while I an working in neuron to try different values?

                
                


