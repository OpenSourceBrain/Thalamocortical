            SUBROUTINE write_GROUCHO_gapbld (thisno, numcells, numgj,
     &       gjtable, allowedcomps, num_allowedcomps, display)
c       Construct a gap-junction network for groucho.f
c numcells = number of cells in population, e.g. number of tufted IB cells
c numgj = total number of gj to be formed in this population
c gjtable = table of gj's: each row is a gj.  Entries are: cell A,
c    compartment on cell A; cell B, compartment on cell B
c allowedcomps = a list of compartments where gj allowed to form
c num_allowedcomps = number of compartments in a cell on which a gj 
c    might form.
c display is an integer flag.  If display = 1, print gjtable

        INTEGER thisno, numcells, numgj, gjtable(numgj,4),
     &    num_allowedcomps, allowedcomps(num_allowedcomps)
        INTEGER i,j,k,l,m,n,o,p, ictr /0/
c ictr keeps track of how many gj have been "built"
        INTEGER display

        double precision seed, x(2), y(2)
        if (thisno.eq.0) then
          do i = 1, numgj
            write (40,50) gjtable(i,1), gjtable(i,2),
     &                gjtable(i,3), gjtable(i,4)
          end do
        endif
50      FORMAT(4i6)

                 END
