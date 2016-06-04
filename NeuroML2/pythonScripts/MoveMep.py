import os
import shutil
import re

def MoveMep(scalingFactor=None):

    src_files = os.listdir("../../neuroConstruct/pythonScripts/")
    for file_name in src_files:
        if "mep" in file_name:
           full_file_name = os.path.join("../../neuroConstruct/pythonScripts/", file_name)
           if (os.path.isfile(full_file_name)):
              print("Copying %s from %s to a directory %s"%(file_name,full_file_name,"../"))
              shutil.copy(full_file_name,"../")
                   
                   
           with open("../"+file_name, 'r') as file:
                lines = file.readlines()
           count=0
           for line in lines:
               
               if "spike times" in line:
                  
                  values=re.findall("\d+\.\d+",line)
                  if values != []:
                     print("will scale spike times in %s by the factor %f"%("../"+file_name,scalingFactor))
                     scaled_spike_times=""
                     counter=0
                     for value in values:
                         counter+=1
                         value_float=float(value)
                         scaled_value=str(value_float*scalingFactor)
                         if counter !=len(values):
                            scaled_spike_times=scaled_spike_times+scaled_value+", "
                         else:
                            scaled_spike_times=scaled_spike_times+scaled_value
                            
                     new_line="       spike times: [%s]"%scaled_spike_times 
                     lines[count]=new_line
                      
                 

                     with open("../"+file_name, 'w') as file:
                          file.writelines( lines )
                          
               count+=1

if __name__=="__main__":

  MoveMep(scalingFactor=0.001)
