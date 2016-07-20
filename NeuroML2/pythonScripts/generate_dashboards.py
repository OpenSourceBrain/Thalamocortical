from dashboard_cells import *


if __name__=="__main__":
  
  print "testing a new script: dashboard_cells"

  configsTest={"L23PyrFRB":{"Analysis":"Cell2-suppyrFRB-FigA1FRB","SpikeProfile":"Cell2-suppyrFRB-10ms",'OriginalTag':'CGsuppyrFRB_0_wtime'} }
  
  all_cell_models={"L23PyrRS":{'Analysis':"Cell1-supppyrRS-FigA1RS","SpikeProfile":"Cell1-supppyrRS-10ms",'OriginalTag':'CGsuppyrRS_0_wtime'},
                   "L23PyrFRB":{"Analysis":"Cell2-suppyrFRB-FigA1FRB","SpikeProfile":"Cell2-suppyrFRB-10ms",'OriginalTag':'CGsuppyrFRB_0_wtime'},
                   "SupBasket":{"Analysis":"Cell3-supbask-FigA2a","SpikeProfile":"Cell3-supbask-10ms","OriginalTag":'CGsupbask_0_wtime'},
                   "SupAxAx":{"Analysis":"Cell4-supaxax-FigA2a","SpikeProfile":"Cell4-supaxax-10ms","OriginalTag":'CGsupaxax_0_wtime'},
                   "SupLTSInter":{"Analysis":"Cell5-supLTS-FigA2b","SpikeProfile":"Cell5-supLTS-10ms","OriginalTag":'CGsupLTS_0_wtime'},
                   "L4SpinyStellate":{"Analysis":"Cell6-spinstell-FigA3-250","SpikeProfile":"Cell6-spinstell-10ms","OriginalTag":'CGspinstell_0_wtime'},
                   "L5TuftedPyrIB":{"Analysis":"Cell7-tuftIB-FigA4-1300","SpikeProfile":"Cell7-tuftIB-10ms","OriginalTag":'CGtuftIB_0_wtime'},
                   "L5TuftedPyrRS":{"Analysis":"Cell8-tuftRS-Fig5A-1200","SpikeProfile":"Cell8-tuftRS-10ms","OriginalTag":'CGtuftRS_0_wtime'},
                   "L6NonTuftedPyrRS":{"Analysis":"Cell9-nontuftRS-FigA6-800","SpikeProfile":"Cell9-nontuftRS-10ms","OriginalTag":'CGnontuftRS_0_wtime'},
                   "DeepBasket":{"Analysis":"Cell10-deepbask-10ms","SpikeProfile":"Cell10-deepbask-10ms","OriginalTag":'CGdeepbask_0_wtime'},
                   "DeepAxAx":{"Analysis":"Cell11-deepaxax-10ms","SpikeProfile":"Cell11-deepaxax-10ms","OriginalTag":'CGdeepaxax_0_wtime'},
                   "DeepLTSInter":{"Analysis":"Cell12-deepLTS-FigA2b","SpikeProfile":"Cell12-deepLTS-10ms","OriginalTag":'CGdeepLTS_0_wtime'},
                   "TCR":{"Analysis":"Cell13-TCR-FigA7-600","SpikeProfile":"Cell13-TCR-10ms","OriginalTag":'CGTCR_0_wtime'},
                   "nRT":{"Analysis":"Cell14-nRT-FigA8-500","SpikeProfile":"Cell14-nRT-10ms","OriginalTag":'CGnRT_min75init_0_wtime'} }
               
  ifParams={'start_amp_nA':0, 
            'end_amp_nA':2, 
            'step_nA':0.5, 
            'analysis_duration':1000, 
            'analysis_delay':50,
            'dt':0.01,
            'temperature':"6.3degC",
            'simulator':"jNeuroML_NEURON",
            'plot_voltage_traces':True,
            'plot_if':True,
            'plot_iv':True}
            
  #ElecLenList=[-1,0.05,0.025, 0.01,0.005, 0.0025, 0.001,0.0005]
  
  ElecLenList=[-1,0.05,0.025,0.005]
  
  #DtList=[0.0005,0.001,0.005,0.01,0.025]
  
  DtList=[0.001,0.005,0.01,0.025]
  
  dashboard_cells(net_id='Target',
                  net_file_name='Thalamocortical',
                  config_array=configsTest,
                  global_dt=0.01,
                  if_params=ifParams,
                  elec_len_list=ElecLenList,
                  dt_list=DtList,
                  comp_summary="compSummary.json",
                  generate_dashboards=True,
                  compare_to_neuroConstruct=False,
                  regenerate_nml2=False,
                  proj_string_neuroConstruct="../../neuroConstruct/Thalamocortical.ncx")
