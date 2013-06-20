Readme for the model code associated with the paper

Traub RD, Contreras D, Cunningham MO, Murray H, Lebeau FE, Roopun A, 
Bibbig A, Wilent WB, Higley M, Whittington MA.
A single-column thalamocortical network model exhibiting gamma 
oscillations, sleep spindles and epileptogenic bursts.
J Neurophysiol. 2004 Nov 3; [Epub ahead of print]

These model files were supplied by Roger Traub with minor fixes
by Tom Morse and Michael Hines. 7/14/06

Note: in the file, job, the cd /home/traub/groucho will need to be
replaced with cd /home/yourdirectory/groucho which is where you issue
the qsub command.  Also you may need an extra path like:

# for LAM/Intel MPI version
export PATH=$PATH:.:/usr/local/lam/bin

supplied in your .bashrc file.  Here are some guidelines supplied
by Roger Traub on building and running the model:

1st compile all the integration subroutines, with compile_integration,
which uses ifc.

Then type "make", which compiles the main program (with mpifwhatever) 
and links everything to give an executable. Then "qsub job", which 
ships the lot to the master node of the Linux cluster; that in turn 
loads the stuff onto 14 cpu's.

groucho.f = main program
compile_integration = does what it says, compiles integration subroutines
makefile creates an executable for "job"
job = what gets submitted, with command "qsub job"

