from matplotlib import pyplot as plt
import math


def PlotNC_vs_NML2(targets_to_plot,legend=False,save_to_file=None,nCcellPath=None,NML2cellPath=None):
    
    path={}
    path['nC']=nCcellPath
    path['NML2']=NML2cellPath
    colour={}
    colour['nC']='r'
    colour['NML2']='b'
    subplot_titles=targets_to_plot['subplotTitles']

    if len(targets_to_plot['NML2'])==len(targets_to_plot['nC']):
       no_of_pairs=len(targets_to_plot['NML2'])
       
       if (no_of_pairs % 5) >= 1:
          rows = max(1,int(math.ceil(no_of_pairs/5)+1))
       else:
          rows=max(1,int(math.ceil(no_of_pairs/5)))
       columns = min(5,no_of_pairs)
       
       fig,ax = plt.subplots(rows,columns,sharex=False,figsize=(4*columns,4*rows))

       if rows > 1 or columns > 1:
          ax = ax.ravel()
      
       fig.canvas.set_window_title("Thalamocortical cell models: neuroConstruct project compared to NeuroML2")
       
       for pair in range(0,no_of_pairs):
           cells={}
           cells['NML2']=targets_to_plot['NML2'][pair]
           cells['nC']=targets_to_plot['nC'][pair]
           if no_of_pairs > 1:
              ax[pair].set_xlabel('Time (s)')
              ax[pair].set_ylabel('Membrane potential (V)')
              ax[pair].xaxis.grid(True)
              ax[pair].yaxis.grid(True)
           else:
              ax.set_xlabel('Time (s)')
              ax.set_ylabel('Membrane potential (V)')
              ax.xaxis.grid(True)
              ax.yaxis.grid(True)
           
           for cell_project in ['NML2','nC']:
               data=[]
               time_array=[]
               voltage_array=[]
               data.append(time_array)
               data.append(voltage_array)
               
               if path[cell_project]==None:
                  cell_path=cells[cell_project]+'.dat'
               else:
                  cell_path=path[cell_project]+cells[cell_project]+'.dat'
               
               for line in open(cell_path):
                   values=line.split() # for each line there is a time point and voltage value at that time point
                   for x in range(0,2):
                       data[x].append(float(values[x]))
               if no_of_pairs >1:
                  ax[pair].plot(data[0],data[1],label=cell_project,color=colour[cell_project])
               else:
                  ax.plot(data[0],data[1],label=cell_project,color=colour[cell_project])
               print("Adding trace for: %s"%subplot_titles[pair])
                  
  
           
           if no_of_pairs >1:
              ax[pair].used = True
              ax[pair].set_title(subplot_titles[pair],size=13)
              ax[pair].locator_params(tight=True, nbins=8)
           else:
              ax.used = True
              ax.set_title(subplot_titles[pair],size=13)
              ax.locator_params(tight=True, nbins=8)
           
           if no_of_pairs >1:
              for tick in ax[pair].xaxis.get_major_ticks():
                  tick.label.set_fontsize(9) 
           else:
              for tick in ax.xaxis.get_major_ticks():
                  tick.label.set_fontsize(9)
                  
       if no_of_pairs != int(rows*columns):  
       
          for empty_plot in range(0,int(rows*columns)-no_of_pairs):
              x=-1-empty_plot
              ax[x].axis("off")         
          
       if legend:
          ##### adjust these for better display
          ax[0].legend(loc='upper center',bbox_to_anchor=(0.19, 1),fontsize=14, fancybox=True,ncol=1, shadow=True)
       plt.tight_layout()
       if save_to_file !=None:
          plt.savefig(save_to_file)
       plt.show()
       
       
if __name__=="__main__":
   #### At the moment Cell6 and Cell13 are not added as there are issues with export to NEURON
   PlotNC_vs_NML2({'NML2':['Sim_Cell1_supppyrRS_10ms.CGsuppyrRS.v','Sim_Cell2_suppyrFRB_10ms.CGsuppyrFRB.v',
   'Sim_Cell3_supbask_10ms.CGsupbask.v','Sim_Cell4_supaxax_10ms.CGsupaxax.v','Sim_Cell5_supLTS_10ms.CGsupLTS.v','Sim_Cell7_tuftIB_10ms.CGtuftIB.v',
   'Sim_Cell8_tuftRS_10ms.CGtuftRS.v','Sim_Cell9_nontuftRS_10ms.CGnontuftRS.v','Sim_Cell10_deepbask_10ms.CGdeepbask.v','Sim_Cell11_deepaxax_10ms.CGdeepaxax.v',
'Sim_Cell12_deepLTS_10ms.CGdeepLTS.v','Sim_Cell14_nRT_10ms.CGnRT_min75init.v'],
 
   'nC':['CGsupppyrRS_0_wtime','CGsuppyrFRB_0_wtime','CGsupbask_0_10ms_wtime',
   'CGsupaxax_0_wtime','CGsupLTS_0_wtime','CGtuftIB_0_wtime','CGtuftRS_0_wtime','CGnontuftRS_0_wtime','CGdeepbask_0_wtime','CGdeepaxax_0_wtime','CGdeepLTS_0_wtime','CGnRT_min75init_0_wtime'],
   
   'subplotTitles':['Cell1-supppyrRS-10ms','Cell2-suppyrFRB-10ms','Cell3-supbask-10ms',
   'Cell4-supaxax-10ms','Cell5-supLTS-10ms','Cell7-tuftIB-10ms','Cell8-tuftRS-10ms','Cell9-nontuftRS-10ms','Cell10-deepbask-10ms','Cell11-deepaxax-10ms','Cell12-deepLTS-10ms','Cell14-nRT-10ms']},save_to_file='Test_10ms_lg.pdf',legend=True)
   
   
   
   PlotNC_vs_NML2({'NML2':['Sim_Cell1_supppyrRS_FIgA1RS.CGsuppyrRS.v',
   'Sim_Cell2_suppyrFRB_FigA1FRB.CGsuppyrFRB.v','Sim_Test_Cell3_supbask_FigA2a.CGsupbask.v',
   'Sim_Cell4_supaxax_FigA2a.CGsupaxax.v','Sim_Cell5_supLTS_FigA2b.CGsupLTS.v','Sim_Cell7_tuftIB_FIgA4_900.CGtuftIB.v',
   'Sim_Cell7_tuftIB_FigA4_1100.CGtuftIB.v','Sim_Cell7_tuftIB_FigA4_1300.CGtuftIB.v','Sim_Cell7_tuftIB_FigA4_1500.CGtuftIB.v','Sim_Cell8_tuftRS_FigA5_800.CGtuftRS.v',
'Sim_Cell8_tuftRS_Fig5A_1000.CGtuftRS.v','Sim_Cell8_tuftRS_Fig5A_1200.CGtuftRS.v','Sim_Cell8_tuftRS_Fig5A_1400.CGtuftRS.v','Sim_Cell9_nontuftRS_FigA6_500.CGnontuftRS.v',
'Sim_Cell9_nontuftRS_FigA6_800.CGnontuftRS.v','Sim_Cell9_nontuftRS_FigA6_1000.CGnontuftRS.v','Sim_Cell12_deepLTS_FigA2b.CGdeepLTS.v','Sim_Cell14_nRT_FigA8_00.CGnRT.v',
'Sim_Cell14_nRT_FigA8_300.CGnRT.v','Sim_Cell14_nRT_FigA8_500.CGnRT.v'],
 
   'nC':['CGsuppyrRS_0_Fig_wtime','CGsuppyrFRB_0_FigA1_wtime',
   'CGsupbask_0_FigA2a_wtime','CGsupaxax_0_FigA2a_wtime','CGsupLTS_0_FigA2b_wtime','CGtuftIB_0_FigA4_900_wtime','CGtuftIB_0_FigA4_1100_wtime',
   'CGtuftIB_0_FigA4_1300_wtime','CGtuftIB_0_FigA4_1500_wtime','CGtuftRS_0_Fig5A_800_wtime','CGtuftRS_0_Fig5A_1000_wtime','CGtuftRS_0_Fig5A_1200_wtime',
   'CGtuftRS_0_Fig5A_1400_wtime','CGnontuftRS_0_Fig6A_500_wtime','CGnontuftRS_0_Fig6A_800_wtime','CGnontuftRS_0_Fig6A_1000_wtime','CGdeepLTS_0_FigA2b_wtime','CGnRT_0_FigA8_00_wtime',
   'CGnRT_0_FigA8_300_wtime','CGnRT_0_FigA8_500_wtime'],'subplotTitles':
   ['Cell1-supppyrRS-FigA1RS','Cell2-suppyrFRB-FigA1FRB','Cell3-supbask-FigA2a','Cell4-supaxax-FigA2a','Cell5-supLTS-FigA2b','Cell7-tuftIB-FigA4-900','Cell7-tuftIB-FigA4-1100','Cell7-tuftIB-FigA4-1300','Cell7-tuftIB-FigA4-1500','Cell8-tuftRS-FigA5-800','Cell8-tuftRS-Fig5A-1000','Cell8-tuftRS-Fig5A-1200','Cell8-tuftRS-Fig5A-1400','Cell9-nontuftRS-FigA6-500','Cell9-nontuftRS-FigA6-800','Cell9-nontuftRS-FigA6-1000','Cell12-deepLTS-FigA2b','Cell14-nRT-FigA8-00','Cell14-nRT-FigA8-300','Cell14-nRT-FigA8-500']},save_to_file='Test_figs_lg.pdf',legend=True)
   
       

