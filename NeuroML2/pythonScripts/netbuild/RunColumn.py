##############################################################
### Subject to change without notice!!
##############################################################
##############################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
##############################################################

import opencortex
import opencortex.utils as oc_utils
import opencortex.build as oc
import os
import sys

#### distribute cells for the sake of network visualization; no spatial dependence of connection probability at the moment;
###### larger networks exceed GitHub's file size limit of 100.00 MB;
######Note: the below leads to Java out of memory errors when validating the final nml2 network file; use another format instead of nml; #TODO


def RunColumnSimulation(net_id="TestRunColumn",
                        nml2_source_dir="../../../neuroConstruct/generatedNeuroML2/",
                        sim_config="TempSimConfig",
                        scale_cortex=0.1,
                        scale_thalamus=0.1,
                        default_synaptic_delay=0.05,
                        gaba_scaling=1.0,
                        l4ss_ampa_scaling=1.0,
                        l5pyr_gap_scaling =1.0,
			in_nrt_tcr_nmda_scaling =1.0,
			pyr_ss_nmda_scaling=1.0,
                        which_models='all',
                        dir_nml2="../../",
                        duration=300,
                        dt=0.025,
                        max_memory='1000M',
                        simulator=None):
              
                        
    popDictFull = {}
    
    ##############   Full model ##################################
    
    popDictFull['CG3D_L23PyrRS'] = (1000, 'L23','L23PyrRS')
    popDictFull['CG3D_SupBask'] = (90, 'L23','SupBasket')
    popDictFull['CG3D_SupAxAx'] = (90, 'L23','SupAxAx')
    popDictFull['CG3D_L5TuftIB'] = (800, 'L5','L5TuftedPyrIB')
    popDictFull['CG3D_L5TuftRS']= (200,'L5','L5TuftedPyrRS')          
    popDictFull['CG3D_L4SpinStell']= (240,'L4','L4SpinyStellate')
    popDictFull['CG3D_L23PyrFRB']= (50,'L23','L23PyrFRB')
    popDictFull['CG3D_L6NonTuftRS']= (500,'L6','L6NonTuftedPyrRS')
    popDictFull['CG3D_DeepAxAx']= (100,'L6','DeepAxAx')
    popDictFull['CG3D_DeepBask']= (100,'L6','DeepBasket')
    popDictFull['CG3D_DeepLTS']= (100,'L6','DeepLTSInter')
    popDictFull['CG3D_SupLTS']= (90,'L23','SupLTSInter')
    popDictFull['CG3D_nRT']= (100,'Thalamus','nRT')
    popDictFull['CG3D_TCR']= (100,'Thalamus','TCR')
    
    ###############################################################
    
    popDict={}
    
    cell_model_list=[]
    
    nml_doc, network = oc.generate_network(net_id)
    
    for cell_population in popDictFull.keys():
    
        include_cell_population=False
    
        if which_models=='all' or cell_model in which_models:
        
           popDict[cell_population]=()

           if popDictFull[cell_population][1] !='Thalamus':
             
              popDict[cell_population]=( int(round(scale_cortex*popDictFull[cell_population][0])), popDictFull[cell_population][1],popDictFull[cell_population][2])
                  
              cell_count=int(round(scale_cortex*popDictFull[cell_population][0]))
                
           else:
             
              popDict[cell_population]=( int(round(scale_thalamus*popDictFull[cell_population][0])),popDictFull[cell_population][1],popDictFull[cell_population][2])
                  
              cell_count=int(round(scale_thalamus*popDictFull[cell_population][0]))
           
           if cell_count !=0:
    
              include_cell_population=True
               
        if include_cell_population:
        
           cell_model_list.append(popDictFull[cell_population][2])
     
    cell_model_list_final=list(set(cell_model_list))
    
    opencortex.print_comment_v("This is a final list of cell model ids: %s"%cell_model_list_final)
    
    dir_to_cells=os.path.join(dir_nml2,"cells")
    
    dir_to_synapses=os.path.join(dir_nml2,"synapses")
    
    dir_to_gap_junctions=os.path.join(dir_nml2,"gapJunctions")
    
    copy_nml2_from_source=False
    
    for cell_model in cell_model_list_final:
    
       if not os.path.exists(os.path.join(dir_to_cells,"%s.cell.nml"%cell_model)):
       
          copy_nml2_from_source=True
          
          break
           
    if copy_nml2_from_source:
       
       oc.copy_nml2_source(dir_to_project_nml2=dir_nml2,
                        primary_nml2_dir=nml2_source_dir,
                        electrical_synapse_tags=['Elect'],
                        chemical_synapse_tags=['.synapse.'],
                        extra_channel_tags=['cad'])
                        
       passed_includes_in_cells=oc_utils.check_includes_in_cells(os.path.join(dir_nml2,"cells"),cell_model_list_final,extra_channel_tags=['cad'])
       
       if not passed_includes_in_cells:
       
          opencortex.print_comment_v("Execution of RunColumn.py will terminate.")
  
          quit()
             
    for cell_model in cell_model_list_final:
        
        oc.add_cell_and_channels(nml_doc, os.path.join(dir_to_cells,"%s.cell.nml"%cell_model), cell_model)
        
    t1=-0
    t2=-250
    t3=-250
    t4=-200.0
    t5=-300.0
    t6=-300.0
    t7=-200.0
    t8=-200.0

    boundaries={}

    boundaries['L1']=[0,t1]
    boundaries['L23']=[t1,t1+t2+t3]
    boundaries['L4']=[t1+t2+t3,t1+t2+t3+t4]
    boundaries['L5']=[t1+t2+t3+t4,t1+t2+t3+t4+t5]
    boundaries['L6']=[t1+t2+t3+t4+t5,t1+t2+t3+t4+t5+t6]
    boundaries['Thalamus']=[t1+t2+t3+t4+t5+t6+t7,t1+t2+t3+t4+t5+t6+t7+t8]

    xs = [0,500]
    zs = [0,500] 

    passed_pops=oc_utils.check_pop_dict_and_layers(pop_dict=popDict,boundary_dict=boundaries)
    
    if passed_pops:
    
       opencortex.print_comment_v("Population parameters were specified correctly.")
      
       pop_params=oc_utils.add_populations_in_layers(network,boundaries,popDict,xs,zs)
       
    else:
    
       opencortex.print_comment_v("Population parameters were specified incorrectly; execution of RunColumn.py will terminate.")
       
       quit() 
    
    src_files = os.listdir("./")
    
    if 'netConnList' in src_files:
    
       full_path_to_connectivity='netConnList'
       
    else:
    
       full_path_to_connectivity="../../../neuroConstruct/pythonScripts/netbuild/netConnList"
                   
    weight_params=[{'weight':gaba_scaling,'synComp':'GABAA','synEndsWith':[],'targetCellGroup':[]},
                   {'weight':l4ss_ampa_scaling,'synComp':'Syn_AMPA_L4SS_L4SS','synEndsWith':[],'targetCellGroup':[]},
                   {'weight':l5pyr_gap_scaling,'synComp':'Syn_Elect_DeepPyr_DeepPyr','synEndsWith':[],'targetCellGroup':['CG3D_L5']},
                   {'weight':in_nrt_tcr_nmda_scaling,'synComp':'NMDA','synEndsWith':["_IN","_DeepIN","_SupIN","_SupFS","_DeepFS","_SupLTS","_DeepLTS","_nRT","_TCR"],
                   'targetCellGroup':[]},
                   {'weight':pyr_ss_nmda_scaling,'synComp':'NMDA','synEndsWith':["_IN","_DeepIN","_SupIN","_SupFS","_DeepFS","_SupLTS","_DeepLTS","_nRT","_TCR"],
                   'targetCellGroup':[]}]
                   
    delay_params=[{'delay':default_synaptic_delay,'synComp':'all'}] 
    
    passed_weight_params=oc_utils.check_weight_params(weight_params)
    
    passed_delay_params=oc_utils.check_delay_params(delay_params)
    
    if passed_weight_params and passed_delay_params:    
    
       opencortex.print_comment_v("Synaptic weight and delay parameters were specified correctly.")     
    
       all_synapse_components,projArray,cached_segment_dicts=oc_utils.build_connectivity(net=network,
                                                                                         pop_objects=pop_params,
                                                                                         path_to_cells=dir_to_cells,
                                                                                         full_path_to_conn_summary=full_path_to_connectivity,
                                                                                         synaptic_scaling_params=weight_params,
                                                                                         synaptic_delay_params=delay_params)   
                                                                                         
    else:
       
       if not passed_weight_params:
       
          opencortex.print_comment_v("Synaptic weight parameters were specified incorrectly; execution of RunColumn.py will terminate.") 
          
       if not passed_delay_params:
       
          opencortex.print_comment_v("Synaptic delay parameters were specified incorrectly; execution of RunColumn.py will terminate.")
       
       quit()
    
    ############ for testing only; will add original specifications later ##############################################################
    
    if sim_config=="Testing1":
       
       input_params={'CG3D_L23PyrRS':[{'InputType':'GeneratePoissonTrains',
                          'InputName':'Poi_CG3D_L23PyrRS',
                          'TrainType':'transient',
                          'Synapse':'Syn_AMPA_SupPyr_SupPyr',
                          'AverageRateList':[200.0,150.0],
                          'RateUnits':'Hz',
                          'TimeUnits':'ms',
                          'DurationList':[100.0,50.0],
                          'DelayList':[50.0,200.0],
                          'FractionToTarget':1.0,
                          'LocationSpecific':False,
                          'TargetDict':{'soma_group':1 }       }]              }
                       
    ###################################################################################################################################
    
    if sim_config=="Testing2":
    
       input_params={'CG3D_L23PyrRS':[{'InputType':'PulseGenerators',
                     'InputName':"DepCurr_L23RS",
                     'Noise':True,
                     'SmallestAmplitudeList':[5.0E-5,1.0E-5],
                     'LargestAmplitudeList':[1.0E-4,2.0E-5],
                     'DurationList':[20000.0,20000.0],
                     'DelayList':[0.0,20000.0],
                     'TimeUnits':'ms',
                     'AmplitudeUnits':'uA',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'TargetDict':{'dendrite_group':1}             }]             } 
                     
    if sim_config=="TempSimConfig":
    
       input_params={'CG3D_L23PyrRS':[{'InputType':'PulseGenerators',
                     'InputName':"DepCurr_L23RS",
                     'Noise':True,
                     'SmallestAmplitudeList':[5.0E-5],
                     'LargestAmplitudeList':[1.0E-4],
                     'DurationList':[20000.0],
                     'DelayList':[0.0],
                     'TimeUnits':'ms',
                     'AmplitudeUnits':'uA',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':0,
                     'UniversalFractionAlong':0.5}],
                     
                     'CG3D_TCR':[{'InputType':'GeneratePoissonTrains',
                     'InputName':"EctopicStimTCR",
                     'TrainType':'persistent',
                     'Synapse':'SynForEctopicStimulation',
                     'AverageRateList':[1.0],
                     'RateUnits':'Hz',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':269,
                     'UniversalFractionAlong':0.5}],  
                     
                     'CG3D_L23PyrFRB':[{'InputType':'GeneratePoissonTrains',
                     'InputName':"EctopicStimL23FRB",
                     'TrainType':'persistent',
                     'Synapse':'SynForEctopicStimulation',
                     'AverageRateList':[0.1],
                     'RateUnits':'Hz',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':143,
                     'UniversalFractionAlong':0.5},
                     
                     {'InputType':'PulseGenerators',
                     'InputName':"DepCurr_L23FRB",
                     'Noise':True,
                     'SmallestAmplitudeList':[2.5E-4],
                     'LargestAmplitudeList':[3.5E-4],
                     'DurationList':[20000.0],
                     'DelayList':[0.0],
                     'TimeUnits':'ms',
                     'AmplitudeUnits':'uA',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':0,
                     'UniversalFractionAlong':0.5} ], 
                     
                     'CG3D_L6NonTuftRS':[{'InputType':'GeneratePoissonTrains',
                     'InputName':"EctopicStimL6NT",
                     'TrainType':'persistent',
                     'Synapse':'SynForEctopicStimulation',
                     'AverageRateList':[1.0],
                     'RateUnits':'Hz',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':95,
                     'UniversalFractionAlong':0.5},
                     
                     {'InputType':'PulseGenerators',
                     'InputName':"DepCurr_L6NT",
                     'Noise':True,
                     'SmallestAmplitudeList':[5.0E-5],
                     'LargestAmplitudeList':[1.0E-4],
                     'DurationList':[20000.0],
                     'DelayList':[0.0],
                     'TimeUnits':'ms',
                     'AmplitudeUnits':'uA',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':0,
                     'UniversalFractionAlong':0.5} ],
                     
                     'CG3D_L6NonTuftRS':[{'InputType':'GeneratePoissonTrains',
                     'InputName':"EctopicStimL6NT",
                     'TrainType':'persistent',
                     'Synapse':'SynForEctopicStimulation',
                     'AverageRateList':[1.0],
                     'RateUnits':'Hz',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':95,
                     'UniversalFractionAlong':0.5}],
                     
                     'CG3D_L4SpinStell':[{'InputType':'PulseGenerators',
                     'InputName':"DepCurr_L4SS",
                     'Noise':True,
                     'SmallestAmplitudeList':[5.0E-5],
                     'LargestAmplitudeList':[1.0E-4],
                     'DurationList':[20000.0],
                     'DelayList':[0.0],
                     'TimeUnits':'ms',
                     'AmplitudeUnits':'uA',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'UniversalTargetSegmentID':0,
                     'UniversalFractionAlong':0.5}],
                     
                     'CG3D_L5TuftIB':[{'InputType':'GeneratePoissonTrains',
                     'InputName':"BackgroundL5",
                     'TrainType':'persistent',
                     'Synapse':'Syn_AMPA_L5RS_L5Pyr',
                     'AverageRateList':[30.0],
                     'RateUnits':'Hz',
                     'FractionToTarget':1.0,
                     'LocationSpecific':False,
                     'TargetDict':{'dendrite_group':100} }] }
                     
    input_list_array_final, input_synapse_list=oc_utils.build_inputs(nml_doc=nml_doc,
                                                                     net=network,
                                                                     population_params=pop_params,
                                                                     input_params=input_params,
                                                                     cached_dicts=cached_segment_dicts,
                                                                     path_to_cells=dir_to_cells,
                                                                     path_to_synapses=dir_to_synapses)
    
    ####################################################################################################################################
    
    for input_synapse in input_synapse_list:
    
        if input_synapse not in all_synapse_components:
        
           all_synapse_components.append(input_synapse)
           
    synapse_list=[]
    
    gap_junction_list=[]
        
    for syn_ind in range(0,len(all_synapse_components)):
    
        if 'Elect' not in all_synapse_components[syn_ind]:
        
           synapse_list.append(all_synapse_components[syn_ind])
        
           all_synapse_components[syn_ind]=os.path.join(net_id,all_synapse_components[syn_ind]+".synapse.nml")
           
        else:
        
           gap_junction_list.append(all_synapse_components[syn_ind])
        
           all_synapse_components[syn_ind]=os.path.join(net_id,all_synapse_components[syn_ind]+".nml")
           
    oc.add_synapses(nml_doc,dir_to_synapses,synapse_list,synapse_tag=True)
    
    oc.add_synapses(nml_doc,dir_to_gap_junctions,gap_junction_list,synapse_tag=False)
    
    nml_file_name = '%s.net.nml'%network.id
    
    oc.save_network(nml_doc, nml_file_name, validate=True)
    
    oc.remove_component_dirs(dir_to_project_nml2="%s"%network.id,list_of_cell_ids=cell_model_list_final,extra_channel_tags=['cad'])
    
    lems_file_name=oc.generate_lems_simulation(nml_doc, 
                                               network, 
                                               nml_file_name, 
                                               duration =duration, 
                                               dt =dt,
                                               include_extra_lems_files=all_synapse_components)
                            
    oc.simulate_network(lems_file_name=lems_file_name,
                        simulator=simulator,
                        max_memory=max_memory)
    
    
    
if __name__=="__main__":

   RunColumnSimulation(sim_config="TempSimConfig")
   
                                              
