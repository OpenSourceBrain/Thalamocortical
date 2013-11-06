        FUNCTION ran1(idum)
        PARAMETER (IA_p=16807,IM_p=2147483647,AM_p=1.d0/IM_p,
     x  IQ_p=127773,
     x  IR_p=2836,
     x  NTAB_p=32,NDIV_p=1+(IM_p-1)/NTAB_p,EPS_p=3.d-16,
     x  RNMX_p=1.d0-EPS_p)
        DOUBLE PRECISION ran1,AM/AM_p/,EPS/EPS_p/,RNMX/RNMX_p/
        INTEGER idum,IA/IA_p/,IM/IM_p/,IQ/IQ_p/,IR/IR_p/,NTAB/NTAB_p/,
     x  NDIV/NDIV_p/
        INTEGER j,k,iv(NTAB_p),iy
        SAVE iv,iy
        DATA iv /NTAB_p*0/, iy /0/
        if (idum.le.0.or.iy.eq.0) then
        idum=max0(-idum,1) ! max0 is the usual integer to integer max
        do 11 j=NTAB+8,1,-1
          k=idum/IQ
          idum=IA*(idum-k*IQ)-IR*k
          if (idum.lt.0) idum=idum+IM
          if (j.le.NTAB) iv(j)=idum
11      continue
        iy=iv(1)
        endif
        k=idum/IQ
        idum=IA*(idum-k*IQ)-IR*k
        if (idum.lt.0) idum=idum+IM
        j =1+iy/NDIV
        iy=iv(j)
        iv(j)=idum
        ran1=DMIN1(AM*iy,RNMX) ! DMIN1 is the usual double to double min
        return
        END

      subroutine durand(seed, npts, x)
      implicit none
      integer npts, i, idum
      real*8  seed, ran1,  x(npts)
      if (seed .lt. 0.0d0  .or. seed .gt. 2147483648.0) then
         write(6,*) 'seed must be a positive integer < 2.1474*10**9'
         seed = 135791113.0
      end if
      idum = -idint(seed) ! idint is the standard double to integer "int"
      do i = 1, npts
           x(i) = ran1(idum)
      end do
      seed = dble(idum)
      end
