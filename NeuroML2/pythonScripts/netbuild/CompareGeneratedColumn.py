##############################################################
### Author : Rokas Stanislovas
###
### GSoC 2016 project: Cortical Networks
##############################################################

from pyneuroml import pynml

class CompareGeneratedColumn():

    def __init__(self,target_net_path,reference_net_path,test_populations=True,test_projections=True,test_inputs=True):
    
       self.target_net_path=target_net_path
       
       self.reference_net_path=reference_net_path
       
       self.test_populations=test_populations
       
       self.test_projections=test_projections
       
       self.test_inputs=test_inputs
       
       self.target_net_doc=pynml.read_neuroml2_file(target_net_path)
       
       self.reference_net_doc=pynml.read_neuroml2_file(reference_net_path)
       
       self.error_counter=0
       
    def check_populations(self):

        target_net=self.target_net_doc.networks[0]
       
        reference_net=self.reference_net_doc.networks[0]
       
        reference_pop_info={}
       
        for pop_counter in range(0,len(reference_net.populations)):
              
            ref_pop=reference_net.populations[pop_counter]
              
            reference_pop_info[ref_pop.id]={}
              
            reference_pop_info[ref_pop.id]['component']=ref_pop.component
              
            reference_pop_info[ref_pop.id]['type']=ref_pop.type
              
            reference_pop_info[ref_pop.id]['size']=ref_pop.size
              
            reference_pop_info[ref_pop.id]['numInstances']=len(ref_pop.instances)
            
        reference_pop_ids=reference_pop_info.keys()
              
        for pop_counter in range(0,len(target_net.populations)):
          
            target_pop=target_net.populations[pop_counter]
          
            if target_pop.id not in reference_pop_info.keys():
            
               print("%s.net.nml is different from %s: target population %s is not in the reference network."%(target_net.id,self.reference_net_path,target_pop.id) )
               self.error_counter+=1
                     
            else:
            
               reference_pop_ids.remove(target_pop.id)
              
               target_component=target_pop.component
                 
               target_type=target_pop.type
                 
               target_size=target_pop.size
               
               if target_size !=reference_pop_info[target_pop.id]['size']:
               
                  print("%s.net.nml is different from %s: target population %s has size= %d but the reference population has size = %d." 
                  %(target_net.id,self.reference_net_path,target_pop.id,target_size,reference_pop_info[target_pop.id]['size']))
                  self.error_counter+=1
                  
               if target_type != reference_pop_info[target_pop.id]['type']:
               
                  print("%s.net.nml is different from %s: target population %s has type= %s but the reference population has type = %s." 
                  %(target_net.id,self.reference_net_path,target_pop.id,target_type,reference_pop_info[target_pop.id]['type']))
                  self.error_counter+=1
                 
               if len(target_pop.instances) != reference_pop_info[target_pop.id]['numInstances']:
                 
                  print("%s.net.nml is different from %s: target population %s has %d cell instances but the reference population in %s has %d cell instances." 
                  %(target_net.id,self.reference_net_path,target_pop.id,len(target_pop.instances),self.reference_net_path,reference_pop_info[target_pop.id]['numInstances']))
                  self.error_counter+=1
                 
               if target_component != reference_pop_info[target_pop.id]['component']:
                 
                  print("%s.net.nml is different from %s: target population %s has a cell component %s but the reference population in %s has a cell component %s."
                  %(target_net.id,self.reference_net_path,target_pop.id,target_component,self.reference_net_path,reference_pop_info[target_pop.id]['component']) )
                  self.error_counter+=1
                  
        if reference_pop_ids !=[]:
        
           print("%s.net.nml is different from %s: reference populations %s from %s are not found in the target network %s.net.nml."
           %(target_net_id,self.reference_net_path,reference_pop_ids,self.reference_net_path,target_net_id))
           self.error_counter+=1   
        
    def check_projections(self):  
         
        target_net=self.target_net_doc.networks[0]
       
        reference_net=self.reference_net_doc.networks[0]
       
        reference_chem_proj_info=[]
        
        reference_elect_proj_info=[]
        
        reference_elect_proj_ids=[]
        
        reference_chem_proj_ids=[]
        
        for elect_proj_counter in range(0,len(reference_net.electrical_projections)):
        
            proj=reference_net.electrical_projections[elect_proj_counter]
            
            reference_elect_proj_ids.append(proj.id)
            
            proj_info={}
            
            proj_info['id']=proj.id
            
            proj_info['pre']=proj.presynaptic_population
            
            proj_info['post']=proj.postsynaptic_population
            
            proj_info['numConns']=len(proj.electrical_connections)
            
            proj_info['synapse']=proj.electrical_connections[0].synapse
            
            reference_elect_proj_info.append(proj_info)
        
        for chem_proj_counter in range(0,len(reference_net.projections)):
        
            proj=reference_net.projections[chem_proj_counter]
            
            reference_chem_proj_ids.append(proj.id)
            
            proj_info={}
            
            proj_info['id']=proj.id
            
            proj_info['pre']=proj.presynaptic_population
            
            proj_info['post']=proj.postsynaptic_population
            
            proj_info['synapse']=proj.synapse
            
            proj_info['numConns']=len(proj.connections)
            
            reference_chem_proj_info.append(proj_info)
        
        found_chemical_proj_list=[]
        
        all_chemical_projs=[]
        
        for chem_proj_counter in range(0,len(target_net.projections)):
 
            target_proj=target_net.projections[chem_proj_counter]
            
            all_chemical_projs.append(target_proj.id)
            
            for ref_proj_counter in range(0,len(reference_chem_proj_info) ):
            
                check_pre_pop=target_proj.presynaptic_population == reference_chem_proj_info[ref_proj_counter]['pre']
                
                check_post_pop=target_proj.postsynaptic_population == reference_chem_proj_info[ref_proj_counter]['post']
                
                check_syn=target_proj.synapse == reference_chem_proj_info[ref_proj_counter]['synapse']
                
                if check_pre_pop and check_post_pop and check_syn:
                   
                   check_num_connections=len(target_proj.connection_wds) == reference_chem_proj_info[ref_proj_counter]['numConns']
                   
                   if not check_num_connections:
            
                      print("%s.net.nml is different from %s: chemical projection id= %s has %d connections but the corresponding reference projection id = %s has %d connections."
                      %(target_net.id,self.reference_net_path,target_proj.id,len(target_proj.connection_wds),reference_chem_proj_info[ref_proj_counter]['id'],
                        reference_chem_proj_info[ref_proj_counter]['numConns']))
                      self.error_counter+=1
                   
                   reference_chem_proj_ids.remove(reference_chem_proj_info[ref_proj_counter]['id'])
                
                   found_chemical_proj_list.append(target_proj.id)
                      
        if reference_chem_proj_ids !=[]:
        
           print("%s.net.nml is different from %s: corresponding chemical projections %s from %s are not found in the target network %s.net.nml."
           %(target_net.id,self.reference_net_path,reference_chem_proj_ids,self.reference_net_path,target_net.id) )
           self.error_counter+=1
           
        target_network_specific_projs=list(set(all_chemical_projs)-set(found_chemical_proj_list) ) 
           
        if target_network_specific_projs != []:
        
           print("%s.net.nml is different from %s: chemical projections %s are not found in the reference network %s."
           %(target_net.id,self.reference_net_path,target_network_specific_projs,self.reference_net_path))
           self.error_counter+=1
           
        found_elect_proj_list=[]
        
        all_elect_projs=[]
        
        for elect_proj_counter in range(0,len(target_net.electrical_projections)):
 
            target_proj=target_net.electrical_projections[elect_proj_counter]
            
            all_elect_projs.append(target_proj.id)
            
            for ref_proj_counter in range(0,len(reference_elect_proj_info) ):
            
                check_pre_pop=target_proj.presynaptic_population == reference_elect_proj_info[ref_proj_counter]['pre']
                
                check_post_pop=target_proj.postsynaptic_population == reference_elect_proj_info[ref_proj_counter]['post']
                
                check_syn=target_proj.electrical_connection_instances[0].synapse == reference_elect_proj_info[ref_proj_counter]['synapse']
                
                if check_pre_pop and check_post_pop and check_syn:
                   
                   check_num_connections=len(target_proj.electrical_connection_instances) == reference_elect_proj_info[ref_proj_counter]['numConns']
                   
                   if not check_num_connections:
            
                      print("%s.net.nml is different from %s: electrical projection id= %s has %d connections but the corresponding reference projection id = %s has %d connections."
                      %(target_net.id,self.reference_net_path,target_proj.id,len(target_proj.electrical_connection_instances),reference_elect_proj_info[ref_proj_counter]['id'],
                      reference_elect_proj_info[ref_proj_counter]['numConns']))
                      self.error_counter+=1
                   
                   reference_elect_proj_ids.remove(reference_elect_proj_info[ref_proj_counter]['id'])
                
                   found_elect_proj_list.append(target_proj.id)
                      
        if reference_elect_proj_ids !=[]:
        
           print("%s.net.nml is different from %s: corresponding electrical projections %s from %s are not found in the target network %s.net.nml."
           %(target_net.id,self.reference_net_path,reference_elect_proj_ids,self.reference_net_path,target_net.id))
           self.error_counter+=1
           
        target_network_specific_projs=list(set(all_elect_projs)-set(found_elect_proj_list) ) 
           
        if target_network_specific_projs != []:
        
           print("%s.net.nml is different from %s: electrical projections %s are not found in the reference network %s."
           %(target_net.id,self.reference_net_path,target_network_specific_projs,self.reference_net_path))
           self.error_counter+=1   
        
            
    def check_inputs(self):
    
        target_net=self.target_net_doc.networks[0]
       
        reference_net=self.reference_net_doc.networks[0]
        
        target_net_pulse_generators=self.target_net_doc.pulse_generators
       
        reference_net_pulse_generators=self.reference_net_doc.pulse_generators
        
        ref_pulse_generators_ids=[]
        
        ref_group_pulse_generators=[]
        
        ref_pulse_generator_counters={}
        
        target_pulse_generators_ids=[]
        
        target_group_pulse_generators=[]
        
        target_pulse_generator_counters={}
        
        target_net_input_lists=target_net.input_lists
        
        ref_net_input_lists=reference_net.input_lists
        
        target_input_list_counters={}
        
        ref_input_list_counters={}
        
        for pulse_index in range(0,len(reference_net_pulse_generators)):
        
            ref_pulse_generators_ids.append(reference_net_pulse_generators[pulse_index].id)
        
        for pulse_index in range(0,len(ref_pulse_generators_ids)):
        
            pulse_id=ref_pulse_generators_ids[pulse_index].split("_")
            
            pulse_group_id=pulse_id[0]+"_"+pulse_id[1]
            
            ref_group_pulse_generators.append(pulse_group_id)
            
        ref_group_pulse_generators=list(set(ref_group_pulse_generators))
        
        for group_id in ref_group_pulse_generators:
        
            ref_pulse_generator_counters[group_id]=-1
            
            ref_input_list_counters[group_id]=0
            
        for group_id in ref_group_pulse_generators:
            
            for pulse_index in range(0,len(ref_pulse_generators_ids)):
        
                if group_id in ref_pulse_generators_ids[pulse_index]:
                
                   ref_pulse_generator_counters[group_id]+=1
                   
            for input_list_index in range(0,len(ref_net_input_lists) ):
            
                if group_id in ref_net_input_lists[input_list_index].id:
                
                   ref_input_list_counters[group_id]+=1
                   
        for pulse_index in range(0,len(target_net_pulse_generators)):
        
            target_pulse_generators_ids.append(target_net_pulse_generators[pulse_index].id)
        
        for pulse_index in range(0,len(target_pulse_generators_ids)):
        
            pulse_id=ref_pulse_generators_ids[pulse_index].split("_")
            
            pulse_group_id=pulse_id[0]+"_"+pulse_id[1]
            
            target_group_pulse_generators.append(pulse_group_id)
            
        target_group_pulse_generators=list(set(target_group_pulse_generators))
        
        for group_id in target_group_pulse_generators:
        
            target_pulse_generator_counters[group_id]=0
            
            target_input_list_counters[group_id]=0
            
        for group_id in target_group_pulse_generators:
            
            for pulse_index in range(0,len(target_pulse_generators_ids)):
             
                if group_id in target_pulse_generators_ids[pulse_index]:
                
                   target_pulse_generator_counters[group_id]+=1
                   
            for input_list_index in range(0,len(target_net_input_lists)):
            
                if group_id in target_net_input_lists[input_list_index].id:
                
                   target_input_list_counters[group_id]+=1
                   
        target_net_specific_pulse_groups=list(set(target_group_pulse_generators)-set(ref_group_pulse_generators))
                   
        if target_net_specific_pulse_groups !=[]:
        
           print("%s.net.nml is different from %s: pulse generator groups %s are not found in the reference network %s."
           %(target_net.id,self.reference_net_path,target_net_specific_pulse_groups,self.reference_net_path))
           self.error_counter+=1   
           
        ref_net_specific_pulse_groups=list(set(ref_group_pulse_generators)-set(target_group_pulse_generators))
        
        if ref_net_specific_pulse_groups !=[]:
        
           print("%s.net.nml is different from %s: corresponding pulse generators %s from %s are not found in the target network %s.net.nml."
           %(target_net.id,self.reference_net_path,reference_elect_proj_ids,self.reference_net_path,target_net.id))
           self.error_counter+=1
           
        if target_net_specific_pulse_groups ==[] and ref_net_specific_pulse_groups ==[] :
               
           for group_id in target_group_pulse_generators:
           
               if not target_pulse_generator_counters[group_id]== ref_pulse_generator_counters[group_id]:
               
                  print("%s.net.nml is different from %s: pulse generator group index= %s in the %s.net.nml contains %d target cells but the corresponding group"
                  " in the reference network %s contains %d cells."
                  %(target_net.id,self.reference_net_path,group_id,target_net.id,target_pulse_generator_counters[group_id],self.reference_net_path,
                  ref_pulse_generator_counters[group_id]))
                  self.error_counter+=1
                  
               if not target_input_list_counters[group_id]== ref_input_list_counters[group_id]:
               
                  print("%s.net.nml is different from %s: pulse generator group index= %s in the %s.net.nml has %d input lists but the corresponding group"
                  " in the reference network %s has %d input lists."
                  %(target_net.id,self.reference_net_path,group_id,target_net.id,target_input_list_counters[group_id],self.reference_net_path,
                  ref_input_list_counters[group_id]))
                  self.error_counter+=1
               
        else:
        
           shared_group_pulse_generators=list(set(target_group_pulse_generators).intersection(ref_group_pulse_generators))
           
           for group_id in shared_group_pulse_generators:
           
               if not target_pulse_generator_counters[group_id]== ref_pulse_generator_counters[group_id]:
               
                  print("%s.net.nml is different from %s: pulse generator group index= %s in the %s.net.nml contains %d target cells but the corresponding group"
                  " in the reference network %s contains %d cells."
                  %(target_net.id,self.reference_net_path,group_id,target_net.id,target_pulse_generator_counters[group_id],self.reference_net_path,
                  ref_pulse_generator_counters[group_id]))
                  self.error_counter+=1
                  
               if not target_input_list_counters[group_id]== ref_input_list_counters[group_id]:
               
                  print("%s.net.nml is different from %s: pulse generator group index= %s in the %s.net.nml has %d input lists but the corresponding group"
                  " in the reference network %s has %d input lists."
                  %(target_net.id,self.reference_net_path,group_id,target_net.id,target_input_list_counters[group_id],self.reference_net_path,
                  ref_input_list_counters[group_id]))
                  self.error_counter+=1
        
    def tests(self):
    
        if self.test_populations:
    
           self.check_populations()
           
        if self.test_projections:
        
           self.check_projections()
           
        if self.test_inputs:
        
           self.check_inputs()
           
        if self.error_counter==0:
        
           print("%s.net.nml is equivalent to the %s"%(self.target_net_path,self.reference_net_path) )
        
    
  
if __name__=="__main__":

  testColumn=CompareGeneratedColumn(target_net_path="TestRunColumn.net.nml",
                                 reference_net_path="../../../neuroConstruct/generatedNeuroML2/LargeConns.net.nml")
  testColumn.tests()
                    
                 
                 
      
