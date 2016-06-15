#   Script for generating analysis plots for Traub model cells in the NeuroML2 format
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


    generate_current_vs_frequency_curve(pathToCell+cellID+".cell.nml", 
                                        cellID, 
                                        start_amp_nA =         -0.2, 
                                        end_amp_nA =           2, 
                                        step_nA =              0.2, 
                                        analysis_duration =    1000, 
                                        analysis_delay =       50,
                                        dt=                    0.01,
                                        temperature=           "6.3degC",
                                        simulator=             "jNeuroML_NEURON",
                                        plot_voltage_traces=   True,
                                        save_if_figure_to='%sIF_%s.png'%(pathToCell,cellID))
                                    
                                    
                                    
def SingleCellSim(simConfig,dt,targetPath):
    
    src_files = os.listdir(targetPath)
    for file_name in src_files:
    
        if file_name=="Thalamocortical.net.nml":
           full_target_path=os.path.join(targetPath,file_name)
           net_doc = pynml.read_neuroml2_file(full_target_path)
           net_doc.id=simConfig

           net=net_doc.networks[0]
           net.id=simConfig


           net_file = '%s.net.nml'%(net_doc.id)
           writers.NeuroMLWriter.write(net_doc, full_target_path)

           print("Written network with 1 cell in network to: %s"%(full_target_path))
           
        if file_name=="LEMS_Thalamocortical.xml":
           full_lems_path=os.path.join(targetPath,file_name)
           with open(full_lems_path, 'r') as file:
                lines = file.readlines()
           for line in lines:
               if "Simulation" in line:
                  target_line=line.split(" ")
                  for item in target_line:
                      if "length" in item:
                         target_str=item.split("=")
                         print target_str
                         get_value=target_str[1][1:-3]
                         sim_duration=float(get_value)
           

    validate_neuroml2(full_target_path)

    generate_lems_file_for_neuroml("Sim_"+net_doc.id, 
                               full_target_path, 
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
                               
                               
def generate_sims(configs,parentDir,dt,sharedTag=None):

    src_files = os.listdir(parentDir)
    for file_name in src_files:
        if file_name in configs.keys():
           full_file_name = os.path.join(parentDir, file_name)
           if (os.path.isdir(full_file_name)):
              print("%s is a directory"%full_file_name)
              src_files2=os.listdir(full_file_name)
              for file_name2 in src_files2:
                  full_file_name2=os.path.join(full_file_name,file_name2)
                  if (os.path.isdir(full_file_name2)):
                     print("%s is a directory"%full_file_name2)
                     if sharedTag !=None:
                        SingleCellSim(sharedTag,dt,full_file_name2)
                     else:
                        SingleCellSim(file_name,dt,full_file_name2)
           

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
   
   
   #PerturbChanNML2(targetCell="TestSeg_all",
   #noSteps=30,
   #sim_duration=100,
   #dt=0.005,
   #mepFile="../.test.mep",
   #omtFile="../.test.SingleComp0005.jnmlnrn.omt",
   #targetNet="Thalamocortical.net.nml",
   #targetChannels=['cal','napf'],
   #targetPath="../Default_Simulation_Configuration/Default_Simulation_Configuration_default/",save_to_file="cal_and_napf.pdf")

  #SingleCellSim(simConfig="Default_Simulation_Configuration",dt=0.005,targetPath="../Test/Default_Simulation_Configuration/Default_Simulation_Configuration_default/")
  #SingleCellSim(simConfig="Target",dt=0.01,targetPath="../Cell1-supppyrRS-FigA1RS/Cell1-supppyrRS-FigA1RS_default/")
  #SingleCellSim(simConfig="Target",dt=0.01,targetPath="../Cell7-tuftIB-FigA4-1500/Cell7-tuftIB-FigA4-1500_default/")
  #SingleCellSim(simConfig="Target",dt=0.01,targetPath="../Cell8-tuftRS-Fig5A-1400/Cell8-tuftRS-Fig5A-1400_default/")
  SingleCellSim(simConfig="Target",dt=0.01,targetPath="../Default_Simulation_Configuration/Default_Simulation_Configuration_default/")
  #configs={"Default Simulation Configuration":"TestSeg_all",  
           #"Cell1-supppyrRS-FigA1RS":"L23PyrRS",
           #"Cell2-suppyrFRB-FigA1FRB":"L23PyrFRB",
           #"Cell3-supbask-FigA2a":"SupBasket",
           #"Cell1-supppyrRS-10ms":"L23PyrRS",
           #"Cell4-supaxax-FigA2a":"SupAxAx",
           #"Cell2-suppyrFRB-10ms":"L23PyrFRB",
           #"Cell3-supbask-10ms":"SupBasket",
           #"Cell4-supaxax-10ms":"SupAxAx",
           #"Cell5-supLTS-10ms":"SupLTSInter",
           #"Cell5-supLTS-FigA2b":"SupLTSInter",
           #"Cell6-spinstell-10ms":"L4SpinyStellate",
           #"Cell6-spinstell-FigA3-167":"L4SpinyStellate",
           #"Cell6-spinstell-FigA3-250":"L4SpinyStellate",
           #"Cell6-spinstell-FigA3-333":"L4SpinyStellate",
           #"Cell7-tuftIB-10ms":"L5TuftedPyrIB",
           #"Cell7-tuftIB-FigA4-900":"L5TuftedPyrIB",
           #"Cell7-tuftIB-FigA4-1100":"L5TuftedPyrIB",
           #"Cell7-tuftIB-FigA4-1300":"L5TuftedPyrIB",
           #"Cell7-tuftIB-FigA4-1500":"L5TuftedPyrIB",
           #"Cell8-tuftRS-10ms":"L5TuftedPyrRS",
           #"Cell8-tuftRS-FigA5-800":"L5TuftedPyrRS",
           #"Cell8-tuftRS-Fig5A-1000":"L5TuftedPyrRS",
           #"Cell8-tuftRS-Fig5A-1200":"L5TuftedPyrRS",
           #"Cell8-tuftRS-Fig5A-1400":"L5TuftedPyrRS",
           #"Cell9-nontuftRS-10ms":"L6NonTuftedPyrRS",
           #"Cell9-nontuftRS-FigA6-500":"L6NonTuftedPyrRS",
           #"Cell9-nontuftRS-FigA6-800":"L6NonTuftedPyrRS",
           #"Cell9-nontuftRS-FigA6-1000":"L6NonTuftedPyrRS",
           #"Cell10-deepbask-10ms":"DeepBasket",
           #"Cell11-deepaxax-10ms":"DeepAxAx",
           #"Cell12-deepLTS-10ms":"DeepLTSInter",
           #"Cell12-deepLTS-FigA2b":"DeepLTSInter",
           #"Cell13-TCR-10ms":"TCR",
           #"Cell13-TCR-FigA7-100":"TCR",
           #"Cell13-TCR-FigA7-600":"TCR",
           #"Cell14-nRT-10ms":"nRT",
           #"Cell14-nRT-FigA8-00":"nRT",
           #"Cell14-nRT-FigA8-300":"nRT",
           #"Cell14-nRT-FigA8-500":"nRT"}
            
  #generate_sims(configs,"../",0.01,'Target')
            
            
  
