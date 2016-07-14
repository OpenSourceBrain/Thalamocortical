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

#### distribute cells for the sake of network visualization; no spatial dependence of connection probability at the moment;
###### larger networks exceed GitHub's file size limit of 100.00 MB;
######Note: the below leads to Java out of memory errors when validating the final nml2 network file; use another format instead of nml; #TODO



def RunColumnSimulation(net_id="TestRunColumn",
                        scaleCortex=0.1,
                        scaleThalamus=0.1,
                        which_models='all',
                        dir_cell_models="../../",
                        simulator=None,
                        duration=300,
                        dt=0.025,
                        max_memory='1000M',
                        extra_params=None):
                        
                        #TODO additional parameters and options
                        
                        
    #extra_params=[{'pre':'L23PyrRS','post':'SupBasket','weights':[0.05],'delays':[5],'synComps':['NMDA']}]                  
                        
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
             
              popDict[cell_population]=( int(round(scaleCortex*popDictFull[cell_population][0])), popDictFull[cell_population][1],popDictFull[cell_population][2])
                  
              cell_count=int(round(scaleCortex*popDictFull[cell_population][0]))
                
           else:
             
              pop_in_layer_tuple=( int(round(scaleThalamus*popDictFull[cell_population][0])),popDictFull[cell_population][1],popDictFull[cell_population][2])
                  
              cell_count=int(round(scaleThalamus*popDictFull[cell_population][0]))
           
           if cell_count !=0:
    
              include_cell_population=True
               
        if include_cell_population:
        
           cell_model_list.append(popDictFull[cell_population][2])
           
           
    cell_model_list_final=list(set(cell_model_list))
    
    for cell_model in cell_model_list_final:
    
        oc.add_cell_and_channels(nml_doc, os.path.join(dir_cell_models,'%s.cell.nml'%cell_model), cell_model)

        
        
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
    
       print("Population parameters were specified correctly.")
      
       pop_params=oc_utils.add_populations_in_layers(network,boundaries,popDict,xs,zs)
       
    else:
    
       print("Population parameters were specified incorrectly; execution of RunColumn.py will terminate.")
       
       quit()
    
    
    src_files = os.listdir("./")
    
    if 'netConnList' in src_files:
    
       full_path_to_connectivity='netConnList'
       
    else:
    
       full_path_to_connectivity="../../../neuroConstruct/pythonScripts/netbuild/netConnList"
    
    

    synapseList,projArray=oc_utils.build_connectivity(network,pop_params,dir_cell_models,full_path_to_connectivity,extra_params)                  

    oc.add_synapses(nml_doc,dir_cell_models,synapseList)
    
    ############ for testing only; will add original specifications later ##############################################################
    
    input_params={'CG3D_L23PyrRS':[{'InputType':'GeneratePoissonTrains',
                  'TrainType':'transient',
                  'Synapse':'Syn_AMPA_SupPyr_SupPyr',
                  'AverageRateList':[200.0,150.0],
                  'DurationList':[100.0,50.0],
                  'DelayList':[50.0,200.0],
                  'FractionToTarget':1.0,
                  'LocationSpecific':False,
                  'TargetDict':{'soma_group':1 }       }]              }
                  
                  
    passed_inputs=oc_utils.check_inputs(input_params,popDict,dir_cell_models)

    if passed_inputs:
    
       print("Input parameters were specified correctly")
       
       oc_utils.build_inputs(nml_doc=nml_doc,net=network,pop_params=pop_params,input_params=input_params,path_to_nml2=dir_cell_models)
       
       
    else:
    
      print("Input parameters were specified incorrectly; execution of RunColumn.py will terminate."
      
      quit()
    
    ####################################################################################################################################
    
    nml_file_name = '%s.net.nml'%network.id
    
    oc.save_network(nml_doc, nml_file_name, validate=True)
    
    for syn_ind in range(0,len(synapseList)):
    
        if 'Elect' not in synapseList[syn_ind]:

           synapseList[syn_ind]=os.path.join(net_id,synapseList[syn_ind]+".synapse.nml")
           
        else:
        
           synapseList[syn_ind]=os.path.join(net_id,synapseList[syn_ind]+".nml")

    lems_file_name=oc.generate_lems_simulation(nml_doc, 
                                               network, 
                                               nml_file_name, 
                                               duration =duration, 
                                               dt =dt,
                                               include_extra_lems_files=synapseList)
                            
    oc.simulate_network(lems_file_name=lems_file_name,
                        simulator=simulator,
                        max_memory=max_memory)
    
    
    
if __name__=="__main__":

   RunColumnSimulation(which_models=['CG3D_L23PyrRS','CG3D_SupBask'])
   
                                              
