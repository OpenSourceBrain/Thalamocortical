#
#  This file plots the performance of the Thalamocortical network (50% full size, 100ms sim)
#  on the UCL cluster, consisting of 10 x 8 core Intel Xeon x5570, 2.93 GHz (Matthau)
#  and 20 x 8 core Intel Xeon E5520, 2.27 GHz (Lemmon)
#

import matplotlib.pyplot as plt
from pylab import *

print "Going to plot performance of simulations on multiple machines"

T_time = 100



# Times on nodes across both Matthau & Lemmon

times_Lm = {}

times_Lm[232] = 3.64    #   B_test1_N
times_Lm[176] = 4.57    #   B_test4_N
times_Lm[120] = 6.64    #   B_test5_N
times_Lm[104] = 8.34    #   ML_test0_N
times_Lm[80] = 10.23    #   ML_test1_N
#64
times_Lm[56] = 17.68    #   ML_test2_N
#32
times_Lm[24] = 41.63    #   ML_test4_N

for i in times_Lm.keys():
	times_Lm[i] = 1000 * times_Lm[i] / T_time



# Times on nodes on Lemmon

times_L = {}

times_L[160] = 5.44     #   Bl_test1_N
times_L[120] = 7.23     #   Bl_test5_N
times_L[80] = 10.54     #   Bl_test0_N
times_L[64] = 14.14     #   ML_test7_N
times_L[40] = 23.75     #   Bl_test6_N
times_L[24] = 41.54     #   Bm_test1_N
times_L[16] = 63.41     #   ML_test3_N
#8

for i in times_L.keys():
	times_L[i] = 1000 * times_L[i] / T_time



# Times on nodes on Matthau

times_M = {}

#80
times_M[72] = 11.64    #  Bm_test0_N
#64
#56
#48
times_M[40] = 20.64    #  ML_test6_N
times_M[32] = 25.98    #  Bl_test3_N
times_M[24] = 36.78    #  ML_test5_N
times_M[16] = 43.65    #  Bl_test2_N
#8

for i in times_M.keys():
	times_M[i] = 1000 * times_M[i] / T_time






times_L_ideal = {}

for i in times_L.keys():
	proc_norm = min(times_L.keys())
	times_L_ideal[i] = proc_norm * times_L[proc_norm]/i

times_M_ideal = {}

for i in times_M.keys():
	proc_norm = min(times_M.keys())
	times_M_ideal[i] = proc_norm * times_M[proc_norm]/i

times_Lm_ideal = {}

for i in times_Lm.keys():
	proc_norm = min(times_Lm.keys())
	times_Lm_ideal[i] = proc_norm * times_Lm[proc_norm]/i
	


def getXvals(times):
    x = times.keys()
    x.sort()
    return x

def getYvals(times):
    x = times.keys()
    x.sort()
    y = []
    for t in x:
        y.append(times[t])
    return y


from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas


fig = plt.figure()

p = fig.add_subplot(111)

lines = p.loglog(getXvals(times_L), getYvals(times_L), 'ro-', getXvals(times_L_ideal), getYvals(times_L_ideal), 'r:', \
		 getXvals(times_M), getYvals(times_M), 'ko-', getXvals(times_M_ideal), getYvals(times_M_ideal), 'k:', \
		 getXvals(times_Lm), getYvals(times_Lm), 'mo-', getXvals(times_Lm_ideal), getYvals(times_Lm_ideal), 'm:')
                 



p.set_ylabel('Simulation time for 1 sec of net activity (sec)', fontsize=14)

p.set_xlabel('Number of processors', fontsize=14)


lines[0].set_label('Lemmon')
lines[2].set_label('Matthau')
lines[4].set_label('Both')

legend()

fig.set_figheight(8)
fig.set_figwidth(12)

#plt.print_figure()

canvas = FigureCanvas(fig)

canvas.print_eps('Performance.eps')

#print dir(fig)


plt.show()


