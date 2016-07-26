from dashboard_cells import *

class generate_dashboards():

   def __init__(self,testing_mode=True,generate_dashboards=True,regenerate_nml2=True,compare_to_neuroconstruct=True,specific_cell_models=None):
   
      self.testing_mode=testing_mode
      
      self.generate_dashboards=generate_dashboards
      
      self.compare_to_neuroconstruct=compare_to_neuroconstruct
      
      self.regenerate_nml2=regenerate_nml2
      
      self.specific_cell_models=specific_cell_models
      
   def set_simulations(self):
  
       print "testing a new script: dashboard_cells"
       
       all_cell_models={"L23PyrRS":{'Analysis':"Cell1-supppyrRS-FigA1RS","SpikeProfile":"Cell1-supppyrRS-10ms",'OriginalTag':'CGsuppyrRS_0_wtime'},
                   "L23PyrFRB":{"Analysis":"Cell2-suppyrFRB-FigA1FRB","SpikeProfile":"Cell2-suppyrFRB-10ms",'OriginalTag':'CGsuppyrFRB_0_wtime'},
                   "SupBasket":{"Analysis":"Cell3-supbask-FigA2a","SpikeProfile":"Cell3-supbask-10ms","OriginalTag":'CGsupbask_0_wtime'},
                   "SupAxAx":{"Analysis":"Cell4-supaxax-FigA2a","SpikeProfile":"Cell4-supaxax-10ms","OriginalTag":'CGsupaxax_0_wtime'},
                   "SupLTSInter":{"Analysis":"Cell5-supLTS-FigA2b","SpikeProfile":"Cell5-supLTS-10ms","OriginalTag":'CGsupLTS_0_wtime'},
                   "L5TuftedPyrIB":{"Analysis":"Cell7-tuftIB-FigA4-1300","SpikeProfile":"Cell7-tuftIB-10ms","OriginalTag":'CGtuftIB_0_wtime'},
                   "L5TuftedPyrRS":{"Analysis":"Cell8-tuftRS-Fig5A-1400","SpikeProfile":"Cell8-tuftRS-10ms","OriginalTag":'CGtuftRS_0_wtime'},
                   "L6NonTuftedPyrRS":{"Analysis":"Cell9-nontuftRS-FigA6-1000","SpikeProfile":"Cell9-nontuftRS-10ms","OriginalTag":'CGnontuftRS_0_wtime'},
                   "DeepBasket":{"Analysis":"Cell10-deepbask-10ms","SpikeProfile":"Cell10-deepbask-10ms","OriginalTag":'CGdeepbask_0_wtime'},
                   "DeepAxAx":{"Analysis":"Cell11-deepaxax-10ms","SpikeProfile":"Cell11-deepaxax-10ms","OriginalTag":'CGdeepaxax_0_wtime'},
                   "DeepLTSInter":{"Analysis":"Cell12-deepLTS-FigA2b","SpikeProfile":"Cell12-deepLTS-10ms","OriginalTag":'CGdeepLTS_0_wtime'},
                   "nRT":{"Analysis":"Cell14-nRT-FigA8-00","SpikeProfile":"Cell14-nRT-10ms","OriginalTag":'CGnRT_0_wtime',
                   'SpikeProfileTag':'CGnRT_min75init','SpikeProfileCellTag':'nRT_minus75init'},
                   "L4SpinyStellate":{"Analysis":"Cell6-spinstell-FigA3-333","SpikeProfile":"Cell6-spinstell-10ms","OriginalTag":'CGspinstell_0_wtime'},
                   "TCR":{"Analysis":"Cell13-TCR-FigA7-600","SpikeProfile":"Cell13-TCR-10ms","OriginalTag":'CGTCR_0_wtime'} }
                   
       if self.specific_cell_models==None:
       
          cell_models=all_cell_models
          
       else:
       
          cell_models={}
          
          for cell_model in self.specific_cell_models:
          
              cell_models[cell_model]=all_cell_models[cell_model]
       
       if self.testing_mode:  
       
          start_amp=-0.2
          
          end_amp=0.4
          
          step=0.2    
          
          duration=800
          
          dt=0.01
          
          ElecLenList=[-1,0.05,0.025]
          
          DtList=[0.005,0.01,0.025]
          
       else:
       
          start_amp=-0.2
          
          end_amp=0.4
          
          step=0.02
          
          duration=3000
          
          dt=0.01
          
          ElecLenList=[-1,0.05,0.025, 0.01,0.005, 0.0025, 0.001,0.0005]
          
          DtList=[0.0001,0.0005,0.001,0.005,0.01,0.025]
               
       ifParams={'start_amp_nA':start_amp, 
                 'end_amp_nA':end_amp, 
                 'step_nA':step, 
                 'analysis_duration':duration, 
                 'analysis_delay':50,
                 'dt':dt,
                 'temperature':"6.3degC",
                 'simulator':"jNeuroML_NEURON",
                 'plot_voltage_traces':True,
                 'plot_if':True,
                 'plot_iv':True}
       
       dashboard_cells(net_id='Target',
                       net_file_name='Thalamocortical',
                       config_array=cell_models,
                       global_dt=0.01,
                       if_params=ifParams,
                       elec_len_list=ElecLenList,
                       dt_list=DtList,
                       comp_summary="compSummary.json",
                       generate_dashboards=self.generate_dashboards,
                       compare_to_neuroConstruct=self.compare_to_neuroconstruct,
                       regenerate_nml2=self.regenerate_nml2,
                       proj_string_neuroConstruct="../../neuroConstruct/Thalamocortical.ncx")
       
if __name__=="__main__":
  
  gen=generate_dashboards(regenerate_nml2=True,
                          testing_mode=True,
                          generate_dashboards=True,
                          compare_to_neuroconstruct=True,
                          specific_cell_models=None) 
  
  gen.set_simulations()
