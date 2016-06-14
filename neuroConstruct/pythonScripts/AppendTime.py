import numpy as np

time_array=np.loadtxt("../simulations/DefaultSimulationConfiguration__N/time.dat")

voltage_array=np.loadtxt("../simulations/DefaultSimulationConfiguration__N/CG_CML_0.dat")

if len(time_array)==len(voltage_array):

   voltage_with_time=np.zeros([len(time_array),2])

   for i in range(0,len(time_array)):
       voltage_with_time[i,0]=time_array[i]/1000
       voltage_with_time[i,1]=voltage_array[i]/1000
  
   np.savetxt("../simulations/DefaultSimulationConfiguration__N/CG_CML_0_wtime_notables.dat",voltage_with_time)

       

if __name__=="__main__":

   print time_array
   print voltage_array
   print len(time_array)
   print len(voltage_array)
