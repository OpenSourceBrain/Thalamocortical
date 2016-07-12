import os
import shutil
import re

def MoveMep(whichMepFiles=None,scalingFactor=None):

    src_files = os.listdir("../../neuroConstruct/pythonScripts/")
    target_file_names=[]
    if whichMepFiles==None:
       for file_name in src_files:
           if "mep" in file_name:
              target_file_names.append(file_name)
    else:
        for target_name in whichMepFiles:
            if target_name in src_files:
               target_file_names.append(target_name)
               
    if target_file_names != []:
       for file_name in target_file_names:
           full_file_name = os.path.join("../../neuroConstruct/pythonScripts/", file_name)
           if (os.path.isfile(full_file_name)):
              print("Copying %s from %s to a directory %s"%(file_name,full_file_name,"../"))
              shutil.copy(full_file_name,"../")
                   
                   
           with open("../"+file_name, 'r') as file:
                lines = file.readlines()
           count=0
           for line in lines:
               print line
               if "spike times" in line:
                  
                  values=re.findall("\d+\.\d+",line)
                  print values
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

  #MoveMep(whichMepFiles=['.test.FigA1RS0005.mep'],scalingFactor=0.001)
  #MoveMep(whichMepFiles=['.test.mep'],scalingFactor=0.001)
  #MoveMep(whichMepFiles=['.test.FigA1FRB0005.mep'],scalingFactor=0.001)
  #MoveMep(whichMepFiles=['.testNoTable.mep'],scalingFactor=0.001)
  #MoveMep(whichMepFiles=['.test.tuftIBFigA4_1300.mep'],scalingFactor=0.001)
  MoveMep(whichMepFiles=['.testNoTable.mep','.testNoTable0005.mep'],scalingFactor=0.001)
  
  
