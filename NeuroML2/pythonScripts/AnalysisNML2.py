#   Script for generating analysis plots for Traub model cells in NeuroML2 format
#
#   Author: Rokas Stanislovas
#
#   GSoC 2016 project Cortical Networks
#
#
#

import sys
import os
from pyneuroml.analysis import generate_current_vs_frequency_curve
from neuroml import *
from pyneuroml import pynml
import neuroml.writers as writers 

from pyneuroml.lems import generate_lems_file_for_neuroml
from neuroml.utils import validate_neuroml2

from matplotlib import pyplot as plt
import random
import subprocess
import re
import numpy as np
import math


def AnalysisNML2(pathToCell,cellID):


    generate_current_vs_frequency_curve(pathToCell, 
                                    cellID, 
                                    start_amp_nA =         -0.2, 
                                    end_amp_nA =           0.8, 
                                    step_nA =              0.2, 
                                    analysis_duration =    1000, 
                                    analysis_delay =       50,
                                    simulator=             "jNeuroML_NEURON")
                                    
                                    
                                    
def SingleCellSim(simConfig,sim_duration,dt,targetPath):
    
    src_files = os.listdir(targetPath)
    for file_name in src_files:
        if file_name=="Thalamocortical.net.nml":
           net_doc = pynml.read_neuroml2_file(targetPath+file_name)
           net_doc.id=simConfig

           net=net_doc.networks[0]
           net.id=simConfig


           net_file = '%s.net.nml'%(net_doc.id)
           writers.NeuroMLWriter.write(net_doc, targetPath+net_file)

           print("Written network with 1 cell in network to: %s"%(targetPath+net_file))

    

    validate_neuroml2(targetPath+net_file)

    generate_lems_file_for_neuroml("Sim_"+net_doc.id, 
                               targetPath+net_file, 
                               net_doc.id, 
                               sim_duration,
                               dt, 
                               "LEMS_%s.xml"%net_doc.id,
                               targetPath,
                               gen_plots_for_all_v = True,
                               plot_all_segments = False,
                               gen_saves_for_all_v = True,
                               save_all_segments = False,
                               copy_neuroml = False,
                               seed = 1234)


def getSpikes(leftIdent,targetFile,scalingFactor=1,rightIdent=None):

    with open(targetFile, 'r') as file:
         lines = file.readlines()
    count=0
    last_line=len(lines)
    for line in lines:
               
         if leftIdent in line:
            first_line=count
         if rightIdent !=None and rightIdent in line:
            last_line=count
         count+=1
    observed_array=[]
    for target_line in range(first_line,last_line):
        values=re.findall("\d+\.\d+",lines[target_line])
        for value in values:
            value_float=float(value)*scalingFactor
            observed_array.append(value_float)   
            
            
    return observed_array
    

def Replace(line,leftTag,rightTag,newString):

    find_left=line.find(leftTag)
    find_right=line.find(rightTag)
    to_be_replaced=line[find_left:find_right+len(rightTag)]
    new_line=line.replace(to_be_replaced,newString)
    return new_line

def spike_df_vs_gmax(gInfo,spikesDict,save_to_file):
    
    no_of_plots=len(spikesDict['observed'])
    if (no_of_plots % 6) >= 1:
       rows = max(1,int(math.ceil(no_of_plots/6)+1))
    else:
       rows=max(1,int(math.ceil(no_of_plots/6)))
    columns = min(6,no_of_plots)
       
    fig,ax = plt.subplots(rows,columns,sharex=False,figsize=(4*columns,3*rows))

    if rows > 1 or columns > 1:
       ax = ax.ravel()
      
    fig.canvas.set_window_title("Euclidian distance between expected and observed spike times versus conductance level")
    channel_counter=0 
    for channel in spikesDict['observed'].keys():
        x_y_values=[]
        gValues=[]
        for gValue in spikesDict['observed'][channel].keys():
            exp=spikesDict['expected']
            obs=spikesDict['observed'][channel][gValue]
            y=math.sqrt(sum([(a - b)**2 for a,b in zip(exp,obs)]))
            x=float(gValue)
            gValues.append(x)
            y=float(y)
            x_y_values.append((x,y))
        x_y_values.sort(key=lambda z: z[0])
        x_values=[x_y_values[l][0] for l in range(0,len(x_y_values))]     
        y_values=[x_y_values[m][1] for m in range(0,len(x_y_values))]
        if no_of_plots > 1:
           ax[channel_counter].set_xlabel('cond density %s'%(gInfo[channel]['units']))
           ax[channel_counter].set_ylabel('Spike time difference (s)')
           ax[channel_counter].set_ylim(-0.005,0.01)  ## should be adjusted or make as function arguments
           ax[channel_counter].set_xlim(0,4.0*round(max(gValues),-int(math.floor(math.log10(abs(max(gValues))))))/3)
           ax[channel_counter].xaxis.grid(True)
           ax[channel_counter].yaxis.grid(True)
        else:
           ax.set_xlabel('cond density %s'%(gInfo[channel]['units']))
           ax.set_ylabel('Spike time difference (s)')
           ax.set_ylim(-0.005,0.01)   ## should be adjusted or make as function arguments
           ax.set_xlim(0,4.0*round(max(gValues),-int(math.floor(math.log10(abs(max(gValues))))))/3)
           ax.xaxis.grid(True)
           ax.yaxis.grid(True)
        if no_of_plots >1:
           ax[channel_counter].scatter(x_values,y_values)
           ax[channel_counter].plot(x_values,y_values,color='r')
        else:
           ax.scatter(x_values,y_values)
           ax.plot(x_values,y_values,color='r')
        
        print("Adding trace for: %s"%channel)
                
        if no_of_plots >1:
           ax[channel_counter].used = True
           ax[channel_counter].set_title(channel,size=13)
           ax[channel_counter].locator_params(tight=True, nbins=6)
        else:
           ax.used = True
           ax.set_title(channel,size=13)
           ax.locator_params(tight=True, nbins=6)
           
        if no_of_plots >1:
           for tick in ax[channel_counter].xaxis.get_major_ticks():
               tick.label.set_fontsize(9) 
        else:
           for tick in ax.xaxis.get_major_ticks():
               tick.label.set_fontsize(9)
        channel_counter+=1
                
    if no_of_plots != int(rows*columns):  
       for empty_plot in range(0,int(rows*columns)-no_of_plots):
           x=-1-empty_plot
           ax[x].axis("off")         
          
    plt.tight_layout()
    if save_to_file !=None:
       plt.savefig(save_to_file)
    plt.show()
                                              
                                    
def PerturbChanNML2(targetCell,noSteps,sim_duration,dt,mepFile,omtFile,targetNet,targetChannels="all",targetPath=None,save_to_file=None):
    ###### method for testing how spiking behaviour of single cell NML2 models is affected by conductance changes in given ion channels  
    cell_nml2 = '%s.cell.nml'%targetCell
    document_cell = loaders.NeuroMLLoader.load(targetPath+cell_nml2)
    cell_obj=document_cell.cells[0]
    
    gInfo={}
    
    
    spikesDict={}
    spikesDict['expected']=getSpikes(leftIdent="spike times",targetFile=mepFile)
    spikesDict['observed']={}
    
    letChannel=False
    
    
    for channel_density in cell_obj.biophysical_properties.membrane_properties.channel_densities:
    
        if targetChannels !="all":
           if channel_density.ion_channel in targetChannels:
              letChannel=True
        else:
           letChannel=True
          
        if letChannel:
           targetChan=channel_density.ion_channel
           gInfo[targetChan]={}
           chan_str=channel_density.cond_density.split(" ") 
           gInfo[targetChan]['units']=chan_str[1]
           initial_value=float(chan_str[0])
           gInfo[targetChan]['values']=np.linspace(initial_value,0,noSteps)
           spikesDict['observed'][targetChan]={}
           for gValue in gInfo[targetChan]['values']:
               if gValue==initial_value:
                  targetOmt=omtFile
               else:
                  document_cell_inner=loaders.NeuroMLLoader.load(targetPath+cell_nml2)
                  cell_obj_inner=document_cell_inner.cells[0]
                  for channel_density_inner in cell_obj_inner.biophysical_properties.membrane_properties.channel_densities:
                      if channel_density_inner.ion_channel==channel_density.ion_channel:
                         target_density=channel_density_inner
                         
                  testFile="../.test.ChannelTest.jnmlnrn.omt"
                  subprocess.call(["cp %s %s"%(omtFile,testFile)],shell=True)
                  targetOmt=testFile
                  cell_id="%sG%s"%(target_density.id,str(gValue).replace(".",""))
                  new_cell_nml2="%s.cell.nml"%cell_id
                  document_cell_inner.id=cell_id
                  cell_obj_inner.id=cell_id
                  target_density.cond_density=str(gValue)+" "+gInfo[targetChan]['units']
                  writers.NeuroMLWriter.write(document_cell_inner, targetPath+new_cell_nml2)
                  
                  src_files = os.listdir(targetPath)
                  if targetNet in src_files:
                     net_doc = pynml.read_neuroml2_file(targetPath+targetNet)
                     net_doc.id="Test_%s"%cell_id
                     net=net_doc.networks[0]
                     pop=net.populations[0]
                     popID=pop.id
                     net.id=net_doc.id
                     net_file = '%s.net.nml'%(net_doc.id)
                     netPath=targetPath+net_file
                     writers.NeuroMLWriter.write(net_doc, netPath)
                     with open(netPath, 'r') as file:
                          lines = file.readlines()
                     count=0
                     for line in lines:
                         if targetCell in line:
                            new_line=line.replace(targetCell,cell_id)
                            lines[count]=new_line
                         count+=1
                     with open(netPath, 'w') as file:
                          file.writelines( lines )
                     lems_string="LEMS_%s.xml"%net_doc.id
                     sim_string="Sim_"+net_doc.id
                     generate_lems_file_for_neuroml(sim_string, 
                               netPath, 
                               net_doc.id, 
                               sim_duration,
                               dt, 
                               lems_string,
                               targetPath,
                               gen_plots_for_all_v = True,
                               plot_all_segments = False,
                               gen_saves_for_all_v = True,
                               save_all_segments = False,
                               copy_neuroml = False,
                               seed = 1234)
                               
                     with open(targetOmt, 'r') as file:
                          lines = file.readlines()
                     count=0
                     for line in lines:
                         if "target" in line:
                            lines[count]=Replace(line,"LEMS","xml",lems_string)
                         if "path" in line:
                            lines[count]=Replace(line,"Sim_","dat",sim_string+".%s.v.dat"%popID)
                         count+=1
                     with open(targetOmt, 'w') as file:
                          file.writelines( lines )
                               
                   
   
               out_file=open(r'../temp_results.txt','w')   
               command_line="omv test  %s"%targetOmt
               print("Running %s..."%command_line+" after setting conDensity of %s to %f"%(targetChan,gValue))
               subprocess.call([command_line],shell=True,stdout=out_file)
               out_file.close()
               observed_spikes=getSpikes(leftIdent="observed data",targetFile=r'../temp_results.txt',rightIdent="and")
               print "Observed spikes:"+str(observed_spikes)
               print "Expected spikes:"+str(spikesDict['expected'])
               if len(observed_spikes) != len(spikesDict['expected']):
                  print "The number of observed spikes is not equal to the number of expected spikes; analysis for %s will be terminated"%targetChan
                  break
               else:
                  spikesDict['observed'][targetChan][str(gValue)]=observed_spikes
            
           letChannel=False   
    print("will generate plots for how differences between expected and observed spike times vary with conductance level of a given ion channel")     
    spike_df_vs_gmax(gInfo,spikesDict,save_to_file)
                                  
                                    
                                    
if __name__=="__main__":
   
   
   PerturbChanNML2(targetCell="TestSeg_all",
   noSteps=1,
   sim_duration=100,
   dt=0.005,
   mepFile="../.test.mep",
   omtFile="../.test.SingleComp0005.jnmlnrn.omt",
   targetNet="Thalamocortical.net.nml",
   targetChannels='all',
   targetPath="../Default_Simulation_Configuration/Default_Simulation_Configuration_default/",save_to_file="Test.pdf")

  #SingleCellSim(simConfig="Default_Simulation_Configuration",sim_duration=100,dt=0.005,targetPath="../Default_Simulation_Configuration/Default_Simulation_Configuration_default/")

  #AnalysisNML2("../L23PyrRS/L23PyrRS_default/L23PyrRS.cell.nml","L23PyrRS")
  #SingleCellSim("SupBasket","Test_Cell3_supbask_FigA2a")
  #SingleCellSim("L23PyrRS","Cell1_supppyrRS_10ms",10)
  #SingleCellSim(simConfig="FigA1RS",sim_duration=800,dt=0.005,targetPath="../Cell1-supppyrRS-FigA1RS/Cell1-supppyrRS-FigA1RS_default/")
  #SingleCellSim("L23PyrFRB","Cell2_suppyrFRB_10ms",10)
  #SingleCellSim(simConfig="L23PyrFRBFigA1RS",sim_duration=800,dt=0.005,targetPath="../Cell2-suppyrFRB-FigA1FRB/Cell2-suppyrFRB-FigA1FRB_default/")
  #SingleCellSim("SupBasket","Cell3_supbask_10ms",10)
  #SingleCellSim("SupAxAx","Cell4_supaxax_10ms",10)
  #SingleCellSim("SupAxAx","Cell4_supaxax_FigA2a",300)
  #SingleCellSim("SupLTSInter","Cell5_supLTS_10ms",10)
  #SingleCellSim("SupLTSInter","Cell5_supLTS_FigA2b",300)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_10ms",30)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_167",700)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_250",700)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_333",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_10ms",10)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FIgA4_900",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1100",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1300",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1500",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_10ms",10)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_FigA5_800",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_Fig5A_1000",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_Fig5A_1200",700)
  #SingleCellSim('L5TuftedPyrRS','Cell8_tuftRS_Fig5A_1400',700)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_10ms",50)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_500",800)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_800",800)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_1000",800)
  #SingleCellSim("DeepBasket","Cell10_deepbask_10ms",10)
  #SingleCellSim("DeepAxAx","Cell11_deepaxax_10ms",10)
  #SingleCellSim("DeepLTSInter","Cell12_deepLTS_10ms",10)
  #SingleCellSim("DeepLTSInter","Cell12_deepLTS_FigA2b",300)
  #SingleCellSim("TCR","Cell13_TCR_10ms",10)
  #SingleCellSim("TCR","Cell13_TCR_FigA7_100",350)
  #SingleCellSim("TCR","Cell13_TCR_FigA7_600",1500)
  #SingleCellSim("nRT","Cell14_nRT_10ms",30)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_00",200)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_300",450)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_500",450)
