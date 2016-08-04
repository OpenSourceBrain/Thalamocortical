import opencortex.utils as oc_utils
import opencortex.build as oc_build
import opencortex
from pyneuroml import pynml


include_these_synapses=oc_utils.replace_cell_types(net_file_name="TestRunColumnSubstitution",
                            path_to_net="./",
                            new_net_id="TestRunColumnAllenInstitute",
                            cell_types_to_be_replaced=["L23PyrRS","L23PyrFRB_varInit"],
                            cell_types_replaced_by=["Cell_472912177","Cell_473834758"],
                            dir_to_new_components="../../../../AllenInstituteNeuroML/CellTypesDatabase/models/NeuroML2",
                            dir_to_old_components="../../cells",
                            reduced_to_single_compartment=False,
                            validate_nml2=False,
                            return_synapses=True,
                            connection_segment_groups=[{'Type':'Chem','PreCellType':"Cell_472912177",'PreSegGroup':"axon",'PostCellType':"Cell_473834758",'PostSegGroup':"apic"},
                                                       {'Type':'Chem','PreCellType':"Cell_472912177",'PreSegGroup':"axon",'PostCellType':"Cell_472912177",'PostSegGroup':"dend_31"},
                                                       {'Type':'Chem','PreCellType':"Cell_473834758",'PreSegGroup':"axon",'PostCellType':"Cell_472912177",'PostSegGroup':"dend_31"},
                                                       {'Type':'Chem','PreCellType':"Cell_473834758",'PreSegGroup':"axon",'PostCellType':"Cell_473834758",'PostSegGroup':"apic"},
                                                       {'Type':'Elect','PreCellType':"Cell_472912177",'PreSegGroup':"axon",'PostCellType':"Cell_473834758",'PostSegGroup':"axon"},
                                                       {'Type':'Elect','PreCellType':"Cell_472912177",'PreSegGroup':"axon",'PostCellType':"Cell_472912177",'PostSegGroup':"axon"},
                                                       {'Type':'Elect','PreCellType':"Cell_473834758",'PreSegGroup':"axon",'PostCellType':"Cell_472912177",'PostSegGroup':"axon"},
                                                       {'Type':'Elect','PreCellType':"Cell_473834758",'PreSegGroup':"axon",'PostCellType':"Cell_473834758",'PostSegGroup':"axon"}],
                            input_segment_groups=[{'PostCellType':"Cell_473834758",'PostSegGroup':"apic"},{'PostCellType':"Cell_472912177",'PostSegGroup':"dend_31"}],
                            synapse_file_tags=['.synapse.','Syn','Elect'])
                            
nml_doc=pynml.read_neuroml2_file("TestRunColumnAllenInstitute.net.nml")

network=nml_doc.networks[0]

lems_file_name=oc_build.generate_lems_simulation(nml_doc, 
                                                 network, 
                                                 "TestRunColumnAllenInstitute.net.nml", 
                                                 duration =10, 
                                                 dt =0.025,
                                                 include_extra_lems_files=include_these_synapses)
     
opencortex.print_comment_v("Starting simulation of %s.net.nml"%"TestRunColumnAllenInstitute")
                            
oc_build.simulate_network(lems_file_name=lems_file_name,
                          simulator=None,
                          max_memory="4000M")
                          


                                             

                                                       
                            

