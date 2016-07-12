from pyneuroml.analysis import generate_current_vs_frequency_curve
from pyneuroml.analysis import analyse_spiketime_vs_dt
from pyneuroml import pynml
import json
import os
from AnalysisNML2 import get_sim_duration
from AnalysisNML2 import analyse_spiketime_vs_dx
from PlotNC_vs_NML2 import *


def dashboard_cells(net_id,
                    net_file_name,
                    config_array,
                    if_params,
                    elec_len_list,
                    dt_list,
                    comp_summary,
                    compare_to_neuroConstruct=False,
                    regenerate_recompartmentalization=False,
                    proj_string_neuroConstruct=None):
                    
    
    if compare_to_neuroConstruct or regenerate_recompartmentalization:
    
       try:
          from java.io import File
       except ImportError:
          print "Note: this file should be run using ..\\..\\..\\nC.bat -python XXX.py' or '../../../nC.sh -python XXX.py'"
          print "See http://www.neuroconstruct.org/docs/python.html for more details"
          quit()
          
       import sys
       
       sys.path.append(os.environ["NC_HOME"]+"/pythonNeuroML/nCUtils")
       
       if proj_string_neuroConstruct==None:
       
          print("Note: loading neuroConstruct is required; set the argument proj_string_neuroConstruct to the path to the neuroConstruct project.")
          quit()                
                    
    if regenerate_recompartmentalization:
    
       from AnalysisNML2 import SingleCellNML2generator
         
    if compare_to_neuroConstruct:
       
       import ncutils as nc
       from ucl.physiol.neuroconstruct.hpc.mpi import MpiSettings
       from java.lang.management import ManagementFactory   
       
    
    
    try:
       with open(comp_summary,'r') as f:
              comp_info=json.load(f)
    except IOError:
       print "cannot open file %s"%connInfo
       
    for cellModel in config_array.keys():
        
        save_to_path="../"+cellModel
        
        if not os.path.exists(save_to_path):
           print("Creating a new directory %s"%save_to_path)
           os.makedirs(save_to_path)
        else:
           print("A directory %s already exists"%save_to_path)
           
        pathToConfig="../"+config_array[cellModel]['Analysis']
           
        cell_morph_summary=comp_info[config_array[cellModel]['Analysis']]
           
        src_files = os.listdir(pathToConfig)
           
        num_dx_configs=0
           
        dx_configs={}
        
        target_v=None
           
        for file_name in src_files:
            full_file_path=os.path.join(pathToConfig,file_name)
            if (os.path.isdir(full_file_path)) and "_default" in file_name:
            
               original_LEMS_target=os.path.join(full_file_path,"LEMS_Target.xml")
            
               ###################################################################################
               if -1 in elec_len_list and "-1" in cell_morph_summary.keys():
                  dx_configs[cell_morph_summary["-1"]["IntDivs"]]=original_LEMS_target
                  num_dx_configs+=1
               ##################################################################################      
               print("%s is a directory"%full_file_path)
               print("will generate the IF curve for %s.cell.nml"%cellModel)
               #generate_current_vs_frequency_curve(os.path.join(full_file_path,cellModel+".cell.nml"), 
                                        #cellModel, 
                                        #start_amp_nA =     if_params['start_amp_nA'], 
                                        #end_amp_nA =       if_params['end_amp_nA'], 
                                        #step_nA =          if_params['step_nA'], 
                                        #analysis_duration =if_params['analysis_duration'], 
                                        #analysis_delay =   if_params['analysis_delay'],
                                        #dt=                if_params['dt'],
                                        #temperature=       if_params['temperature'],
                                        #plot_voltage_traces=if_params['plot_voltage_traces'],
                                        #plot_if=            if_params['plot_if'],
                                        #save_if_figure_to='%s/IF_%s.png'%(save_to_path,cellModel),
                                        #simulator=         if_params['simulator'])
                                        
               IFcurve="IF_%s"%cellModel
                  
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
               
               print("will generate the comparison between the nC model and NeuroML2 model")
               
               PlotNC_vs_NML2({'NML2':[{'t':t,'v':v}],'nC':[config_array[cellModel]['OriginalTag']],'subplotTitles':['NML2 versus nC model: simulations in NEURON']},
                              {'cols':8,'rows':5},
                              legend=True,
                              save_to_file='%s/nC_vs_NML2_%s.png'%(save_to_path,config_array[cellModel]['Analysis']),
                              nCcellPath=os.path.join(save_to_path,config_array[cellModel]['Analysis'])   )
                              
                              
               nC_vs_NML2_config="nC_vs_NML2_%s"%config_array[cellModel]['Analysis']
               
               ########################################################################################
               print("will generate the spike times vs dt curve for %s.cell.nml"%cellModel)
               #analyse_spiketime_vs_dt(nml2_file_path, 
                                       #net_id,
                                       #get_sim_duration(os.path.join(full_file_path,"LEMS_%s.xml"%net_id)),
                                       #if_params['simulator'],
                                       #target_v,
                                       #dt_list,
                                       #verbose=False,
                                       #spike_threshold_mV = 0,
                                       #show_plot_already=True,
                                       #save_figure_to="%s/Dt_%s.png"%(save_to_path,cellModel))
                                          
               dt_curve="Dt_%s"%cellModel 
                  
            for elecLen in range(0,len(elec_len_list)):
               
                elec_len=str(elec_len_list[elecLen]) 
                  
                if elec_len  in file_name and elec_len in cell_morph_summary.keys():
                      
                   dx_configs[cell_morph_summary[elec_len]["IntDivs"]]=os.path.join(full_file_path,"LEMS_Target.xml")
                      
                   num_dx_configs+=1
                      
        if num_dx_configs==len(elec_len_list):
           print("testing the presence of cell configs with different levels of spatial discretization")
           #analyse_spiketime_vs_dx(dx_configs, 
                                   #if_params['simulator'],
                                   #target_v,
                                   #verbose=False,
                                   #spike_threshold_mV = 0,
                                   #show_plot_already=True,
                                   #save_figure_to="%s/Dx_%s.png"%(save_to_path,cellModel)) 
               
           dx_curve="Dx_%s"%cellModel        
                               
        
        pathToProfileConfig="../"+config_array[cellModel]['SpikeProfile']+"/"+config_array[cellModel]['SpikeProfile']+"_default"
           
           
        original_LEMS_target=os.path.join(pathToProfileConfig,"LEMS_Target.xml")
               
        if if_params['simulator'] == 'jNeuroML':
           results = pynml.run_lems_with_jneuroml(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
        if if_params['simulator'] == 'jNeuroML_NEURON':
           results = pynml.run_lems_with_jneuroml_neuron(original_LEMS_target, nogui=True, load_saved_data=True, plot=False, verbose=False)
                  
        t = results['t']
        v = results[target_v]
               
        print("will generate the comparison between the nC model and NeuroML2 model")
               
        PlotNC_vs_NML2({'NML2':[{'t':t,'v':v}],'nC':[config_array[cellModel]['OriginalTag']],'subplotTitles':['NML2 versus nC model: simulations in NEURON']},
                       {'cols':8,'rows':5},
                       legend=True,
                       save_to_file='%s/nC_vs_NML2_%s.png'%(save_to_path,config_array[cellModel]['SpikeProfile']),
                       nCcellPath=os.path.join(save_to_path,config_array[cellModel]['SpikeProfile'])   )
                              
                              
        nC_vs_NML2_spike_profile="nC_vs_NML2_%s"%config_array[cellModel]['SpikeProfile']
               
        os.chdir(save_to_path)
        
        readme = ''' 
         
## Model: %(CellID)s

### Original neuroConstruct config ID: %(SpikeProfile)s

**Comparison between the original nC model and NeuroML2 model: simulations in NEURON**

![Simulation](%(SpikeProfileCurve)s.png)

### Original neuroConstruct config ID: %(Config)s

**Comparison between the original nC model and NeuroML2 model: simulations in NEURON**

![Simulation](%(nC_vs_NML2Curve)s.png)

**IF curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(IFcurve)s.png)

**Spike times versus dt curve for the NeuroML2 model simulated in NEURON**

![Simulation](%(DtCurve)s.png)

**Spike times versus spatial discretization**

![Simulation](%(DxCurve)s.png)'''

        readme_file = open('README.md','w')
        readme_file.write(readme%{"CellID":cellModel,"IFcurve":IFcurve,'Config':configArray[cellModel]['Analysis'],'DtCurve':dt_curve,'DxCurve':dx_curve,
                           'nC_vs_NML2Curve':nC_vs_NML2_config,'SpikeProfileCurve':nC_vs_NML2_spike_profile,'SpikeProfile':configArray[cellModel]['SpikeProfile']})
        readme_file.close()

        os.chdir('..')
    

if __name__=="__main__":
  
  print "testing a new script: dashboard_cells"

  configsTest={"L23PyrRS":{'Analysis':"Cell1-supppyrRS-FigA1RS","SpikeProfile":"Cell1-supppyrRS-10ms",'OriginalTag':'CGsuppyrRS_0_wtime'}  }
  
  configs_all={"L23PyrRS":["Cell1-supppyrRS-FigA1RS","Cell1-supppyrRS-10ms"],
               "L23PyrFRB":["Cell2-suppyrFRB-FigA1FRB","Cell2-suppyrFRB-10ms"],
               "SupBasket":["Cell3-supbask-FigA2a","Cell3-supbask-10ms"],
               "SupAxAx":["Cell4-supaxax-FigA2a","Cell4-supaxax-10ms"],
               "SupLTSInter":["Cell5-supLTS-10ms","Cell5-supLTS-FigA2b"],
               "L4SpinyStellate":["Cell6-spinstell-10ms","Cell6-spinstell-FigA3-167","Cell6-spinstell-FigA3-250","Cell6-spinstell-FigA3-333"],
               "L5TuftedPyrIB":["Cell7-tuftIB-10ms", "Cell7-tuftIB-FigA4-900","Cell7-tuftIB-FigA4-1100","Cell7-tuftIB-FigA4-1300","Cell7-tuftIB-FigA4-1500"],
               "L5TuftedPyrRS":["Cell8-tuftRS-10ms","Cell8-tuftRS-FigA5-800","Cell8-tuftRS-Fig5A-1000","Cell8-tuftRS-Fig5A-1200","Cell8-tuftRS-Fig5A-1400"],
               "L6NonTuftedPyrRS":["Cell9-nontuftRS-10ms","Cell9-nontuftRS-FigA6-500","Cell9-nontuftRS-FigA6-800","Cell9-nontuftRS-FigA6-1000"],
               "DeepBasket":["Cell10-deepbask-10ms"],
               "DeepAxAx":["Cell11-deepaxax-10ms"],
               "DeepLTSInter":["Cell12-deepLTS-10ms"],
               "DeepLTSInter":["Cell12-deepLTS-FigA2b"],
               "TCR":["Cell13-TCR-10ms","Cell13-TCR-FigA7-100","Cell13-TCR-FigA7-600"],
               "nRT":["Cell14-nRT-10ms","Cell14-nRT-FigA8-00","Cell14-nRT-FigA8-300","Cell14-nRT-FigA8-500"]}
               
                
  ifParams={'start_amp_nA':0, 
            'end_amp_nA':1, 
            'step_nA':0.5, 
            'analysis_duration':1000, 
            'analysis_delay':50,
            'dt':0.01,
            'temperature':"6.3degC",
            'simulator':"jNeuroML_NEURON",
            'plot_voltage_traces':False,
            'plot_if':False}
            
  #ElecLenList=[-1,0.05,0.025, 0.01,0.005, 0.0025, 0.001,0.0005, 0.00025, 0.0001]
  
  ElecLenList=[-1,0.001]
  
  #DtList=[0.0005,0.001,0.005,0.01,0.025]
  
  DtList=[0.01,0.025]
  
  dashboard_cells(net_id='Target',
                  net_file_name='Thalamocortical',
                  config_array=configsTest,
                  if_params=ifParams,
                  elec_len_list=ElecLenList,
                  dt_list=DtList,
                  comp_summary="../compSummaryFull.json",
                  compare_to_neuroConstruct=False,
                  regenerate_recompartmentalization=True)
                  
                  #proj_string_neuroConstruct="../../neuroConstruct/Thalamocortical.ncx")
  
    
  
  
            
            
  
                                             
