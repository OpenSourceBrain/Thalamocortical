import opencortex.utils as oc_utils

from RunColumn import *

RunColumnSimulation(net_id="TestRunColumnSubstitution",
                    sim_config="TempSimConfig",
                    which_models=["L23PyrRS","L23PyrFRB_varInit"])

oc_utils.replace_cell_types(net_file_name="TestRunColumnSubstitution",
                            path_to_net="./",
                            new_net_id="TestRunColumnAllenInstitute",
                            cell_types_to_be_replaced=["L23PyrRS","L23PyrFRB_varInit"],
                            cell_types_replaced_by=["Cell_471081668","Cell_472430904"],
                            dir_to_new_components="../../../../AllenInstituteNeuroML/CellTypesDatabase/models/NeuroML2",
                            dir_to_old_components="../../cells",
                            reduced_to_single_compartment=False,
                            validate_nml2=False,
                            specify_segment_groups=[{'Type':'Chem','PreCellType':"Cell_471081668",'PreSegGroup':"axon",'PostCellType':"Cell_472430904",'PostSegGroup':"apic_42"},
                                                    {'Type':'Chem','PreCellType':"Cell_471081668",'PreSegGroup':"axon",'PostCellType':"Cell_471081668",'PostSegGroup':"dend_31"},
                                                    {'Type':'Chem','PreCellType':"Cell_472430904",'PreSegGroup':"axon",'PostCellType':"Cell_471081668",'PostSegGroup':"dend_31"},
                                                    {'Type':'Chem','PreCellType':"Cell_472430904",'PreSegGroup':"axon",'PostCellType':"Cell_472430904",'PostSegGroup':"apic_42"},
                                                    {'Type':'Elect','PreCellType':"Cell_471081668",'PreSegGroup':"axon",'PostCellType':"Cell_472430904",'PostSegGroup':"apic_42"},
                                                    {'Type':'Elect','PreCellType':"Cell_471081668",'PreSegGroup':"axon",'PostCellType':"Cell_471081668",'PostSegGroup':"dend_31"},
                                                    {'Type':'Elect','PreCellType':"Cell_472430904",'PreSegGroup':"axon",'PostCellType':"Cell_471081668",'PostSegGroup':"dend_31"},
                                                    {'Type':'Elect','PreCellType':"Cell_472430904",'PreSegGroup':"axon",'PostCellType':"Cell_472430904",'PostSegGroup':"apic_42"}],
                            synapse_file_tags=['.synapse.','Syn','Elect'])
