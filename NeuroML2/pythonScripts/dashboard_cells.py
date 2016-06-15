from AnalysisNML2 import AnalysisNML2



def dashboard_cells(configArray,simParams=None):
   
    for model in in configArray.keys():
        AnalysisNML2(modelArray[model]['PathToCellModel'],modelArray[model]['CellID'])


if __name__=="__main__":

 
  modelArray=[{'PathToCellModel':"../Cell1-supppyrRS-FigA1RS/Cell1-supppyrRS-FigA1RS_default",'CellID':"L23PyrRS"}]
  dashboard_cells(modelArray)
  print "testing a new script: dashboard_cells"
  
  configsTest={"L23PyrRS":["Cell1-supppyrRS-FigA1RS","Cell1-supppyrRS-10ms"]}
  
  configs_all={"L23PyrRS":["Cell1-supppyrRS-FigA1RS","Cell1-supppyrRS-10ms"],
               "L23PyrFRB":["Cell2-suppyrFRB-FigA1FRB","Cell2-suppyrFRB-10ms"],
               "SupBasket":["Cell3-supbask-FigA2a","Cell3-supbask-10ms"],
               "SupAxAx":["Cell4-supaxax-FigA2a","Cell4-supaxax-10ms"],
               "SupLTSInter":["Cell5-supLTS-10ms","Cell5-supLTS-FigA2b"],
               "L4SpinyStellate":["Cell6-spinstell-10ms","Cell6-spinstell-FigA3-167","Cell6-spinstell-FigA3-250","Cell6-spinstell-FigA3-333"],
               "L5TuftedPyrIB":["Cell7-tuftIB-10ms", "Cell7-tuftIB-FigA4-900","Cell7-tuftIB-FigA4-1100","Cell7-tuftIB-FigA4-1300","Cell7-tuftIB-FigA4-1500"],
               "L5TuftedPyrRS":["Cell8-tuftRS-10ms","Cell8-tuftRS-FigA5-800","Cell8-tuftRS-Fig5A-1000","Cell8-tuftRS-Fig5A-1200","Cell8-tuftRS-Fig5A-1400"],
               "L6NonTuftedPyrRS":["Cell9-nontuftRS-10ms","Cell9-nontuftRS-FigA6-500","Cell9-nontuftRS-FigA6-800","Cell9-nontuftRS-FigA6-1000"],
               "DeepBasket":["Cell10-deepbask-10ms"],
               "DeepAxAx":["Cell11-deepaxax-10ms"],
               "DeepLTSInter":["Cell12-deepLTS-10ms"],
               "DeepLTSInter":["Cell12-deepLTS-FigA2b"],
               "TCR":["Cell13-TCR-10ms","Cell13-TCR-FigA7-100","Cell13-TCR-FigA7-600"],
               "nRT":["Cell14-nRT-10ms","Cell14-nRT-FigA8-00","Cell14-nRT-FigA8-300","Cell14-nRT-FigA8-500"]
               
                
           
