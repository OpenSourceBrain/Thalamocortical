#FLAGS =   -w 
#FLAGS = -c  -w 
#FLAGS = -g -d1 -C -w -save
#FFLAGS = -O3 -w -quiet

# this is for the g77 debugger and ifc if desired
#FFLAGS = -w -g -finit-local-zero -fno-automatic -ffortran-bounds-check
# groucho will of course run faster without the bounds check
#FFLAGS = -w -finit-local-zero -fno-automatic -O3
FFLAGS = -w -finit-local-zero -fno-automatic -O3
# -g is for the debugger
#FFLAGS=-w -O3

#FLAGS1 = -O3 -c -w -xW -save
#FLAGS1 = -C -g -d1 -c -w -xW -save

# FC=gfortran
#FC=ifc
#FC=g77
FC=mpif77

# STRUCT = gettime.o dexptablesmall_setup.o dexptablebig_setup.o synaptic_map_construct.o synaptic_compmap_construct.o groucho_gapbld.o groucho_gapbld_mix.o durand.o

STRUCT = dexptablesmall_setup.o dexptablebig_setup.o synaptic_map_construct.o  synaptic_compmap_construct.o  groucho_gapbld.o  groucho_gapbld_mix.o durand.o

INTEGRATE = integrate_suppyrRS.o fnmda.o integrate_suppyrFRB.o integrate_supbask.o integrate_supaxax.o integrate_deepbask.o integrate_deepaxax.o integrate_supLTS.o integrate_deepLTS.o integrate_tcr.o integrate_nRT.o integrate_spinstell.o integrate_nontuftRS.o integrate_tuftRS.o integrate_tuftIB.o

EXTRA=trapfpe.o

OUTPUT_FILE=-o groucho
#OUTPUT_FILE=

GROUCHO = groucho.f

groucho : $(GROUCHO) $(STRUCT) $(INTEGRATE) makefile 
	$(FC) $(FFLAGS) $(GROUCHO) $(STRUCT) $(INTEGRATE)  $(OUTPUT_FILE)
#	mpif77 $(FLAGS) groucho_nogettime.f $(STRUCT) $(INTEGRATE) -lPEPCF90 -o groucho

# STRUCT files

dexptablesmall_setup.o: dexptablesmall_setup.f

dexptablebig_setup.o: dexptablebig_setup.f

synaptic_map_construct.o: synaptic_map_construct.f
write_synaptic_map_construct.o: write_synaptic_map_construct.f

synaptic_compmap_construct.o: synaptic_compmap_construct.f
write_synaptic_compmap_construct.o: write_synaptic_compmap_construct.f

groucho_gapbld.o: groucho_gapbld.f
write_groucho_gapbld.o: write_groucho_gapbld.f

groucho_gapbld_mix.o: groucho_gapbld_mix.f
write_groucho_gapbld_mix.o: write_groucho_gapbld_mix.f

durand.o: durand.f

# INTEGRATE files

integrate_suppyrRS.o:integrate_suppyrRS.f

fnmda.o: fnmda.f

integrate_suppyrFRB.o: integrate_suppyrFRB.f

integrate_supbask.o: integrate_supbask.f

integrate_supaxax.o: integrate_supaxax.f

integrate_deepbask.o: integrate_deepbask.f

integrate_deepaxax.o: integrate_deepaxax.f

integrate_supLTS.o: integrate_supLTS.f

integrate_deepLTS.o: integrate_deepLTS.f

integrate_tcr.o: integrate_tcr.f

integrate_nRT.o: integrate_nRT.f

integrate_spinstell.o: integrate_spinstell.f

integrate_nontuftRS.o: integrate_nontuftRS.f

integrate_tuftRS.o: integrate_tuftRS.f

integrate_tuftIB.o: integrate_tuftIB.f



clean :
	rm -f groucho
	rm -f *.o
