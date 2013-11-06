
! Integration program for nrt cells. 
! From dienf. : nrt_I cells, with low-threshold spikes                 

       SUBROUTINE integrate_nrt (O, time, numcell, V, curr,
     &  gAMPA, gNMDA, gGABA_A, Mg, gapcon, totaxgj, gjtable, dt,
     &  chi,mnaf,mnap,
     &  hnaf,mkdr,mka,
     &  hka,mk2,hk2,
     &  mkm,mkc,mkahp,
     &  mcat,hcat,mcal,
     &  mar)

           SAVE

       parameter (numcomp_p = 59)  ! should be compat. with calling prog
       integer numcomp/numcomp_p/
       INTEGER numcell, n, O, I, J, L, L1, totaxgj
       INTEGER gjtable(totaxgj,4)
       real*8 time, Mg, gapcon, dt
c L = cell number relative to entire system

c CINV is 1/C, i.e. inverse capacitance
       real*8 v(numcomp_p,numcell), chi(numcomp_p,numcell),
     x cinv(numcomp_p), mnaf(numcomp_p,numcell),
     x mnap(numcomp_p,numcell),
     x hnaf(numcomp_p,numcell), mkdr(numcomp_p,numcell),
     x mka(numcomp_p,numcell),hka(numcomp_p,numcell),
     x mk2(numcomp_p,numcell),hk2(numcomp_p,numcell),
     x mkm(numcomp_p,numcell),mkc(numcomp_p,numcell),
     x mkahp(numcomp_p,numcell),
     x mcat(numcomp_p,numcell),hcat(numcomp_p,numcell),
     x mcal(numcomp_p,numcell), betchi(numcomp_p),
     x mar(numcomp_p,numcell),jacob(numcomp_p,numcomp_p),
     x gam(0:numcomp_p,0:numcomp_p),gL(numcomp_p),gnaf(numcomp_p),
     x gnap(numcomp_p),gkdr(numcomp_p),gka(numcomp_p),
     x gk2(numcomp_p),gkm(numcomp_p),gkc(numcomp_p),gkahp(numcomp_p),
     x gcat(numcomp_p),gcaL(numcomp_p),gar(numcomp_p),
     x gampa(numcomp_p,numcell),gnmda(numcomp_p,numcell),
     x ggaba_a(numcomp_p,numcell),
     x curr(numcomp_p,numcell), cafor(numcomp_p),c(numcomp_p)
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

c the f's are the functions giving 1st derivatives for evolution of
c the differential equations for the voltages (v), calcium (chi), and
c other state variables.
       real*8 fv(numcomp_p), fchi(numcomp_p),fmnaf(numcomp_p),
     x fhnaf(numcomp_p),fmkdr(numcomp_p),
     x fmka(numcomp_p),fhka(numcomp_p),
     x fmk2(numcomp_p),fhk2(numcomp_p),
     x fmkm(numcomp_p),fmkc(numcomp_p),fmkahp(numcomp_p),
     x fmcat(numcomp_p),fhcat(numcomp_p),
     x fmcal(numcomp_p),fmar(numcomp_p)

c below are for calculating the partial derivatives
       real*8 dfv_dv(numcomp_p,numcomp_p), dfv_dchi(numcomp_p), 
     x  dfv_dmnaf(numcomp_p),
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
     x dfmkahp_dmkahp(numcomp_p), dt2, outrcd(20)

         REAL*8 vL,vk,vna,var,vca,vgaba_a,Z,Z1,Z2
         INTEGER  K1, NEIGH(numcomp_p,11), NNUM(numcomp_p)
         INTEGER level(numcomp_p)
       REAL*8 OPEN(numcomp_p),gamma(numcomp_p),gamma_prime(numcomp_p)
c gamma is function of chi used in calculating KC conductance
       REAL*8 alpham_ahp(numcomp_p), alpham_ahp_prime(numcomp_p)
       REAL*8 gna_tot(numcomp_p),gk_tot(numcomp_p)
       REAL*8 gca_tot(numcomp_p),gar_tot(numcomp_p)
       REAL*8 gca_high(numcomp_p)
c this will be gCa conductance corresponding to high-thresh channels
       double precision A, BB1, BB2

          if (O.eq.1) then
       CALL   NRT_SETUP_I
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

        CALL NRTMAJ_I (GL,GAM,GKDR,GKA,GKC,GKAHP,GK2,GKM,
     X              GCAT,GCAL,GNAF,GNAP,GAR,
     X    CAFOR,JACOB,C,BETCHI,NEIGH,NNUM,LEVEL)

          do i = 1, numcomp
             cinv(i) = 1.d0 / c(i)
          end do

        VL = -75.d0
        VK = -100.d0
        VNA = 50.d0
        VCA = 125.d0
        VAR = -40.d0
        VGABA_A = -75.d0

c ? initialize membrane state variables?
          do L = 1, numcell    
          do i = 1, numcomp
        v(i,L) = -75.d0

        k1 = idnint (4.d0 * (v(1,1) + 120.d0))

          chi(i,L) = 0.d0
       mnaf(i,L) = 0.d0
       mnap(i,L) = 0.d0
       mkdr(i,L) = 0.d0
       mka(i,L) = 0.d0
       mk2(i,L) = 0.d0
       mkm(i,L) = 0.d0
       mkc(i,L) = 0.d0
       mkahp(i,L) = 0.d0
       mcat(i,L) = 0.d0
       mcal(i,L) = 0.d0
       mar(i,L) = 0.d0

      hnaf(i,L) = alphah_naf(k1)/(alphah_naf(k1)+betah_naf(k1))
      hka(i,L) = alphah_ka(k1)/(alphah_ka(k1)+betah_ka(k1))
      hk2(i,L) = alphah_k2(k1)/(alphah_k2(k1)+betah_k2(k1))
      hcat(i,L) = alphah_cat(k1)/(alphah_cat(k1)+betah_cat(k1))

          end do
          end do

c Program assumes A, BB1, BB2 defined in calling program
c as follows:
         A = DEXP(-2.847d0)
         BB1 = DEXP(-.693d0)
         BB2 = DEXP(-3.101d0)
            endif

           do 4000, L = 1, numcell    

       DO 301, I = 1, numcomp
          FV(I) = -GL(I) * (V(I,L) - VL) * cinv(i)
          DO 302, J = 1, NNUM(I)
             K = NEIGH(I,J)
302     FV(I) = FV(I) + GAM(I,K) * (V(K,L) - V(I,L)) * cinv(i)
301    CONTINUE


        CALL FNMDA (V, OPEN, numcell, numcomp, MG, L, 
     &    A, BB1, BB2)

      DO 421, I = 1, numcomp
421    FV(I) = FV(I) + ( CURR(I,L)
     X   - (gampa(I,L) + open(i) * gnmda(I,L))*V(I,L)
     X   - ggaba_a(I,L)*(V(I,L)-Vgaba_a) ) * cinv(i)
c above assumes equil. potential for AMPA & NMDA = 0 mV

! gj code to follow here

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

cxx	All following L1 should be L. We can fix merely by...
	L1 = L

       do i = 1, numcomp
        gamma(i) = dmin1 (1.d0, .004d0 * chi(i,L1))
        if (chi(i,L1).le.250.d0) then
          gamma_prime(i) = .004d0
        else
          gamma_prime(i) = 0.d0
        endif
       end do

      DO 88, I = 1, numcomp
       gna_tot(i) = gnaf(i) * (mnaf(i,L1)**3) * hnaf(i,L1) +
     x     gnap(i) * (mnaf(i,L1)**3)
       gk_tot(i) = gkdr(i) * (mkdr(i,L1)**4) +
     x             gka(i)  * (mka(i,L1)**4) * hka(i,L1) +
     x             gk2(i)  * mk2(i,L1) * hk2(i,L1) +
     x             gkm(i)  * mkm(i,L1) +
     x             gkc(i)  * mkc(i,L1) * gamma(i) +
     x             gkahp(i)* mkahp(i,L1)
       gca_tot(i) = gcat(i) * (mcat(i,L1)**2) * hcat(i,L1) +
     x              gcaL(i) * (mcaL(i,L1)**2)
       gca_high(i) =
     x              gcaL(i) * (mcaL(i,L1)**2)
       gar_tot(i) = gar(i) * mar(i,L1)


88     FV(I) = FV(I) - ( gna_tot(i) * (v(i,L) - vna)
     X  + gk_tot(i) * (v(i,L) - vK)
     X  + gca_tot(i) * (v(i,L) - vCa)
     X  + gar_tot(i) * (v(i,L) - var) ) * cinv(i)

         do i = 1, numcomp
         do j = 1, numcomp
          if (i.ne.j) then
            dfv_dv(i,j) = jacob(i,j)
          else
            dfv_dv(i,j) = jacob(i,i) - cinv(i) *
     X  (gna_tot(i) + gk_tot(i) + gca_tot(i) + gar_tot(i)
     X    + ggaba_a(i,L) + gampa(i,L)
     X   + open(i) * gnmda(I,L) )
          endif
         end do
         end do

          do i = 1, numcomp
        dfv_dchi(i)  = - cinv(i) * gkc(i) * mkc(i,L1) *
     x                     gamma_prime(i) * (v(i,L)-vK)
        dfv_dmnaf(i) = -3.d0 * cinv(i) * (mnaf(i,L1)**2) *
     X    (gnaf(i) * hnaf(i,L1) + gnap(i)) * (v(i,L) - vna)
        dfv_dhnaf(i) = - cinv(i) * gnaf(i) * (mnaf(i,L1)**3) *
     X                    (v(i,L) - vna)
        dfv_dmkdr(i) = -4.d0 * cinv(i) * gkdr(i) * (mkdr(i,L1)**3)
     X                   * (v(i,L) - vK)
        dfv_dmka(i)  = -4.d0 * cinv(i) * gka(i) * (mka(i,L1)**3) *
     X                   hka(i,L1) * (v(i,L) - vK)
        dfv_dhka(i)  = - cinv(i) * gka(i) * (mka(i,L1)**4) *
     X                    (v(i,L) - vK)
        dfv_dmk2(i)  = - cinv(i) * gk2(i) * hk2(i,L1) * (v(i,L)-vK)
        dfv_dhk2(i)  = - cinv(i) * gk2(i) * mk2(i,L1) * (v(i,L)-vK)
        dfv_dmkm(i)  = - cinv(i) * gkm(i) * (v(i,L) - vK)
        dfv_dmkc(i)  = - cinv(i) * gkc(i) * gamma(i) * (v(i,L)-vK)
        dfv_dmkahp(i)= - cinv(i) * gkahp(i) * (v(i,L) - vK)
        dfv_dmcat(i)  = -2.d0 * cinv(i) * gcat(i) * mcat(i,L1) *
     X                    hcat(i,L1) * (v(i,L) - vCa)
        dfv_dhcat(i) = - cinv(i) * gcat(i) * (mcat(i,L1)**2) *
     X                  (v(i,L) - vCa)
        dfv_dmcal(i) = -2.d0 * cinv(i) * gcal(i) * mcal(i,L1) *
     X                      (v(i,L) - vCa)
        dfv_dmar(i) = - cinv(i) * gar(i) * (v(i,L) - var)
          end do

         do i = 1, numcomp
          fchi(i) = - cafor(i) * gca_high(i) * (v(i,L) - vca)
     x       - betchi(i) * chi(i,L1)
          dfchi_dv(i) = - cafor(i) * gca_high(i)
          dfchi_dchi(i) = - betchi(i)
         end do

       do i = 1, numcomp
        alpham_ahp(i) = dmin1(0.2d-4 * chi(i,L1),0.01d0)
        if (chi(i,L1).le.500.d0) then
          alpham_ahp_prime(i) = 0.2d-4
        else
          alpham_ahp_prime(i) = 0.d0
        endif
       end do

       do i = 1, numcomp
        fmkahp(i) = alpham_ahp(i) * (1.d0 - mkahp(i,L1))
     x                  -.001d0 * mkahp(i,L1)
        dfmkahp_dmkahp(i) = - alpham_ahp(i) - .001d0
        dfmkahp_dchi(i) = alpham_ahp_prime(i) *
     x                     (1.d0 - mkahp(i,L1))
       end do

          do i = 1, numcomp

       K1 = IDNINT ( 4.d0 * (V(I,L) + 120.d0) )
       IF (K1.GT.640) K1 = 640
       IF (K1.LT.  0) K1 =   0

        fmnaf(i) = alpham_naf(k1) * (1.d0 - mnaf(i,L1)) -
     X              betam_naf(k1) * mnaf(i,L1)
        fhnaf(i) = alphah_naf(k1) * (1.d0 - hnaf(i,L1)) -
     X              betah_naf(k1) * hnaf(i,L1)
        fmkdr(i) = alpham_kdr(k1) * (1.d0 - mkdr(i,L1)) -
     X              betam_kdr(k1) * mkdr(i,L1)
        fmka(i)  = alpham_ka (k1) * (1.d0 - mka(i,L1)) -
     X              betam_ka (k1) * mka(i,L1)
        fhka(i)  = alphah_ka (k1) * (1.d0 - hka(i,L1)) -
     X              betah_ka (k1) * hka(i,L1)
        fmk2(i)  = alpham_k2 (k1) * (1.d0 - mk2(i,L1)) -
     X              betam_k2 (k1) * mk2(i,L1)
        fhk2(i)  = alphah_k2 (k1) * (1.d0 - hk2(i,L1)) -
     X              betah_k2 (k1) * hk2(i,L1)
        fmkm(i)  = alpham_km (k1) * (1.d0 - mkm(i,L1)) -
     X              betam_km (k1) * mkm(i,L1)
        fmkc(i)  = alpham_kc (k1) * (1.d0 - mkc(i,L1)) -
     X              betam_kc (k1) * mkc(i,L1)
        fmcat(i) = alpham_cat(k1) * (1.d0 - mcat(i,L1)) -
     X              betam_cat(k1) * mcat(i,L1)
        fhcat(i) = alphah_cat(k1) * (1.d0 - hcat(i,L1)) -
     X              betah_cat(k1) * hcat(i,L1)
        fmcaL(i) = alpham_caL(k1) * (1.d0 - mcaL(i,L1)) -
     X              betam_caL(k1) * mcaL(i,L1)
        fmar(i)  = alpham_ar (k1) * (1.d0 - mar(i,L1)) -
     X              betam_ar (k1) * mar(i,L1)

       dfmnaf_dv(i) = dalpham_naf(k1) * (1.d0 - mnaf(i,L1)) -
     X                  dbetam_naf(k1) * mnaf(i,L1)
       dfhnaf_dv(i) = dalphah_naf(k1) * (1.d0 - hnaf(i,L1)) -
     X                  dbetah_naf(k1) * hnaf(i,L1)
       dfmkdr_dv(i) = dalpham_kdr(k1) * (1.d0 - mkdr(i,L1)) -
     X                  dbetam_kdr(k1) * mkdr(i,L1)
       dfmka_dv(i)  = dalpham_ka(k1) * (1.d0 - mka(i,L1)) -
     X                  dbetam_ka(k1) * mka(i,L1)
       dfhka_dv(i)  = dalphah_ka(k1) * (1.d0 - hka(i,L1)) -
     X                  dbetah_ka(k1) * hka(i,L1)
       dfmk2_dv(i)  = dalpham_k2(k1) * (1.d0 - mk2(i,L1)) -
     X                  dbetam_k2(k1) * mk2(i,L1)
       dfhk2_dv(i)  = dalphah_k2(k1) * (1.d0 - hk2(i,L1)) -
     X                  dbetah_k2(k1) * hk2(i,L1)
       dfmkm_dv(i)  = dalpham_km(k1) * (1.d0 - mkm(i,L1)) -
     X                  dbetam_km(k1) * mkm(i,L1)
       dfmkc_dv(i)  = dalpham_kc(k1) * (1.d0 - mkc(i,L1)) -
     X                  dbetam_kc(k1) * mkc(i,L1)
       dfmcat_dv(i) = dalpham_cat(k1) * (1.d0 - mcat(i,L1)) -
     X                  dbetam_cat(k1) * mcat(i,L1)
       dfhcat_dv(i) = dalphah_cat(k1) * (1.d0 - hcat(i,L1)) -
     X                  dbetah_cat(k1) * hcat(i,L1)
       dfmcaL_dv(i) = dalpham_caL(k1) * (1.d0 - mcaL(i,L1)) -
     X                  dbetam_caL(k1) * mcaL(i,L1)
       dfmar_dv(i)  = dalpham_ar(k1) * (1.d0 - mar(i,L1)) -
     X                  dbetam_ar(k1) * mar(i,L1)

       dfmnaf_dmnaf(i) =  - alpham_naf(k1) - betam_naf(k1)
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

        chi(i,L1) = chi(i,L1) + dt * fchi(i) + dt2 *
     X   (dfchi_dchi(i) * fchi(i) + dfchi_dv(i) * fv(i))
        mnaf(i,L1) = mnaf(i,L1) + dt * fmnaf(i) + dt2 *
     X   (dfmnaf_dmnaf(i) * fmnaf(i) + dfmnaf_dv(i)*fv(i))
        hnaf(i,L1) = hnaf(i,L1) + dt * fhnaf(i) + dt2 *
     X   (dfhnaf_dhnaf(i) * fhnaf(i) + dfhnaf_dv(i)*fv(i))
        mkdr(i,L1) = mkdr(i,L1) + dt * fmkdr(i) + dt2 *
     X   (dfmkdr_dmkdr(i) * fmkdr(i) + dfmkdr_dv(i)*fv(i))
        mka(i,L1) =  mka(i,L1) + dt * fmka(i) + dt2 *
     X   (dfmka_dmka(i) * fmka(i) + dfmka_dv(i) * fv(i))
        hka(i,L1) =  hka(i,L1) + dt * fhka(i) + dt2 *
     X   (dfhka_dhka(i) * fhka(i) + dfhka_dv(i) * fv(i))
        mk2(i,L1) =  mk2(i,L1) + dt * fmk2(i) + dt2 *
     X   (dfmk2_dmk2(i) * fmk2(i) + dfmk2_dv(i) * fv(i))
        hk2(i,L1) =  hk2(i,L1) + dt * fhk2(i) + dt2 *
     X   (dfhk2_dhk2(i) * fhk2(i) + dfhk2_dv(i) * fv(i))
        mkm(i,L1) =  mkm(i,L1) + dt * fmkm(i) + dt2 *
     X   (dfmkm_dmkm(i) * fmkm(i) + dfmkm_dv(i) * fv(i))
        mkc(i,L1) =  mkc(i,L1) + dt * fmkc(i) + dt2 *
     X   (dfmkc_dmkc(i) * fmkc(i) + dfmkc_dv(i) * fv(i))
        mkahp(i,L1) = mkahp(i,L1) + dt * fmkahp(i) + dt2 *
     X (dfmkahp_dmkahp(i)*fmkahp(i) + dfmkahp_dchi(i)*fchi(i))
        mcat(i,L1) =  mcat(i,L1) + dt * fmcat(i) + dt2 *
     X   (dfmcat_dmcat(i) * fmcat(i) + dfmcat_dv(i) * fv(i))
        hcat(i,L1) =  hcat(i,L1) + dt * fhcat(i) + dt2 *
     X   (dfhcat_dhcat(i) * fhcat(i) + dfhcat_dv(i) * fv(i))
        mcaL(i,L1) =  mcaL(i,L1) + dt * fmcaL(i) + dt2 *
     X   (dfmcaL_dmcaL(i) * fmcaL(i) + dfmcaL_dv(i) * fv(i))
        mar(i,L1) =   mar(i,L1) + dt * fmar(i) + dt2 *
     X   (dfmar_dmar(i) * fmar(i) + dfmar_dv(i) * fv(i))
         end do

4000           CONTINUE
c all type I nrt cells integrated


c      IF ((MOD(O,75).EQ.0).and.(thisno.eq.0)) THEN
c          OUTRCD(1) = TIME
c          OUTRCD(2) = v(1,1)
c          outrcd(3) = v(1,2)
c          outrcd(4) = v(1,3)
c        OPEN(12,FILE='DIENNR.OU')
c        WRITE (12,FMT='( 4F10.3)') (OUTRCD(I),I=1, 4)
c      ENDIF


              END

C  SETS UP TABLES FOR RATE FUNCTIONS
       SUBROUTINE NRT_SETUP_I
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
            taum = .0125d0 + .1525d0*dexp((v+30.d0)/10.d0)
           else
            taum = .02d0 + .145d0*dexp((-v-30.d0)/10.d0)
           endif
c from interneuron data, Martina & Jonas 1997, tau x 0.5
           alpham_naf(i) = minf / taum
           betam_naf(i) = 1.d0/taum - alpham_naf(i)

            shift_hnaf =  0.d0
        hinf = 1.d0/(1.d0 +
     x     dexp((v + shift_hnaf + 58.3d0)/6.7d0))
        tauh = 0.225d0 + 1.125d0/(1.d0+dexp((v+37.d0)/15.d0))
c from interneuron data, Martina & Jonas 1997, tau x 0.5
            alphah_naf(i) = hinf / tauh
            betah_naf(i) = 1.d0/tauh - alphah_naf(i)

          shift_mkdr = 0.d0
c delayed rectifier, non-inactivating
       minf = 1.d0/(1.d0+dexp((-v-shift_mkdr-27.d0)/11.5d0))
            if (v.le.-10.d0) then
             taum = .25d0 + 4.35d0*dexp((v+10.d0)/10.d0)
            else
             taum = .25d0 + 4.35d0*dexp((-v-10.d0)/10.d0)
            endif
              alpham_kdr(i) = minf / taum
              betam_kdr(i) = 1.d0 /taum - alpham_kdr(i)
c from Martina, Schultz et al., 1998

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

c T-current, from Destexhe et al., 1996, pg. 170
         minf = 1.d0/(1.d0 + dexp((-v-52.d0)/7.4d0))
         hinf = 1.d0/(1.d0 + dexp((v+80.d0)/5.d0))
         taum = 1.d0 + .33d0/(dexp((v+27.d0)/10.d0) +
     x                  dexp((-v-102.d0)/15.d0))
         tauh = 28.3d0 +.33d0/(dexp((v+48.d0)/4.d0) +
     x                     dexp((-v-407.d0)/50.d0))
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

        SUBROUTINE NRTMAJ_I
C BRANCHED ACTIVE DENDRITES
     X             (GL,GAM,GKDR,GKA,GKC,GKAHP,GK2,GKM,
     X              GCAT,GCAL,GNAF,GNAP,GAR,
     X    CAFOR,JACOB,C,BETCHI,NEIGH,NNUM,LEVEL)
c Conductances: leak gL, coupling g, delayed rectifier gKDR, A gKA,
c C gKC, AHP gKAHP, K2 gK2, M gKM, low thresh Ca gCAT, high thresh
c gCAL, fast Na gNAF, persistent Na gNAP, h or anom. rectif. gAR.
c Note VAR = equil. potential for anomalous rectifier.
c Soma = comp. 1; 4 dendrites each with 13 compartments, 6-comp. axon
c Drop "glc"-like terms, just using "gl"-like
c CAFOR corresponds to "phi" in Traub et al., 1994
c Consistent set of units: nF, mV, ms, nA, microS

        parameter (numcomp_p = 59)
        integer numcomp/numcomp_p/
        REAL*8 C(numcomp_p),GL(numcomp_p),GAM(0:numcomp_p,0:numcomp_p)
        REAL*8 GNAF(numcomp_p),GCAT(numcomp_p)
        REAL*8 GKDR(numcomp_p),GKA(numcomp_p)
        REAL*8 GKC(numcomp_p),GKAHP(numcomp_p),GCAL(numcomp_p)
        REAL*8 GK2(numcomp_p),GKM(numcomp_p)
        REAL*8 GNAP(numcomp_p),GAR(numcomp_p),jacob(numcomp_p,numcomp_p)
        REAL*8 RI_SD,RI_AXON,RM_SD,RM_AXON,CDENS
        INTEGER LEVEL(numcomp_p)
        REAL*8 GNAF_DENS(0:9), GCAT_DENS(0:9), GKDR_DENS(0:9)
        REAL*8 GKA_DENS(0:9), GKC_DENS(0:9), GKAHP_DENS(0:9)
        REAL*8 GCAL_DENS(0:9), GK2_DENS(0:9), GKM_DENS(0:9)
        REAL*8 GNAP_DENS(0:9), GAR_DENS(0:9)
        REAL*8 RES, RINPUT, ELEN(numcomp_p)
        REAL*8 RSOMA, PI, BETCHI(numcomp_p),CAFOR(numcomp_p)
        REAL*8 RAD(numcomp_p), LEN(numcomp_p), GAM1, GAM2
        REAL*8 RIN, D(numcomp_p), AREA(numcomp_p), RI, Z
        INTEGER NEIGH(numcomp_p,11), NNUM(numcomp_p)
C FOR ESTABLISHING TOPOLOGY OF COMPARTMENTS

        RI_SD = 250.d0
        RM_SD = 20000.d0
        RI_AXON = 100.d0
        RM_AXON = 1000.d0
        CDENS = 1.d0

        PI = 3.14159d0

        gnaf_dens(0) = 400.d0
        gnaf_dens(1) =  60.d0
        gnaf_dens(2) =  60.d0
        gnaf_dens(3) =  60.d0
        do i = 4, 9
c         gnaf_dens(i) = 60.d0
          gnaf_dens(i) = 10.d0
        end do

        gkdr_dens(0) = 400.d0
        gkdr_dens(1) =  60.d0
        gkdr_dens(2) =  60.d0
        gkdr_dens(3) =  60.d0
        do i = 4, 9
         gkdr_dens(i) = 10.d0
        end do

        do i = 1, 9
          gnap_dens(i) = 0.01d0 * gnaf_dens(i)
        end do

        do i = 1, 3
          gcat_dens(i) = 0.05d0
        end do
        do i = 4, 9
          gcat_dens(i) = 2.d0
        end do

        do i = 1, 3
          gcal_dens(i) = 0.5d0
        end do
        do i = 4, 9
          gcal_dens(i) = 0.5d0
        end do

        gka_dens(0) = 1.d0
        gka_dens(1) =  5.d0
        gka_dens(2) =  5.d0
        gka_dens(3) =  5.d0
        do i = 4, 9
         gka_dens(i) = 1.0d0
        end do

        do i = 1, 9
         gkc_dens(i) = 10.00d0
        end do

        do i = 1, 9
         gkm_dens(i) = 0.50d0
        end do

        gk2_dens(0) = .5d0
        do i = 1, 9
         gk2_dens(i) = 0.50d0
        end do

        do i = 1, 9
         gkahp_dens(i) = 0.10d0
        end do

        do i = 1, 9
         gar_dens(i) = 0.025d0
        end do

c       WRITE   (6,9988)
9988    FORMAT(2X,'I',4X,'NADENS',' CADENS(T)',' KDRDEN',' KAHPDE',
     X     ' KCDENS',' KADENS')
        DO 9989, I = 0, 9
c         WRITE (6,9990) I, gnaf_dens(i), gcat_dens(i), gkdr_dens(i),
c    X  gkahp_dens(i), gkc_dens(i), gka_dens(i)
9990    FORMAT(2X,I2,2X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2,1X,F6.2)
9989    CONTINUE


        level(1) = 1
        do i = 2, 41, 13
         level(i) = 2
        end do
        do i = 3, 42, 13
           level(i) = 3
           level(i+1) = 3
        end do
        do i = 5, 44, 13
           level(i) = 4
           level(i+1) = 4
           level(i+2) = 4
        end do
        do i = 8, 47, 13
           level(i) = 5
           level(i+1) = 5
           level(i+2) = 5
        end do
        do i = 11, 50, 13
           level(i) = 6
           level(i+1) = 7
           level(i+2) = 8
           level(i+3) = 9
        end do

        do i = 54, 59
         level(i) = 0
        end do

c connectivity of axon
        nnum(54) = 2
        nnum(55) = 3
        nnum(56) = 3
        nnum(58) = 3
        nnum(57) = 1
        nnum(59) = 1
         neigh(54,1) =  1
         neigh(54,2) = 55
         neigh(55,1) = 54
         neigh(55,2) = 56
         neigh(55,3) = 58
         neigh(56,1) = 55
         neigh(56,2) = 57
         neigh(56,3) = 58
         neigh(58,1) = 55
         neigh(58,2) = 56
         neigh(58,3) = 59
         neigh(57,1) = 56
         neigh(59,1) = 58

c connectivity of SD part
          nnum(1) = 5
          neigh(1,1) = 54
          neigh(1,2) =  2
          neigh(1,3) = 15
          neigh(1,4) = 28
          neigh(1,5) = 41

          do i = 2, 41, 13
           nnum(i) = 3
           neigh(i,1) = 1
           neigh(i,2) = i + 1
           neigh(i,3) = i + 2
          end do

          do i = 3, 42, 13
           nnum(i) = 4
           neigh(i,1) = i - 1
           neigh(i,2) = i + 1
           neigh(i,3) = i + 2
           neigh(i,4) = i + 3
          end do

          do i = 4, 43, 13
           nnum(i) = 3
           neigh(i,1) = i - 2
           neigh(i,2) = i - 1
           neigh(i,3) = i + 3
          end do

          do i = 5, 44, 13
           nnum(i) = 3
           neigh(i,1) = i - 2
           neigh(i,2) = i + 1
           neigh(i,3) = i + 3
          end do

          do i = 6, 45, 13
           nnum(i) = 3
            neigh(i,1) = i - 3
            neigh(i,2) = i - 1
            neigh(i,3) = i + 3
          end do

          do i = 7, 46, 13
           nnum(i) = 2
           neigh(i,1) = i - 3
           neigh(i,2) = i + 3
          end do

          do i = 8, 47, 13
           nnum(i) = 2
           neigh(i,1) = i - 3
           neigh(i,2) = i + 3
          end do

          do i = 9, 48, 13
           nnum(i) = 1
           neigh(i,1) = i - 3
          end do

          do i = 10, 49, 13
           nnum(i) = 1
           neigh(i,1) = i - 3
          end do

          do i = 11, 50, 13
           nnum(i) = 2
           neigh(i,1) = i - 3
           neigh(i,2) = i + 1
          end do

          do i = 12, 51, 13
           nnum(i) = 2
           neigh(i,1) = i - 1
           neigh(i,2) = i + 1
          end do

          do i = 13, 52, 13
           nnum(i) = 2
           neigh(i,1) = i - 1
           neigh(i,2) = i + 1
          end do

          do i = 14, 53, 13
           nnum(i) = 1
           neigh(i,1) = i - 1
          end do

         DO 332, I = 1, 59
c          WRITE(6,3330) I, NEIGH(I,1),NEIGH(I,2),NEIGH(I,3),NEIGH(I,4),
c    X NEIGH(I,5)
3330     FORMAT(2X,I5,I5,I5,I5,I5,I5)
332      CONTINUE
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
             ENDIF
858       CONTINUE

c length and radius of axonal compartments
          do i = 54, 59
            len(i) = 50.d0
          end do
          rad(54) = 0.80d0
          rad(55) = 0.7d0
          do i = 56, 59
           rad(i) = 0.5d0
          end do

c  length and radius of SD compartments
          len(1) = 30.d0
          rad(1) = 9.34d0

          do i = 2, 53
           len(i) = 75.d0
          end do

          rad(2) =   1.06d0
          rad(3) =   rad(2) / 1.59d0
          rad(4) =   rad(2) / 1.59d0
          rad(5) =   rad(2) / 2.53d0
          rad(6) =   rad(2) / 2.53d0
          rad(7) =   rad(2) / 1.59d0
          rad(8) =   rad(2) / 2.53d0
          rad(9) =   rad(2) / 2.53d0
          rad(10) =  rad(2) / 1.59d0
          rad(11) =  rad(2) / 2.53d0
          rad(12) =  rad(2) / 2.53d0
          rad(13) =  rad(2) / 2.53d0
          rad(14) =  rad(2) / 2.53d0

          do i = 15, 53
           rad(i) = rad(i-13)
          end do

c       WRITE(6,919)
919     FORMAT('COMPART.',' LEVEL ',' RADIUS ',' LENGTH(MU)')
c       DO 920, I = 1, 59
c920      WRITE(6,921) I, LEVEL(I), RAD(I), LEN(I)
921     FORMAT(I3,5X,I2,3X,F6.2,1X,F6.1,2X,F4.3)

        DO 120, I = 1, numcomp
          AREA(I) = 2.d0 * PI * RAD(I) * LEN(I)
C NO CORRECTION FOR CONTRIBUTION OF SPINES TO AREA
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
         DO 1019, I = 2, 53
           Z = Z + AREA(I)
1019     CONTINUE
c        WRITE(6,1020) Z
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
        BETCHI( 1) =  .02d0

        DO 300, I = 1, numcomp
300     D(I) = 2.D-4
        DO 301, I = 1, numcomp
         IF (LEVEL(I).EQ.1) D(I) = 5.D-3
301     CONTINUE
C  NOTE NOTE NOTE  (DIFFERENT FROM SWONG)


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

       DO 500, I = 1, numcomp
c       WRITE (6,501) I,C(I)
501     FORMAT(1X,I2,' C(I) = ',F7.4)
500     CONTINUE
        END

