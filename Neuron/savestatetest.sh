#!/bin/sh
np=4
tstop=20

mpiexec -n $np nrniv -mpi -c mytstop=$tstop -c savestatetest=1 init.hoc
sortspike out$np.dat out.savestatetest.1

mpiexec -n $np nrniv -mpi -c mytstop=$tstop -c savestatetest=2 init.hoc
sortspike out$np.dat out.savestatetest.2

diff out.savestatetest.* | tail
echo "the last line above should not be greater than $tstop/2"


