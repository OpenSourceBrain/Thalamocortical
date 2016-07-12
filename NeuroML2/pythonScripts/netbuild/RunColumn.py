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
                        full_path_to_connectivity='netConnList',
                        simulator=None,
                        duration=300,
                        dt=0.025,
                        max_memory='1000M',
                        extra_params=None):
                        
                        #TODO additional parameters and options
                        
                        
    #extra_params=[{'pre':'L23PyrRS','post':'SupBasket','weights':[0.05],'delays':[5],'synComps':['NMDA']}]                  
                        
    popDictFull = {}
    
    ##############   Full model ##################################
    
    popDictFull['L23PyrRS'] = [(1000, 'L23')]
    popDictFull['SupBasket'] = [(90, 'L23')]
    popDictFull['SupAxAx'] = [(90, 'L23')]
    popDictFull['L5TuftedPyrIB'] = [(800, 'L5')]
    popDictFull['L5TuftedPyrRS']=[(0,'L5')]           ##### not all of the L5TuftedPyrRS synapses can be found in generatedNeuroML2;  200
    popDictFull['L4SpinyStellate']=[(240,'L4')]
    popDictFull['L23PyrFRB']=[(50,'L23')]
    popDictFull['L6NonTuftedPyrRS']=[(500,'L6')]
    popDictFull['DeepAxAx']=[(100,'L6')]
    popDictFull['DeepBasket']=[(100,'L6')]
    popDictFull['DeepLTSInter']=[(100,'L6')]
    popDictFull['SupLTSInter']=[(90,'L23')]
    popDictFull['nRT']=[(100,'Thalamus')]
    popDictFull['TCR']=[(100,'Thalamus')]
    
    ###############################################################
    
    popDict={}
    
    nml_doc, network = oc.generate_network(net_id)
    
    for cell_model in popDictFull.keys():
    
        include_cell_model=False
    
        if which_models=='all' or cell_model in which_models:

           popDict[cell_model]=[]
    
           for pop_in_layer in range(0,len(popDictFull[cell_model])):
      
               pop_in_layer_tuple=()
             
               if popDictFull[cell_model][pop_in_layer][1] !='Thalamus':
             
                  pop_in_layer_tuple=( int(round(scaleCortex*popDictFull[cell_model][pop_in_layer][0] )), popDictFull[cell_model][pop_in_layer][1] )
                  
                  cell_count=int(round(scaleCortex*popDictFull[cell_model][pop_in_layer][0] ))
                
               else:
             
                  pop_in_layer_tuple=( int(round(scaleThalamus*popDictFull[cell_model][pop_in_layer][0] )), popDictFull[cell_model][pop_in_layer][1] )
                  
                  cell_count=int(round(scaleThalamus*popDictFull[cell_model][pop_in_layer][0] ))
           
               popDict[cell_model].append(pop_in_layer_tuple)
               
               if cell_count !=0:
    
                  include_cell_model=True
               
        if include_cell_model:
    
           oc.add_cell_and_channels(nml_doc, os.path.join(dir_cell_models,'%s.cell.nml'%cell_model),cell_model)

        
        
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

    pop_params=oc_utils.add_populations_in_layers(network,boundaries,popDict,xs,zs)

    synapseList,projArray=oc_utils.build_connectivity(network,pop_params,dir_cell_models,full_path_to_connectivity,extra_params)                  

    oc.add_synapses(nml_doc,dir_cell_models,synapseList)
    
    ############ for testing only; will add original specifications later ##############################################################
    
    input_params={'L23PyrRS':[{'InputType':'GeneratePoissonTrains',
                  'Layer':'L23',
                  'TrainType':'transient',
                  'Synapse':'Syn_AMPA_SupPyr_SupPyr',
                  'AverageRateList':[200.0,150.0],
                  'DurationList':[100.0,50.0],
                  'DelayList':[50.0,200.0],
                  'FractionToTarget':1.0,
                  'LocationSpecific':False,
                  'TargetDict':{'soma_group':1 }       }]              }
                  
                  
    passed=oc_utils.check_inputs(input_params,popDict,dir_cell_models)

    if passed:
    
       print("Input parameters are specified correctly")
       
       oc_utils.build_inputs(nml_doc=nml_doc,net=network,pop_params=pop_params,input_params=input_params,path_to_nml2=dir_cell_models)
    
    ####################################################################################################################################
    
    nml_file_name = '%s.net.nml'%network.id
    
    oc.save_network(nml_doc, nml_file_name, validate=True)
    
    for syn_ind in range(0,len(synapseList)):

        synapseList[syn_ind]=os.path.join(net_id,synapseList[syn_ind]+".synapse.nml")

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

   RunColumnSimulation(which_models=['L23PyrRS','SupBasket'])
   
                                              
