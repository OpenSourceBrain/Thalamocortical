c 3 Nov. 2003, modify layVrsp.f (layer 5 nontufted. pyr cell with thin
c apical dendrite), for use in groucho.f

c 14 May 2003.  Copy program from Rose and modify for mpi.
c 19 June 2001. Taken from scortpd.f.  Parallel.
c 19 June 2001: layer V RS cell with "thin" dendrite, no apical tuft.
c See Kim & Connors, Mason & Larkman.
c 44 SD compartments, 6 axonal, total 50.
c 5 basal and 6 apical oblique dendrites, each with 3 compartments.
c 10-compartment apical dendrite, no branches (apart from obliques)

c 13 April 2001, version of scortp.f, for looking at dendritic activities.
c  7 April 2001, parallel version of scort.f
c 30 March 2001: layer 2/3 pyramidal cell, with geometry (as much as
c possible) from Guy Major thesis; start with tcr.f.
c Total 74 compartments: 6 axon.  8 basal and 3 oblique dendrites, each
c with 3 compartments: apical shaft and branch; 8 3-segment pieces in
c the "apical tuft".

c Revised tcr.f, using modifications developed in short.f
c 22 Feb. 2001: alter persistent gNaP to have lower threshold and
c 1st power activation; in addition, try increasing activation
c threshold of fast gNa, as per Parri & Crunelli 1998.
c 25 Jan. 2001, single TCR cell, modification of nrt.f
c TCR cell has 10 short dendrites, each with 13 compartments.
c Soma is compartment 1; axon is 132-137, with structure as in
c  nRT cell model.  Each dendrite has 2 layers of trifurcations.

c 28 Dec. 2000, begin converting interneuron program to nRT cell.
c Soma will be comp. 1.  4 equivalent dendrites, each with 13 comps.
c (so 53 SD compartments).  Branching axon with 6 compartments - 59
c compartments in all.  Try one integration program for whole structure.
c Currents: leak, fast Na (naf), persistent Na (nap), fast DR (kdr),
c A-current (ka), K2 current, M-current (km), C current (kc), AHP
c (kahp), T-current (cat), high-thresh. Ca (CAL), h-current = anomalous
c rectifier (ar).

         SUBROUTINE integrate_nontuftRS (O, time, numcell, V, curr,
     &    gAMPA, gNMDA, gGABA_A, Mg, gapcon, totaxgj, gjtable, dt,
     &  chi,mnaf,mnap,
     &  hnaf,mkdr,mka,
     &  hka,mk2,hk2,
     &  mkm,mkc,mkahp,
     &  mcat,hcat,mcal,
     &  mar,field_1mm,field_2mm)

         SAVE

         parameter (numcomp_p = 50)
c numcomp = number of compartments, including 6 in the axon.
         integer numcomp /numcomp_p/
       integer numcell, totaxgj, gjtable(totaxgj,4)
       INTEGER J1, I, J, K, L, O, k0, K1, k2
       REAL*8  Z, Z1, Z2, Z3, curr(numcomp_p,numcell)
       REAL*8  mg, time, gapcon, dt, c(numcomp_p)

c CINV is 1/C, i.e. inverse capacitance

       real*8 v(numcomp_p,numcell),chi(numcomp_p,numcell),
     x  mnaf(numcomp_p,numcell),mnap(numcomp_p,numcell),
     x hnaf(numcomp_p,numcell),mkdr(numcomp_p,numcell),
     x mka(numcomp_p,numcell),hka(numcomp_p,numcell),
     x mk2(numcomp_p,numcell), cinv(numcomp_p),
     x hk2(numcomp_p,numcell),mkm(numcomp_p,numcell),
     x mkc(numcomp_p,numcell),mkahp(numcomp_p,numcell),
     x mcat(numcomp_p,numcell),hcat(numcomp_p,numcell),
     x mcal(numcomp_p,numcell),
     x mar(numcomp_p,numcell),
     x jacob(numcomp_p,numcomp_p),betchi(numcomp_p),
     x gam(0: numcomp_p,0: numcomp_p),gL(numcomp_p),gnaf(numcomp_p),
     x gnap(numcomp_p),gkdr(numcomp_p),gka(numcomp_p),
     x gk2(numcomp_p),gkm(numcomp_p),gkc(numcomp_p),gkahp(numcomp_p),
     x gcat(numcomp_p),gcaL(numcomp_p),gar(numcomp_p),
     x gampa(numcomp_p,numcell),gnmda(numcomp_p,numcell),
     x ggaba_a(numcomp_p,numcell),cafor(numcomp_p)

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
       real*8 outrcd(20), A, BB1, BB2

        INTEGER NEIGH(numcomp_p, 11), NNUM(numcomp_p)

c the f's are the functions giving 1st derivatives for evolution of
c the differential equations for the voltages (v), calcium (chi), and
c other state variables.
       real*8 fv(numcomp_p), fchi(numcomp_p),
     x fmnaf(numcomp_p),fhnaf(numcomp_p),fmkdr(numcomp_p),
     x fmka(numcomp_p),fhka(numcomp_p),fmar(numcomp_p),
     x fmk2(numcomp_p),fhk2(numcomp_p),fmnap(numcomp_p),
     x fmkm(numcomp_p),fmkc(numcomp_p),fmkahp(numcomp_p),
     x fmcat(numcomp_p),fhcat(numcomp_p),fmcal(numcomp_p)

c below are for calculating the partial derivatives
       real*8 dfv_dv(numcomp_p,numcomp_p), dfv_dchi(numcomp_p),
     x    dfv_dmnaf(numcomp_p),
     x    dfv_dmnap(numcomp_p),
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
       REAL*8 gna_tot(numcomp_p),gk_tot(numcomp_p)
       REAL*8 gca_tot(numcomp_p),gar_tot(numcomp_p)
       REAL*8 gca_high(numcomp_p)
c this will be gCa conductance corresponding to high-thresh channels
       real*8 depth(14), membcurr(14), field_1mm, field_2mm
       integer level(numcomp_p)

       double precision:: persistentNa_shift, fastNa_shift

c Do initialization on 1st time step
        if (O.eq.1) then

c Program assumes A, BB1, BB2 defined in calling program
c as follows:
         A = DEXP(-2.847d0)
         BB1 = DEXP(-.693d0)
         BB2 = DEXP(-3.101d0)

       CALL  nontuftRS_SETUP
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

        CALL nontuftRSMAJ (GL,GAM,GKDR,GKA,GKC,GKAHP,GK2,GKM,
     X              GCAT,GCAL,GNAF,GNAP,GAR,
     X    CAFOR,JACOB,C,BETCHI,NEIGH,NNUM,depth,level)

          do i = 1, numcomp
             cinv(i) = 1.d0 / c(i)
             vL(i) = -70.d0
             vK(i) = -95.d0
          end do


        VNA = 50.d0
        VCA = 125.d0
        VAR = -43.d0
        VAR = -35.d0
c -43 mV from Huguenard & McCormick
c       VGABA_A = -81.d0
        VGABA_A = -75.d0


c ? initialize membrane state variables?
      do i = 1, numcomp
      do j= 1, numcell
             v(i,j) = VL(I)

        k1 = idnint (4.d0 * (v(1,j) + 120.d0))
       IF (K1.GT.640) K1 = 640
       IF (K1.LT.  0) K1 =   0

      hnaf(i,j) = alphah_naf(k1)/(alphah_naf(k1)+betah_naf(k1))
      hka(i,j) = alphah_ka(k1)/(alphah_ka(k1)+betah_ka(k1))
      hk2(i,j)  = alphah_k2(k1)/(alphah_k2(k1)+betah_k2(k1))
      hcat(i,j)=alphah_cat(k1)/(alphah_cat(k1)+betah_cat(k1))
c     mar=alpham_ar(k1)/(alpham_ar(k1)+betam_ar(k1))
      mar(i,j) = .25d0
      mnaf(i,j) = 0.d0 ! = 0.d0
      mkdr(i,j) = 0.d0 ! = 0.d0
      mka(i,j) = 0.d0 ! = 0.d0
      mk2(i,j) = 0.d0 ! = 0.d0
      mkm(i,j) = 0.d0 ! = 0.d0
      mkc(i,j) = 0.d0 ! = 0.d0
      mkahp(i,j) = 0.d0 ! = 0.d0
      mcat(i,j) = 0.d0 ! = 0.d0
      mcal(i,j) = 0.d0 ! = 0.d0
      mnap(i,j) = 0.d0 ! = 0.d0
      chi(i,j) = 0.d0

      end do
      end do



           z1 = 0.10d0
           z2 = 2.0d0
c This should give an RS cell?

             do i = 1, numcomp
         gnap(i) = z1 * gnap(i)
         gkc (i) = z2 * gkc (i)
             end do

      endif !  End initialization

             do i = 1, 14
              membcurr(i) = 0.d0
             end do

          do L = 1, numcell

       DO 301, I = 1, numcomp
          FV(I) = -GL(I) * (V(I,L) - VL(i)) * cinv(i)
          DO 302, J = 1, NNUM(I)
             K = NEIGH(I,J)
302     FV(I) = FV(I) + GAM(I,K) * (V(K,L) - V(I,L)) * cinv(i)
301    CONTINUE


        CALL FNMDA (V, OPEN, numcell, numcomp, MG, L, 
     &    A, BB1, BB2)

      DO 421, I = 1, numcomp
       FV(I) = FV(I) + ( CURR(I,L)
     X   - (gampa(I,L) + open(i) * gnmda(I,L))*V(I,L)
     X   - ggaba_a(I,L)*(V(I,L)-Vgaba_a) ) * cinv(i)
c above assumes equil. potential for AMPA & NMDA = 0 mV
421      continue

! gj code here

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

       do i = 1, numcomp
        gamma(i) = dmin1 (1.d0, .004d0 * chi(i,L))
        if (chi(i,L).le.250.d0) then
          gamma_prime(i) = .004d0
        else
          gamma_prime(i) = 0.d0
        endif
c         endif
       end do

      DO 88, I = 1, numcomp
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
        dfv_dmk2(i)  = - cinv(i)*gk2(i)*hk2(i,L)*(v(i,L)-vK(i))
        dfv_dhk2(i)  = - cinv(i)*gk2(i)*mk2(i,L)*(v(i,L)-vK(i))
        dfv_dmkm(i)  = - cinv(i) * gkm(i) * (v(i,L) - vK(i))
      dfv_dmkc(i) = - cinv(i) * gkc(i) * gamma(i)*(v(i,L)-vK(i))
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
c       alpham_ahp(i) = dmin1(0.2d-4 * chi(i),0.01d0)
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
     x                  -.001d0 * mkahp(i,L)
c    x                  -.010d0 * mkahp(i,L)
        dfmkahp_dmkahp(i) = - alpham_ahp(i) - .001d0
c       dfmkahp_dmkahp(i) = - alpham_ahp(i) - .010d0
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
          do i = 1, 6
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 13, 17
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 24, 28
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do
          do i = 35, 44
           j = level(i)
           membcurr(j) = membcurr(j) + fv(i) * c(i)
          end do

           end do ! do L

         field_1mm = 0.d0
         field_2mm = 0.d0

         do i = 1, 14
          field_1mm = field_1mm + membcurr(i) / dabs(1000.d0 - depth(i))
          field_2mm = field_2mm + membcurr(i) / dabs(2000.d0 - depth(i))
         end do

              END

        SUBROUTINE nontuftRSMAJ
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

        parameter (numcomp_p = 50)
        integer numcomp/numcomp_p/
        REAL*8 C(numcomp_p),GL(numcomp_p),GAM(0:numcomp_p,0:numcomp_p)
        REAL*8 GNAF(numcomp_p),GCAT(numcomp_p)
        REAL*8 GKDR(numcomp_p),GKA(numcomp_p),GKC(numcomp_p)
        REAL*8 GKAHP(numcomp_p),GCAL(numcomp_p)
        REAL*8 GK2(numcomp_p),GKM(numcomp_p),GNAP(numcomp_p),
     x  GAR(numcomp_p)
        REAL*8 JACOB(numcomp_p,numcomp_p),RI_SD,RI_AXON,RM_SD,RM_AXON
        INTEGER LEVEL(numcomp_p)
        REAL*8 GNAF_DENS(0:14), GCAT_DENS(0:14), GKDR_DENS(0:14)
        REAL*8 GKA_DENS(0:14), GKC_DENS(0:14), GKAHP_DENS(0:14)
        REAL*8 GCAL_DENS(0:14), GK2_DENS(0:14), GKM_DENS(0:14)
        REAL*8 GNAP_DENS(0:14), GAR_DENS(0:14)
        REAL*8 RES, RINPUT, CDENS
        REAL*8 RSOMA, PI, BETCHI(numcomp_p), CAFOR(numcomp_p)
        REAL*8 RAD(numcomp_p),LEN(numcomp_p),GAM1,GAM2,ELEN(numcomp_p)
        REAL*8 RIN, D(numcomp_p), AREA(numcomp_p), RI, Z
        INTEGER NEIGH(numcomp_p, 11), NNUM(numcomp_p)
C FOR ESTABLISHING TOPOLOGY OF COMPARTMENTS
        real*8 depth(14) ! in microns, subscript refers to level

        depth(1) = 2200.d0
        depth(2) = 2245.d0
        depth(3) = 2290.d0
        depth(4) = 2335.d0
        depth(5) = 2175.d0
        depth(6) = 2125.d0
        depth(7) = 2075.d0
        depth(8) = 2025.d0
        depth(9) = 1975.d0
        depth(10) = 1925.d0
        depth(11) = 1875.d0
        depth(12) = 1825.d0
        depth(13) = 1775.d0
        depth(14) = 1725.d0

        RI_SD = 250.d0
        RM_SD = 50000.d0
        RI_AXON = 100.d0
        RM_AXON = 1000.d0
        CDENS = 0.9d0

        PI = 3.14159d0

!        gnaf_dens =  5.d0 ! this orig code replaced by below for compatibility
        do i=0,14
        gnaf_dens(i) =  5.d0
        end do

c       gnaf_dens = 10.d0
        gnaf_dens(0) = 450.d0
        gnaf_dens(1) = 200.d0
        gnaf_dens(2) =  75.d0
        gnaf_dens(5) = 150.d0
        gnaf_dens(6) =  75.d0

!        gkdr_dens = 0.d0
        do i=0,14
        gkdr_dens(i) =  0.d0
        end do

        gkdr_dens(0) = 450.d0
        gkdr_dens(1) = 170.d0
        gkdr_dens(2) =  75.d0
        gkdr_dens(5) = 120.d0
        gkdr_dens(6) =  75.d0

        do i = 1, 14
          gnap_dens(i) = 0.0040d0 * gnaf_dens(i)
        end do

        do i = 1, 14
          gcat_dens(i) = 0.1d0
        end do

        do i = 1, 9
          gcaL_dens(i) = 0.20d0
        end do
        do i = 10, 14
          gcaL_dens(i) = 2.0d0
        end do

!       gka_dens    = 4.d0 ! original code replaced by below for compatibility
        do i=0,14
           gka_dens(i)    = 4.d0
        end do

        gka_dens(1) = 35.d0
        gka_dens(5) = 35.d0
        do i = 1, 14
          gka_dens(i) = 3.4d0 * gka_dens(i)
        end do

!        gkc_dens = 0.00d0
        do i=0, 14
           gkc_dens(i) = 0.00d0
        end do
        gkc_dens(1) =  7.50d0
         gkc_dens(2) =  7.50d0
         gkc_dens(5) =  7.50d0
         gkc_dens(6) =  7.50d0

        do i = 1, 14
c        gkm_dens(i) = 1.4d0 * 1.50d0
         gkm_dens(i) = 2.8d0 * 1.50d0
         gk2_dens(i) = 0.1d0
        end do

!        gk2_dens    = 0.1d0
        do i=0,14
          gk2_dens(i)    = 0.1d0
        end do

        do i = 1, 14
c        gkahp_dens(i) = 0.100d0
         gkahp_dens(i) = 0.200d0
        end do

        do i = 1, 14
         gar_dens(i) = 0.25d0
        end do

c        if (thisno.eq.0) then
c       WRITE   (6,9988)
9988    FORMAT(2X,'I',4X,'NADENS',' CADENS(L)',' KDRDEN',' KAHPDE',
     X     ' KCDENS',' KADENS')
        DO 9989, I = 0, 14
c         WRITE (6,9990) I, gnaf_dens(i), gcaL_dens(i), gkdr_dens(i),
c    X  gkahp_dens(i), gkc_dens(i), gka_dens(i)
9990    FORMAT(2X,I2,2X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2)
9989    CONTINUE
c         endif


        level(1) = 1
        do i = 2, 12
         level(i) = 2
        end do
        do i = 13, 23
           level(i) = 3
        end do
        do i = 24, 34
           level(i) = 4
        end do
        level(35) = 5
        level(36) = 6
        level(37) = 7
        level(38) = 8
        level(39) = 9
        level(40) = 10
        level(41) = 11
        level(42) = 12
        level(43) = 13
        level(44) = 14

        do i =  45, 50
         level(i) = 0
        end do

c connectivity of axon
        nnum( 45) = 2
        nnum( 46) = 3
        nnum( 47) = 3
        nnum( 49) = 3
        nnum( 48) = 1
        nnum( 50) = 1
         neigh(45,1) =  1
         neigh(45,2) = 46
         neigh(46,1) = 45
         neigh(46,2) = 47
         neigh(46,3) = 49
         neigh(47,1) = 46
         neigh(47,2) = 48
         neigh(47,3) = 49
         neigh(49,1) = 46
         neigh(49,2) = 47
         neigh(49,3) = 50
         neigh(48,1) = 47
         neigh(50,1) = 49

c connectivity of SD part
          nnum(1) = 7
          neigh(1,1) = 45
          neigh(1,2) =  2
          neigh(1,3) =  3
          neigh(1,4) =  4
          neigh(1,5) =  5
          neigh(1,6) =  6
          neigh(1,7) = 35

          do i = 2, 6
           nnum(i) = 2
           neigh(i,1) = 1
           neigh(i,2) = i + 11
          end do

          do i = 13, 17
            nnum(i) = 2
            neigh(i,1) = i - 11
            neigh(i,2) = i + 11
          end do

          do i = 24, 28
            nnum(i) = 1
            neigh(i,1) = i - 11
          end do

          do i =  7, 12
            nnum(i) = 2
      if ((i.eq.7).or.(i.eq.12)) neigh(i,1) = 35
      if ((i.eq.8).or.(i.eq.11)) neigh(i,1) = 36
      if ((i.eq.9).or.(i.eq.10)) neigh(i,1) = 37
            neigh(i,2) = i + 11
          end do

          do i = 18, 23
            nnum(i) = 2
            neigh(i,1) = i - 11
            neigh(i,2) = i + 11
          end do

          do i = 29, 34
            nnum(i) = 1
            neigh(i,1) = i - 11
          end do

          nnum(35) = 4
          neigh(35,1) = 1
          neigh(35,2) = 36
          neigh(35,3) =  7
          neigh(35,4) = 12

          nnum(36) = 4
          neigh(36,1) = 35
          neigh(36,2) = 37
          neigh(36,3) =  8
          neigh(36,4) = 11

          nnum(37) = 4
          neigh(37,1) = 36
          neigh(37,2) = 38
          neigh(37,3) =  9
          neigh(37,4) = 10

          nnum(38) = 2
          neigh(38,1) = 37
          neigh(38,2) = 39

          nnum(39) = 2
          neigh(39,1) = 38
          neigh(39,2) = 40

          nnum(40) = 2
          neigh(40,1) = 39
          neigh(40,2) = 41

          nnum(41) = 2
          neigh(41,1) = 40
          neigh(41,2) = 42

          nnum(42) = 2
          neigh(42,1) = 41
          neigh(42,2) = 43

          nnum(43) = 2
          neigh(43,1) = 42
          neigh(43,2) = 44

          nnum(44) = 1
          neigh(44,1) = 43

c           if (thisno.eq.0) then
         DO 332, I = 1, numcomp
c          WRITE(6,3330) I, NEIGH(I,1),NEIGH(I,2),NEIGH(I,3),NEIGH(I,4),
c    X NEIGH(I,5),NEIGH(I,6),NEIGH(I,7)
3330     FORMAT(2X, 8I5)
332      CONTINUE
c            endif

          DO 858, I = 1, numcomp
           DO 858, J = 1, NNUM(I)
            K = NEIGH(I,J)
            IT = 0
            DO 859, L = 1, NNUM(K)
             IF (NEIGH(K,L).EQ.I) IT = 1
859         CONTINUE
             IF (IT.EQ.0) THEN
c             WRITE(6,8591) I, K
8591          FORMAT(' ASYMMETRY IN NEIGH MATRIX ',I4,I4)
              STOP
             ENDIF
858       CONTINUE

c length and radius of axonal compartments
c Note shortened "initial segment"
          len(45) = 25.d0
          do i = 46, 50
            len(i) = 50.d0
          end do
          rad( 45) = 0.90d0
          rad( 46) = 0.7d0
          do i = 47, 50
           rad(i) = 0.5d0
          end do

c  length and radius of SD compartments
          len(1) = 20.d0
          rad(1) =  8.d0

          do i = 2, 34
           len(i) = 60.d0
          end do

          do i = 35, 44
           len(i) = 50.d0
          end do

          do i = 2, 6
            rad(i) = 0.85d0
          end do
          do i = 13, 17
            rad(i) = 0.85d0
          end do
          do i = 24, 28
            rad(i) = 0.85d0
          end do

          do i = 7, 12
            rad(i) = 0.62d0
          end do
          do i = 18, 23
            rad(i) = 0.62d0
          end do
          do i = 29, 34
            rad(i) = 0.62d0
          end do

          rad(35) = 1.5d0
          rad(36) = 1.4d0
          rad(37) = 1.3d0
          rad(38) = 1.2d0
          rad(39) = 1.1d0
          rad(40) = 1.0d0
          rad(41) = 0.9d0
          rad(42) = 0.8d0
          rad(43) = 0.7d0
          rad(44) = 0.6d0


c            if (thisno.eq.0) then
        WRITE(6,919)
919     FORMAT('COMPART.',' LEVEL ',' RADIUS ',' LENGTH(MU)')
c       DO 920, I = 1, numcomp
c920      WRITE(6,921) I, LEVEL(I), RAD(I), LEN(I)
921     FORMAT(I3,5X,I2,3X,F6.2,1X,F6.1,2X,F4.3)
c            endif

        DO 120, I = 1, numcomp
          AREA(I) = 2.d0 * PI * RAD(I) * LEN(I)
      if((i.gt.1).and.(i.le.44)) area(i) = 2.d0 * area(i)
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
          GCAL(I) = GCAL_DENS(K) * AREA(I) * (1.D-5)
          GK2(I) = GK2_DENS(K) * AREA(I) * (1.D-5)
          GKM(I) = GKM_DENS(K) * AREA(I) * (1.D-5)
          GAR(I) = GAR_DENS(K) * AREA(I) * (1.D-5)
c above conductances should be in microS
120           continue

         Z = 0.d0
         DO 1019, I = 2, 44
           Z = Z + AREA(I)
1019     CONTINUE
c             if (thisno.eq.1) then
c        WRITE(6,1020) Z
c              endif
1020     FORMAT(2X,' TOTAL DENDRITIC AREA ',F7.0)

        DO 140, I = 1, numcomp
        DO 140, K = 1, NNUM(I)
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
140     CONTINUE
c gam computed in microS

        DO 299, I = 1, numcomp
299       BETCHI(I) = .05d0
        BETCHI( 1) =  .01d0

        DO 300, I = 1, numcomp
300     D(I) = 4.D-4
        DO 301, I = 1, numcomp
         IF (LEVEL(I).EQ.1) D(I) = 4.D-3
301     CONTINUE


       DO 160, I = 1, numcomp
160     CAFOR(I) = 5200.d0 / (AREA(I) * D(I))
C     NOTE CORRECTION

        do 200, i = 1, numcomp
200     C(I) = 1000.d0 * C(I)
C     TO GO FROM MICROF TO NF.

      DO 909, I = 1, numcomp
       JACOB(I,I) = - GL(I)
      DO 909, J = 1, NNUM(I)
         K = NEIGH(I,J)
         IF (I.EQ.K) THEN
c            WRITE(6,510) I
510          FORMAT(' UNEXPECTED SYMMETRY IN NEIGH ',I4)
         ENDIF
         JACOB(I,K) = GAM(I,K)
         JACOB(I,I) = JACOB(I,I) - GAM(I,K)
909   CONTINUE

c 15 Jan. 2001: make correction for c(i)
          do i = 1, numcomp
          do j = 1, numcomp
             jacob(i,j) = jacob(i,j) / c(i)
          end do
          end do

c          if (thisno.eq.1) then
       DO 500, I = 1, numcomp
c       WRITE (6,501) I,C(I)
501     FORMAT(1X,I3,' C(I) = ',F7.4)
500     CONTINUE
c               endif

        END

C  SETS UP TABLES FOR RATE FUNCTIONS
       SUBROUTINE nontuftRS_SETUP
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

         do 2, i = 0, 639

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
2      CONTINUE
       END
