            SUBROUTINE write_synaptic_compmap_construct (thisno,
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

        if (thisno.eq.0) then
          do i = 1, num_postsynaptic_cells
            write(40,4040) 
     x      (compmap(j,i),j = 1, num_presyninputs_perpostsyn_cell)
          end do

4040   FORMAT(100000i6) ! arbitrarily 1e5 is largest number 
! of columns that will work (unless 100000 is increased here)
! note: smaller sized arrays use what they need and ignore large
! capacity.
        end if
       END
