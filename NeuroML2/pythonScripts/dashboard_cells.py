#################################################################
###### Script that generates cell model dashboards
###
###    Author: Rokas Stanislovas
###
###    GSoC 2016 project Cortical Networks
###
######
#################################################################

from pyneuroml.analysis import generate_current_vs_frequency_curve
from pyneuroml.analysis import analyse_spiketime_vs_dt
from pyneuroml import pynml
import json
import os
from AnalysisNML2 import get_sim_duration
from AnalysisNML2 import analyse_spiketime_vs_dx
from AnalysisNML2 import generate_sims
from AnalysisNML2 import generate_and_copy_dat
from AnalysisNML2 import PlotNC_vs_NML2
from AnalysisNML2 import generate_nml2_plot
from matplotlib import pyplot as plt
import math
import numpy as np
import subprocess


def use_NeuroConstruct(compare_to_neuroConstruct,regenerate_nml2,proj_string=None,global_dt=None,config_array=None,elec_len_list=None,shell=None,nc_home=None):

    if compare_to_neuroConstruct or regenerate_nml2:
       
       if proj_string==None:
       
          print("Note: loading a neuroConstruct project is required; set the argument proj_string_neuroConstruct to the aprropriate project path.")
          quit()   
          
       if global_dt==None:
       
          print("Note: global_dt is None; change this to generate the target LEMS files.")
          quit()
          
       if config_array==None:
       
          print("Note: target config_array is None; change this to regenerate nml2 and/or run NeuroConstruct for making comparisons with NeuroML2.")
          quit()
          
       if regenerate_nml2 and elec_len_list==None:
       
          print("Note: elec_len_list is None but regenerate_nml2 is True; change elec_len_list to a list of target discretization levels.")
          quit()
          
       nc_parameters={}
       
       lems_configs={}        
                    
       if regenerate_nml2:
       
          nc_parameters['GenerateConfigs']=True
          
          nc_parameters['configsToGenerate']={}
          
          nc_parameters['ElecLenList']=elec_len_list
          
       else:
       
          nc_parameters['GenerateConfigs']=False
           
       if compare_to_neuroConstruct:
       
          nc_parameters['CompareToNeuroConstruct']=True
          
          nc_parameters['configsToCompare']=[]
          
          nc_parameters['dt']=global_dt
          
          cell_models_to_compare=[]
          
       else:
          
          nc_parameters['CompareToNeuroConstruct']=False
           
       for cell_model in config_array.keys():
           
           if regenerate_nml2:
              
              if 'Analysis' in config_array[cell_model].keys():
              
                 nc_parameters['configsToGenerate'][config_array[cell_model]['Analysis']]=cell_model
                 
                 lems_configs[config_array[cell_model]['Analysis']]=cell_model
                 
              if 'SpikeProfile' in config_array[cell_model].keys():
              
                 nc_parameters['configsToGenerate'][config_array[cell_model]['SpikeProfile']]=cell_model
                 
                 lems_configs[config_array[cell_model]['SpikeProfile']]=cell_model
                    
           if compare_to_neuroConstruct:
           
              cell_models_to_compare.append(cell_model)
           
              if 'Analysis' in config_array[cell_model].keys():
              
                 nc_parameters['configsToCompare'].append(config_array[cell_model]['Analysis'])
                 
                 lems_configs[config_array[cell_model]['SpikeProfile']]=cell_model
                 
              
              if 'SpikeProfile' in config_array[cell_model].keys():
              
                 nc_parameters['configsToCompare'].append(config_array[cell_model]['SpikeProfile'])
                 
                 lems_configs[config_array[cell_model]['SpikeProfile']]=cell_model
                 
       with open("nc_parameters.json",'w') as fout:
            json.dump(nc_parameters, fout)
            
       if shell ==None:
          extension='sh'
       else:
          extension=shell   
          
       if nc_home==None:
       
          nc_dir="~/neuroConstruct"  
        
       else:
       
          nc_dir=nc_home
           
       command_line="%s/nC.%s -python RunNeuroConstruct.py"%(nc_dir,extension)
       
       subprocess.call(command_line,shell=True )
       
       generate_sims(lems_configs,"../",global_dt,'Target')
       
       if compare_to_neuroConstruct:
       
          targetFileDict={"L23PyrRS":{'DatTagList':['CGsuppyrRS_0']},
                   "L23PyrFRB":{'DatTagList':['CGsuppyrFRB_0']},
                   "SupBasket":{'DatTagList':['CGsupbask_0']},
                   "L4SpinyStellate":{'DatTagList':['CGspinstell_0']},
                   "SupAxAx":{'DatTagList':['CGsupaxax_0']},
                   "SupLTSInter":{'DatTagList':['CGsupLTS_0']},
                   "L5TuftedPyrIB":{'DatTagList':['CGtuftIB_0']},
                   "L5TuftedPyrRS":{'DatTagList':['CGtuftRS_0']},
                   "L6NonTuftedPyrRS":{'DatTagList':['CGnontuftRS_0']},
                   "DeepBasket":{"DatTagList":['CGdeepbask_0']},
                   "DeepAxAx":{"DatTagList":['CGdeepaxax_0']},
                   "DeepLTSInter":{'DatTagList':['CGdeepLTS_0']},
                   "nRT":{"DatTagList":['CGnRT_min75init_0','CGnRT_0']},
                   "TCR":{"DatTagList":['CGTCR_0']} }
                   
          required_cell_models={}
          
          for cell_model in cell_models_to_compare:
          
              if cell_model in targetFileDict.keys():
              
                 required_cell_models[cell_model]=targetFileDict[cell_model]
        
          generate_and_copy_dat("../../neuroConstruct/simulations",required_cell_models,"../")
       
             
###########################################################################################################

def dashboard_cells(net_id,
                    net_file_name,
                    config_array,
                    global_dt,
                    if_params,
                    elec_len_list,
                    dt_list,
                    generate_dashboards=True,
                    compare_to_neuroConstruct=False,
                    regenerate_nml2=False,
                    show_plot_already=False,
                    proj_string_neuroConstruct=None,
                    shell=None,
                    nc_home=None):
            
    ################### check whether use of neuroConstruct python/java interface is needed ########################
    
    if regenerate_nml2:
    
       use_NeuroConstruct(compare_to_neuroConstruct=compare_to_neuroConstruct,
                          regenerate_nml2=regenerate_nml2,
                          proj_string=proj_string_neuroConstruct,
                          global_dt=global_dt,
                          config_array=config_array,
                          elec_len_list=elec_len_list,
                          shell=shell,
                          nc_home=nc_home)
                             
    else:
       
          
       use_NeuroConstruct(compare_to_neuroConstruct=compare_to_neuroConstruct,
                          regenerate_nml2=regenerate_nml2,
                          proj_string=proj_string_neuroConstruct,
                          global_dt=global_dt,
                          config_array=config_array,
                          shell=shell,
                          nc_home=nc_home)     
                             
            
                             
    ############################################################################################################
        
    if generate_dashboards:    
       
       cell_id_list=[]
       
       config_list=[]
       
       analysis_header_list=[]
       
       nC_vs_NML2Curve_list=[]
       
       IFcurve_list=[]
       
       for cellModel in config_array.keys():
       
           cell_id_list.append(cellModel)
           
           config_list.append(config_array[cellModel]['Analysis'])
        
           save_to_path="../"+cellModel
        
           if not os.path.exists(save_to_path):
              print("Creating a new directory %s"%save_to_path)
              os.makedirs(save_to_path)
           else:
              print("A directory %s already exists"%save_to_path)
           
           pathToConfig="../"+config_array[cellModel]['Analysis']
           
           try:
              
              with open(os.path.join(pathToConfig,"compSummary.json"),'r') as f:
              
                   comp_info=json.load(f)
                   
           except IOError:
           
              print "cannot open file %s"%os.path.join(pathToConfig,"compSummary.json")
              
           cell_morph_summary=comp_info[config_array[cellModel]['Analysis']]
           
           src_files = os.listdir(pathToConfig)
           
           num_dx_configs=0
           
           dx_array=[]
           
           found_all_compartmentalizations=False
           
           dx_configs={}
        
           target_v=None
           
           found_default=False
           
           for file_name in src_files:
           
               full_file_path=os.path.join(pathToConfig,file_name)
               
               if (os.path.isdir(full_file_path)) and "_default" in file_name:
               
                  found_default=True
            
                  original_LEMS_target=os.path.join(full_file_path,"LEMS_Target.xml")
            
                  ###################################################################################
                  if -1 in elec_len_list and "-1" in cell_morph_summary.keys():
                  
                      dx_configs[cell_morph_summary["-1"]["IntDivs"]]=original_LEMS_target
                     
                      default_num_of_comps=cell_morph_summary["-1"]["IntDivs"]
                      
                      dx_array.append(int(default_num_of_comps))
                     
                      num_dx_configs+=1
                  ##################################################################################      
                  print("%s is a directory"%full_file_path)
                  print("will generate the IF curve for %s.cell.nml"%cellModel)
                  generate_current_vs_frequency_curve(os.path.join(full_file_path,cellModel+".cell.nml"), 
                                      cellModel, 
                                      start_amp_nA =     if_params['start_amp_nA'], 
                                      end_amp_nA =       if_params['end_amp_nA'], 
                                      step_nA =          if_params['step_nA'], 
                                      analysis_duration =if_params['analysis_duration'], 
                                      analysis_delay =   if_params['analysis_delay'],
                                      dt=                if_params['dt'],
                                      temperature=       if_params['temperature'],
                                      plot_voltage_traces=if_params['plot_voltage_traces'],
                                      plot_if=            if_params['plot_if'],
                                      plot_iv=            if_params['plot_iv'],
                                      show_plot_already=  show_plot_already,
                                      save_if_figure_to='%s/IF_%s.png'%(save_to_path,cellModel),
                                      save_iv_figure_to='%s/IV_%s.png'%(save_to_path,cellModel),
                                      simulator=         if_params['simulator'])
                                        
                  IFcurve="IF_%s"%cellModel
                  
                  IFcurve_list.append(IFcurve)
                  
                  IVcurve="IV_%s"%cellModel
                  
                  nml2_file_path=os.path.join(full_file_path,net_file_name+".net.nml")      
                  
                  net_doc = pynml.read_neuroml2_file(nml2_file_path)
                  net=net_doc.networks[0]
                  pop=net.populations[0]
                  popID=pop.id
                  
                  target_v="%s/0/%s/v"%(popID,cellModel)
               
                  ########################################################################################
               
                  if if_params['simulator'] == 'jNeuroML':
                     results = pynml.run_lems_with_jneuroml(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
                  if if_params['simulator'] == 'jNeuroML_NEURON':
                     results = pynml.run_lems_with_jneuroml_neuron(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
                  
                  t = results['t']
                  v = results[target_v]
                  
                  if compare_to_neuroConstruct:
                  
                     print("will generate the comparison between the nC model and NeuroML2 model")
                     
                     PlotNC_vs_NML2({'NML2':[{'t':t,'v':v}],'nC':[config_array[cellModel]['OriginalTag']],
                                     'subplotTitles':['NeuroML2 versus nC model: simulations in NEURON with dt=%f'%global_dt]},
                                     {'cols':8,'rows':5},
                                     legend=True,
                                     show=False,
                                     save_to_file='%s/nC_vs_NML2_%s.png'%(save_to_path,config_array[cellModel]['Analysis']),
                                     nCcellPath=os.path.join(save_to_path,config_array[cellModel]['Analysis'])   )
                                    
                     analysis_string1="nC_vs_NML2_%s"%config_array[cellModel]['Analysis']
                     
                     analysis_header1="Comparison between the original nC model and NeuroML2 model: simulations in NEURON with dt=%f"%global_dt
                     
                     analysis_header_list.append(analysis_header1)
                     
                     nC_vs_NML2Curve_list.append(analysis_string1)
                              
                  else:
                  
                     print("will generate the plot for the NeuroML2 model")
                     
                     generate_nml2_plot({'NML2':[{'t':t,'v':v}],'subplotTitles':['NeuroML2 model: simulations in NEURON with dt=%f'%global_dt]},
                                        {'cols':8,'rows':5},
                                        show=False,
                                        save_to_file='%s/NML2_%s.png'%(save_to_path,config_array[cellModel]['Analysis']))
                                            
                     analysis_string1="NML2_%s"%config_array[cellModel]['Analysis']
                     
                     analysis_header1="NeuroML2 model: simulations in NEURON with dt=%f"%global_dt    
                     
                     analysis_header_array.append(analysis_header1) 
                     
                     nC_vs_NML2Curve_array.append(analysis_string1)
                     
                  smallest_dt=min(dt_list)  
                              
                  ########################################################################################
                  print("will generate the spike times vs dt curve for %s.cell.nml"%cellModel)
                  analyse_spiketime_vs_dt(nml2_file_path, 
                                          net_id,
                                          get_sim_duration(os.path.join(full_file_path,"LEMS_%s.xml"%net_id)),
                                          if_params['simulator'],
                                          target_v,
                                          dt_list,
                                          verbose=False,
                                          spike_threshold_mV = 0,
                                          show_plot_already=show_plot_already,
                                          save_figure_to="%s/Dt_%s.png"%(save_to_path,cellModel),
                                          num_of_last_spikes=None)
                                          
                  dt_curve="Dt_%s"%cellModel
                  
               if not found_all_compartmentalizations:
                  
                  for elecLen in range(0,len(elec_len_list)):
               
                      elec_len=str(elec_len_list[elecLen]) 
                      
                      if elec_len != "-1":
                  
                         if (elec_len  in file_name) and (elec_len in cell_morph_summary.keys() ):
                      
                            dx_configs[cell_morph_summary[elec_len]["IntDivs"]]=os.path.join(full_file_path,"LEMS_Target.xml")
                      
                            num_dx_configs+=1
                         
                            dx_array.append(int(cell_morph_summary[elec_len]["IntDivs"] ) )
                      
                            break
                         
               if num_dx_configs==len(elec_len_list):
                  
                  found_all_compartmentalizations=True 
                      
           if not found_default:
           
              print("default configuration for %s analysis is not found; execution will terminate; set regenerate_nml2 to True to generate target dirs."%cellModel)
              
              quit()
                      
           if found_all_compartmentalizations:
           
              dx_array=list(np.sort(dx_array) )
                  
              maximum_int_divs=max(dx_array)
           
              print("testing the presence of cell configs with different levels of spatial discretization")
              
              analyse_spiketime_vs_dx(dx_configs, 
                                      if_params['simulator'],
                                      target_v,
                                      verbose=False,
                                      spike_threshold_mV = 0,
                                      show_plot_already=show_plot_already,
                                      save_figure_to="%s/Dx_%s.png"%(save_to_path,cellModel),
                                      num_of_last_spikes=3) 
               
              dx_curve="Dx_%s"%cellModel
                
           else:
              print("not all of the target configurations were recompartmentalized; execution will terminate; set regenerate_nml2 to True to obtain all of the target configurations.")
              quit() 
              
           if config_array[cellModel]['Analysis'] != config_array[cellModel]['SpikeProfile']:    
        
              pathToProfileConfig="../"+config_array[cellModel]['SpikeProfile']+"/"+config_array[cellModel]['SpikeProfile']+"_default"
           
              original_LEMS_target=os.path.join(pathToProfileConfig,"LEMS_Target.xml")
               
              if if_params['simulator'] == 'jNeuroML':
                 results = pynml.run_lems_with_jneuroml(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
              if if_params['simulator'] == 'jNeuroML_NEURON':
                 results = pynml.run_lems_with_jneuroml_neuron(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
                
              if 'SpikeProfileTag' in config_array[cellModel].keys():
                 
                  tag=config_array[cellModel]['SpikeProfileTag']+"_0_wtime"
                 
              else:
                 
                  tag=config_array[cellModel]['OriginalTag']
                  
              if 'SpikeProfileCellTag' in config_array[cellModel].keys() and 'SpikeProfileTag' in config_array[cellModel].keys():
                
                 target_v="%s/0/%s/v"%(config_array[cellModel]['SpikeProfileTag'],config_array[cellModel]['SpikeProfileCellTag'])
                    
              t = results['t']
              v = results[target_v]
        
              if compare_to_neuroConstruct:
               
                 print("will generate the comparison between the nC model and NeuroML2 model")
                 
                 PlotNC_vs_NML2({'NML2':[{'t':t,'v':v}],'nC':[tag],
                                 'subplotTitles':['NML2 versus nC model: simulations in NEURON with dt=%f'%global_dt]},
                                 {'cols':8,'rows':5},
                                 legend=True,
                                 show=show_plot_already,
                                 save_to_file='%s/nC_vs_NML2_%s.png'%(save_to_path,config_array[cellModel]['SpikeProfile']),
                                 nCcellPath=os.path.join(save_to_path,config_array[cellModel]['SpikeProfile'])   )
                               
                 analysis_string2="nC_vs_NML2_%s"%config_array[cellModel]['SpikeProfile']
           
                 analysis_header2="Comparison between the original nC model and NeuroML2 model: simulations in NEURON with dt=%f"%global_dt
           
              else:
        
                 print("will generate the plot for the NeuroML2 model")
                 
                 generate_nml2_plot({'NML2':[{'t':t,'v':v}],'subplotTitles':['NeuroML2 model: simulations in NEURON with dt=%f'%global_dt]},
                                        {'cols':8,'rows':5},
                                        show=False,
                                        save_to_file='%s/NML2_%s.png'%(save_to_path,config_array[cellModel]['SpikeProfile']))
           
                                         
                 analysis_string2="NML2_%s"%config_array[cellModel]['SpikeProfile']
                     
                 analysis_header2="NeuroML2 model: simulations in NEURON with dt=%f"%global_dt
              
              cwd=os.getcwd()
               
              os.chdir(save_to_path)
        
              readme = ''' 
         
## Model: %(CellID)s

### Original neuroConstruct config ID: %(SpikeProfile)s

**%(AnalysisHeader2)s**

![Simulation](%(SpikeProfileCurve)s.png)

### Original neuroConstruct config ID: %(Config)s

**%(AnalysisHeader1)s**

![Simulation](%(nC_vs_NML2Curve)s.png)

**IF curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IFcurve)s.png)

**IV curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IVcurve)s.png)

**Spike times versus time step: the NeuroML2 model simulated in NEURON.
Dashed black lines - spike times at the %(Smallest_dt)s ms time step; Green - spike times at the following time steps (in ms): %(DtArray)s.**

![Simulation](%(DtCurve)s.png)

**Spike times versus spatial discretization: the NeuroML2 model simulated in NEURON.
Default value for the number of internal divs is %(default_divs)s.
Dashed black lines - spike times at the %(MaximumDivs)s internal divisions; Blue - spike times at the following values of internal divisions:
%(IntDivsArray)s.**

![Simulation](%(DxCurve)s.png)'''

              readme_file = open('README.md','w')
              
              readme_final=readme%{"CellID":cellModel,
                                   "IFcurve":IFcurve,
                                   "IVcurve":IVcurve,
                                   "Config":config_array[cellModel]['Analysis'],
                                   "DtCurve":dt_curve,
                                   "DxCurve":dx_curve,
                                   "nC_vs_NML2Curve":analysis_string1,
                                   "AnalysisHeader1":analysis_header1,
                                   "SpikeProfileCurve":analysis_string2,
                                   "AnalysisHeader2":analysis_header2,
                                   "default_divs":default_num_of_comps,
                                   "SpikeProfile":config_array[cellModel]['SpikeProfile'],
                                   "Smallest_dt":smallest_dt,
                                   "DtArray":dt_list,
                                   "IntDivsArray":dx_array,
                                   "MaximumDivs":maximum_int_divs}
                           
              readme_file.write(readme_final)
              
              readme_file.close()

              os.chdir(cwd)
      
           else:  
           
              cwd=os.getcwd()
               
              os.chdir(save_to_path)
        
              readme = ''' 
         
## Model: %(CellID)s

### Original neuroConstruct config ID: %(Config)s

**%(AnalysisHeader1)s**

![Simulation](%(nC_vs_NML2Curve)s.png)

**IF curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IFcurve)s.png)

**IV curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IVcurve)s.png)

**Spike times versus time step: the NeuroML2 model simulated in NEURON.
Dashed black lines - spike times at the %(Smallest_dt)s ms time step; Green - spike times for the following time steps (in ms): %(DtArray)s.**

![Simulation](%(DtCurve)s.png)

**Spike times versus spatial discretization: the NeuroML2 model simulated in NEURON.
Default value for the number of internal divs is %(default_divs)s.
Dashed black lines - spike times at the %(MaximumDivs)s internal divisions; Blue - spike times at the following values of internal divisions:
%(IntDivsArray)s.**

![Simulation](%(DxCurve)s.png)'''

              readme_file = open('README.md','w')
              
              readme_final=readme%{"CellID":cellModel,
                                   "IFcurve":IFcurve,
                                   "IVcurve":IVcurve,
                                   "Config":config_array[cellModel]['Analysis'],
                                   "DtCurve":dt_curve,
                                   "DxCurve":dx_curve,
                                   "nC_vs_NML2Curve":analysis_string1,
                                   "AnalysisHeader1":analysis_header1,
                                   "default_divs":default_num_of_comps,
                                   "Smallest_dt":smallest_dt,
                                   "DtArray":dt_list,
                                   "IntDivsArray":dx_array,
                                   "MaximumDivs":maximum_int_divs}
                           
              readme_file.write(readme_final)
              readme_file.close()
              os.chdir(cwd)                                
              
       cwd=os.getcwd()
               
       os.chdir(os.path.dirname(cwd))
        
       readme = ''' 
      
## Conversion of Thalamocortical cell models to NeuroML2

'''
       readme_file = open('README.md','w')

       for cell_index in range(0,len(cell_id_list)):
       
           readme_cell='''
           
## Model: %(CellID)s

### Original neuroConstruct config ID: %(Config)s

**%(AnalysisHeader)s**

![Simulation](%(nC_vs_NML2Curve)s.png)

**IF curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IFcurve)s.png)'''

           readme_cell=readme_cell%{"CellID":cell_id_list[cell_index],
                                    "Config":config_list[cell_index],
                                    "AnalysisHeader":analysis_header_list[cell_index],
                                    "nC_vs_NML2Curve":os.path.join(cell_id_list[cell_index],nC_vs_NML2Curve_list[cell_index]),
                                    "IFcurve":os.path.join(cell_id_list[cell_index],IFcurve_list[cell_index])}
                                    
           readme=readme+readme_cell
                                
       readme_file.write(readme)
       readme_file.close()
       os.chdir(cwd)     
       
           
