import numpy as np
import shutil
import os

def generate_and_copy_dat(targetDir,targetFileDict,saveToParentDir):

    for cellModel in targetFileDict.keys():
        
        save_to_path=saveToParentDir+cellModel
        
        if not os.path.exists(save_to_path):
           print("Creating a new directory %s"%save_to_path)
           os.makedirs(save_to_path)
        else:
           print("A directory %s already exists"%save_to_path)
           
        src_files = os.listdir(targetDir)
        for file_name in src_files:
            full_file_name = os.path.join(targetDir, file_name)
            if (os.path.isdir(full_file_name)):
               #### strip off __N from target dirs
               target_config=file_name[0:-3]
               
               src_files2=os.listdir(full_file_name) 
               for file2 in src_files2:
                   if ".dat" in file2:
                      ###### strip off .dat from target dirs
                      file_name2=file2[0:-4]
                  
                      if file_name2==targetFileDict[cellModel]['DatTag']:
                  
                         time_array=np.loadtxt(os.path.join(full_file_name,"time.dat"))
                         voltage_array=np.loadtxt(os.path.join(full_file_name,"%s.dat"%file_name2))

                         if len(time_array)==len(voltage_array):

                            voltage_with_time=np.zeros([len(time_array),2])

                            for i in range(0,len(time_array)):
                                voltage_with_time[i,0]=time_array[i]/1000
                                voltage_with_time[i,1]=voltage_array[i]/1000
                         
                            wtime=os.path.join(full_file_name,"%s_wtime.dat"%(file_name2))
                            print("will save %s_wtime.dat to the %s"%(file_name2,full_file_name))
                            np.savetxt(wtime,voltage_with_time)
                            
                            save_to_path_config=os.path.join(save_to_path,target_config)
                            
                            if not os.path.exists(save_to_path_config):
                               print("Creating a new directory %s"%save_to_path_config)
                               os.makedirs(save_to_path_config)
                            else:
                               print("A directory %s already exists"%save_to_path_config)
                            
                            print("moving to the %s"%save_to_path_config)
                            
                            shutil.copy(wtime,save_to_path_config)
       

if __name__=="__main__":
   
   
   targetFileDict={"L23PyrRS":{'DatTag':'CGsuppyrRS_0'},
                   "L23PyrFRB":{'DatTag':'CGsuppyrFRB_0'},
                   "SupBasket":{'DatTag':'CGsupbask_0'},
                   "L4SpinyStellate":{'DatTag':'CGspinstell_0'},
                   "SupAxAx":{'DatTag':'CGsupaxax_0'},
                   "SupLTSInter":{'DatTag':'CGsupLTS_0'},
                   "L5TuftedPyrIB":{'DatTag':'CGtuftIB_0'},
                   "L5TuftedPyrRS":{'DatTag':'CGtuftRS_0'},
                   "L6NonTuftedPyrRS":{'DatTag':'CGnontuftRS_0'},
                   "DeepBasket":{"DatTag":'CGdeepbask_0'},
                   "DeepAxAx":{"DatTag":'CGdeepaxax_0'},
                   "DeepLTSInter":{'DatTag':'CGdeepLTS_0'},
                   "nRT":{"DatTag":'CGnRT_min75init_0'},
                   "TCR":{"DatTag":'CGTCR_0'}}
   
   generate_and_copy_dat("../simulations",targetFileDict,"../../NeuroML2/")
   
