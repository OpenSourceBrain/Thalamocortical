            SUBROUTINE write_synaptic_map_construct (thisno,
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

       if (thisno.eq.0) then
         do i=1, num_presyninputs_perpostsyn_cell
           write(40,4040)(map(i,j),j=1,num_postsynaptic_cells)
         end do
       endif

4040   FORMAT(100000i6) ! arbitrarily 1e5 is largest number 
! of columns that will work (unless 100000 is increased here)
! note: smaller sized arrays use what they need and ignore large
! capacity.

                 END
