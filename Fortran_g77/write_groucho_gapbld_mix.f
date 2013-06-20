! 15 Nov. 2003, variation of groucho_gapbld.f to allow for gj
! between 2 cell populations, eg suppyrRS and suppyrFRB, or
! tuftRS and tuftIB.  Structure of gjtable as before, with col. 1
! giving cell of 1st type and col. 3 giving coupled cell of 2nd type.

      SUBROUTINE write_GROUCHO_gapbld_mix (thisno, numcells1, numcells2,
     & numgj, gjtable, allowedcomps, num_allowedcomps, display)
c       Construct a gap-junction network for groucho.f
c numcells1 = number of cells in 1st population.
c numcells2 = number of cells in 2nd population.
c numgj = total number of gj to be formed between these populations.
c gjtable = table of gj's: each row is a gj.  Entries are: cell A,
c    compartment on cell A; cell B, compartment on cell B
c allowedcomps = a list of compartments where gj allowed to form
c num_allowedcomps = number of compartments in a cell on which a gj 
c    might form.
! IT IS ASSUMED THAT ALLOWEDCOMPS AND NUM_ALLOWEDCOMPS SAME FOR
! THE 2 POPULATIONS.
c display is an integer flag.  If display = 1, print gjtable

        INTEGER thisno, numcells1, numcells2, numgj, gjtable(numgj,4),
     &    num_allowedcomps, allowedcomps(num_allowedcomps)
        INTEGER i,j,k,l,m,n,o,p, ictr /0/
c ictr keeps track of how many gj have been "built"
        INTEGER display

        double precision seed, x1(1), x2(1), y(2)

        if (thisno.eq.0) then
          do i = 1, numgj
            write (40,50) gjtable(i,1), gjtable(i,2),
     &                gjtable(i,3), gjtable(i,4)
          end do
        endif
50       FORMAT(4i6)

                 END
