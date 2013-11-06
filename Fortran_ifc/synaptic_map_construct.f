            SUBROUTINE synaptic_map_construct (thisno,
     &    num_presynaptic_cells, num_postsynaptic_cells,
     &    map, num_presyninputs_perpostsyn_cell, display) 

c Construct a map of presynaptic cells of one type to postsyn.
c  cells of some type. 
c display is an integer flag.  If display = 1, print gjtable

        INTEGER thisno, num_presynaptic_cells,
     &   num_postsynaptic_cells,
     &   num_presyninputs_perpostsyn_cell,
     &   map (num_presyninputs_perpostsyn_cell,
     &          num_postsynaptic_cells) 
        INTEGER i,j,k,l,m,n,o,p
        INTEGER display

        double precision seed, x(1)

            seed = 297.d0
            map = 0
            k = 1

        do i = 1, num_postsynaptic_cells
        do j = 1, num_presyninputs_perpostsyn_cell
            call durand (seed, k, x)
c This defines a presynaptic cell

           L = int ( x(1) * dble (num_presynaptic_cells) )
           if (L.eq.0) L = 1
           if (L.gt.num_presynaptic_cells)
     &           L = num_presynaptic_cells

           map (j,i) = L

        end do
        end do

c Possibly print out map when done.
       if ((display.eq.1).and.(thisno.eq.0)) then
        write (6,800)               
800     format('  SYNAPTIC MAP ')
        do i = 1, num_postsynaptic_cells
         write (6,50) map(1,i), map(2,i),
     &        map(num_presyninputs_perpostsyn_cell,i)               
50       FORMAT(3i6)
        end do
       endif

                 END
