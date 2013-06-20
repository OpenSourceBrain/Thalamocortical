c Program assumes A, BB1, BB2 defined in calling program
c as follows:
c        A = DEXP(-2.847d0)
c        BB1 = DEXP(-.693d0)
c        BB2 = DEXP(-3.101d0)
        SUBROUTINE FNMDA (VSTOR, OPEN, numcells, numcomps,
     &    MG, L, A, BB1, BB2) 
c Computes "open" for all compartments of cell # L

           integer L, numcells, numcomps, i
       REAL*8 VSTOR(numcomps,numcells), OPEN(numcomps)
       REAL*8 A, BB1, BB2, VM, A1, A2, B1, B2, MG
c modify so that potential is absolute and not relative to
c  "rest"
C  TO DETERMINE VOLTAGE-DEPENDENCE OF NMDA CHANNELS
           DO 1, I = 1, numcomps
           VM = VSTOR(I,L)
           A1 = DEXP(-.016d0*VM - 2.91d0)
           A2 = 1000.d0 * MG * DEXP (-.045d0 * VM - 6.97d0)
           B1 = DEXP(.009d0*VM + 1.22d0)
           B2 = DEXP(.017d0*VM + 0.96d0)
        OPEN(I)     = 1.d0/(1.d0 + (A1+A2)*(A1*BB1 + A2*BB2) /
     X   (A*A1*(B1+BB1) + A*A2*(B2+BB2))  )
C  FROM JAHR & STEVENS, EQ. 4A
C               DO 124, J = 1, 19
C          OPEN(J) = 1./(1.+.667* EXP(-0.07*(VSTOR(J)-60.)) )
C  FROM CHUCK STEVENS
1               CONTINUE
                        END
