            SUBROUTINE synaptic_compmap_construct (thisno,
     &    num_postsynaptic_cells, compmap,
     &    num_presyninputs_perpostsyn_cell, 
     &    num_allowcomp, allow, display)

c Construct a map of compartments at connections of one presynaptic
c cell to type to a postsynaptic cell type.
c compmap (i,j) = compartment number on postsynaptic cell j of its
c  i'th presynaptic input.
c display is an integer flag.  If display = 1, print compmap

        INTEGER thisno,
     &   num_postsynaptic_cells,
     &   num_presyninputs_perpostsyn_cell,
     &   compmap (num_presyninputs_perpostsyn_cell, 
     &                  num_postsynaptic_cells),
     &   num_allowcomp, allow(num_allowcomp)
c num_allowcomp = number of different allowed compartments
c allow = list of allowed compartments
        INTEGER i,j,k,l,m,n,o,p
        INTEGER display

        double precision seed, x(1)

            seed = 377.d0
            map = 0
            k = 1

        do i = 1, num_postsynaptic_cells
        do j = 1, num_presyninputs_perpostsyn_cell
            call durand (seed, k, x)
c This defines a compartment     

           L = int ( x(1) * dble (num_allowcomp) )         
           if (L.eq.0) L = 1
           if (L.gt.num_allowcomp)             
     &           L = num_allowcomp         

           compmap (j,i) = allow(L)

        end do
        end do

c Possibly print out map when done.
       if ((display.eq.1).and.(thisno.eq.0)) then
        write (6,800)                           
800     format(' SYNAPTIC COMPARTMENT MAP ')
        do i = 1, num_postsynaptic_cells
         write (6,50) compmap(1,i), compmap(2,i),
     &        compmap(num_presyninputs_perpostsyn_cell,i)               
50       FORMAT(3i6)
        end do
       endif

                 END
