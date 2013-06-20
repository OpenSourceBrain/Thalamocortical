	
! Integration routine for suppyrFRB cells
! Routine adapted from scortn in supergj.f
       SUBROUTINE INTEGRATE_suppyrFRB (O, time, numcell,     
     &    V, curr,
     & gAMPA, gNMDA, gGABA_A,
     & Mg, 
     & gapcon  ,totaxgj   ,gjtable, dt,
     & totaxgj_mix, gjtable_mix, num_other, vax,
     &  chi,mnaf,mnap,
     &  hnaf,mkdr,mka,
     &  hka,mk2,hk2,
     &  mkm,mkc,mkahp,
     &  mcat,hcat,mcal,
     &  mar,field_1mm,field_2mm)

       SAVE

       PARAMETER (numcomp_p = 74)
! numcomp here must be compat. with numcomp_suppyrFRB in calling prog.
	integer numcomp/numcomp_p/
       INTEGER  numcell, num_other
       INTEGER J1, I, J, K, K1, K2, L, L1, O
       REAL*8 c(numcomp_p), curr(numcomp_p,numcell)
       REAL*8  Z, Z1, Z2, Z3, Z4, DT, time
       integer totaxgj, gjtable(totaxgj,4)
       integer totaxgj_mix, gjtable_mix(totaxgj_mix,4)
       real*8 gapcon, gAMPA(numcomp_p,numcell),
     &        gNMDA(numcomp_p,numcell), gGABA_A(numcomp_p,numcell)
       real*8 Mg, V(numcomp_p,numcell)
       real*8 vax(num_other)

c CINV is 1/C, i.e. inverse capacitance
       real*8 chi(numcomp_p,numcell),
     & mnaf(numcomp_p,numcell),mnap(numcomp_p,numcell),
     x hnaf(numcomp_p,numcell), mkdr(numcomp_p,numcell),
     x mka(numcomp_p,numcell),hka(numcomp_p,numcell),
     x mk2(numcomp_p,numcell), cinv(numcomp_p),
     x hk2(numcomp_p,numcell),mkm(numcomp_p,numcell),
     x mkc(numcomp_p,numcell),mkahp(numcomp_p,numcell),
     x mcat(numcomp_p,numcell),hcat(numcomp_p,numcell),
     x mcal(numcomp_p,numcell), betchi(numcomp_p),
     x mar(numcomp_p,numcell),jacob(numcomp_p,numcomp_p),
     x gam(0: numcomp_p,0: numcomp_p),gL(numcomp_p),gnaf(numcomp_p),
     x gnap(numcomp_p),gkdr(numcomp_p),gka(numcomp_p),
     x gk2(numcomp_p),gkm(numcomp_p),
     x gkc(numcomp_p),gkahp(numcomp_p),
     x gcat(numcomp_p),gcaL(numcomp_p),gar(numcomp_p),
     x cafor(numcomp_p)
       real*8
     X alpham_naf(0:640),betam_naf(0:640),dalpham_naf(0:640),
     X   dbetam_naf(0:640),
     X alphah_naf(0:640),betah_naf(0:640),dalphah_naf(0:640),
     X   dbetah_naf(0:640),
     X alpham_kdr(0:640),betam_kdr(0:640),dalpham_kdr(0:640),
     X   dbetam_kdr(0:640),
     X alpham_ka(0:640), betam_ka(0:640),dalpham_ka(0:640) ,
     X   dbetam_ka(0:640),
     X alphah_ka(0:640), betah_ka(0:640), dalphah_ka(0:640),
     X   dbetah_ka(0:640),
     X alpham_k2(0:640), betam_k2(0:640), dalpham_k2(0:640),
     X   dbetam_k2(0:640),
     X alphah_k2(0:640), betah_k2(0:640), dalphah_k2(0:640),
     X   dbetah_k2(0:640),
     X alpham_km(0:640), betam_km(0:640), dalpham_km(0:640),
     X   dbetam_km(0:640),
     X alpham_kc(0:640), betam_kc(0:640), dalpham_kc(0:640),
     X   dbetam_kc(0:640),
     X alpham_cat(0:640),betam_cat(0:640),dalpham_cat(0:640),
     X   dbetam_cat(0:640),
     X alphah_cat(0:640),betah_cat(0:640),dalphah_cat(0:640),
     X   dbetah_cat(0:640),
     X alpham_caL(0:640),betam_caL(0:640),dalpham_caL(0:640),
     X   dbetam_caL(0:640),
     X alpham_ar(0:640), betam_ar(0:640), dalpham_ar(0:640),
     X   dbetam_ar(0:640)
       real*8 vL(numcomp_p),vk(numcomp_p),vna,var,vca,vgaba_a
       real*8 depth(12), membcurr(12), field_1mm, field_2mm
       integer level(numcomp_p)

        INTEGER NEIGH(numcomp_p,11), NNUM(numcomp_p)
        INTEGER igap1, igap2
c the f's are the functions giving 1st derivatives for evolution of
c the differential equations for the voltages (v), calcium (chi), and
c other state variables.
       real*8 fv(numcomp_p), fchi(numcomp_p),
     x fmnaf(numcomp_p),fhnaf(numcomp_p),fmkdr(numcomp_p),
     x fmka(numcomp_p),fhka(numcomp_p),fmk2(numcomp_p),
     x fhk2(numcomp_p),fmnap(numcomp_p),
     x fmkm(numcomp_p),fmkc(numcomp_p),fmkahp(numcomp_p),
     x fmcat(numcomp_p),fhcat(numcomp_p),fmcal(numcomp_p),
     x fmar(numcomp_p)

c below are for calculating the partial derivatives
       real*8 dfv_dv(numcomp_p,numcomp_p), dfv_dchi(numcomp_p),
     x  dfv_dmnaf(numcomp_p),  dfv_dmnap(numcomp_p),
     x  dfv_dhnaf(numcomp_p),dfv_dmkdr(numcomp_p),
     x  dfv_dmka(numcomp_p),dfv_dhka(numcomp_p),
     x  dfv_dmk2(numcomp_p),dfv_dhk2(numcomp_p),
     x  dfv_dmkm(numcomp_p),dfv_dmkc(numcomp_p),
     x  dfv_dmkahp(numcomp_p),dfv_dmcat(numcomp_p),
     x  dfv_dhcat(numcomp_p),dfv_dmcal(numcomp_p),
     x  dfv_dmar(numcomp_p)

        real*8 dfchi_dv(numcomp_p), dfchi_dchi(numcomp_p),
     x dfmnaf_dmnaf(numcomp_p), dfmnaf_dv(numcomp_p),
     x dfhnaf_dhnaf(numcomp_p),
     x dfmnap_dmnap(numcomp_p), dfmnap_dv(numcomp_p),
     x dfhnaf_dv(numcomp_p),dfmkdr_dmkdr(numcomp_p),
     x dfmkdr_dv(numcomp_p),
     x dfmka_dmka(numcomp_p),dfmka_dv(numcomp_p),
     x dfhka_dhka(numcomp_p),dfhka_dv(numcomp_p),
     x dfmk2_dmk2(numcomp_p),dfmk2_dv(numcomp_p),
     x dfhk2_dhk2(numcomp_p),dfhk2_dv(numcomp_p),
     x dfmkm_dmkm(numcomp_p),dfmkm_dv(numcomp_p),
     x dfmkc_dmkc(numcomp_p),dfmkc_dv(numcomp_p),
     x dfmcat_dmcat(numcomp_p),dfmcat_dv(numcomp_p),
     x dfhcat_dhcat(numcomp_p),
     x dfhcat_dv(numcomp_p),dfmcal_dmcal(numcomp_p),
     x dfmcal_dv(numcomp_p),
     x dfmar_dmar(numcomp_p),dfmar_dv(numcomp_p),
     x dfmkahp_dchi(numcomp_p),
     x dfmkahp_dmkahp(numcomp_p), dt2

       REAL*8 OPEN(numcomp_p),gamma(numcomp_p),gamma_prime(numcomp_p)
c gamma is function of chi used in calculating KC conductance
       REAL*8 alpham_ahp(numcomp_p), alpham_ahp_prime(numcomp_p)
       REAL*8 gna_tot(numcomp_p),gk_tot(numcomp_p),gca_tot(numcomp_p)
       REAL*8 gca_high(numcomp_p), gar_tot(numcomp_p)
c this will be gCa conductance corresponding to high-thresh channels

       REAL*8 A, BB1, BB2  ! params. for FNMDA.f


           if (O.eq.1) then
c do initialization

c Program fnmda assumes A, BB1, BB2 defined in calling program
c as follows:
         A = DEXP(-2.847d0)
         BB1 = DEXP(-.693d0)
         BB2 = DEXP(-3.101d0)

c       goto 4000
       CALL   SCORT_SETUP_FRB
     X   (alpham_naf, betam_naf, dalpham_naf, dbetam_naf,
     X    alphah_naf, betah_naf, dalphah_naf, dbetah_naf,
     X    alpham_kdr, betam_kdr, dalpham_kdr, dbetam_kdr,
     X    alpham_ka , betam_ka , dalpham_ka , dbetam_ka ,
     X    alphah_ka , betah_ka , dalphah_ka , dbetah_ka ,
     X    alpham_k2 , betam_k2 , dalpham_k2 , dbetam_k2 ,
     X    alphah_k2 , betah_k2 , dalphah_k2 , dbetah_k2 ,
     X    alpham_km , betam_km , dalpham_km , dbetam_km ,
     X    alpham_kc , betam_kc , dalpham_kc , dbetam_kc ,
     X    alpham_cat, betam_cat, dalpham_cat, dbetam_cat,
     X    alphah_cat, betah_cat, dalphah_cat, dbetah_cat,
     X    alpham_caL, betam_caL, dalpham_caL, dbetam_caL,
     X    alpham_ar , betam_ar , dalpham_ar , dbetam_ar)

        CALL SCORTMAJ_FRB (GL,GAM,GKDR,GKA,GKC,GKAHP,GK2,GKM,
     X              GCAT,GCAL,GNAF,GNAP,GAR,
     X    CAFOR,JACOB,C,BETCHI,NEIGH,NNUM,depth,level)

          do i = 1, numcomp
             cinv(i) = 1.d0 / c(i)
          end do
4000      CONTINUE

           do i = 1, numcomp
          vL(i) = -70.d0
          vK(i) = -95.d0
           end do

        VNA = 50.d0
        VCA = 125.d0
        VAR = -43.d0
        VAR = -35.d0
c -43 mV from Huguenard & McCormick
        VGABA_A = -81.d0

c ? initialize membrane state variables?
         do L = 1, numcell  
         do i = 1, numcomp
        v(i,L) = VL(i)
	chi(i,L) = 0.d0
	mnaf(i,L) = 0.d0
	mkdr(i,L) = 0.d0
	mk2(i,L) = 0.d0
	mkm(i,L) = 0.d0
	mkc(i,L) = 0.d0
	mkahp(i,L) = 0.d0
	mcat(i,L) = 0.d0
	mcal(i,L) = 0.d0
         end do
         end do

          do L = 1, numcell
        k1 = idnint (4.d0 * (v(1,L) + 120.d0))
       IF (K1.GT.640) K1 = 640
       IF (K1.LT.  0) K1 =   0

            do i = 1, numcomp
      hnaf(i,L) = alphah_naf(k1)/(alphah_naf(k1)
     &       +betah_naf(k1))
      hka(i,L) = alphah_ka(k1)/(alphah_ka(k1)
     &                               +betah_ka(k1))
      hk2(i,L) = alphah_k2(k1)/(alphah_k2(k1)
     &                                +betah_k2(k1))
      hcat(i,L)=alphah_cat(k1)/(alphah_cat(k1)
     &                                +betah_cat(k1))
c     mar=alpham_ar(k1)/(alpham_ar(k1)+betam_ar(k1))
      mar(i,L) = .25d0
             end do
           end do


             do i = 1, numcomp
	    open(i) = 0.d0
            gkm(i) = 2.d0 * gkm(i)
             end do

         do i = 1, 68
           gnaf(i) = 1.25d0 * gnaf(i)
           gkdr(i) = 1.25d0 * gkdr(i)
         end do
 
c Perhaps reduce fast gNa on IS
          gnaf(69) = 1.00d0 * gnaf(69)
c         gnaf(69) = 0.25d0 * gnaf(69)
          gnaf(70) = 1.00d0 * gnaf(70)
c         gnaf(70) = 0.25d0 * gnaf(70)

c Perhaps reduce coupling between soma and IS
c         gam(1,69) = 0.15d0 * gam(1,69)
c         gam(69,1) = 0.15d0 * gam(69,1)

c Determine which cells are FRB and which RS.
c           if (L.le.(nL2-nFRB)) then
c              z1 = 0.0d0
c              z1 = 0.2d0
c              z2 = 1.6d0
c              z2 = 1.0d0
c              z3 = 0.4d0
c              z4 = 1.0d0
c RS cell
c           else
!              z1 = 1.50d0
! below to make FRB less bursty
               z1 = 0.80d0
               z2 = 0.6d0
               z3 = 1.d0
               z4 = 1.d0
c FRB cell
c           endif
             do i = 1, numcomp
              gnap(i) = z1 * gnap(i)
              gkc (i) = z2 * gkc (i)
              gkahp(i) = z3 * gkahp(i)
              gkm (i) = z4 * gkm (i)
             end do


          endif
c End initialization

           do i = 1, 12
            membcurr(i) = 0.d0
           end do

c                  goto 2001


              do L = 1, numcell

	  do i = 1, numcomp
	  do j = 1, nnum(i)
	   if (neigh(i,j).gt.numcomp) then
          write(6,433) i, j, L
433       format(' ls ',3x,3i5)
           endif
	end do
	end do

       DO I = 1, numcomp
          FV(I) = -GL(I) * (V(I,L) - VL(i)) * cinv(i)
          DO J = 1, NNUM(I)
             K = NEIGH(I,J)
302     FV(I) = FV(I) + GAM(I,K) * (V(K,L) - V(I,L)) * cinv(i)
           END DO
       END DO
301    CONTINUE


       CALL FNMDA (V, OPEN, numcell, numcomp, MG, L,
     &                 A, BB1, BB2)

      DO I = 1, numcomp
       FV(I) = FV(I) + ( CURR(I,L)
     X   - (gampa(I,L) + open(i) * gnmda(I,L))*V(I,L)
     X   - ggaba_a(I,L)*(V(I,L)-Vgaba_a) ) * cinv(i)
c above assumes equil. potential for AMPA & NMDA = 0 mV
      END DO
421      continue

       do m = 1, totaxgj
        if (gjtable(m,1).eq.L) then
         L1 = gjtable(m,3)
         igap1 = gjtable(m,2)
         igap2 = gjtable(m,4)
 	fv(igap1) = fv(igap1) + gapcon *
     &   (v(igap2,L1) - v(igap1,L)) * cinv(igap1)
        else if (gjtable(m,3).eq.L) then
         L1 = gjtable(m,1)
         igap1 = gjtable(m,4)
         igap2 = gjtable(m,2)
 	fv(igap1) = fv(igap1) + gapcon *
     &   (v(igap2,L1) - v(igap1,L)) * cinv(igap1)
        endif
       end do ! do m

       do m = 1, totaxgj_mix
        if (gjtable_mix(m,3).eq.L) then
         L1 = gjtable_mix(m,1)
         igap1 = gjtable_mix(m,4)
 	fv(igap1) = fv(igap1) + gapcon *
     &   (vax(L1) - v(igap1,L)) * cinv(igap1)
        endif
       end do ! do m

c      do i = 1, ngap(L) ! OBSOLETE CODE FROM SUPERGJ.F
c      L1 = list_gap(L,i)
c	fv(axsite) = fv(axsite) + gapcon *
c    &   (vaxgap_global(L1) - v(axsite,L)) * cinv(axsite)
c      end do  ! OBSOLETE CODE FROM SUPERGJ.F

       do i = 1, numcomp
        gamma(i) = dmin1 (1.d0, .004d0 * chi(i,L))
        if (chi(i,L).le.250.d0) then
          gamma_prime(i) = .004d0
        else
          gamma_prime(i) = 0.d0
        endif
c         endif
       end do

      DO I = 1, numcomp
       gna_tot(i) = gnaf(i) * (mnaf(i,L)**3) * hnaf(i,L) +
     x     gnap(i) * mnap(i,L)
       gk_tot(i) = gkdr(i) * (mkdr(i,L)**4) +
     x             gka(i)  * (mka(i,L)**4) * hka(i,L) +
     x             gk2(i)  * mk2(i,L) * hk2(i,L) +
     x             gkm(i)  * mkm(i,L) +
     x             gkc(i)  * mkc(i,L) * gamma(i) +
     x             gkahp(i)* mkahp(i,L)
       gca_tot(i) = gcat(i) * (mcat(i,L)**2) * hcat(i,L) +
     x              gcaL(i) * (mcaL(i,L)**2)
       gca_high(i) =
     x              gcaL(i) * (mcaL(i,L)**2)
       gar_tot(i) = gar(i) * mar(i,L)


       FV(I) = FV(I) - ( gna_tot(i) * (v(i,L) - vna)
     X  + gk_tot(i) * (v(i,L) - vK(i))
     X  + gca_tot(i) * (v(i,L) - vCa)
     X  + gar_tot(i) * (v(i,L) - var) ) * cinv(i)
c        endif
       END DO
88           continue

         do i = 1, numcomp
         do j = 1, numcomp
          if (i.ne.j) then
            dfv_dv(i,j) = jacob(i,j)
          else
            dfv_dv(i,j) = jacob(i,i) - cinv(i) *
     X  (gna_tot(i) + gk_tot(i) + gca_tot(i) + gar_tot(i)
     X   + ggaba_a(i,L) + gampa(i,L)
     X   + open(i) * gnmda(I,L) )
          endif
         end do
         end do

           do i = 1, numcomp
        dfv_dchi(i)  = - cinv(i) * gkc(i) * mkc(i,L) *
     x                     gamma_prime(i) * (v(i,L)-vK(i))
        dfv_dmnaf(i) = -3.d0 * cinv(i) * (mnaf(i,L)**2) *
     X    (gnaf(i) * hnaf(i,L)          ) * (v(i,L) - vna)
        dfv_dmnap(i) = - cinv(i) *
     X    (               gnap(i)) * (v(i,L) - vna)
        dfv_dhnaf(i) = - cinv(i) * gnaf(i) * (mnaf(i,L)**3) *
     X                    (v(i,L) - vna)
        dfv_dmkdr(i) = -4.d0 * cinv(i) * gkdr(i) * (mkdr(i,L)**3)
     X                   * (v(i,L) - vK(i))
        dfv_dmka(i)  = -4.d0 * cinv(i) * gka(i) * (mka(i,L)**3) *
     X                   hka(i,L) * (v(i,L) - vK(i))
        dfv_dhka(i)  = - cinv(i) * gka(i) * (mka(i,L)**4) *
     X                    (v(i,L) - vK(i))
      dfv_dmk2(i) = - cinv(i) * gk2(i) * hk2(i,L) * (v(i,L)-vK(i))
      dfv_dhk2(i) = - cinv(i) * gk2(i) * mk2(i,L) * (v(i,L)-vK(i))
      dfv_dmkm(i) = - cinv(i) * gkm(i) * (v(i,L) - vK(i))
      dfv_dmkc(i) = - cinv(i)*gkc(i) * gamma(i) * (v(i,L)-vK(i))
        dfv_dmkahp(i)= - cinv(i) * gkahp(i) * (v(i,L) - vK(i))
        dfv_dmcat(i)  = -2.d0 * cinv(i) * gcat(i) * mcat(i,L) *
     X                    hcat(i,L) * (v(i,L) - vCa)
        dfv_dhcat(i) = - cinv(i) * gcat(i) * (mcat(i,L)**2) *
     X                  (v(i,L) - vCa)
        dfv_dmcal(i) = -2.d0 * cinv(i) * gcal(i) * mcal(i,L) *
     X                      (v(i,L) - vCa)
        dfv_dmar(i) = - cinv(i) * gar(i) * (v(i,L) - var)
            end do

         do i = 1, numcomp
          fchi(i) = - cafor(i) * gca_high(i) * (v(i,L) - vca)
     x       - betchi(i) * chi(i,L)
          dfchi_dv(i) = - cafor(i) * gca_high(i)
          dfchi_dchi(i) = - betchi(i)
         end do

       do i = 1, numcomp
c Note possible increase in rate at which AHP current develops
c       alpham_ahp(i) = dmin1(0.2d-4 * chi(i,L),0.01d0)
        alpham_ahp(i) = dmin1(1.0d-4 * chi(i,L),0.01d0)
        if (chi(i,L).le.500.d0) then
c         alpham_ahp_prime(i) = 0.2d-4
          alpham_ahp_prime(i) = 1.0d-4
        else
          alpham_ahp_prime(i) = 0.d0
        endif
       end do

       do i = 1, numcomp
        fmkahp(i) = alpham_ahp(i) * (1.d0 - mkahp(i,L))
c    x                  -.001d0 * mkahp(i,L)
     x                  -.010d0 * mkahp(i,L)
c       dfmkahp_dmkahp(i) = - alpham_ahp(i) - .001d0
        dfmkahp_dmkahp(i) = - alpham_ahp(i) - .010d0
        dfmkahp_dchi(i) = alpham_ahp_prime(i) *
     x                     (1.d0 - mkahp(i,L))
       end do

          do i = 1, numcomp

       K1 = IDNINT ( 4.d0 * (V(I,L) + 120.d0) )
       IF (K1.GT.640) K1 = 640
       IF (K1.LT.  0) K1 =   0

c      persistentNa_shift =  0.d0
c      persistentNa_shift =  8.d0
       persistentNa_shift = 10.d0
       K2 = IDNINT ( 4.d0 * (V(I,L)+persistentNa_shift+ 120.d0) )
       IF (K2.GT.640) K2 = 640
       IF (K2.LT.  0) K2 =   0

c            fastNa_shift = -2.0d0
c            fastNa_shift = -2.5d0
             fastNa_shift = -3.5d0
       K0 = IDNINT ( 4.d0 * (V(I,L)+      fastNa_shift+ 120.d0) )
       IF (K0.GT.640) K0 = 640
       IF (K0.LT.  0) K0 =   0

        fmnaf(i) = alpham_naf(k0) * (1.d0 - mnaf(i,L)) -
     X              betam_naf(k0) * mnaf(i,L)
        fmnap(i) = alpham_naf(k2) * (1.d0 - mnap(i,L)) -
     X              betam_naf(k2) * mnap(i,L)
        fhnaf(i) = alphah_naf(k1) * (1.d0 - hnaf(i,L)) -
     X              betah_naf(k1) * hnaf(i,L)
        fmkdr(i) = alpham_kdr(k1) * (1.d0 - mkdr(i,L)) -
     X              betam_kdr(k1) * mkdr(i,L)
        fmka(i)  = alpham_ka (k1) * (1.d0 - mka(i,L)) -
     X              betam_ka (k1) * mka(i,L)
        fhka(i)  = alphah_ka (k1) * (1.d0 - hka(i,L)) -
     X              betah_ka (k1) * hka(i,L)
        fmk2(i)  = alpham_k2 (k1) * (1.d0 - mk2(i,L)) -
     X              betam_k2 (k1) * mk2(i,L)
        fhk2(i)  = alphah_k2 (k1) * (1.d0 - hk2(i,L)) -
     X              betah_k2 (k1) * hk2(i,L)
        fmkm(i)  = alpham_km (k1) * (1.d0 - mkm(i,L)) -
     X              betam_km (k1) * mkm(i,L)
        fmkc(i)  = alpham_kc (k1) * (1.d0 - mkc(i,L)) -
     X              betam_kc (k1) * mkc(i,L)
        fmcat(i) = alpham_cat(k1) * (1.d0 - mcat(i,L)) -
     X              betam_cat(k1) * mcat(i,L)
        fhcat(i) = alphah_cat(k1) * (1.d0 - hcat(i,L)) -
     X              betah_cat(k1) * hcat(i,L)
        fmcaL(i) = alpham_caL(k1) * (1.d0 - mcaL(i,L)) -
     X              betam_caL(k1) * mcaL(i,L)
        fmar(i)  = alpham_ar (k1) * (1.d0 - mar(i,L)) -
     X              betam_ar (k1) * mar(i,L)

       dfmnaf_dv(i) = dalpham_naf(k0) * (1.d0 - mnaf(i,L)) -
     X                  dbetam_naf(k0) * mnaf(i,L)
       dfmnap_dv(i) = dalpham_naf(k2) * (1.d0 - mnap(i,L)) -
     X                  dbetam_naf(k2) * mnap(i,L)
       dfhnaf_dv(i) = dalphah_naf(k1) * (1.d0 - hnaf(i,L)) -
     X                  dbetah_naf(k1) * hnaf(i,L)
       dfmkdr_dv(i) = dalpham_kdr(k1) * (1.d0 - mkdr(i,L)) -
     X                  dbetam_kdr(k1) * mkdr(i,L)
       dfmka_dv(i)  = dalpham_ka(k1) * (1.d0 - mka(i,L)) -
     X                  dbetam_ka(k1) * mka(i,L)
       dfhka_dv(i)  = dalphah_ka(k1) * (1.d0 - hka(i,L)) -
     X                  dbetah_ka(k1) * hka(i,L)
       dfmk2_dv(i)  = dalpham_k2(k1) * (1.d0 - mk2(i,L)) -
     X                  dbetam_k2(k1) * mk2(i,L)
       dfhk2_dv(i)  = dalphah_k2(k1) * (1.d0 - hk2(i,L)) -
     X                  dbetah_k2(k1) * hk2(i,L)
       dfmkm_dv(i)  = dalpham_km(k1) * (1.d0 - mkm(i,L)) -
     X                  dbetam_km(k1) * mkm(i,L)
       dfmkc_dv(i)  = dalpham_kc(k1) * (1.d0 - mkc(i,L)) -
     X                  dbetam_kc(k1) * mkc(i,L)
       dfmcat_dv(i) = dalpham_cat(k1) * (1.d0 - mcat(i,L)) -
     X                  dbetam_cat(k1) * mcat(i,L)
       dfhcat_dv(i) = dalphah_cat(k1) * (1.d0 - hcat(i,L)) -
     X                  dbetah_cat(k1) * hcat(i,L)
       dfmcaL_dv(i) = dalpham_caL(k1) * (1.d0 - mcaL(i,L)) -
     X                  dbetam_caL(k1) * mcaL(i,L)
       dfmar_dv(i)  = dalpham_ar(k1) * (1.d0 - mar(i,L)) -
     X                  dbetam_ar(k1) * mar(i,L)

       dfmnaf_dmnaf(i) =  - alpham_naf(k0) - betam_naf(k0)
       dfmnap_dmnap(i) =  - alpham_naf(k2) - betam_naf(k2)
       dfhnaf_dhnaf(i) =  - alphah_naf(k1) - betah_naf(k1)
       dfmkdr_dmkdr(i) =  - alpham_kdr(k1) - betam_kdr(k1)
       dfmka_dmka(i)  =   - alpham_ka (k1) - betam_ka (k1)
       dfhka_dhka(i)  =   - alphah_ka (k1) - betah_ka (k1)
       dfmk2_dmk2(i)  =   - alpham_k2 (k1) - betam_k2 (k1)
       dfhk2_dhk2(i)  =   - alphah_k2 (k1) - betah_k2 (k1)
       dfmkm_dmkm(i)  =   - alpham_km (k1) - betam_km (k1)
       dfmkc_dmkc(i)  =   - alpham_kc (k1) - betam_kc (k1)
       dfmcat_dmcat(i) =  - alpham_cat(k1) - betam_cat(k1)
       dfhcat_dhcat(i) =  - alphah_cat(k1) - betah_cat(k1)
       dfmcaL_dmcaL(i) =  - alpham_caL(k1) - betam_caL(k1)
       dfmar_dmar(i)  =   - alpham_ar (k1) - betam_ar (k1)

          end do

       dt2 = 0.5d0 * dt * dt

        do i = 1, numcomp
          v(i,L) = v(i,L) + dt * fv(i)
           do j = 1, numcomp
        v(i,L) = v(i,L) + dt2 * dfv_dv(i,j) * fv(j)
           end do
        v(i,L) = v(i,L) + dt2 * ( dfv_dchi(i) * fchi(i)
     X          + dfv_dmnaf(i) * fmnaf(i)
     X          + dfv_dmnap(i) * fmnap(i)
     X          + dfv_dhnaf(i) * fhnaf(i)
     X          + dfv_dmkdr(i) * fmkdr(i)
     X          + dfv_dmka(i)  * fmka(i)
     X          + dfv_dhka(i)  * fhka(i)
     X          + dfv_dmk2(i)  * fmk2(i)
     X          + dfv_dhk2(i)  * fhk2(i)
     X          + dfv_dmkm(i)  * fmkm(i)
     X          + dfv_dmkc(i)  * fmkc(i)
     X          + dfv_dmkahp(i)* fmkahp(i)
     X          + dfv_dmcat(i)  * fmcat(i)
     X          + dfv_dhcat(i) * fhcat(i)
     X          + dfv_dmcaL(i) * fmcaL(i)
     X          + dfv_dmar(i)  * fmar(i) )

        chi(i,L) = chi(i,L) + dt * fchi(i) + dt2 *
     X   (dfchi_dchi(i) * fchi(i) + dfchi_dv(i) * fv(i))
        mnaf(i,L) = mnaf(i,L) + dt * fmnaf(i) + dt2 *
     X   (dfmnaf_dmnaf(i) * fmnaf(i) + dfmnaf_dv(i)*fv(i))
        mnap(i,L) = mnap(i,L) + dt * fmnap(i) + dt2 *
     X   (dfmnap_dmnap(i) * fmnap(i) + dfmnap_dv(i)*fv(i))
        hnaf(i,L) = hnaf(i,L) + dt * fhnaf(i) + dt2 *
     X   (dfhnaf_dhnaf(i) * fhnaf(i) + dfhnaf_dv(i)*fv(i))
        mkdr(i,L) = mkdr(i,L) + dt * fmkdr(i) + dt2 *
     X   (dfmkdr_dmkdr(i) * fmkdr(i) + dfmkdr_dv(i)*fv(i))
        mka(i,L) =  mka(i,L) + dt * fmka(i) + dt2 *
     X   (dfmka_dmka(i) * fmka(i) + dfmka_dv(i) * fv(i))
        hka(i,L) =  hka(i,L) + dt * fhka(i) + dt2 *
     X   (dfhka_dhka(i) * fhka(i) + dfhka_dv(i) * fv(i))
        mk2(i,L) =  mk2(i,L) + dt * fmk2(i) + dt2 *
     X   (dfmk2_dmk2(i) * fmk2(i) + dfmk2_dv(i) * fv(i))
        hk2(i,L) =  hk2(i,L) + dt * fhk2(i) + dt2 *
     X   (dfhk2_dhk2(i) * fhk2(i) + dfhk2_dv(i) * fv(i))
        mkm(i,L) =  mkm(i,L) + dt * fmkm(i) + dt2 *
     X   (dfmkm_dmkm(i) * fmkm(i) + dfmkm_dv(i) * fv(i))
        mkc(i,L) =  mkc(i,L) + dt * fmkc(i) + dt2 *
     X   (dfmkc_dmkc(i) * fmkc(i) + dfmkc_dv(i) * fv(i))
        mkahp(i,L) = mkahp(i,L) + dt * fmkahp(i) + dt2 *
     X (dfmkahp_dmkahp(i)*fmkahp(i) + dfmkahp_dchi(i)*fchi(i))
        mcat(i,L) =  mcat(i,L) + dt * fmcat(i) + dt2 *
     X   (dfmcat_dmcat(i) * fmcat(i) + dfmcat_dv(i) * fv(i))
        hcat(i,L) =  hcat(i,L) + dt * fhcat(i) + dt2 *
     X   (dfhcat_dhcat(i) * fhcat(i) + dfhcat_dv(i) * fv(i))
        mcaL(i,L) =  mcaL(i,L) + dt * fmcaL(i) + dt2 *
     X   (dfmcaL_dmcaL(i) * fmcaL(i) + dfmcaL_dv(i) * fv(i))
        mar(i,L) =   mar(i,L) + dt * fmar(i) + dt2 *
     X   (dfmar_dmar(i) * fmar(i) + dfmar_dv(i) * fv(i))
c            endif
         end do

! Add membrane currents into membcurr for appropriate compartments
          do i = 1, 9
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 14, 21
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 26, 33
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 39, 68
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do

            end do
c Finish loop L = 1 to numcell

         field_1mm = 0.d0
         field_2mm = 0.d0

         do i = 1, 12
          field_1mm = field_1mm + membcurr(i) / dabs(1000.d0 - depth(i))
          field_2mm = field_2mm + membcurr(i) / dabs(2000.d0 - depth(i))
         end do


2001          CONTINUE

        END



C  SETS UP TABLES FOR RATE FUNCTIONS
       SUBROUTINE SCORT_SETUP_FRB
     X   (alpham_naf, betam_naf, dalpham_naf, dbetam_naf,
     X    alphah_naf, betah_naf, dalphah_naf, dbetah_naf,
     X    alpham_kdr, betam_kdr, dalpham_kdr, dbetam_kdr,
     X    alpham_ka , betam_ka , dalpham_ka , dbetam_ka ,
     X    alphah_ka , betah_ka , dalphah_ka , dbetah_ka ,
     X    alpham_k2 , betam_k2 , dalpham_k2 , dbetam_k2 ,
     X    alphah_k2 , betah_k2 , dalphah_k2 , dbetah_k2 ,
     X    alpham_km , betam_km , dalpham_km , dbetam_km ,
     X    alpham_kc , betam_kc , dalpham_kc , dbetam_kc ,
     X    alpham_cat, betam_cat, dalpham_cat, dbetam_cat,
     X    alphah_cat, betah_cat, dalphah_cat, dbetah_cat,
     X    alpham_caL, betam_caL, dalpham_caL, dbetam_caL,
     X    alpham_ar , betam_ar , dalpham_ar , dbetam_ar)
      INTEGER I,J,K
      real*8 minf, hinf, taum, tauh, V, Z, shift_hnaf,
     X  shift_mkdr,
     X alpham_naf(0:640),betam_naf(0:640),dalpham_naf(0:640),
     X   dbetam_naf(0:640),
     X alphah_naf(0:640),betah_naf(0:640),dalphah_naf(0:640),
     X   dbetah_naf(0:640),
     X alpham_kdr(0:640),betam_kdr(0:640),dalpham_kdr(0:640),
     X   dbetam_kdr(0:640),
     X alpham_ka(0:640), betam_ka(0:640),dalpham_ka(0:640) ,
     X   dbetam_ka(0:640),
     X alphah_ka(0:640), betah_ka(0:640), dalphah_ka(0:640),
     X   dbetah_ka(0:640),
     X alpham_k2(0:640), betam_k2(0:640), dalpham_k2(0:640),
     X   dbetam_k2(0:640),
     X alphah_k2(0:640), betah_k2(0:640), dalphah_k2(0:640),
     X   dbetah_k2(0:640),
     X alpham_km(0:640), betam_km(0:640), dalpham_km(0:640),
     X   dbetam_km(0:640),
     X alpham_kc(0:640), betam_kc(0:640), dalpham_kc(0:640),
     X   dbetam_kc(0:640),
     X alpham_cat(0:640),betam_cat(0:640),dalpham_cat(0:640),
     X   dbetam_cat(0:640),
     X alphah_cat(0:640),betah_cat(0:640),dalphah_cat(0:640),
     X   dbetah_cat(0:640),
     X alpham_caL(0:640),betam_caL(0:640),dalpham_caL(0:640),
     X   dbetam_caL(0:640),
     X alpham_ar(0:640), betam_ar(0:640), dalpham_ar(0:640),
     X   dbetam_ar(0:640)
C FOR VOLTAGE, RANGE IS -120 TO +40 MV (absol.), 0.25 MV RESOLUTION


       DO 1, I = 0, 640
          V = dble(I)
          V = (V / 4.d0) - 120.d0

c gNa
           minf = 1.d0/(1.d0 + dexp((-V-38.d0)/10.d0))
           if (v.le.-30.d0) then
            taum = .025d0 + .14d0*dexp((v+30.d0)/10.d0)
           else
            taum = .02d0 + .145d0*dexp((-v-30.d0)/10.d0)
           endif
c from principal c. data, Martina & Jonas 1997, tau x 0.5
c Note that minf about the same for interneuron & princ. cell.
           alpham_naf(i) = minf / taum
           betam_naf(i) = 1.d0/taum - alpham_naf(i)

            shift_hnaf =  0.d0
        hinf = 1.d0/(1.d0 +
     x     dexp((v + shift_hnaf + 62.9d0)/10.7d0))
        tauh = 0.15d0 + 1.15d0/(1.d0+dexp((v+37.d0)/15.d0))
c from princ. cell data, Martina & Jonas 1997, tau x 0.5
            alphah_naf(i) = hinf / tauh
            betah_naf(i) = 1.d0/tauh - alphah_naf(i)

          shift_mkdr = 0.d0
c delayed rectifier, non-inactivating
       minf = 1.d0/(1.d0+dexp((-v-shift_mkdr-29.5d0)/10.0d0))
            if (v.le.-10.d0) then
             taum = .25d0 + 4.35d0*dexp((v+10.d0)/10.d0)
            else
             taum = .25d0 + 4.35d0*dexp((-v-10.d0)/10.d0)
            endif
              alpham_kdr(i) = minf / taum
              betam_kdr(i) = 1.d0 /taum - alpham_kdr(i)
c from Martina, Schultz et al., 1998. See espec. Table 1.

c A current: Huguenard & McCormick 1992, J Neurophysiol (TCR)
            minf = 1.d0/(1.d0 + dexp((-v-60.d0)/8.5d0))
            hinf = 1.d0/(1.d0 + dexp((v+78.d0)/6.d0))
        taum = .185d0 + .5d0/(dexp((v+35.8d0)/19.7d0) +
     x                            dexp((-v-79.7d0)/12.7d0))
        if (v.le.-63.d0) then
         tauh = .5d0/(dexp((v+46.d0)/5.d0) +
     x                  dexp((-v-238.d0)/37.5d0))
        else
         tauh = 9.5d0
        endif
           alpham_ka(i) = minf/taum
           betam_ka(i) = 1.d0 / taum - alpham_ka(i)
           alphah_ka(i) = hinf / tauh
           betah_ka(i) = 1.d0 / tauh - alphah_ka(i)

c h-current (anomalous rectifier), Huguenard & McCormick, 1992
           minf = 1.d0/(1.d0 + dexp((v+75.d0)/5.5d0))
           taum = 1.d0/(dexp(-14.6d0 -0.086d0*v) +
     x                   dexp(-1.87 + 0.07d0*v))
           alpham_ar(i) = minf / taum
           betam_ar(i) = 1.d0 / taum - alpham_ar(i)

c K2 K-current, McCormick & Huguenard
             minf = 1.d0/(1.d0 + dexp((-v-10.d0)/17.d0))
             hinf = 1.d0/(1.d0 + dexp((v+58.d0)/10.6d0))
            taum = 4.95d0 + 0.5d0/(dexp((v-81.d0)/25.6d0) +
     x                  dexp((-v-132.d0)/18.d0))
            tauh = 60.d0 + 0.5d0/(dexp((v-1.33d0)/200.d0) +
     x                  dexp((-v-130.d0)/7.1d0))
             alpham_k2(i) = minf / taum
             betam_k2(i) = 1.d0/taum - alpham_k2(i)
             alphah_k2(i) = hinf / tauh
             betah_k2(i) = 1.d0 / tauh - alphah_k2(i)

c voltage part of C-current, using 1994 kinetics, shift 60 mV
              if (v.le.-10.d0) then
       alpham_kc(i) = (2.d0/37.95d0)*dexp((v+50.d0)/11.d0 -
     x                                     (v+53.5)/27.d0)
       betam_kc(i) = 2.d0*dexp((-v-53.5d0)/27.d0)-alpham_kc(i)
               else
       alpham_kc(i) = 2.d0*dexp((-v-53.5d0)/27.d0)
       betam_kc(i) = 0.d0
               endif

c high-threshold gCa, from 1994, with 60 mV shift & no inactivn.
            alpham_cal(i) = 1.6d0/(1.d0+dexp(-.072d0*(v-5.d0)))
            betam_cal(i) = 0.1d0 * ((v+8.9d0)/5.d0) /
     x          (dexp((v+8.9d0)/5.d0) - 1.d0)

c M-current, from plast.f, with 60 mV shift
        alpham_km(i) = .02d0/(1.d0+dexp((-v-20.d0)/5.d0))
        betam_km(i) = .01d0 * dexp((-v-43.d0)/18.d0)

c T-current, from Destexhe, Neubig et al., 1998
         minf = 1.d0/(1.d0 + dexp((-v-56.d0)/6.2d0))
         hinf = 1.d0/(1.d0 + dexp((v+80.d0)/4.d0))
         taum = 0.204d0 + .333d0/(dexp((v+15.8d0)/18.2d0) +
     x                  dexp((-v-131.d0)/16.7d0))
          if (v.le.-81.d0) then
         tauh = 0.333 * dexp((v+466.d0)/66.6d0)
          else
         tauh = 9.32d0 + 0.333d0*dexp((-v-21.d0)/10.5d0)
          endif
              alpham_cat(i) = minf / taum
              betam_cat(i) = 1.d0/taum - alpham_cat(i)
              alphah_cat(i) = hinf / tauh
              betah_cat(i) = 1.d0 / tauh - alphah_cat(i)

1        CONTINUE

         do  i = 0, 639

      dalpham_naf(i) = (alpham_naf(i+1)-alpham_naf(i))/.25d0
      dbetam_naf(i) = (betam_naf(i+1)-betam_naf(i))/.25d0
      dalphah_naf(i) = (alphah_naf(i+1)-alphah_naf(i))/.25d0
      dbetah_naf(i) = (betah_naf(i+1)-betah_naf(i))/.25d0
      dalpham_kdr(i) = (alpham_kdr(i+1)-alpham_kdr(i))/.25d0
      dbetam_kdr(i) = (betam_kdr(i+1)-betam_kdr(i))/.25d0
      dalpham_ka(i) = (alpham_ka(i+1)-alpham_ka(i))/.25d0
      dbetam_ka(i) = (betam_ka(i+1)-betam_ka(i))/.25d0
      dalphah_ka(i) = (alphah_ka(i+1)-alphah_ka(i))/.25d0
      dbetah_ka(i) = (betah_ka(i+1)-betah_ka(i))/.25d0
      dalpham_k2(i) = (alpham_k2(i+1)-alpham_k2(i))/.25d0
      dbetam_k2(i) = (betam_k2(i+1)-betam_k2(i))/.25d0
      dalphah_k2(i) = (alphah_k2(i+1)-alphah_k2(i))/.25d0
      dbetah_k2(i) = (betah_k2(i+1)-betah_k2(i))/.25d0
      dalpham_km(i) = (alpham_km(i+1)-alpham_km(i))/.25d0
      dbetam_km(i) = (betam_km(i+1)-betam_km(i))/.25d0
      dalpham_kc(i) = (alpham_kc(i+1)-alpham_kc(i))/.25d0
      dbetam_kc(i) = (betam_kc(i+1)-betam_kc(i))/.25d0
      dalpham_cat(i) = (alpham_cat(i+1)-alpham_cat(i))/.25d0
      dbetam_cat(i) = (betam_cat(i+1)-betam_cat(i))/.25d0
      dalphah_cat(i) = (alphah_cat(i+1)-alphah_cat(i))/.25d0
      dbetah_cat(i) = (betah_cat(i+1)-betah_cat(i))/.25d0
      dalpham_caL(i) = (alpham_cal(i+1)-alpham_cal(i))/.25d0
      dbetam_caL(i) = (betam_cal(i+1)-betam_cal(i))/.25d0
      dalpham_ar(i) = (alpham_ar(i+1)-alpham_ar(i))/.25d0
      dbetam_ar(i) = (betam_ar(i+1)-betam_ar(i))/.25d0
       end do
2      CONTINUE

         do i = 640, 640
      dalpham_naf(i) =  dalpham_naf(i-1)
      dbetam_naf(i) =  dbetam_naf(i-1)
      dalphah_naf(i) = dalphah_naf(i-1)
      dbetah_naf(i) = dbetah_naf(i-1)
      dalpham_kdr(i) =  dalpham_kdr(i-1)
      dbetam_kdr(i) =  dbetam_kdr(i-1)
      dalpham_ka(i) =  dalpham_ka(i-1)
      dbetam_ka(i) =  dbetam_ka(i-1)
      dalphah_ka(i) =  dalphah_ka(i-1)
      dbetah_ka(i) =  dbetah_ka(i-1)
      dalpham_k2(i) =  dalpham_k2(i-1)
      dbetam_k2(i) =  dbetam_k2(i-1)
      dalphah_k2(i) =  dalphah_k2(i-1)
      dbetah_k2(i) =  dbetah_k2(i-1)
      dalpham_km(i) =  dalpham_km(i-1)
      dbetam_km(i) =  dbetam_km(i-1)
      dalpham_kc(i) =  dalpham_kc(i-1)
      dbetam_kc(i) =  dbetam_kc(i-1)
      dalpham_cat(i) =  dalpham_cat(i-1)
      dbetam_cat(i) =  dbetam_cat(i-1)
      dalphah_cat(i) =  dalphah_cat(i-1)
      dbetah_cat(i) =  dbetah_cat(i-1)
      dalpham_caL(i) =  dalpham_caL(i-1)
      dbetam_caL(i) =  dbetam_caL(i-1)
      dalpham_ar(i) =  dalpham_ar(i-1)
      dbetam_ar(i) =  dbetam_ar(i-1)
       end do   

       END

        SUBROUTINE SCORTMAJ_FRB
C BRANCHED ACTIVE DENDRITES
     X             (GL,GAM,GKDR,GKA,GKC,GKAHP,GK2,GKM,
     X              GCAT,GCAL,GNAF,GNAP,GAR,
     X    CAFOR,JACOB,C,BETCHI,NEIGH,NNUM,depth,level)
c Conductances: leak gL, coupling g, delayed rectifier gKDR, A gKA,
c C gKC, AHP gKAHP, K2 gK2, M gKM, low thresh Ca gCAT, high thresh
c gCAL, fast Na gNAF, persistent Na gNAP, h or anom. rectif. gAR.
c Note VAR = equil. potential for anomalous rectifier.
c Soma = comp. 1; 10 dendrites each with 13 compartments, 6-comp. axon
c Drop "glc"-like terms, just using "gl"-like
c CAFOR corresponds to "phi" in Traub et al., 1994
c Consistent set of units: nF, mV, ms, nA, microS

        PARAMETER (numcomp_p = 74)
        integer numcomp/numcomp_p/
! numcomp here must be comp. with numcomp_suppyrFRB in calling prog.
        REAL*8 C(numcomp_p),GL(numcomp_p), GAM(0:numcomp_p, 0:numcomp_p)
        REAL*8 GNAF(numcomp_p),GCAT(numcomp_p), GKAHP(numcomp_p)
        REAL*8 GKDR(numcomp_p),GKA(numcomp_p),GKC(numcomp_p)
        REAL*8 GK2(numcomp_p),GNAP(numcomp_p),GAR(numcomp_p)
        REAL*8 GKM(numcomp_p), gcal(numcomp_p), CDENS
        REAL*8 JACOB(numcomp_p,numcomp_p),RI_SD,RI_AXON,RM_SD,RM_AXON
        INTEGER LEVEL(numcomp_p)
        REAL*8 GNAF_DENS(0:12), GCAT_DENS(0:12), GKDR_DENS(0:12)
        REAL*8 GKA_DENS(0:12), GKC_DENS(0:12), GKAHP_DENS(0:12)
        REAL*8 GCAL_DENS(0:12), GK2_DENS(0:12), GKM_DENS(0:12)
        REAL*8 GNAP_DENS(0:12), GAR_DENS(0:12)
        REAL*8 RES, RINPUT, Z, ELEN(numcomp_p)
        REAL*8 RSOMA, PI, BETCHI(numcomp_p), CAFOR(numcomp_p)
        REAL*8 RAD(numcomp_p), LEN(numcomp_p), GAM1, GAM2
        REAL*8 RIN, D(numcomp_p), AREA(numcomp_p), RI
        INTEGER NEIGH(numcomp_p,11), NNUM(numcomp_p), i, j, k, it
C FOR ESTABLISHING TOPOLOGY OF COMPARTMENTS
        real*8 depth(12) ! depth in microns of levels 1-12, assuming soma in middle
! of layer 2/3 at depth 850 mu

        depth(1) = 850.d0
        depth(2) = 885.d0
        depth(3) = 920.d0
        depth(4) = 955.d0
        depth(5) = 825.d0
        depth(6) = 775.d0
        depth(7) = 725.d0
        depth(8) = 690.d0
        depth(9) = 655.d0
        depth(10) = 620.d0
        depth(11) = 585.d0
        depth(12) = 550.d0

        RI_SD = 250.d0
        RM_SD = 50000.d0
        RI_AXON = 100.d0
        RM_AXON = 1000.d0
        CDENS = 0.9d0

        PI = 3.14159d0

       do i = 0, 12
        gnaf_dens(i) = 10.d0
       end do
        gnaf_dens(0) = 400.d0
        gnaf_dens(1) = 150.d0
        gnaf_dens(2) =  75.d0
        gnaf_dens(5) = 100.d0
        gnaf_dens(6) =  75.d0

       do i = 0, 12
        gkdr_dens(i) = 5.d0
       end do
        gkdr_dens(0) = 400.d0
        gkdr_dens(1) = 100.d0
        gkdr_dens(2) =  75.d0
        gkdr_dens(5) = 100.d0
        gkdr_dens(6) =  75.d0

        gnap_dens(0) = 0.d0
        do i = 1, 12
          gnap_dens(i) = 0.0040d0 * gnaf_dens(i)
c         gnap_dens(i) = 0.002d0 * gnaf_dens(i)
c         gnap_dens(i) = 0.0030d0 * gnaf_dens(i)
        end do

        gcat_dens(0) = 0.d0
        do i = 1, 12
c         gcat_dens(i) = 0.5d0
          gcat_dens(i) = 0.1d0
        end do

        gcaL_dens(0) = 0.d0
        do i = 1, 6
          gcaL_dens(i) = 1.d0
        end do
        do i = 7, 12
          gcaL_dens(i) = 1.0d0
        end do

       do i = 0, 12
        gka_dens(i) = 2.d0
       end do
        gka_dens(1) = 30.d0
        gka_dens(5) = 30.d0

      do i = 0, 12
c        gkc_dens(i)  = 12.00d0
         gkc_dens(i)  =  7.50d0
c        gkc_dens(i)  =  2.00d0
c        gkc_dens(i)  =  7.00d0
      end do
         gkc_dens(0) =  0.00d0

        gkm_dens(0) = 0.d0
        do i = 1, 12
         gkm_dens(i) = 2.5d0 * 1.50d0
        end do

        do i = 0, 12
c       gk2_dens(i) = 1.d0
        gk2_dens(i) = 0.1d0
        end do

        gkahp_dens(0) = 0.d0
        do i = 1, 12
c        gkahp_dens(i) = 0.200d0
         gkahp_dens(i) = 0.100d0
c        gkahp_dens(i) = 0.050d0
        end do

        gar_dens(0) = 0.d0
        do i = 1, 12
         gar_dens(i) = 0.25d0
        end do

c       WRITE   (6,9988)
9988    FORMAT(2X,'I',4X,'NADENS',' CADENS(T)',' KDRDEN',' KAHPDE',
     X     ' KCDENS',' KADENS')
        DO 9989, I = 0, 12
c         WRITE (6,9990) I, gnaf_dens(i), gcat_dens(i), gkdr_dens(i),
c    X  gkahp_dens(i), gkc_dens(i), gka_dens(i)
9990    FORMAT(2X,I2,2X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2)
9989    CONTINUE


        level(1) = 1
        do i = 2, 13
         level(i) = 2
        end do
        do i = 14, 25
           level(i) = 3
        end do
        do i = 26, 37
           level(i) = 4
        end do
        level(38) = 5
        level(39) = 6
        level(40) = 7
        level(41) = 8
        level(42) = 8
        level(43) = 9
        level(44) = 9
        do i = 45, 52
           level(i) = 10
        end do
        do i = 53, 60
           level(i) = 11
        end do
        do i = 61, 68
           level(i) = 12
        end do

        do i =  69, 74
         level(i) = 0
        end do

c connectivity of axon
        nnum( 69) = 2
        nnum( 70) = 3
        nnum( 71) = 3
        nnum( 73) = 3
        nnum( 72) = 1
        nnum( 74) = 1
         neigh(69,1) =  1
         neigh(69,2) = 70
         neigh(70,1) = 69
         neigh(70,2) = 71
         neigh(70,3) = 73
         neigh(71,1) = 70
         neigh(71,2) = 72
         neigh(71,3) = 73
         neigh(73,1) = 70
         neigh(73,2) = 71
         neigh(73,3) = 74
         neigh(72,1) = 71
         neigh(74,1) = 73

c connectivity of SD part
          nnum(1) = 10
          neigh(1,1) = 69
          neigh(1,2) =  2
          neigh(1,3) =  3
          neigh(1,4) =  4
          neigh(1,5) =  5
          neigh(1,6) =  6
          neigh(1,7) =  7
          neigh(1,8) =  8
          neigh(1,9) =  9
          neigh(1,10) = 38

          do i = 2, 9
           nnum(i) = 2
           neigh(i,1) = 1
           neigh(i,2) = i + 12
          end do

          do i = 14, 21
            nnum(i) = 2
            neigh(i,1) = i - 12
            neigh(i,2) = i + 12
          end do

          do i = 26, 33
            nnum(i) = 1
            neigh(i,1) = i - 12
          end do

          do i = 10, 13
            nnum(i) = 2
            neigh(i,1) = 38
            neigh(i,2) = i + 12
          end do

          do i = 22, 25
            nnum(i) = 2
            neigh(i,1) = i - 12
            neigh(i,2) = i + 12
          end do

          do i = 34, 37
            nnum(i) = 1
            neigh(i,1) = i - 12
          end do

          nnum(38) = 6
          neigh(38,1) = 1
          neigh(38,2) = 39
          neigh(38,3) = 10
          neigh(38,4) = 11
          neigh(38,5) = 12
          neigh(38,6) = 13

          nnum(39) = 2
          neigh(39,1) = 38
          neigh(39,2) = 40

          nnum(40) = 3
          neigh(40,1) = 39
          neigh(40,2) = 41
          neigh(40,3) = 42

          nnum(41) = 3
          neigh(41,1) = 40
          neigh(41,2) = 42
          neigh(41,3) = 43

          nnum(42) = 3
          neigh(42,1) = 40
          neigh(42,2) = 41
          neigh(42,3) = 44

           nnum(43) = 5
           neigh(43,1) = 41
           neigh(43,2) = 45
           neigh(43,3) = 46
           neigh(43,4) = 47
           neigh(43,5) = 48

           nnum(44) = 5
           neigh(44,1) = 42
           neigh(44,2) = 49
           neigh(44,3) = 50
           neigh(44,4) = 51
           neigh(44,5) = 52

           nnum(45) = 5
           neigh(45,1) = 43
           neigh(45,2) = 53
           neigh(45,3) = 46
           neigh(45,4) = 47
           neigh(45,5) = 48

           nnum(46) = 5
           neigh(46,1) = 43
           neigh(46,2) = 54
           neigh(46,3) = 45
           neigh(46,4) = 47
           neigh(46,5) = 48

           nnum(47) = 5
           neigh(47,1) = 43
           neigh(47,2) = 55
           neigh(47,3) = 45
           neigh(47,4) = 46
           neigh(47,5) = 48

           nnum(48) = 5
           neigh(48,1) = 43
           neigh(48,2) = 56
           neigh(48,3) = 45
           neigh(48,4) = 46
           neigh(48,5) = 47

           nnum(49) = 5
           neigh(49,1) = 44
           neigh(49,2) = 57
           neigh(49,3) = 50
           neigh(49,4) = 51
           neigh(49,5) = 52

           nnum(50) = 5
           neigh(50,1) = 44
           neigh(50,2) = 58
           neigh(50,3) = 49
           neigh(50,4) = 51
           neigh(50,5) = 52

           nnum(51) = 5
           neigh(51,1) = 44
           neigh(51,2) = 59
           neigh(51,3) = 49
           neigh(51,4) = 50
           neigh(51,5) = 52

           nnum(52) = 5
           neigh(52,1) = 44
           neigh(52,2) = 60
           neigh(52,3) = 49
           neigh(52,4) = 51
           neigh(52,5) = 50

          do i = 53, 60
           nnum(i) = 2
           neigh(i,1) = i - 8
           neigh(i,2) = i + 8
          end do

          do i = 61, 68
           nnum(i) = 1
           neigh(i,1) = i - 8
          end do

c        DO 332, I = 1, 74
         DO I = 1, 74
c          WRITE(6,3330) I, NEIGH(I,1),NEIGH(I,2),NEIGH(I,3),NEIGH(I,4),
c    X NEIGH(I,5),NEIGH(I,6),NEIGH(I,7),NEIGH(I,8),NEIGH(I,9),
c    X NEIGH(I,10)
3330     FORMAT(2X,11I5)
         END DO
332      CONTINUE
c         DO 858, I = 1, 74
          DO I = 1, 74
c          DO 858, J = 1, NNUM(I)
           DO J = 1, NNUM(I)
            K = NEIGH(I,J)
            IT = 0
c           DO 859, L = 1, NNUM(K)
            DO  L = 1, NNUM(K)
             IF (NEIGH(K,L).EQ.I) IT = 1
            END DO
859         CONTINUE
             IF (IT.EQ.0) THEN
c             WRITE(6,8591) I, K
8591          FORMAT(' ASYMMETRY IN NEIGH MATRIX ',I4,I4)
              STOP
             ENDIF
          END DO
          END DO
858       CONTINUE

c length and radius of axonal compartments
c Note shortened "initial segment"
          len(69) = 25.d0
          do i = 70, 74
            len(i) = 50.d0
          end do
          rad( 69) = 0.90d0
c         rad( 69) = 0.80d0
          rad( 70) = 0.7d0
          do i = 71, 74
           rad(i) = 0.5d0
          end do

c  length and radius of SD compartments
          len(1) = 15.d0
          rad(1) =  8.d0

          do i = 2, 68
           len(i) = 50.d0
          end do

          do i = 2, 37
            rad(i) = 0.5d0
          end do

          z = 4.0d0
          rad(38) = z
          rad(39) = 0.9d0 * z
          rad(40) = 0.8d0 * z
          rad(41) = 0.5d0 * z
          rad(42) = 0.5d0 * z
          rad(43) = 0.5d0 * z
          rad(44) = 0.5d0 * z
          do i = 45, 68
           rad(i) = 0.2d0 * z
          end do


c       WRITE(6,919)
919     FORMAT('COMPART.',' LEVEL ',' RADIUS ',' LENGTH(MU)')
c       DO 920, I = 1, 74
c920      WRITE(6,921) I, LEVEL(I), RAD(I), LEN(I)
921     FORMAT(I3,5X,I2,3X,F6.2,1X,F6.1,2X,F4.3)

        DO 120, I = 1, 74
          AREA(I) = 2.d0 * PI * RAD(I) * LEN(I)
      if((i.gt.1).and.(i.le.68)) area(i) = 2.d0 * area(i)
C    CORRECTION FOR CONTRIBUTION OF SPINES TO AREA
          K = LEVEL(I)
          C(I) = CDENS * AREA(I) * (1.D-8)

           if (k.ge.1) then
          GL(I) = (1.D-2) * AREA(I) / RM_SD
           else
          GL(I) = (1.D-2) * AREA(I) / RM_AXON
           endif

          GNAF(I) = GNAF_DENS(K) * AREA(I) * (1.D-5)
          GNAP(I) = GNAP_DENS(K) * AREA(I) * (1.D-5)
          GCAT(I) = GCAT_DENS(K) * AREA(I) * (1.D-5)
          GKDR(I) = GKDR_DENS(K) * AREA(I) * (1.D-5)
          GKA(I) = GKA_DENS(K) * AREA(I) * (1.D-5)
          GKC(I) = GKC_DENS(K) * AREA(I) * (1.D-5)
          GKAHP(I) = GKAHP_DENS(K) * AREA(I) * (1.D-5)
          GKM(I) = GKM_DENS(K) * AREA(I) * (1.D-5)
          GCAL(I) = GCAL_DENS(K) * AREA(I) * (1.D-5)
          GK2(I) = GK2_DENS(K) * AREA(I) * (1.D-5)
          GAR(I) = GAR_DENS(K) * AREA(I) * (1.D-5)
c above conductances should be in microS
120           continue

         Z = 0.d0
c        DO 1019, I = 2, 68
         DO I = 2, 68
           Z = Z + AREA(I)
         END DO
1019     CONTINUE
c        WRITE(6,1020) Z
1020     FORMAT(2X,' TOTAL DENDRITIC AREA ',F7.0)

c       DO 140, I = 1, 74
        DO I = 1, 74
c       DO 140, K = 1, NNUM(I)
        DO K = 1, NNUM(I)
         J = NEIGH(I,K)
           if (level(i).eq.0) then
               RI = RI_AXON
           else
               RI = RI_SD
           endif
         GAM1 =100.d0 * PI * RAD(I) * RAD(I) / ( RI * LEN(I) )

           if (level(j).eq.0) then
               RI = RI_AXON
           else
               RI = RI_SD
           endif
         GAM2 =100.d0 * PI * RAD(J) * RAD(J) / ( RI * LEN(J) )
         GAM(I,J) = 2.d0/( (1.d0/GAM1) + (1.d0/GAM2) )
	 END DO
	 END DO

140     CONTINUE
c gam computed in microS

c       DO 299, I = 1, 74
        DO I = 1, 74
299       BETCHI(I) = .05d0
        END DO
        BETCHI( 1) =  .01d0

c       DO 300, I = 1, 74
        DO I = 1, 74
c300     D(I) = 2.D-4
300     D(I) = 5.D-4
        END DO
c       DO 301, I = 1, 74
        DO I = 1, 74
         IF (LEVEL(I).EQ.1) D(I) = 2.D-3
        END DO
301     CONTINUE
C  NOTE NOTE NOTE  (DIFFERENT FROM SWONG)


c      DO 160, I = 1, 74
       DO I = 1, 74
160     CAFOR(I) = 5200.d0 / (AREA(I) * D(I))
       END DO
C     NOTE CORRECTION

c       do 200, i = 1, 74
        do i = 1, numcomp
200     C(I) = 1000.d0 * C(I)
        end do
C     TO GO FROM MICROF TO NF.

c     DO 909, I = 1, 74
      DO I = 1, numcomp
       JACOB(I,I) = - GL(I)
c     DO 909, J = 1, NNUM(I)
      DO J = 1, NNUM(I)
         K = NEIGH(I,J)
         IF (I.EQ.K) THEN
c            WRITE(6,510) I
510          FORMAT(' UNEXPECTED SYMMETRY IN NEIGH ',I4)
         ENDIF
         JACOB(I,K) = GAM(I,K)
         JACOB(I,I) = JACOB(I,I) - GAM(I,K)
       END DO
       END DO
909   CONTINUE

c 15 Jan. 2001: make correction for c(i)
          do i = 1, numcomp
          do j = 1, numcomp
             jacob(i,j) = jacob(i,j) / c(i)
          end do
          end do

c      DO 500, I = 1, 74
       DO I = 1, 74
c       WRITE (6,501) I,C(I)
501     FORMAT(1X,I3,' C(I) = ',F7.4)
       END DO
500     CONTINUE
        END

