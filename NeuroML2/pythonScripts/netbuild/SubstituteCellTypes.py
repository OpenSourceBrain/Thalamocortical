import opencortex.utils as oc_utils
import opencortex.build as oc_build
import opencortex
from pyneuroml import pynml


include_these_synapses=oc_utils.replace_cell_types(net_file_name="TestRunColumnSubstitution",
                           path_to_net="./",
                           new_net_id="TestRunColumnAllenInstitute",
                           cell_types_to_be_replaced=["L23PyrRS","L23PyrFRB_varInit"],
                           cell_types_replaced_by=["pyr_4_sym","bask"],
                           dir_to_new_components="../../../../OpenCortex/NeuroML2/prototypes/acnet2",
                           dir_to_old_components="../../cells",
                           reduced_to_single_compartment=False,
                           validate_nml2=False,
                           return_synapses=True,
                           connection_segment_groups=[{'Type':'Chem','PreCellType':"pyr_4_sym",'PreSegGroup':"soma_group",'PostCellType':"pyr_4_sym",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Chem','PreCellType':"pyr_4_sym",'PreSegGroup':"soma_group",'PostCellType':"bask",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Chem','PreCellType':"bask",'PreSegGroup':"soma_group",'PostCellType':"bask",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Chem','PreCellType':"bask",'PreSegGroup':"soma_group",'PostCellType':"pyr_4_sym",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Elect','PreCellType':"pyr_4_sym",'PreSegGroup':"apical_dends",'PostCellType':"pyr_4_sym",'PostSegGroup':"apical_dends"},
                                                      {'Type':'Elect','PreCellType':"pyr_4_sym",'PreSegGroup':"soma_group",'PostCellType':"bask",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Elect','PreCellType':"bask",'PreSegGroup':"dendrite_group",'PostCellType':"bask",'PostSegGroup':"dendrite_group"},
                                                      {'Type':'Elect','PreCellType':"bask",'PreSegGroup':"dendrite_group",'PostCellType':"pyr_4_sym",'PostSegGroup':"dendrite_group"}],
                            input_segment_groups=[{'PostCellType':"pyr_4_sym",'PostSegGroup':"dendrite_group"},{'PostCellType':"bask",'PostSegGroup':"dendrite_group"}],
                            synapse_file_tags=['.synapse.','Syn','Elect'])
                            
nml_doc=pynml.read_neuroml2_file("TestRunColumnAllenInstitute.net.nml")

network=nml_doc.networks[0]

lems_file_name=oc_build.generate_lems_simulation(nml_doc, 
                                                 network, 
                                                 "TestRunColumnAllenInstitute.net.nml", 
                                                 duration =100, 
                                                 dt =0.020,
                                                 include_extra_lems_files=include_these_synapses)
     
opencortex.print_comment_v("Starting simulation of %s.net.nml"%"TestRunColumnAllenInstitute")
                            
oc_build.simulate_network(lems_file_name=lems_file_name,
                          simulator="jNeuroML_NEURON",
                          max_memory="4000M")
                          


                                             

                                                       
                            

