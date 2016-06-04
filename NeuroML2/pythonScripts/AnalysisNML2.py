#   Script for generating analysis plots for Traub model cells in NeuroML2 format
#
#   Author: Rokas Stanislovas
#
#   GSoC 2016 project Cortical Networks
#
#
#

import sys
import os
from pyneuroml.analysis import generate_current_vs_frequency_curve
from neuroml import *
from pyneuroml import pynml
import neuroml.writers as writers 

from pyneuroml.lems import generate_lems_file_for_neuroml
from neuroml.utils import validate_neuroml2

import random


def AnalysisNML2(pathToCell,cellID):


    generate_current_vs_frequency_curve(pathToCell, 
                                    cellID, 
                                    start_amp_nA =         -0.2, 
                                    end_amp_nA =           0.8, 
                                    step_nA =              0.2, 
                                    analysis_duration =    1000, 
                                    analysis_delay =       50,
                                    simulator=             "jNeuroML_NEURON")
                                    
                                    
                                    
def SingleCellSim(simConfig,sim_duration,dt,targetPath):
    
    src_files = os.listdir(targetPath)
    for file_name in src_files:
        if file_name=="Thalamocortical.net.nml":
           net_doc = pynml.read_neuroml2_file(targetPath+file_name)
           net_doc.id=simConfig

           net=net_doc.networks[0]
           net.id=simConfig


           net_file = '%s.net.nml'%(net_doc.id)
           writers.NeuroMLWriter.write(net_doc, targetPath+net_file)

           print("Written network with 1 cell in network to: %s"%(targetPath+net_file))

    

    validate_neuroml2(targetPath+net_file)

    generate_lems_file_for_neuroml("Sim_"+net_doc.id, 
                               targetPath+net_file, 
                               net_doc.id, 
                               sim_duration,
                               dt, 
                               "LEMS_%s.xml"%net_doc.id,
                               targetPath,
                               gen_plots_for_all_v = True,
                               plot_all_segments = False,
                               gen_saves_for_all_v = True,
                               save_all_segments = False,
                               copy_neuroml = False,
                               seed = 1234)

                                    
                                    
                                    
                                    
                                    
if __name__=="__main__":

  #AnalysisNML2("../L23PyrRS/L23PyrRS_default/L23PyrRS.cell.nml","L23PyrRS")
  #SingleCellSim("SupBasket","Test_Cell3_supbask_FigA2a")
  #SingleCellSim("L23PyrRS","Cell1_supppyrRS_10ms",10)
  SingleCellSim(simConfig="FigA1RS",sim_duration=800,dt=0.01,targetPath="../Cell1-supppyrRS-FigA1RS/Cell1-supppyrRS-FigA1RS_default/")
  #SingleCellSim("L23PyrFRB","Cell2_suppyrFRB_10ms",10)
  #SingleCellSim("L23PyrFRB","Cell2_suppyrFRB_FigA1FRB",800)
  #SingleCellSim("SupBasket","Cell3_supbask_10ms",10)
  #SingleCellSim("SupAxAx","Cell4_supaxax_10ms",10)
  #SingleCellSim("SupAxAx","Cell4_supaxax_FigA2a",300)
  #SingleCellSim("SupLTSInter","Cell5_supLTS_10ms",10)
  #SingleCellSim("SupLTSInter","Cell5_supLTS_FigA2b",300)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_10ms",30)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_167",700)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_250",700)
  #SingleCellSim("L4SpinyStellate","Cell6_spinstell_FigA3_333",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_10ms",10)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FIgA4_900",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1100",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1300",700)
  #SingleCellSim("L5TuftedPyrIB","Cell7_tuftIB_FigA4_1500",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_10ms",10)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_FigA5_800",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_Fig5A_1000",700)
  #SingleCellSim("L5TuftedPyrRS","Cell8_tuftRS_Fig5A_1200",700)
  #SingleCellSim('L5TuftedPyrRS','Cell8_tuftRS_Fig5A_1400',700)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_10ms",50)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_500",800)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_800",800)
  #SingleCellSim("L6NonTuftedPyrRS","Cell9_nontuftRS_FigA6_1000",800)
  #SingleCellSim("DeepBasket","Cell10_deepbask_10ms",10)
  #SingleCellSim("DeepAxAx","Cell11_deepaxax_10ms",10)
  #SingleCellSim("DeepLTSInter","Cell12_deepLTS_10ms",10)
  #SingleCellSim("DeepLTSInter","Cell12_deepLTS_FigA2b",300)
  #SingleCellSim("TCR","Cell13_TCR_10ms",10)
  #SingleCellSim("TCR","Cell13_TCR_FigA7_100",350)
  #SingleCellSim("TCR","Cell13_TCR_FigA7_600",1500)
  #SingleCellSim("nRT","Cell14_nRT_10ms",30)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_00",200)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_300",450)
  #SingleCellSim("nRT","Cell14_nRT_FigA8_500",450)
