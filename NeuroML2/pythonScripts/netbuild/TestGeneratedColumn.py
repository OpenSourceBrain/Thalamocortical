from pyneuroml import pynml

class TestGeneratedColumn():

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
    
        pass
        #TODO
        #projDict={}
        
        #for proj_counter in range(0,len(net.projections)):
            
            #connections=[]
            
            #proj=net.projections[proj_counter]
            #print proj.id
            #for conn_counter in range(0,len(proj.connection_wds)):
                #connection_dict={}
                #connection=proj.connection_wds[conn_counter]
                #print connection.id
                #connection_dict['preCellId']=connection.pre_cell_id
                #connection_dict['postCellId']=connection.post_cell_id
                #if hasattr(connection,'post_segment_id'):
                   #connection_dict['postSegmentId']=connection.post_segment_id
                #if hasattr(connection,'pre_segment_id'):
                  # connection_dict['preSegmentId']=connection.pre_segment_id
                #if hasattr(connection,'pre_fraction_along'):
                  # connection_dict['preFractionAlong']=connection.pre_fraction_along
                #if hasattr(connection,'post_fraction_along'):
                  # connection_dict['postFractionAlong']=connection.post_fraction_along
                #if hasattr(connection,'delay'):
                  # connection_dict['delay']=connection.delay
                #if hasattr(connection,'weight'):
                  # connection_dict['weight']=connection.weight
                #connections.append(connection_dict)
                
            #projDict[proj.id]=connections
            
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

  testColumn=TestGeneratedColumn(target_net_path="TestRunColumn.net.nml",
                                 reference_net_path="../../../neuroConstruct/generatedNeuroML2/LargeConns.net.nml")
  testColumn.tests()
                    
                 
                 
      
