#FLAGS =   -w 
#FLAGS = -c  -w 
#FLAGS = -g -d1 -C -w -save
 FLAGS = -O3 -w -xW -save

#FLAGS1 = -O3 -c -w -xW -save
#FLAGS1 = -C -g -d1 -c -w -xW -save



 STRUCT = gettime.o dexptablesmall_setup.o dexptablebig_setup.o synaptic_map_construct.o synaptic_compmap_construct.o groucho_gapbld.o groucho_gapbld_mix.o durand.o

 INTEGRATE = integrate_suppyrRS.o fnmda.o integrate_suppyrFRB.o integrate_supbask.o integrate_supaxax.o integrate_deepbask.o integrate_deepaxax.o integrate_supLTS.o integrate_deepLTS.o integrate_tcr.o integrate_nRT.o integrate_spinstell.o integrate_nontuftRS.o integrate_tuftRS.o integrate_tuftIB.o


groucho : groucho.f makefile
        mpif77 $(FLAGS) groucho.f $(STRUCT) $(INTEGRATE) -lPEPCF90 -o groucho
#       mpif77 $(FLAGS) groucho.f $(STRUCT)              -lPEPCF90 -o groucho

clean :
        rm -f groucho
        
