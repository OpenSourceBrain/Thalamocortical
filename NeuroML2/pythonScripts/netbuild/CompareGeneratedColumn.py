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
            
               print("Error in %s.net.nml: target population %s is not in the reference network %s."%(target_net.id,target_pop.id,reference_net_path) )
               self.error_counter+=1
                     
            else:
            
               reference_pop_ids.remove(target_pop.id)
              
               target_component=target_pop.component
                 
               target_type=target_pop.type
                 
               target_size=target_pop.size
               
               if target_size !=reference_pop_info[target_pop.id]['size']:
               
                  print("Error in %s.net.nml: target population %s has size= %d but the reference population has size = %d." 
                  %(target_net.id,target_pop.id,target_size,reference_pop_info[target_pop.id]['size']))
                  self.error_counter+=1
                  
               if target_type != reference_pop_info[target_pop.id]['type']:
               
                  print("Error in %s.net.nml: target population %s has type= %s but the reference population has type = %s." 
                  %(target_net.id,target_pop.id,target_type,reference_pop_info[target_pop.id]['type']))
                  self.error_counter+=1
                 
               if len(target_pop.instances) != reference_pop_info[target_pop.id]['numInstances']:
                 
                  print("Error in %s.net.nml: target population %s has %d cell instances but the reference population in %s has %d cell instances." 
                  %(target_net.id,target_pop.id,len(target_pop.instances),self.reference_net_path,reference_pop_info[target_pop.id]['numInstances']))
                  self.error_counter+=1
                 
               if target_component != reference_pop_info[target_pop.id]['component']:
                 
                  print("Error in %s.net.nml: target population %s has a cell component %s but the reference population in %s has a cell component %s."
                  %(target_net.id,target_pop.id,target_component,self.reference_net_path,reference_pop_info[target_pop.id]['component']) )
                  self.error_counter+=1
                  
        if reference_pop_ids !=[]:
        
           print("Error in %s.net.nml: reference populations %s from %s are are not found in the target network."%(target_net_id,reference_pop_ids,self.reference_net_path))
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
            
            reference_chem_proj_ids.append(proj.id)
            
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
        
        found_target_proj_list=[]
        
        all_target_projs=[]
        
        for chem_proj_counter in range(0,len(target_net.projections)):
 
            target_proj=target_net.projections[chem_proj_counter]
            
            all_target_projs.append(target_proj.id)
            
            for ref_proj_counter in range(0,len(reference_chem_proj_info) ):
            
                check_pre_pop=target_proj.presynaptic_population == reference_chem_proj_info[ref_proj_counter]['pre']
                
                check_post_pop=target_proj.postsynaptic_population == reference_chem_proj_info[ref_proj_counter]['post']
                
                check_syn=target_proj.synapse == reference_chem_proj_info[ref_proj_counter]['synapse']
                
                if check_pre_pop and check_post_pop and check_syn:
                   
                   check_num_connections=len(target_proj.connection_wds) == reference_chem_proj_info[ref_proj_counter]['numConns']
                   
                   if not check_num_connections:
            
                      print("Error in %s.net.nml: the projection id= %s has %d connections but the corresponding reference projection id = %s has %d connections."
                      %(target_net.id,target_proj.id,len(target_proj.connection_wds),ref_proj_id, reference_chem_proj_info[ref_proj_id]['numConns']))
                      self.error_counter+=1
                   
                   reference_chem_proj_ids.remove(reference_chem_proj_info[ref_proj_counter]['id'])
                
                   found_target_proj_list.append(target_proj.id)
                      
        if reference_chem_proj_ids !=[]:
        
           print("Error in %s.net.nml: reference projections %s from %s are are not found in the target network."%(target_net_id,reference_chem_proj_ids,self.reference_net_path))
           self.error_counter+=1
           
        target_network_specific_projs=list(set(all_target_projs)-set(found_target_proj_list) ) 
           
        if target_network_specific_projs != []:
        
           print("Error in %s.net.nml: projections %s are not found in the reference network %s."%(target_net_id,target_network_specific_projs,self.reference_net_path))
           self.error_counter+=1
            
    def check_inputs(self):
        #TODO
        pass
    
    def tests(self):
    
        if self.test_populations:
    
           self.check_populations()
           
        if self.test_projections:
        
           self.check_projections()
           
        if self.test_inputs:
        
           self.check_inputs()
           
        if self.error_counter==0:
        
           print("%s.net.nml is equivalent in structure to the %s"%(self.target_net_path,self.reference_net_path) )
        
    
  
if __name__=="__main__":

  testColumn=CompareGeneratedColumn(target_net_path="TestRunColumn.net.nml",
                                 reference_net_path="../../../neuroConstruct/generatedNeuroML2/LargeConns.net.nml")
  testColumn.tests()
                    
                 
                 
      
