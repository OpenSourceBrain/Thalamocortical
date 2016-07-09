import opencortex
import opencortex.utils as oc_utils
import opencortex.build as oc

#### distribute cells for the sake of network visualization; no spatial dependence of connection probability at the moment;
###### larger networks exceed GitHub's file size limit of 100.00 MB;
######Note: the below leads to Java out of memory errors when validating the final nml2 network file; use another format instead of nml;
popDictFull = {}
##############   Full model ############################## 
popDictFull['L23PyrRS'] = [(1000, 'L23')]
popDictFull['SupBasket'] = [(90, 'L23')]
popDictFull['SupAxAx'] = [(90, 'L23')]
popDictFull['L5TuftedPyrIB'] = [(800, 'L5')]
popDictFull['L5TuftedPyrRS']=[(0,'L5')]           ##### not all of the L5TuftedPyrRS synapses can be found in generatedNeuroML2; therefore the size is set to 0 at the moment;
                                                  ##### original value in the full model is 200.
popDictFull['L4SpinyStellate']=[(240,'L4')]
popDictFull['L23PyrFRB']=[(50,'L23')]
popDictFull['L6NonTuftedPyrRS']=[(500,'L6')]
popDictFull['DeepAxAx']=[(100,'L6')]
popDictFull['DeepBasket']=[(100,'L6')]
popDictFull['DeepLTSInter']=[(100,'L6')]
popDictFull['SupLTSInter']=[(90,'L23')]
popDictFull['nRT']=[(100,'Thalamus')]
popDictFull['TCR']=[(100,'Thalamus')]
###########################################################
scale=0.1
popDict={}
for cell_model in popDictFull.keys():

    popDict[cell_model]=[]
    
    for pop_in_layer in range(0,len(popDictFull[cell_model])):
      
        pop_in_layer_tuple=()
        print round(scale*popDictFull[cell_model][pop_in_layer][0])
        pop_in_layer_tuple=( int(round(scale*popDictFull[cell_model][pop_in_layer][0] )), popDictFull[cell_model][pop_in_layer][1] )
        
        popDict[cell_model].append(pop_in_layer_tuple)
        
        

t1=-0
t2=-250
t3=-250
t4=-200.0
t5=-300.0
t6=-300.0
t7=-200.0
t8=-200.0

boundaries={}

boundaries['L1']=[0,t1]
boundaries['L23']=[t1,t1+t2+t3]
boundaries['L4']=[t1+t2+t3,t1+t2+t3+t4]
boundaries['L5']=[t1+t2+t3+t4,t1+t2+t3+t4+t5]
boundaries['L6']=[t1+t2+t3+t4+t5,t1+t2+t3+t4+t5+t6]
boundaries['Thalamus']=[t1+t2+t3+t4+t5+t6+t7,t1+t2+t3+t4+t5+t6+t7+t8]

xs = [0,500]
zs = [0,500] 

nml_doc, network = oc.generate_network("TestTraubBuildFull")


for cellModel in popDict.keys():
    oc.add_cell_and_channels(nml_doc, '../NeuroML2/prototypes/Thalamocortical/%s.cell.nml'%cellModel,cellModel)



pop_params=oc_utils.add_populations_in_layers(network,boundaries,popDict,xs,zs)


#extra_params=[{'pre':'L23PyrRS','post':'SupBasket','weights':[0.05],'delays':[5],'synComps':['NMDA']}]


synapseList,projArray=oc_utils.build_connectivity(network,pop_params,"./",'netConnList')                  

oc.add_synapses(nml_doc,'../NeuroML2/prototypes/Thalamocortical/',synapseList)

nml_file_name = '%s.net.nml'%network.id
oc.save_network(nml_doc, nml_file_name, validate=True)

oc.generate_lems_simulation(nml_doc, 
                            network, 
                            nml_file_name, 
                            duration =      300, 
                            dt =            0.025)
                                              
