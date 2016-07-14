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
import shutil
import os

##############################################################################################################################
def PlotNC_vs_NML2(targets_to_plot,cols_rows_scale,legend=False,show=False,save_to_file=None,nCcellPath=None,NML2cellPath=None):
    
    path={}
    path['nC']=nCcellPath
    path['NML2']=NML2cellPath
    colour={}
    colour['nC']='r'
    colour['NML2']='b'
    subplot_titles=targets_to_plot['subplotTitles']

    if len(targets_to_plot['NML2'])==len(targets_to_plot['nC']):
       no_of_pairs=len(targets_to_plot['NML2'])
       
       if (no_of_pairs % 5) >= 1:
          rows = max(1,int(math.ceil(no_of_pairs/5)+1))
       else:
          rows=max(1,int(math.ceil(no_of_pairs/5)))
       columns = min(5,no_of_pairs)
       
       fig,ax = plt.subplots(rows,columns,sharex=False,figsize=(cols_rows_scale['cols']*columns,cols_rows_scale['rows']*rows))

       if rows > 1 or columns > 1:
          ax = ax.ravel()
      
       fig.canvas.set_window_title("Thalamocortical cell models: neuroConstruct project compared to NeuroML2")
       
       for pair in range(0,no_of_pairs):
           cells={}
           cells['NML2']=targets_to_plot['NML2'][pair]
           cells['nC']=targets_to_plot['nC'][pair]
           if no_of_pairs > 1:
              ax[pair].set_xlabel('Time (s)')
              ax[pair].set_ylabel('Membrane potential (V)')
              ax[pair].xaxis.grid(True)
              ax[pair].yaxis.grid(True)
           else:
              ax.set_xlabel('Time (s)')
              ax.set_ylabel('Membrane potential (V)')
              ax.xaxis.grid(True)
              ax.yaxis.grid(True)
           
           for cell_project in ['NML2','nC']:
               data=[]
               time_array=[]
               voltage_array=[]
               data.append(time_array)
               data.append(voltage_array)
               
               if not isinstance(cells[cell_project],dict):
               
                  if path[cell_project]==None:
                     cell_path=cells[cell_project]+'.dat'
                  else:
                     cell_path=os.path.join(path[cell_project],cells[cell_project]+'.dat')
               
                  for line in open(cell_path):
                      values=line.split() # for each line there is a time point and voltage value at that time point
                      for x in range(0,2):
                          data[x].append(float(values[x]))
                  if no_of_pairs >1:
                     ax[pair].plot(data[0],data[1],label=cell_project,color=colour[cell_project])
                  else:
                     ax.plot(data[0],data[1],label=cell_project,color=colour[cell_project])
                  print("Adding trace for: %s"%subplot_titles[pair])
                  
               else:
               
                  if 'v' and 't' in cells[cell_project].keys():
                     
                     data[0]=cells[cell_project]['t']
                     data[1]=cells[cell_project]['v']
                     
                     if no_of_pairs >1:
                        ax[pair].plot(data[0],data[1],label=cell_project,color=colour[cell_project])
                     else:
                        ax.plot(data[0],data[1],label=cell_project,color=colour[cell_project])
                     print("Adding trace for: %s"%subplot_titles[pair])
  
           
           if no_of_pairs >1:
              ax[pair].used = True
              ax[pair].set_title(subplot_titles[pair],size=13)
              ax[pair].locator_params(tight=True, nbins=8)
           else:
              ax.used = True
              ax.set_title(subplot_titles[pair],size=13)
              ax.locator_params(tight=True, nbins=8)
           
           if no_of_pairs >1:
              for tick in ax[pair].xaxis.get_major_ticks():
                  tick.label.set_fontsize(9) 
           else:
              for tick in ax.xaxis.get_major_ticks():
                  tick.label.set_fontsize(9)
                  
       if no_of_pairs != int(rows*columns):  
       
          for empty_plot in range(0,int(rows*columns)-no_of_pairs):
              x=-1-empty_plot
              ax[x].axis("off")         
          
       if legend:
          ##### adjust these for better display
          if no_of_pairs >1:
             ax[0].legend(loc='upper center',bbox_to_anchor=(0.19, 1),fontsize=14, fancybox=True,ncol=1, shadow=True)
          else:
             ax.legend(loc='upper center',bbox_to_anchor=(0.19, 1),fontsize=14, fancybox=True,ncol=1, shadow=True)
             
       plt.tight_layout()
       
       if save_to_file !=None:
          plt.savefig(save_to_file)
       
       if show:
          plt.show()
       
#############################################################################################################################
def get_sim_duration(full_lems_path):

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
                  
    return sim_duration
##################################################################                                    
                                    
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
           sim_duration=get_sim_duration(full_lems_path)
           

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
                               
###############################################################################################                               
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
                        
#####################################################################################################
def RunNeuroConstruct():

    #TODO
    pass                        
           
######################################################################################################
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
    
##################################################################################################################
def Replace(line,leftTag,rightTag,newString):

    find_left=line.find(leftTag)
    find_right=line.find(rightTag)
    to_be_replaced=line[find_left:find_right+len(rightTag)]
    new_line=line.replace(to_be_replaced,newString)
    return new_line
####################################################################################################################
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
                                              
#####################################################################################################################                                   
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
    
############################################################################################################################################################   
    
def analyse_spiketime_vs_dx(lems_path_dict, 
                            simulator,
                            cell_v_path,
                            verbose=False,
                            spike_threshold_mV = 0,
                            show_plot_already=True,
                            save_figure_to=None):
                                
    from pyelectro.analysis import max_min
    
    all_results = {}
    comp_values=[]
    for num_of_comps in lems_path_dict.keys():
        comp_values.append(int(num_of_comps))
        if verbose:
            print_comment_v(" == Generating simulation for electrotonic length = %s"%(dx))
                                   
        if simulator == 'jNeuroML':
             results = pynml.run_lems_with_jneuroml(lems_path_dict[num_of_comps], nogui=True, load_saved_data=True, plot=False, verbose=verbose)
        if simulator == 'jNeuroML_NEURON':
             results = pynml.run_lems_with_jneuroml_neuron(lems_path_dict[num_of_comps], nogui=True, load_saved_data=True, plot=False, verbose=verbose)
             
        print("Results reloaded: %s"%results.keys())
             
        all_results[int(num_of_comps)] = results
        

    xs = []
    ys = []
    labels = []
    
    spxs = []
    spys = []
    linestyles = []
    markers = []
    
    for num_of_comps in comp_values:
        t = all_results[num_of_comps]['t']
        v = all_results[num_of_comps][cell_v_path]
        xs.append(t)
        ys.append(v)
        labels.append(num_of_comps)
        
        mm = max_min(v, t, delta=0, peak_threshold=spike_threshold_mV)
        spike_times = mm['maxima_times']
        

        spxs_ = []
        spys_ = []
        for s in spike_times:
            spys_.append(s)
            spxs_.append(num_of_comps)
        
        spys.append(spys_)
        spxs.append(spxs_)
        linestyles.append('-')
        markers.append('x')
        
    num_of_spikes=len(spys[0])
    all_equal=True
    for num_of_comps in range(0,len(comp_values)):
        if len(spys[num_of_comps]) != num_of_spikes:
           all_equal=False
           break
    if all_equal:
       line_spxs=[]
       line_spys=[]
       linestyles=[]
       markers=[]
       for spike in range(0,num_of_spikes):
           linestyles.append('-')
           markers.append('x')
           line_spxs.append(comp_values)
           spike_var=[]
           for comp_value in range(0,len(comp_values)):
               spike_var.append(spys[comp_value][spike])
           line_spys.append(spike_var)
       spxs=line_spxs
       spys=line_spys
                   
    pynml.generate_plot(spxs, 
          spys, 
          "Spike times vs spatial discretization",
          linestyles = linestyles,
          markers = markers,
          xaxis = 'Number of compartments', 
          yaxis = 'Spike times (s)',
          show_plot_already=show_plot_already,
          save_figure_to=save_figure_to) 

        
    if verbose:
        pynml.generate_plot(xs, 
                  ys, 
                  "Membrane potentials in %s for %s"%(simulator,dts),
                  labels = labels,
                  show_plot_already=show_plot_already,
                  save_figure_to=save_figure_to)      

######################################################################################################################
def generate_and_copy_dat(targetDir,targetFileDict,saveToParentDir):

    for cellModel in targetFileDict.keys():
        
        save_to_path=saveToParentDir+cellModel
        
        if not os.path.exists(save_to_path):
           print("Creating a new directory %s"%save_to_path)
           os.makedirs(save_to_path)
        else:
           print("A directory %s already exists"%save_to_path)
           
        src_files = os.listdir(targetDir)
        for file_name in src_files:
            full_file_name = os.path.join(targetDir, file_name)
            if (os.path.isdir(full_file_name)):
               #### strip off __N from target dirs
               target_config=file_name[0:-3]
               
               src_files2=os.listdir(full_file_name) 
               for file2 in src_files2:
                   if ".dat" in file2:
                      ###### strip off .dat from target dirs
                      file_name2=file2[0:-4]
                  
                      if file_name2==targetFileDict[cellModel]['DatTag']:
                  
                         time_array=np.loadtxt(os.path.join(full_file_name,"time.dat"))
                         voltage_array=np.loadtxt(os.path.join(full_file_name,"%s.dat"%file_name2))

                         if len(time_array)==len(voltage_array):

                            voltage_with_time=np.zeros([len(time_array),2])

                            for i in range(0,len(time_array)):
                                voltage_with_time[i,0]=time_array[i]/1000
                                voltage_with_time[i,1]=voltage_array[i]/1000
                         
                            wtime=os.path.join(full_file_name,"%s_wtime.dat"%(file_name2))
                            print("will save %s_wtime.dat to the %s"%(file_name2,full_file_name))
                            np.savetxt(wtime,voltage_with_time)
                            
                            save_to_path_config=os.path.join(save_to_path,target_config)
                            
                            if not os.path.exists(save_to_path_config):
                               print("Creating a new directory %s"%save_to_path_config)
                               os.makedirs(save_to_path_config)
                            else:
                               print("A directory %s already exists"%save_to_path_config)
                            
                            print("moving to the %s"%save_to_path_config)
                            
                            shutil.copy(wtime,save_to_path_config)
       
                                               
#####################################################################################################################                                    
                                    
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
  #SingleCellSim(simConfig="Target",dt=0.01,targetPath="../Default_Simulation_Configuration/Default_Simulation_Configuration_default/")
  configs={"Default Simulation Configuration":"TestSeg_all",  
           "Cell1-supppyrRS-FigA1RS":"L23PyrRS",
           "Cell2-suppyrFRB-FigA1FRB":"L23PyrFRB",
           "Cell3-supbask-FigA2a":"SupBasket",
           "Cell1-supppyrRS-10ms":"L23PyrRS",
           "Cell4-supaxax-FigA2a":"SupAxAx",
           "Cell2-suppyrFRB-10ms":"L23PyrFRB",
           "Cell3-supbask-10ms":"SupBasket",
           "Cell4-supaxax-10ms":"SupAxAx",
           "Cell5-supLTS-10ms":"SupLTSInter",
           "Cell5-supLTS-FigA2b":"SupLTSInter",
           "Cell6-spinstell-10ms":"L4SpinyStellate",
           "Cell6-spinstell-FigA3-167":"L4SpinyStellate",
           "Cell6-spinstell-FigA3-250":"L4SpinyStellate",
           "Cell6-spinstell-FigA3-333":"L4SpinyStellate",
           "Cell7-tuftIB-10ms":"L5TuftedPyrIB",
           "Cell7-tuftIB-FigA4-900":"L5TuftedPyrIB",
           "Cell7-tuftIB-FigA4-1100":"L5TuftedPyrIB",
           "Cell7-tuftIB-FigA4-1300":"L5TuftedPyrIB",
           "Cell7-tuftIB-FigA4-1500":"L5TuftedPyrIB",
           "Cell8-tuftRS-10ms":"L5TuftedPyrRS",
           "Cell8-tuftRS-FigA5-800":"L5TuftedPyrRS",
           "Cell8-tuftRS-Fig5A-1000":"L5TuftedPyrRS",
           "Cell8-tuftRS-Fig5A-1200":"L5TuftedPyrRS",
           "Cell8-tuftRS-Fig5A-1400":"L5TuftedPyrRS",
           "Cell9-nontuftRS-10ms":"L6NonTuftedPyrRS",
           "Cell9-nontuftRS-FigA6-500":"L6NonTuftedPyrRS",
           "Cell9-nontuftRS-FigA6-800":"L6NonTuftedPyrRS",
           "Cell9-nontuftRS-FigA6-1000":"L6NonTuftedPyrRS",
           "Cell10-deepbask-10ms":"DeepBasket",
           "Cell11-deepaxax-10ms":"DeepAxAx",
           "Cell12-deepLTS-10ms":"DeepLTSInter",
           "Cell12-deepLTS-FigA2b":"DeepLTSInter",
           "Cell13-TCR-10ms":"TCR",
           "Cell13-TCR-FigA7-100":"TCR",
           "Cell13-TCR-FigA7-600":"TCR",
           "Cell14-nRT-10ms":"nRT",
           "Cell14-nRT-FigA8-00":"nRT",
           "Cell14-nRT-FigA8-300":"nRT",
           "Cell14-nRT-FigA8-500":"nRT"}
            
  generate_sims(configs,"../",0.01,'Target')
  
  
  targetFileDict={"L23PyrRS":{'DatTag':'CGsuppyrRS_0'},
                   "L23PyrFRB":{'DatTag':'CGsuppyrFRB_0'},
                   "SupBasket":{'DatTag':'CGsupbask_0'},
                   "L4SpinyStellate":{'DatTag':'CGspinstell_0'},
                   "SupAxAx":{'DatTag':'CGsupaxax_0'},
                   "SupLTSInter":{'DatTag':'CGsupLTS_0'},
                   "L5TuftedPyrIB":{'DatTag':'CGtuftIB_0'},
                   "L5TuftedPyrRS":{'DatTag':'CGtuftRS_0'},
                   "L6NonTuftedPyrRS":{'DatTag':'CGnontuftRS_0'},
                   "DeepBasket":{"DatTag":'CGdeepbask_0'},
                   "DeepAxAx":{"DatTag":'CGdeepaxax_0'},
                   "DeepLTSInter":{'DatTag':'CGdeepLTS_0'},
                   "nRT":{"DatTag":'CGnRT_min75init_0'},
                   "TCR":{"DatTag":'CGTCR_0'}}
   
  generate_and_copy_dat("../simulations",targetFileDict,"../../NeuroML2/")
   
  PlotNC_vs_NML2({'NML2':['Sim_Cell1_supppyrRS_10ms.CGsuppyrRS.v','Sim_Cell2_suppyrFRB_10ms.CGsuppyrFRB.v',
   'Sim_Cell3_supbask_10ms.CGsupbask.v','Sim_Cell4_supaxax_10ms.CGsupaxax.v','Sim_Cell5_supLTS_10ms.CGsupLTS.v','Sim_Cell7_tuftIB_10ms.CGtuftIB.v',
   'Sim_Cell8_tuftRS_10ms.CGtuftRS.v','Sim_Cell9_nontuftRS_10ms.CGnontuftRS.v','Sim_Cell10_deepbask_10ms.CGdeepbask.v','Sim_Cell11_deepaxax_10ms.CGdeepaxax.v',
'Sim_Cell12_deepLTS_10ms.CGdeepLTS.v','Sim_Cell14_nRT_10ms.CGnRT_min75init.v'],
 
   'nC':['CGsupppyrRS_0_wtime','CGsuppyrFRB_0_wtime','CGsupbask_0_10ms_wtime',
   'CGsupaxax_0_wtime','CGsupLTS_0_wtime','CGtuftIB_0_wtime','CGtuftRS_0_wtime','CGnontuftRS_0_wtime','CGdeepbask_0_wtime','CGdeepaxax_0_wtime','CGdeepLTS_0_wtime','CGnRT_min75init_0_wtime'],
   
   'subplotTitles':['Cell1-supppyrRS-10ms','Cell2-suppyrFRB-10ms','Cell3-supbask-10ms',
   'Cell4-supaxax-10ms','Cell5-supLTS-10ms','Cell7-tuftIB-10ms','Cell8-tuftRS-10ms','Cell9-nontuftRS-10ms','Cell10-deepbask-10ms','Cell11-deepaxax-10ms','Cell12-deepLTS-10ms','Cell14-nRT-10ms']},legend=True,save_to_file='Test_10ms_lg.pdf')
   
   
   
  PlotNC_vs_NML2({'NML2':['Sim_Cell1_supppyrRS_FIgA1RS.CGsuppyrRS.v',
   'Sim_Cell2_suppyrFRB_FigA1FRB.CGsuppyrFRB.v','Sim_Test_Cell3_supbask_FigA2a.CGsupbask.v',
   'Sim_Cell4_supaxax_FigA2a.CGsupaxax.v','Sim_Cell5_supLTS_FigA2b.CGsupLTS.v','Sim_Cell7_tuftIB_FIgA4_900.CGtuftIB.v',
   'Sim_Cell7_tuftIB_FigA4_1100.CGtuftIB.v','Sim_Cell7_tuftIB_FigA4_1300.CGtuftIB.v','Sim_Cell7_tuftIB_FigA4_1500.CGtuftIB.v','Sim_Cell8_tuftRS_FigA5_800.CGtuftRS.v',
'Sim_Cell8_tuftRS_Fig5A_1000.CGtuftRS.v','Sim_Cell8_tuftRS_Fig5A_1200.CGtuftRS.v','Sim_Cell8_tuftRS_Fig5A_1400.CGtuftRS.v','Sim_Cell9_nontuftRS_FigA6_500.CGnontuftRS.v',
'Sim_Cell9_nontuftRS_FigA6_800.CGnontuftRS.v','Sim_Cell9_nontuftRS_FigA6_1000.CGnontuftRS.v','Sim_Cell12_deepLTS_FigA2b.CGdeepLTS.v','Sim_Cell14_nRT_FigA8_00.CGnRT.v',
'Sim_Cell14_nRT_FigA8_300.CGnRT.v','Sim_Cell14_nRT_FigA8_500.CGnRT.v'],
 
   'nC':['CGsuppyrRS_0_Fig_wtime','CGsuppyrFRB_0_FigA1_wtime',
   'CGsupbask_0_FigA2a_wtime','CGsupaxax_0_FigA2a_wtime','CGsupLTS_0_FigA2b_wtime','CGtuftIB_0_FigA4_900_wtime','CGtuftIB_0_FigA4_1100_wtime',
   'CGtuftIB_0_FigA4_1300_wtime','CGtuftIB_0_FigA4_1500_wtime','CGtuftRS_0_Fig5A_800_wtime','CGtuftRS_0_Fig5A_1000_wtime','CGtuftRS_0_Fig5A_1200_wtime',
   'CGtuftRS_0_Fig5A_1400_wtime','CGnontuftRS_0_Fig6A_500_wtime','CGnontuftRS_0_Fig6A_800_wtime','CGnontuftRS_0_Fig6A_1000_wtime','CGdeepLTS_0_FigA2b_wtime','CGnRT_0_FigA8_00_wtime',
   'CGnRT_0_FigA8_300_wtime','CGnRT_0_FigA8_500_wtime'],'subplotTitles':
   ['Cell1-supppyrRS-FigA1RS','Cell2-suppyrFRB-FigA1FRB','Cell3-supbask-FigA2a','Cell4-supaxax-FigA2a','Cell5-supLTS-FigA2b','Cell7-tuftIB-FigA4-900','Cell7-tuftIB-FigA4-1100','Cell7-tuftIB-FigA4-1300','Cell7-tuftIB-FigA4-1500','Cell8-tuftRS-FigA5-800','Cell8-tuftRS-Fig5A-1000','Cell8-tuftRS-Fig5A-1200','Cell8-tuftRS-Fig5A-1400','Cell9-nontuftRS-FigA6-500','Cell9-nontuftRS-FigA6-800','Cell9-nontuftRS-FigA6-1000','Cell12-deepLTS-FigA2b','Cell14-nRT-FigA8-00','Cell14-nRT-FigA8-300','Cell14-nRT-FigA8-500']},legend=True,save_to_file='Test_figs_lg.pdf')
   
       
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
  
  
            
            
  
