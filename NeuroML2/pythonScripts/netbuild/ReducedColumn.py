import opencortex.utils as oc_utils
import opencortex.build as oc_build
import opencortex
from pyneuroml import pynml


include_these_synapses=oc_utils.replace_cell_types(net_file_name="TestRunColumnSubstitution",
                                                   path_to_net="./",
                                                   new_net_id="TestRunColumnReduced",
                                                   cell_types_to_be_replaced=["L23PyrRS","L23PyrFRB_varInit"],
                                                   cell_types_replaced_by=["HH_464198958","HH_471141261"],
                                                   dir_to_new_components="../../../../OpenCortex/NeuroML2/prototypes/AllenInstituteCellTypesDB_HH",
                                                   dir_to_old_components="../../cells",
                                                   reduced_to_single_compartment=True,
                                                   validate_nml2=False,
                                                   return_synapses=True,
                                                   connection_segment_groups=None,
                                                   input_segment_groups=None,
                                                   synapse_file_tags=['.synapse.','Syn','Elect']) 
                                                   
nml_doc=pynml.read_neuroml2_file("TestRunColumnReduced.net.nml")

network=nml_doc.networks[0]

lems_file_name=oc_build.generate_lems_simulation(nml_doc, 
                                                 network, 
                                                 "TestRunColumnReduced.net.nml", 
                                                 duration =100, 
                                                 dt =0.01,
                                                 include_extra_lems_files=include_these_synapses)
     
opencortex.print_comment_v("Starting simulation of %s.net.nml"%"TestRunColumnReduced")
                            
oc_build.simulate_network(lems_file_name=lems_file_name,
                          simulator="jNeuroML_NEURON",
                          max_memory="4000M")      
