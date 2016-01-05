from pyneuroml import pynml

import matplotlib.pyplot as plt

v_nml2_f = 'CG_CML_0.0.dat'
ca_nml2_f = 'CG_CML_0.0.cad_CONC_ca.dat'

sim_dir= '../simulations/DefaultSimulationConfiguration__N/'

t_nrn_f = sim_dir+'time.dat'
v_nrn_f = sim_dir+'CG_CML_0.dat'
ca_nrn_f = sim_dir+'CG_CML_0.cad_CONC_ca.dat'



data, indices = pynml.reload_standard_dat_file(v_nml2_f)
x = []
y = []
tt = [t*1000 for t in data['t']]
x.append(tt)
y.append([v*1000 for v in data[0]])
    
data, indices = pynml.reload_standard_dat_file(ca_nml2_f)
xc = []
yc = []    
tt = [t*1000 for t in data['t']]
xc.append(tt)
yc.append([c for c in data[0]])
    
def read_dat_file(filename):

    f = open(filename)
    vals = []
    for line in f:
        if len(line.strip())>0: vals.append(float(line.strip()))
    return vals

tt = read_dat_file(t_nrn_f)
vv = read_dat_file(v_nrn_f)
cc = read_dat_file(ca_nrn_f)
x.append(tt)
y.append(vv)
xc.append(tt)
yc.append(cc)

pynml.generate_plot(x,
                    y, 
                    "V from: %s and %s"%(v_nml2_f,v_nrn_f), 
                    xaxis = "Time (ms)", 
                    yaxis = "Membrane potential (mV)", 
                    labels = ["NML2","NRN"],
                    ylim = [-100, 40],
                    show_plot_already=False)

pynml.generate_plot(xc,
                    yc, 
                    "[Ca2+] from: %s and %s"%(ca_nml2_f, ca_nrn_f), 
                    xaxis = "Time (ms)", 
                    yaxis = "Ca conc (mM)", 
                    labels = ["NML2","NRN"],
                    show_plot_already=False)
                    
                

plt.show()