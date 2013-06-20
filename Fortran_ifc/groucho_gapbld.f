            SUBROUTINE GROUCHO_gapbld (thisno, numcells, numgj,
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

            seed = 137.d0
            gjtable = 0
            ictr = 0
            k = 2

2           call durand (seed, k, x)
c This defines a candidate cell pair
            call durand (seed, k, y)
c This defines a candidate pair of compartments

           i = int ( x(1) * dble (numcells) )
           j = int ( x(2) * dble (numcells) )
           if (i.eq.0) i = 1
           if (i.gt.numcells) i = numcells
           if (j.eq.0) j = 1
           if (j.gt.numcells) j = numcells

c Is the unordered cell pair (i,j) in the list so far?
           if (ictr.eq.0) goto 1

           p = 0
         do L = 1, ictr
       if ((gjtable(L,1).eq.i).and.(gjtable(L,3).eq.j)) p = 1
       if ((gjtable(L,1).eq.j).and.(gjtable(L,3).eq.i)) p = 1
         end do

          if (p.eq.1) goto 2

c Proceed with construction
1          ictr = ictr + 1
           m = int ( y(1) * dble (num_allowedcomps) )
           n = int ( y(2) * dble (num_allowedcomps) )
         if (m.eq.0) m = 1
         if (m.gt.num_allowedcomps) m = num_allowedcomps
         if (n.eq.0) n = 1
         if (n.gt.num_allowedcomps) n = num_allowedcomps

         gjtable (ictr,1) = i
         gjtable (ictr,3) = j
         gjtable (ictr,2) = allowedcomps (m)
         gjtable (ictr,4) = allowedcomps (n)

            if (ictr.lt.numgj) goto 2

c Possibly print out gjtable when done.
       if ((display.eq.1).and.(thisno.eq.0)) then
        write (6,800)           
800     format(' GJTABLE ')
        do i = 1, numgj
         write (6,50) gjtable(i,1), gjtable(i,2),
     &                gjtable(i,3), gjtable(i,4)
50       FORMAT(4i6)
        end do
       endif

                 END
