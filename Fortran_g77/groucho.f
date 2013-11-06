
c Cell types: superficial pyramidal RS; superficial pyramidal FRB;
c superficial basket; superficial axoaxonic; superficial LTS;
c spiny stellate; tufted deep IB; tufted deep RS; nontufted deep RS;
c deep basket; deep axoaxonic; deep LTS; thalamocortical relay (TCR);
c nucleus reticularis thalami (nRT).

               PROGRAM GROUCHO

! max number of cells of any one type should be 1000; otherwise problems with broadcasting
! axonal potentials (see position code below
        PARAMETER (num_suppyrRS_p = 1000, num_suppyrFRB_p =  50,
     & num_supbask_p = 90, num_supaxax_p = 90, num_supLTS_p = 90,
     & num_spinstell_p = 240, num_tuftIB_p = 800, num_tuftRS_p = 200,
     & num_nontuftRS_p = 500, num_deepbask_p = 100, 
     & num_deepaxax_p = 100, num_deepLTS_p = 100, num_TCR_p = 100,
     & num_nRT_p = 100)

!    & num_spinstell = 240, num_tuftIB = 500, num_tuftRS = 500,
!    Diego unsure how many tuftRS there are

        PARAMETER (numcomp_suppyrRS_p   = 74,
     &             numcomp_suppyrFRB_p  = 74,
     &             numcomp_supbask_p    = 59,
     &             numcomp_supaxax_p    = 59,
     &             numcomp_supLTS_p     = 59,
     &             numcomp_spinstell_p  = 59,
     &             numcomp_tuftIB_p     = 61,
     &             numcomp_tuftRS_p     = 61,
     &             numcomp_nontuftRS_p  = 50,
     &             numcomp_deepbask_p   = 59,
     &             numcomp_deepaxax_p   = 59,
     &             numcomp_deepLTS_p    = 59,
     &             numcomp_TCR_p        =137,
     &             numcomp_nRT_p        = 59)

        PARAMETER (num_suppyrRS_to_suppyrRS_p = 50,
     &   num_suppyrRS_to_suppyrFRB_p = 50,
     &   num_suppyrRS_to_supbask_p   = 90,
     &   num_suppyrRS_to_supaxax_p   = 90,
     &   num_suppyrRS_to_supLTS_p    = 90,
     &   num_suppyrRS_to_spinstell_p =  3,
     &   num_suppyrRS_to_tuftIB_p    = 60,
     &   num_suppyrRS_to_tuftRS_p    = 60, 
     &   num_suppyrRS_to_deepbask_p  = 30,
     &   num_suppyrRS_to_deepaxax_p  = 30,
     &   num_suppyrRS_to_deepLTS_p   = 30,
     &   num_suppyrRS_to_nontuftRS_p =  3,
     &   num_suppyrFRB_to_suppyrRS_p = 5,
     &   num_suppyrFRB_to_suppyrFRB_p= 5,
     &   num_suppyrFRB_to_supbask_p  = 5,
     &   num_suppyrFRB_to_supaxax_p  = 5,
     &   num_suppyrFRB_to_supLTS_p   = 5,
     &   num_suppyrFRB_to_spinstell_p= 1,
     &   num_suppyrFRB_to_tuftIB_p   = 3,
     &   num_suppyrFRB_to_tuftRS_p   = 3,
     &   num_suppyrFRB_to_deepbask_p = 3,
     &   num_suppyrFRB_to_deepaxax_p = 3,
     &   num_suppyrFRB_to_deepLTS_p  = 3,
     &   num_suppyrFRB_to_nontuftRS_p= 1)

!     comments from above (the lines with c in first char are uncommented above
!    &   num_suppyrRS_to_spinstell = 30,
!     &   num_suppyrRS_to_spinstell =  3, ! make small, per Thomson & Bannister
!    &   num_suppyrRS_to_tuftIB    = 30,
c     &   num_suppyrRS_to_tuftIB    = 60, ! big per Thomson & Bannister
!    &   num_suppyrRS_to_tuftRS    = 30,
c     &   num_suppyrRS_to_tuftRS    = 60, ! big per Thomson & Bannister
!    &   num_suppyrRS_to_nontuftRS = 30,
c     &   num_suppyrRS_to_nontuftRS =  3, ! small per Thomson & Bannister
!    &   num_suppyrFRB_to_spinstell= 3,
c     &   num_suppyrFRB_to_spinstell= 1, ! make small, per Thomson & Bannister
!    &   num_suppyrFRB_to_nontuftRS= 3)
c     &   num_suppyrFRB_to_nontuftRS= 1) ! small per Thomson & Bannister

        PARAMETER
     &  (num_supbask_to_suppyrRS_p   = 20,
     &   num_supbask_to_suppyrFRB_p  = 20,
     &   num_supbask_to_supbask_p    = 20,
     &   num_supbask_to_supaxax_p    = 20,
     &   num_supbask_to_supLTS_p     = 20,
     &   num_supbask_to_spinstell_p  = 20,

     &   num_supaxax_to_suppyrRS_p   = 20,
     &   num_supaxax_to_suppyrFRB_p  = 20,
     &   num_supaxax_to_spinstell_p  = 5,
     &   num_supaxax_to_tuftIB_p     = 5,
     &   num_supaxax_to_tuftRS_p     = 5,
     &   num_supaxax_to_nontuftRS_p  = 5,

     &   num_supLTS_to_suppyrRS_p    = 20,
     &   num_supLTS_to_suppyrFRB_p   = 20,
     &   num_supLTS_to_supbask_p     = 20,
     &   num_supLTS_to_supaxax_p     = 20,
     &   num_supLTS_to_supLTS_p      = 20,
     &   num_supLTS_to_spinstell_p   = 20,
     &   num_supLTS_to_tuftIB_p      = 20)
        PARAMETER
     &  (num_supLTS_to_tuftRS_p      = 20,
     &   num_supLTS_to_deepbask_p    = 20,
     &   num_supLTS_to_deepaxax_p    = 20,
     &   num_supLTS_to_deepLTS_p     = 20,
     &   num_supLTS_to_nontuftRS_p   = 20,
     &   num_spinstell_to_suppyrRS_p = 20,
     &   num_spinstell_to_suppyrFRB_p= 20,
     &   num_spinstell_to_supbask_p  = 20,
     &   num_spinstell_to_supaxax_p  = 20,
     &   num_spinstell_to_supLTS_p   = 20,
     &   num_spinstell_to_spinstell_p= 30,
     &   num_spinstell_to_tuftIB_p   = 20,
     &   num_spinstell_to_tuftRS_p   = 20,
     &   num_spinstell_to_deepbask_p = 20,
     &   num_spinstell_to_deepaxax_p = 20,
     &   num_spinstell_to_deepLTS_p  = 20,
     &   num_spinstell_to_nontuftRS_p= 20,
     &   num_tuftIB_to_suppyrRS_p    =  2, 
     &   num_tuftIB_to_suppyrFRB_p   =  2,
     &   num_tuftIB_to_supbask_p     = 20)

c     comments from above (c were uncommented above)
!    &   num_tuftIB_to_suppyrRS    = 20,
c     &   num_tuftIB_to_suppyrRS    =  2, ! small per Thomson & Bannister
!    &   num_tuftIB_to_suppyrFRB   = 20,
c     &   num_tuftIB_to_suppyrFRB   =  2, ! small per Thomson & Bannister

        PARAMETER
     &  (num_tuftIB_to_supaxax_p     = 20,
     &   num_tuftIB_to_supLTS_p      = 20,
     &   num_tuftIB_to_spinstell_p   = 20,
     &   num_tuftIB_to_tuftIB_p      = 50,
     &   num_tuftIB_to_tuftRS_p      = 20,
     &   num_tuftIB_to_deepbask_p    = 20,
     &   num_tuftIB_to_deepaxax_p    = 20,
     &   num_tuftIB_to_deepLTS_p     = 20,
     &   num_tuftIB_to_nontuftRS_p   = 20,
     &   num_tuftRS_to_suppyrRS_p    =  2, 
     &   num_tuftRS_to_suppyrFRB_p   =  2, 
     &   num_tuftRS_to_supbask_p     = 20,
     &   num_tuftRS_to_supaxax_p     = 20,
     &   num_tuftRS_to_supLTS_p      = 20,
     &   num_tuftRS_to_spinstell_p   = 20,
     &   num_tuftRS_to_tuftIB_p      = 20,
     &   num_tuftRS_to_tuftRS_p      = 10,
     &   num_tuftRS_to_deepbask_p    = 20,
     &   num_tuftRS_to_deepaxax_p    = 20,
     &   num_tuftRS_to_deepLTS_p     = 20,
     &   num_tuftRS_to_nontuftRS_p   = 20)

!    &   num_tuftRS_to_suppyrRS    = 20,
c     &   num_tuftRS_to_suppyrRS    =  2, ! small per Thomson & Bannister
!    &   num_tuftRS_to_suppyrFRB   = 20,
c     &   num_tuftRS_to_suppyrFRB   =  2, ! small per Thomson & Bannister

        PARAMETER
     &  (num_deepbask_to_spinstell_p = 20,
     &   num_deepbask_to_tuftIB_p    = 20,
     &   num_deepbask_to_tuftRS_p    = 20,
     &   num_deepbask_to_deepbask_p  = 20,
     &   num_deepbask_to_deepaxax_p  = 20,
     &   num_deepbask_to_deepLTS_p   = 20,
     &   num_deepbask_to_nontuftRS_p = 20,
     &   num_deepaxax_to_suppyrRS_p  =  5,
     &   num_deepaxax_to_suppyrFRB_p =  5,
     &   num_deepaxax_to_spinstell_p =  5,
     &   num_deepaxax_to_tuftIB_p    =  5,
     &   num_deepaxax_to_tuftRS_p    =  5,
     &   num_deepaxax_to_nontuftRS_p =  5,
     &   num_deepLTS_to_suppyrRS_p   = 10)
        PARAMETER
     &  (num_deepLTS_to_suppyrFRB_p  = 10,
     &   num_deepLTS_to_supbask_p    = 10,
     &   num_deepLTS_to_supaxax_p    = 10,
     &   num_deepLTS_to_supLTS_p     = 10,
     &   num_deepLTS_to_spinstell_p  = 20,
     &   num_deepLTS_to_tuftIB_p     = 20,
     &   num_deepLTS_to_tuftRS_p     = 20,
     &   num_deepLTS_to_deepbask_p   = 20,
     &   num_deepLTS_to_deepaxax_p   = 20,
     &   num_deepLTS_to_deepLTS_p    = 20,
     &   num_deepLTS_to_nontuftRS_p  = 20,
     &   num_TCR_to_suppyrRS_p       = 10,
     &   num_TCR_to_suppyrFRB_p      = 10,
     &   num_TCR_to_supbask_p        = 10,
     &   num_TCR_to_supaxax_p        = 10,
     &   num_TCR_to_spinstell_p      = 20,
     &   num_TCR_to_tuftIB_p         = 10,
     &   num_TCR_to_tuftRS_p         = 10,
     &   num_TCR_to_deepbask_p       = 20,
     &   num_TCR_to_deepaxax_p       = 10,
     &   num_TCR_to_nRT_p            = 25, 
     &   num_TCR_to_nontuftRS_p      = 10,
     &   num_nRT_to_TCR_p            = 15, 
     &   num_nRT_to_nRT_p            = 10)

!    &   num_TCR_to_spinstell      = 10,
c     &   num_TCR_to_spinstell      = 20,
!    &   num_TCR_to_deepbask       = 10,
c     &   num_TCR_to_deepbask       = 20,

        PARAMETER
     &  (num_nontuftRS_to_suppyrRS_p = 10,
     &   num_nontuftRS_to_suppyrFRB_p= 10,
     &   num_nontuftRS_to_supbask_p  = 10,
     &   num_nontuftRS_to_supaxax_p  = 10,
     &   num_nontuftRS_to_supLTS_p   = 10,
     &   num_nontuftRS_to_spinstell_p= 10,
     &   num_nontuftRS_to_tuftIB_p   = 10,
     &   num_nontuftRS_to_tuftRS_p   = 10,
     &   num_nontuftRS_to_deepbask_p = 10,
     &   num_nontuftRS_to_deepaxax_p = 10,
     &   num_nontuftRS_to_deepLTS_p  = 10,
     &   num_nontuftRS_to_TCR_p      = 20,
     &   num_nontuftRS_to_nRT_p      = 20,
     &   num_nontuftRS_to_nontuftRS_p= 20)

c Begin definition of number of compartments that can be
c contacted for each type of synaptic connection.
        PARAMETER (ncompallow_suppyrRS_to_suppyrRS_p = 36,
     &   ncompallow_suppyrRS_to_suppyrFRB_p = 36,
     &   ncompallow_suppyrRS_to_supbask_p   = 24,
     &   ncompallow_suppyrRS_to_supaxax_p   = 24,
     &   ncompallow_suppyrRS_to_supLTS_p    = 24,
     &   ncompallow_suppyrRS_to_spinstell_p = 24,
     &   ncompallow_suppyrRS_to_tuftIB_p    =  8,
     &   ncompallow_suppyrRS_to_tuftRS_p    =  8,
     &   ncompallow_suppyrRS_to_deepbask_p  = 24,
     &   ncompallow_suppyrRS_to_deepaxax_p  = 24,
     &   ncompallow_suppyrRS_to_deepLTS_p   = 24,
     &   ncompallow_suppyrRS_to_nontuftRS_p =  7)

        PARAMETER (ncompallow_suppyrFRB_to_suppyrRS_p = 36,
     &   ncompallow_suppyrFRB_to_suppyrFRB_p = 36,
     &   ncompallow_suppyrFRB_to_supbask_p   = 24,
     &   ncompallow_suppyrFRB_to_supaxax_p   = 24,
     &   ncompallow_suppyrFRB_to_supLTS_p    = 24,
     &   ncompallow_suppyrFRB_to_spinstell_p = 24,
     &   ncompallow_suppyrFRB_to_tuftIB_p    =  8,
     &   ncompallow_suppyrFRB_to_tuftRS_p    =  8,
     &   ncompallow_suppyrFRB_to_deepbask_p  = 24,
     &   ncompallow_suppyrFRB_to_deepaxax_p  = 24,
     &   ncompallow_suppyrFRB_to_deepLTS_p   = 24,
     &   ncompallow_suppyrFRB_to_nontuftRS_p =  7)

        PARAMETER (ncompallow_supbask_to_suppyrRS_p   = 11,
     &   ncompallow_supbask_to_suppyrFRB_p   = 11,
     &   ncompallow_supbask_to_supbask_p     = 24,
     &   ncompallow_supbask_to_supaxax_p     = 24,
     &   ncompallow_supbask_to_supLTS_p      = 24,
     &   ncompallow_supbask_to_spinstell_p   =  5)

        PARAMETER (ncompallow_supLTS_to_suppyrRS_p    = 53,
     &   ncompallow_supLTS_to_suppyrFRB_p    = 53,
     &   ncompallow_supLTS_to_supbask_p      = 40,
     &   ncompallow_supLTS_to_supaxax_p      = 40,
     &   ncompallow_supLTS_to_supLTS_p       = 40,
     &   ncompallow_supLTS_to_spinstell_p    = 40,
     &   ncompallow_supLTS_to_tuftIB_p       = 40,
     &   ncompallow_supLTS_to_tuftRS_p       = 40,
     &   ncompallow_supLTS_to_deepbask_p     = 20,
     &   ncompallow_supLTS_to_deepaxax_p     = 20,
     &   ncompallow_supLTS_to_deepLTS_p      = 20,
     &   ncompallow_supLTS_to_nontuftRS_p    = 29)

        PARAMETER (ncompallow_spinstell_to_suppyrRS_p = 24,
     &   ncompallow_spinstell_to_suppyrFRB_p = 24,
     &   ncompallow_spinstell_to_supbask_p   = 24,
     &   ncompallow_spinstell_to_supaxax_p   = 24,
     &   ncompallow_spinstell_to_supLTS_p    = 24,
     &   ncompallow_spinstell_to_spinstell_p = 24,
     &   ncompallow_spinstell_to_tuftIB_p    = 12,
     &   ncompallow_spinstell_to_tuftRS_p    = 12,
     &   ncompallow_spinstell_to_deepbask_p  = 24,
     &   ncompallow_spinstell_to_deepaxax_p  = 24,
     &   ncompallow_spinstell_to_deepLTS_p   = 24,
     &   ncompallow_spinstell_to_nontuftRS_p =  5)

        PARAMETER (ncompallow_tuftIB_to_suppyrRS_p   = 13,
     &   ncompallow_tuftIB_to_suppyrFRB_p    = 13,
     &   ncompallow_tuftIB_to_supbask_p      = 24,
     &   ncompallow_tuftIB_to_supaxax_p      = 24,
     &   ncompallow_tuftIB_to_supLTS_p       = 24,
     &   ncompallow_tuftIB_to_spinstell_p    = 24,
     &   ncompallow_tuftIB_to_tuftIB_p       = 46,
     &   ncompallow_tuftIB_to_tuftRS_p       = 46,
     &   ncompallow_tuftIB_to_deepbask_p     = 24,
     &   ncompallow_tuftIB_to_deepaxax_p     = 24,
     &   ncompallow_tuftIB_to_deepLTS_p      = 24,
     &   ncompallow_tuftIB_to_nontuftRS_p    = 43)

        PARAMETER (ncompallow_tuftRS_to_suppyrRS_p   = 13,
     &   ncompallow_tuftRS_to_suppyrFRB_p    = 13,
     &   ncompallow_tuftRS_to_supbask_p      = 24,
     &   ncompallow_tuftRS_to_supaxax_p      = 24,
     &   ncompallow_tuftRS_to_supLTS_p       = 24,
     &   ncompallow_tuftRS_to_spinstell_p    = 24,
     &   ncompallow_tuftRS_to_tuftIB_p       = 46,
     &   ncompallow_tuftRS_to_tuftRS_p       = 46,
     &   ncompallow_tuftRS_to_deepbask_p     = 24,
     &   ncompallow_tuftRS_to_deepaxax_p     = 24,
     &   ncompallow_tuftRS_to_deepLTS_p      = 24,
     &   ncompallow_tuftRS_to_nontuftRS_p    = 43)

        PARAMETER (ncompallow_deepbask_to_spinstell_p = 5, 
     &   ncompallow_deepbask_to_tuftIB_p     =  8,
     &   ncompallow_deepbask_to_tuftRS_p     =  8,
     &   ncompallow_deepbask_to_deepbask_p   = 24,
     &   ncompallow_deepbask_to_deepaxax_p   = 24,
     &   ncompallow_deepbask_to_deepLTS_p    = 24,
     &   ncompallow_deepbask_to_nontuftRS_p  =  8)

        PARAMETER (ncompallow_deepLTS_to_suppyrRS_p = 53,
     &   ncompallow_deepLTS_to_suppyrFRB_p   = 53,
     &   ncompallow_deepLTS_to_supbask_p     = 20,
     &   ncompallow_deepLTS_to_supaxax_p     = 20,
     &   ncompallow_deepLTS_to_supLTS_p      = 20,
     &   ncompallow_deepLTS_to_spinstell_p   = 40,
     &   ncompallow_deepLTS_to_tuftIB_p      = 40,
     &   ncompallow_deepLTS_to_tuftRS_p      = 40,
     &   ncompallow_deepLTS_to_deepbask_p    = 40,
     &   ncompallow_deepLTS_to_deepaxax_p    = 40,
     &   ncompallow_deepLTS_to_deepLTS_p     = 40,
     &   ncompallow_deepLTS_to_nontuftRS_p   = 29)


        PARAMETER (ncompallow_TCR_to_suppyrRS_p = 24,
     &   ncompallow_TCR_to_suppyrFRB_p    = 24,
     &   ncompallow_TCR_to_supbask_p      = 12,
     &   ncompallow_TCR_to_supaxax_p      = 12,
     &   ncompallow_TCR_to_spinstell_p    = 52,
     &   ncompallow_TCR_to_tuftIB_p       =  9,
     &   ncompallow_TCR_to_tuftRS_p       =  9,
     &   ncompallow_TCR_to_deepbask_p     = 12,
     &   ncompallow_TCR_to_deepaxax_p     = 12,
     &   ncompallow_TCR_to_nRT_p          = 12,
     &   ncompallow_TCR_to_nontuftRS_p    =  5)

        PARAMETER (ncompallow_nRT_to_TCR_p  = 11,
     &   ncompallow_nRT_to_nRT_p = 53)

        PARAMETER (ncompallow_nontuftRS_to_suppyrRS_p = 4,
     &    ncompallow_nontuftRS_to_suppyrFRB_p =  4,
     &    ncompallow_nontuftRS_to_supbask_p   = 24,
     &    ncompallow_nontuftRS_to_supaxax_p   = 24,
     &    ncompallow_nontuftRS_to_supLTS_p    = 24,
     &    ncompallow_nontuftRS_to_spinstell_p = 24,
     &    ncompallow_nontuftRS_to_tuftIB_p    = 46,
     &    ncompallow_nontuftRS_to_tuftRS_p    = 46,
     &    ncompallow_nontuftRS_to_deepbask_p  = 24,
     &    ncompallow_nontuftRS_to_deepaxax_p  = 24,
     &    ncompallow_nontuftRS_to_deepLTS_p   = 24,
     &    ncompallow_nontuftRS_to_TCR_p       = 90,
     &    ncompallow_nontuftRS_to_nRT_p       = 12,
     &    ncompallow_nontuftRS_to_nontuftRS_p = 43)
c End definition of number of allowed compartments that
c can be contacted for each sort of connection

c Note that gj form only between cells of a given type,
c  except suppyrRS/suppyrFRB & tuftIB/tuftRS
c gj/cell = 2 x total gj / # cells
c for proportions, see /home/traub/supergj/tests.f
!     Note: with the porting of this code to f77 if the X_p's are
!     changed below then the "integer X"'s have to be changed far below
!     (to the same values)
        Parameter (totaxgj_suppyrRS_p=722)
        PARAMETER (totaxgj_suppyrFRB_p =   4 )
        PARAMETER (totaxgj_suppyr_p    =  74 )
! totaxgj_suppyr = number of "mixed" gj between RS suppyr
! (1st col. of table) and FRB suppyr (3rd col. of table) cells
        PARAMETER (totSDgj_supbask_p   = 200 )
        PARAMETER (totSDgj_supaxax_p   =   0 )
        PARAMETER (totSDgj_supLTS_p    = 200 )
        PARAMETER (totaxgj_spinstell_p = 240 )
        PARAMETER (totaxgj_tuftIB_p    = 350 )
        PARAMETER (totaxgj_tuftRS_p    = 350 )
!        PARAMETER (totaxgj_tuft_p      = 350 )
        PARAMETER (totaxgj_tuft_p      =  10 )  ! decr. antidr. bursts in IB
! totaxgj_tuft for mixed gj between tuftIB (1st) and tuftRS (next)
        PARAMETER (totaxgj_nontuftRS_p = 500 )
        PARAMETER (totSDgj_deepbask_p  = 250 )
        PARAMETER (totSDgj_deepaxax_p  =   0 )
        PARAMETER (totSDgj_deepLTS_p   = 250 )
        PARAMETER (totaxgj_TCR_p       = 100  )
        PARAMETER (totSDgj_nRT_p       = 250)
c Note: no gj between axoaxonic cells.

c Define number of compartments on a cell where a gj might form
        PARAMETER (num_axgjcompallow_suppyrRS_p = 1)
        PARAMETER (num_axgjcompallow_suppyrFRB_p= 1)
        PARAMETER (num_SDgjcompallow_supbask_p  = 8)
        PARAMETER (num_SDgjcompallow_supLTS_p   = 8)
        PARAMETER (num_axgjcompallow_spinstell_p= 1)
        PARAMETER (num_axgjcompallow_tuftIB_p   = 1)
        PARAMETER (num_axgjcompallow_tuftRS_p   = 1)
        PARAMETER (num_axgjcompallow_nontuftRS_p= 1)
        PARAMETER (num_SDgjcompallow_deepbask_p = 8)
        PARAMETER (num_SDgjcompallow_deepLTS_p  = 8)
        PARAMETER (num_axgjcompallow_TCR_p      = 1)
        PARAMETER (num_SDgjcompallow_nRT_p      = 8)

c Define gap junction conductances.
       REAL*8 gapcon_suppyrRS  / 3.d-3 /
!      double precision, parameter :: gapcon_suppyrRS  = 0.d-3 ! to see if superf. lay. can follow 40 Hz
       REAL*8 gapcon_suppyrFRB / 3.d-3 /
!      double precision, parameter :: gapcon_suppyrFRB = 0.d-3 ! to see if superf. lay. can follow 40 Hz
       REAL*8 gapcon_supbask  / 1.d-3 /
       REAL*8 gapcon_supaxax  / 0.d-3 /
       REAL*8 gapcon_supLTS   / 1.d-3 /
       REAL*8 gapcon_spinstell/ 3.d-3 /
!      double precision, parameter :: gapcon_spinstell = 0.d-3 ! to see if ctx follows 40 Hz from thal.
       REAL*8 gapcon_tuftIB   / 4.d-3 /
!      REAL*8 gapcon_tuftIB    = 0.d-3 ! to decr. antidr. bursting
       real*8 gapcon_tuftRS   / 4.d-3 /
!      REAL*8 gapcon_tuftRS    = 0.d-3 ! now follow 40 Hz?
       REAL*8 gapcon_nontuftRS/ 4.d-3 /
!      REAL*8 gapcon_nontuftRS = 0.d-3 ) ! to abolish VFO in lay. 6
       real*8 gapcon_deepbask / 1.d-3 /
       REAL*8 gapcon_deepaxax / 0.d-3 /
       REAL*8 gapcon_deepLTS  / 1.d-3 /
!      REAL*8 gapcon_TCR       = 3.d-3 )
       real*8 gapcon_TCR      / 0.d-3 /
       REAL*8 gapcon_nRT       /1.d-3 /

        INTEGER
     &   num_supbask_to_suppyrRS   /num_supbask_to_suppyrRS_p/,
     &   num_supbask_to_suppyrFRB  /num_supbask_to_suppyrFRB_p/,
     &   num_supbask_to_supbask    /num_supbask_to_supbask_p/,
     &   num_supbask_to_supaxax    /num_supbask_to_supaxax_p/,
     &   num_supbask_to_supLTS     /num_supbask_to_supLTS_p/,
     &   num_supbask_to_spinstell  /num_supbask_to_spinstell_p/,
     &   num_supaxax_to_suppyrRS   /num_supaxax_to_suppyrRS_p/,
     &   num_supaxax_to_suppyrFRB  /num_supaxax_to_suppyrFRB_p/,
     &   num_supaxax_to_spinstell  /num_supaxax_to_spinstell_p/,
     &   num_supaxax_to_tuftIB     /num_supaxax_to_tuftIB_p/,
     &   num_supaxax_to_tuftRS     /num_supaxax_to_tuftRS_p/,
     &   num_supaxax_to_nontuftRS  /num_supaxax_to_nontuftRS_p/,
     &   num_supLTS_to_suppyrRS    /num_supLTS_to_suppyrRS_p/,
     &   num_supLTS_to_suppyrFRB   /num_supLTS_to_suppyrFRB_p/,
     &   num_supLTS_to_supbask     /num_supLTS_to_supbask_p/,
     &   num_supLTS_to_supaxax     /num_supLTS_to_supaxax_p/,
     &   num_supLTS_to_supLTS      /num_supLTS_to_supLTS_p/,
     &   num_supLTS_to_spinstell   /num_supLTS_to_spinstell_p/,
     &   num_supLTS_to_tuftIB      /num_supLTS_to_tuftIB_p/
        INTEGER
     &   num_supLTS_to_tuftRS      /num_supLTS_to_tuftRS_p/,
     &   num_supLTS_to_deepbask    /num_supLTS_to_deepbask_p/,
     &   num_supLTS_to_deepaxax    /num_supLTS_to_deepaxax_p/,
     &   num_supLTS_to_deepLTS     /num_supLTS_to_deepLTS_p/,
     &   num_supLTS_to_nontuftRS   /num_supLTS_to_nontuftRS_p/,
     &   num_spinstell_to_suppyrRS /num_spinstell_to_suppyrRS_p/,
     &   num_spinstell_to_suppyrFRB/num_spinstell_to_suppyrFRB_p/,
     &   num_spinstell_to_supbask  /num_spinstell_to_supbask_p/,
     &   num_spinstell_to_supaxax  /num_spinstell_to_supaxax_p/,
     &   num_spinstell_to_supLTS   /num_spinstell_to_supLTS_p/,
     &   num_spinstell_to_spinstell/num_spinstell_to_spinstell_p/,
     &   num_spinstell_to_tuftIB   /num_spinstell_to_tuftIB_p/,
     &   num_spinstell_to_tuftRS   /num_spinstell_to_tuftRS_p/,
     &   num_spinstell_to_deepbask /num_spinstell_to_deepbask_p/,
     &   num_spinstell_to_deepaxax /num_spinstell_to_deepaxax_p/,
     &   num_spinstell_to_deepLTS  /num_spinstell_to_deepLTS_p/,
     &   num_spinstell_to_nontuftRS/num_spinstell_to_nontuftRS_p/,
     &   num_tuftIB_to_suppyrRS    /num_tuftIB_to_suppyrRS_p/, 
     &   num_tuftIB_to_suppyrFRB   /num_tuftIB_to_suppyrFRB_p/,
     &   num_tuftIB_to_supbask     /num_tuftIB_to_supbask_p/

c     comments from above (c were uncommented above)
!    &   num_tuftIB_to_suppyrRS    = 20,
c     &   num_tuftIB_to_suppyrRS    =  2, ! small per Thomson & Bannister
!    &   num_tuftIB_to_suppyrFRB   = 20,
c     &   num_tuftIB_to_suppyrFRB   =  2, ! small per Thomson & Bannister

        INTEGER
     &   num_tuftIB_to_supaxax     /num_tuftIB_to_supaxax_p/,
     &   num_tuftIB_to_supLTS      /num_tuftIB_to_supLTS_p/,
     &   num_tuftIB_to_spinstell   /num_tuftIB_to_spinstell_p/,
     &   num_tuftIB_to_tuftIB      /num_tuftIB_to_tuftIB_p/,
     &   num_tuftIB_to_tuftRS      /num_tuftIB_to_tuftRS_p/,
     &   num_tuftIB_to_deepbask    /num_tuftIB_to_deepbask_p/,
     &   num_tuftIB_to_deepaxax    /num_tuftIB_to_deepaxax_p/,
     &   num_tuftIB_to_deepLTS     /num_tuftIB_to_deepLTS_p/,
     &   num_tuftIB_to_nontuftRS   /num_tuftIB_to_nontuftRS_p/,
     &   num_tuftRS_to_suppyrRS    /num_tuftRS_to_suppyrRS_p/, 
     &   num_tuftRS_to_suppyrFRB   /num_tuftRS_to_suppyrFRB_p/, 
     &   num_tuftRS_to_supbask     /num_tuftRS_to_supbask_p/,
     &   num_tuftRS_to_supaxax     /num_tuftRS_to_supaxax_p/,
     &   num_tuftRS_to_supLTS      /num_tuftRS_to_supLTS_p/,
     &   num_tuftRS_to_spinstell   /num_tuftRS_to_spinstell_p/,
     &   num_tuftRS_to_tuftIB      /num_tuftRS_to_tuftIB_p/,
     &   num_tuftRS_to_tuftRS      /num_tuftRS_to_tuftRS_p/,
     &   num_tuftRS_to_deepbask    /num_tuftRS_to_deepbask_p/,
     &   num_tuftRS_to_deepaxax    /num_tuftRS_to_deepaxax_p/,
     &   num_tuftRS_to_deepLTS     /num_tuftRS_to_deepLTS_p/,
     &   num_tuftRS_to_nontuftRS   /num_tuftRS_to_nontuftRS_p/

!    &   num_tuftRS_to_suppyrRS    = 20,
c     &   num_tuftRS_to_suppyrRS    =  2, ! small per Thomson & Bannister
!    &   num_tuftRS_to_suppyrFRB   = 20,
c     &   num_tuftRS_to_suppyrFRB   =  2, ! small per Thomson & Bannister

        INTEGER
     &   num_deepbask_to_spinstell /num_deepbask_to_spinstell_p/,
     &   num_deepbask_to_tuftIB    /num_deepbask_to_tuftIB_p/,
     &   num_deepbask_to_tuftRS    /num_deepbask_to_tuftRS_p/,
     &   num_deepbask_to_deepbask  /num_deepbask_to_deepbask_p/,
     &   num_deepbask_to_deepaxax  /num_deepbask_to_deepaxax_p/,
     &   num_deepbask_to_deepLTS   /num_deepbask_to_deepLTS_p/,
     &   num_deepbask_to_nontuftRS /num_deepbask_to_nontuftRS_p/,
     &   num_deepaxax_to_suppyrRS  /num_deepaxax_to_suppyrRS_p/,
     &   num_deepaxax_to_suppyrFRB /num_deepaxax_to_suppyrFRB_p/,
     &   num_deepaxax_to_spinstell /num_deepaxax_to_spinstell_p/,
     &   num_deepaxax_to_tuftIB    /num_deepaxax_to_tuftIB_p/,
     &   num_deepaxax_to_tuftRS    /num_deepaxax_to_tuftRS_p/,
     &   num_deepaxax_to_nontuftRS /num_deepaxax_to_nontuftRS_p/,
     &   num_deepLTS_to_suppyrRS   /num_deepLTS_to_suppyrRS_p/
        INTEGER
     &   num_deepLTS_to_suppyrFRB  /num_deepLTS_to_suppyrFRB_p/,
     &   num_deepLTS_to_supbask    /num_deepLTS_to_supbask_p/,
     &   num_deepLTS_to_supaxax    /num_deepLTS_to_supaxax_p/,
     &   num_deepLTS_to_supLTS     /num_deepLTS_to_supLTS_p/,
     &   num_deepLTS_to_spinstell  /num_deepLTS_to_spinstell_p/,
     &   num_deepLTS_to_tuftIB     /num_deepLTS_to_tuftIB_p/,
     &   num_deepLTS_to_tuftRS     /num_deepLTS_to_tuftRS_p/,
     &   num_deepLTS_to_deepbask   /num_deepLTS_to_deepbask_p/,
     &   num_deepLTS_to_deepaxax   /num_deepLTS_to_deepaxax_p/,
     &   num_deepLTS_to_deepLTS    /num_deepLTS_to_deepLTS_p/,
     &   num_deepLTS_to_nontuftRS  /num_deepLTS_to_nontuftRS_p/,
     &   num_TCR_to_suppyrRS       /num_TCR_to_suppyrRS_p/,
     &   num_TCR_to_suppyrFRB      /num_TCR_to_suppyrFRB_p/,
     &   num_TCR_to_supbask        /num_TCR_to_supbask_p/,
     &   num_TCR_to_supaxax        /num_TCR_to_supaxax_p/,
     &   num_TCR_to_spinstell      /num_TCR_to_spinstell_p/,
     &   num_TCR_to_tuftIB         /num_TCR_to_tuftIB_p/,
     &   num_TCR_to_tuftRS         /num_TCR_to_tuftRS_p/,
     &   num_TCR_to_deepbask       /num_TCR_to_deepbask_p/,
     &   num_TCR_to_deepaxax       /num_TCR_to_deepaxax_p/,
     &   num_TCR_to_nRT            /num_TCR_to_nRT_p/, 
     &   num_TCR_to_nontuftRS      /num_TCR_to_nontuftRS_p/,
     &   num_nRT_to_TCR            /num_nRT_to_TCR_p/, 
     &   num_nRT_to_nRT            /num_nRT_to_nRT_p/

!    &   num_TCR_to_spinstell      = 10,
c     &   num_TCR_to_spinstell      = 20,
!    &   num_TCR_to_deepbask       = 10,
c     &   num_TCR_to_deepbask       = 20,

        INTEGER
     &   num_nontuftRS_to_suppyrRS /num_nontuftRS_to_suppyrRS_p/,
     &   num_nontuftRS_to_suppyrFRB/num_nontuftRS_to_suppyrFRB_p/,
     &   num_nontuftRS_to_supbask  /num_nontuftRS_to_supbask_p/,
     &   num_nontuftRS_to_supaxax  /num_nontuftRS_to_supaxax_p/,
     &   num_nontuftRS_to_supLTS   /num_nontuftRS_to_supLTS_p/,
     &   num_nontuftRS_to_spinstell/num_nontuftRS_to_spinstell_p/,
     &   num_nontuftRS_to_tuftIB   /num_nontuftRS_to_tuftIB_p/,
     &   num_nontuftRS_to_tuftRS   /num_nontuftRS_to_tuftRS_p/,
     &   num_nontuftRS_to_deepbask /num_nontuftRS_to_deepbask_p/,
     &   num_nontuftRS_to_deepaxax /num_nontuftRS_to_deepaxax_p/,
     &   num_nontuftRS_to_deepLTS  /num_nontuftRS_to_deepLTS_p/,
     &   num_nontuftRS_to_TCR      /num_nontuftRS_to_TCR_p/,
     &   num_nontuftRS_to_nRT      /num_nontuftRS_to_nRT_p/,
     &   num_nontuftRS_to_nontuftRS/num_nontuftRS_to_nontuftRS_p/

c Begin definition of number of compartments that can be
c contacted for each type of synaptic connection.
        INTEGER 
     &   ncompallow_suppyrRS_to_suppyrRS 
     &       /ncompallow_suppyrRS_to_suppyrRS_p/,
     &   ncompallow_suppyrRS_to_suppyrFRB 
     &       /ncompallow_suppyrRS_to_suppyrFRB_p/,
     &   ncompallow_suppyrRS_to_supbask   
     &       /ncompallow_suppyrRS_to_supbask_p/,
     &   ncompallow_suppyrRS_to_supaxax   
     &       /ncompallow_suppyrRS_to_supaxax_p/,
     &   ncompallow_suppyrRS_to_supLTS    
     &       /ncompallow_suppyrRS_to_supLTS_p/,
     &   ncompallow_suppyrRS_to_spinstell 
     &       /ncompallow_suppyrRS_to_spinstell_p/,
     &   ncompallow_suppyrRS_to_tuftIB    
     &       /ncompallow_suppyrRS_to_tuftIB_p/,
     &   ncompallow_suppyrRS_to_tuftRS    
     &       /ncompallow_suppyrRS_to_tuftRS_p/,
     &   ncompallow_suppyrRS_to_deepbask  
     &       /ncompallow_suppyrRS_to_deepbask_p/,
     &   ncompallow_suppyrRS_to_deepaxax  
     &       /ncompallow_suppyrRS_to_deepaxax_p/,
     &   ncompallow_suppyrRS_to_deepLTS   
     &       /ncompallow_suppyrRS_to_deepLTS_p/,
     &   ncompallow_suppyrRS_to_nontuftRS 
     &       /ncompallow_suppyrRS_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_suppyrFRB_to_suppyrRS 
     &       /ncompallow_suppyrFRB_to_suppyrRS_p/,
     &   ncompallow_suppyrFRB_to_suppyrFRB 
     &       /ncompallow_suppyrFRB_to_suppyrFRB_p/,
     &   ncompallow_suppyrFRB_to_supbask   
     &       /ncompallow_suppyrFRB_to_supbask_p/,
     &   ncompallow_suppyrFRB_to_supaxax   
     &       /ncompallow_suppyrFRB_to_supaxax_p/,
     &   ncompallow_suppyrFRB_to_supLTS    
     &       /ncompallow_suppyrFRB_to_supLTS_p/,
     &   ncompallow_suppyrFRB_to_spinstell 
     &       /ncompallow_suppyrFRB_to_spinstell_p/,
     &   ncompallow_suppyrFRB_to_tuftIB    
     &       /ncompallow_suppyrFRB_to_tuftIB_p/,
     &   ncompallow_suppyrFRB_to_tuftRS    
     &       /ncompallow_suppyrFRB_to_tuftRS_p/,
     &   ncompallow_suppyrFRB_to_deepbask  
     &       /ncompallow_suppyrFRB_to_deepbask_p/,
     &   ncompallow_suppyrFRB_to_deepaxax  
     &       /ncompallow_suppyrFRB_to_deepaxax_p/,
     &   ncompallow_suppyrFRB_to_deepLTS   
     &       /ncompallow_suppyrFRB_to_deepLTS_p/,
     &   ncompallow_suppyrFRB_to_nontuftRS 
     &       /ncompallow_suppyrFRB_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_supbask_to_suppyrRS   
     &       /ncompallow_supbask_to_suppyrRS_p/,
     &   ncompallow_supbask_to_suppyrFRB   
     &       /ncompallow_supbask_to_suppyrFRB_p/,
     &   ncompallow_supbask_to_supbask     
     &       /ncompallow_supbask_to_supbask_p/,
     &   ncompallow_supbask_to_supaxax     
     &       /ncompallow_supbask_to_supaxax_p/,
     &   ncompallow_supbask_to_supLTS      
     &       /ncompallow_supbask_to_supLTS_p/,
     &   ncompallow_supbask_to_spinstell   
     &       /ncompallow_supbask_to_spinstell_p/

        INTEGER 
     &   ncompallow_supLTS_to_suppyrRS    
     &       /ncompallow_supLTS_to_suppyrRS_p/,
     &   ncompallow_supLTS_to_suppyrFRB    
     &       /ncompallow_supLTS_to_suppyrFRB_p/,
     &   ncompallow_supLTS_to_supbask      
     &       /ncompallow_supLTS_to_supbask_p/,
     &   ncompallow_supLTS_to_supaxax      
     &       /ncompallow_supLTS_to_supaxax_p/,
     &   ncompallow_supLTS_to_supLTS       
     &       /ncompallow_supLTS_to_supLTS_p/,
     &   ncompallow_supLTS_to_spinstell    
     &       /ncompallow_supLTS_to_spinstell_p/,
     &   ncompallow_supLTS_to_tuftIB       
     &       /ncompallow_supLTS_to_tuftIB_p/,
     &   ncompallow_supLTS_to_tuftRS       
     &       /ncompallow_supLTS_to_tuftRS_p/,
     &   ncompallow_supLTS_to_deepbask     
     &       /ncompallow_supLTS_to_deepbask_p/,
     &   ncompallow_supLTS_to_deepaxax     
     &       /ncompallow_supLTS_to_deepaxax_p/,
     &   ncompallow_supLTS_to_deepLTS      
     &       /ncompallow_supLTS_to_deepLTS_p/,
     &   ncompallow_supLTS_to_nontuftRS    
     &       /ncompallow_supLTS_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_spinstell_to_suppyrRS 
     &       /ncompallow_spinstell_to_suppyrRS_p/,
     &   ncompallow_spinstell_to_suppyrFRB 
     &       /ncompallow_spinstell_to_suppyrFRB_p/,
     &   ncompallow_spinstell_to_supbask   
     &       /ncompallow_spinstell_to_supbask_p/,
     &   ncompallow_spinstell_to_supaxax   
     &       /ncompallow_spinstell_to_supaxax_p/,
     &   ncompallow_spinstell_to_supLTS    
     &       /ncompallow_spinstell_to_supLTS_p/,
     &   ncompallow_spinstell_to_spinstell 
     &       /ncompallow_spinstell_to_spinstell_p/,
     &   ncompallow_spinstell_to_tuftIB    
     &       /ncompallow_spinstell_to_tuftIB_p/,
     &   ncompallow_spinstell_to_tuftRS    
     &       /ncompallow_spinstell_to_tuftRS_p/,
     &   ncompallow_spinstell_to_deepbask  
     &       /ncompallow_spinstell_to_deepbask_p/,
     &   ncompallow_spinstell_to_deepaxax  
     &       /ncompallow_spinstell_to_deepaxax_p/,
     &   ncompallow_spinstell_to_deepLTS   
     &       /ncompallow_spinstell_to_deepLTS_p/,
     &   ncompallow_spinstell_to_nontuftRS 
     &       /ncompallow_spinstell_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_tuftIB_to_suppyrRS   
     &       /ncompallow_tuftIB_to_suppyrRS_p/,
     &   ncompallow_tuftIB_to_suppyrFRB    
     &       /ncompallow_tuftIB_to_suppyrFRB_p/,
     &   ncompallow_tuftIB_to_supbask      
     &       /ncompallow_tuftIB_to_supbask_p/,
     &   ncompallow_tuftIB_to_supaxax      
     &       /ncompallow_tuftIB_to_supaxax_p/,
     &   ncompallow_tuftIB_to_supLTS       
     &       /ncompallow_tuftIB_to_supLTS_p/,
     &   ncompallow_tuftIB_to_spinstell    
     &       /ncompallow_tuftIB_to_spinstell_p/,
     &   ncompallow_tuftIB_to_tuftIB       
     &       /ncompallow_tuftIB_to_tuftIB_p/,
     &   ncompallow_tuftIB_to_tuftRS       
     &       /ncompallow_tuftIB_to_tuftRS_p/,
     &   ncompallow_tuftIB_to_deepbask     
     &       /ncompallow_tuftIB_to_deepbask_p/,
     &   ncompallow_tuftIB_to_deepaxax     
     &       /ncompallow_tuftIB_to_deepaxax_p/,
     &   ncompallow_tuftIB_to_deepLTS      
     &       /ncompallow_tuftIB_to_deepLTS_p/,
     &   ncompallow_tuftIB_to_nontuftRS    
     &       /ncompallow_tuftIB_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_tuftRS_to_suppyrRS   
     &       /ncompallow_tuftRS_to_suppyrRS_p/,
     &   ncompallow_tuftRS_to_suppyrFRB    
     &       /ncompallow_tuftRS_to_suppyrFRB_p/,
     &   ncompallow_tuftRS_to_supbask      
     &       /ncompallow_tuftRS_to_supbask_p/,
     &   ncompallow_tuftRS_to_supaxax      
     &       /ncompallow_tuftRS_to_supaxax_p/,
     &   ncompallow_tuftRS_to_supLTS       
     &       /ncompallow_tuftRS_to_supLTS_p/,
     &   ncompallow_tuftRS_to_spinstell    
     &       /ncompallow_tuftRS_to_spinstell_p/,
     &   ncompallow_tuftRS_to_tuftIB       
     &       /ncompallow_tuftRS_to_tuftIB_p/,
     &   ncompallow_tuftRS_to_tuftRS       
     &       /ncompallow_tuftRS_to_tuftRS_p/,
     &   ncompallow_tuftRS_to_deepbask     
     &       /ncompallow_tuftRS_to_deepbask_p/,
     &   ncompallow_tuftRS_to_deepaxax     
     &       /ncompallow_tuftRS_to_deepaxax_p/,
     &   ncompallow_tuftRS_to_deepLTS      
     &       /ncompallow_tuftRS_to_deepLTS_p/,
     &   ncompallow_tuftRS_to_nontuftRS    
     &       /ncompallow_tuftRS_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_deepbask_to_spinstell 
     &       /ncompallow_deepbask_to_spinstell_p/, 
     &   ncompallow_deepbask_to_tuftIB     
     &       /ncompallow_deepbask_to_tuftIB_p/,
     &   ncompallow_deepbask_to_tuftRS     
     &       /ncompallow_deepbask_to_tuftRS_p/,
     &   ncompallow_deepbask_to_deepbask   
     &       /ncompallow_deepbask_to_deepbask_p/,
     &   ncompallow_deepbask_to_deepaxax   
     &       /ncompallow_deepbask_to_deepaxax_p/,
     &   ncompallow_deepbask_to_deepLTS    
     &       /ncompallow_deepbask_to_deepLTS_p/,
     &   ncompallow_deepbask_to_nontuftRS  
     &       /ncompallow_deepbask_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_deepLTS_to_suppyrRS 
     &       /ncompallow_deepLTS_to_suppyrRS_p/,
     &   ncompallow_deepLTS_to_suppyrFRB   
     &       /ncompallow_deepLTS_to_suppyrFRB_p/,
     &   ncompallow_deepLTS_to_supbask     
     &       /ncompallow_deepLTS_to_supbask_p/,
     &   ncompallow_deepLTS_to_supaxax     
     &       /ncompallow_deepLTS_to_supaxax_p/,
     &   ncompallow_deepLTS_to_supLTS      
     &       /ncompallow_deepLTS_to_supLTS_p/,
     &   ncompallow_deepLTS_to_spinstell   
     &       /ncompallow_deepLTS_to_spinstell_p/,
     &   ncompallow_deepLTS_to_tuftIB      
     &       /ncompallow_deepLTS_to_tuftIB_p/,
     &   ncompallow_deepLTS_to_tuftRS      
     &       /ncompallow_deepLTS_to_tuftRS_p/,
     &   ncompallow_deepLTS_to_deepbask    
     &       /ncompallow_deepLTS_to_deepbask_p/,
     &   ncompallow_deepLTS_to_deepaxax    
     &       /ncompallow_deepLTS_to_deepaxax_p/,
     &   ncompallow_deepLTS_to_deepLTS     
     &       /ncompallow_deepLTS_to_deepLTS_p/,
     &   ncompallow_deepLTS_to_nontuftRS   
     &       /ncompallow_deepLTS_to_nontuftRS_p/


        INTEGER 
     &   ncompallow_TCR_to_suppyrRS 
     &       /ncompallow_TCR_to_suppyrRS_p/,
     &   ncompallow_TCR_to_suppyrFRB    
     &       /ncompallow_TCR_to_suppyrFRB_p/,
     &   ncompallow_TCR_to_supbask      
     &       /ncompallow_TCR_to_supbask_p/,
     &   ncompallow_TCR_to_supaxax      
     &       /ncompallow_TCR_to_supaxax_p/,
     &   ncompallow_TCR_to_spinstell    
     &       /ncompallow_TCR_to_spinstell_p/,
     &   ncompallow_TCR_to_tuftIB       
     &       /ncompallow_TCR_to_tuftIB_p/,
     &   ncompallow_TCR_to_tuftRS       
     &       /ncompallow_TCR_to_tuftRS_p/,
     &   ncompallow_TCR_to_deepbask     
     &       /ncompallow_TCR_to_deepbask_p/,
     &   ncompallow_TCR_to_deepaxax     
     &       /ncompallow_TCR_to_deepaxax_p/,
     &   ncompallow_TCR_to_nRT          
     &       /ncompallow_TCR_to_nRT_p/,
     &   ncompallow_TCR_to_nontuftRS    
     &       /ncompallow_TCR_to_nontuftRS_p/

        INTEGER 
     &   ncompallow_nRT_to_TCR  
     &       /ncompallow_nRT_to_TCR_p/,
     &   ncompallow_nRT_to_nRT 
     &       /ncompallow_nRT_to_nRT_p/

        INTEGER 
     &    ncompallow_nontuftRS_to_suppyrRS 
     &       /ncompallow_nontuftRS_to_suppyrRS_p/,
     &    ncompallow_nontuftRS_to_suppyrFRB 
     &       /ncompallow_nontuftRS_to_suppyrFRB_p/,
     &    ncompallow_nontuftRS_to_supbask   
     &       /ncompallow_nontuftRS_to_supbask_p/,
     &    ncompallow_nontuftRS_to_supaxax   
     &       /ncompallow_nontuftRS_to_supaxax_p/,
     &    ncompallow_nontuftRS_to_supLTS    
     &       /ncompallow_nontuftRS_to_supLTS_p/,
     &    ncompallow_nontuftRS_to_spinstell 
     &       /ncompallow_nontuftRS_to_spinstell_p/,
     &    ncompallow_nontuftRS_to_tuftIB    
     &       /ncompallow_nontuftRS_to_tuftIB_p/,
     &    ncompallow_nontuftRS_to_tuftRS    
     &       /ncompallow_nontuftRS_to_tuftRS_p/,
     &    ncompallow_nontuftRS_to_deepbask  
     &       /ncompallow_nontuftRS_to_deepbask_p/,
     &    ncompallow_nontuftRS_to_deepaxax  
     &       /ncompallow_nontuftRS_to_deepaxax_p/,
     &    ncompallow_nontuftRS_to_deepLTS   
     &       /ncompallow_nontuftRS_to_deepLTS_p/,
     &    ncompallow_nontuftRS_to_TCR       
     &       /ncompallow_nontuftRS_to_TCR_p/,
     &    ncompallow_nontuftRS_to_nRT       
     &       /ncompallow_nontuftRS_to_nRT_p/,
     &    ncompallow_nontuftRS_to_nontuftRS 
     &       /ncompallow_nontuftRS_to_nontuftRS_p/
c     parameters converted to integers above

c Assorted parameters
         REAL*8 dt/ 0.002d0/
         REAL*8 Mg/ 1.50d0 /
! Castro-Alamancos J Physiol, disinhib. neocortex in vitro, uses
! Mg = 1.3
         REAL*8 NMDA_saturation_fact
!    &                                   = 5.d0
     &                                   /80.d0/
c NMDA conductance developed on one postsynaptic compartment,
c from one type of presynaptic cell, can be at most this
c factor x unitary conductance
c UNFORTUNATELY, with this scheme,if one NMDA cond. set to 0
c on a cell type, all NMDA conductances will be forced to 0
c on that cell type...

       REAL*8 thal_cort_delay /1.d0/
       REAL*8 cort_thal_delay /5.d0/
! changed from PARAMETER to   INTEGER how_often = 50 and moved below declarations
       INTEGER:: how_often =50
! these values were defined as integer, PARAMETER in the orig code.  They are defined
! here as integers since that fort90 feature is not available in g77
! Note: if a X_p parameter is changed then these X parameters (integers) also need to 
! be changed to the same value:
       integer:: totaxgj_suppyrRS = totaxgj_suppyrRS_p ! 722
       integer:: totaxgj_suppyrFRB =totaxgj_suppyrFRB_p ! 722
       integer:: totaxgj_suppyr =totaxgj_suppyr_p ! 74
       integer:: totSDgj_supbask =totSDgj_supbask_p ! 200
       integer:: totSDgj_supaxax =totSDgj_supaxax_p ! 0
       integer:: totSDgj_supLTS    =totSDgj_supLTS_p !    200
       integer:: totaxgj_spinstell =totaxgj_spinstell_p ! 240
       integer:: totaxgj_tuftIB    =totaxgj_tuftIB_p !    350
       integer:: totaxgj_tuftRS    =totaxgj_tuftRS_p !    350
!       integer:: totaxgj_tuft      =350
       integer:: totaxgj_tuft       =totaxgj_tuft_p !       10
       integer:: totaxgj_nontuftRS =totaxgj_nontuftRS_p ! 500
       integer:: totSDgj_deepbask  =totSDgj_deepbask_p !  250
       integer:: totSDgj_deepaxax   =totSDgj_deepaxax_p !   0
       integer:: totSDgj_deepLTS  =totSDgj_deepLTS_p !  250
       integer:: totaxgj_TCR       =totaxgj_TCR_p !       100
       integer:: totSDgj_nRT       =totSDgj_nRT_p !       250
       integer:: num_axgjcompallow_suppyrRS 
     &          =num_axgjcompallow_suppyrRS_p ! 1
       integer:: num_axgjcompallow_suppyrFRB 
     &          =num_axgjcompallow_suppyrFRB_p ! 1
       integer:: num_SDgjcompallow_supbask  
     &          =num_SDgjcompallow_supbask_p !  8
       integer:: num_SDgjcompallow_supLTS   
     &          =num_SDgjcompallow_supLTS_p !   8
       integer:: num_axgjcompallow_spinstell 
     &          =num_axgjcompallow_spinstell_p ! 1
       integer:: num_axgjcompallow_tuftIB   
     &          =num_axgjcompallow_tuftIB_p !   1
       integer:: num_axgjcompallow_tuftRS   
     &          =num_axgjcompallow_tuftRS_p !   1
       integer:: num_axgjcompallow_nontuftRS 
     &          =num_axgjcompallow_nontuftRS_p ! 1
       integer:: num_SDgjcompallow_deepbask 
     &          =num_SDgjcompallow_deepbask_p ! 8
       integer:: num_SDgjcompallow_deepLTS  
     &          =num_SDgjcompallow_deepLTS_p !  8
       integer:: num_axgjcompallow_TCR      
     &          =num_axgjcompallow_TCR_p !      1
       integer:: num_SDgjcompallow_nRT  
     &          =num_SDgjcompallow_nRT_p !  8

       integer num_suppyrRS_to_suppyrRS /num_suppyrRS_to_suppyrRS_p/,
     &   num_suppyrRS_to_suppyrFRB /num_suppyrRS_to_suppyrFRB_p/,
     &   num_suppyrRS_to_supbask /num_suppyrRS_to_supbask_p/,
     &   num_suppyrRS_to_supaxax /num_suppyrRS_to_supaxax_p/,
     &   num_suppyrRS_to_supLTS /num_suppyrRS_to_supLTS_p/,
     &   num_suppyrRS_to_spinstell /num_suppyrRS_to_spinstell_p/,
     &   num_suppyrRS_to_tuftIB /num_suppyrRS_to_tuftIB_p/,
     &   num_suppyrRS_to_tuftRS /num_suppyrRS_to_tuftRS_p/, 
     &   num_suppyrRS_to_deepbask /num_suppyrRS_to_deepbask_p/,
     &   num_suppyrRS_to_deepaxax /num_suppyrRS_to_deepaxax_p/,
     &   num_suppyrRS_to_deepLTS /num_suppyrRS_to_deepLTS_p/,
     &   num_suppyrRS_to_nontuftRS /num_suppyrRS_to_nontuftRS_p/,
     &   num_suppyrFRB_to_suppyrRS /num_suppyrFRB_to_suppyrRS_p/,
     &   num_suppyrFRB_to_suppyrFRB /num_suppyrFRB_to_suppyrFRB_p/,
     &   num_suppyrFRB_to_supbask /num_suppyrFRB_to_supbask_p/,
     &   num_suppyrFRB_to_supaxax /num_suppyrFRB_to_supaxax_p/,
     &   num_suppyrFRB_to_supLTS /num_suppyrFRB_to_supLTS_p/,
     &   num_suppyrFRB_to_spinstell /num_suppyrFRB_to_spinstell_p/,
     &   num_suppyrFRB_to_tuftIB /num_suppyrFRB_to_tuftIB_p/,
     &   num_suppyrFRB_to_tuftRS /num_suppyrFRB_to_tuftRS_p/,
     &   num_suppyrFRB_to_deepbask /num_suppyrFRB_to_deepbask_p/,
     &   num_suppyrFRB_to_deepaxax /num_suppyrFRB_to_deepaxax_p/,
     &   num_suppyrFRB_to_deepLTS /num_suppyrFRB_to_deepLTS_p/,
     &   num_suppyrFRB_to_nontuftRS /num_suppyrFRB_to_nontuftRS_p/

! how_often defines how many time steps between synaptic conductance
! updates, and between broadcastings of axonal voltages.
       real*8 axon_refrac_time /1.5d0/

c For these ectopic rate parameters, assume noisepe checked
c every 200 time steps = 0.4 ms = 1./2.5 ms
       real*8  noisepe_suppyrRS
!     &            1.d0 / (2.5d0 * 10000.d0) /
!!    &            1.d0 / (2.5d0 * 1000.d0) ! USUAL

       real*8  noisepe_suppyrFRB
!     &            1.d0 / (2.5d0 * 10000.d0) )
!!    &            1.d0 / (2.5d0 * 1000.d0) ! USUAL

       real*8  noisepe_spinstell
!     &            1.d0 / (2.5d0 * 1000.d0) )
       real*8  noisepe_tuftIB 
!     &            1.d0 / (2.5d0 * 1000.d0) )
       real*8  noisepe_tuftRS
!     &            1.d0 / (2.5d0 * 1000.d0) )
       real*8  noisepe_nontuftRS
!     &            1.d0 / (2.5d0 * 1000.d0) )
       real*8  noisepe_TCR 
!     &            1.d0 / (2.5d0 * 1000.d0) )


c Synaptic conductance time constants. 
      REAL*8 tauAMPA_suppyrRS_to_suppyrRS/2.d0 /
      REAL*8 tauNMDA_suppyrRS_to_suppyrRS/130.5d0 /
      REAL*8 tauAMPA_suppyrRS_to_suppyrFRB/2.d0 /
      REAL*8 tauNMDA_suppyrRS_to_suppyrFRB/130.d0  /
      REAL*8 tauAMPA_suppyrRS_to_supbask  /.8d0   /
      REAL*8 tauNMDA_suppyrRS_to_supbask  /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_supaxax  /.8d0  /
      REAL*8 tauNMDA_suppyrRS_to_supaxax  /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_supLTS   /1.d0  /
      REAL*8 tauNMDA_suppyrRS_to_supLTS   /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_spinstell/2.d0   /
      REAL*8 tauNMDA_suppyrRS_to_spinstell/130.d0 /
      REAL*8 tauAMPA_suppyrRS_to_tuftIB   /2.d0   /
      REAL*8 tauNMDA_suppyrRS_to_tuftIB   /130.d0 /
      REAL*8 tauAMPA_suppyrRS_to_tuftRS   /2.d0   /
      REAL*8 tauNMDA_suppyrRS_to_tuftRS   /130.d0 /
      REAL*8 tauAMPA_suppyrRS_to_deepbask /.8d0   /
      REAL*8 tauNMDA_suppyrRS_to_deepbask /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_deepaxax /.8d0   /
      REAL*8 tauNMDA_suppyrRS_to_deepaxax /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_deepLTS  /1.d0   /
      REAL*8 tauNMDA_suppyrRS_to_deepLTS  /100.d0 /
      REAL*8 tauAMPA_suppyrRS_to_nontuftRS/2.d0   /
      REAL*8 tauNMDA_suppyrRS_to_nontuftRS/130.d0 /

      REAL*8 tauAMPA_suppyrFRB_to_suppyrRS/2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_suppyrRS/130.d0  /
      REAL*8 tauAMPA_suppyrFRB_to_suppyrFRB/2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_suppyrFRB/130.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_supbask  /.8d0   /
      REAL*8 tauNMDA_suppyrFRB_to_supbask  /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_supaxax  /.8d0  /
      REAL*8 tauNMDA_suppyrFRB_to_supaxax  /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_supLTS   /1.d0  /
      REAL*8 tauNMDA_suppyrFRB_to_supLTS   /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_spinstell/2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_spinstell/130.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_tuftIB   /2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_tuftIB   /130.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_tuftRS   /2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_tuftRS   /130.d0/
      REAL*8 tauAMPA_suppyrFRB_to_deepbask /.8d0   /
      REAL*8 tauNMDA_suppyrFRB_to_deepbask /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_deepaxax /.8d0   /
      REAL*8 tauNMDA_suppyrFRB_to_deepaxax /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_deepLTS  /1.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_deepLTS  /100.d0 /
      REAL*8 tauAMPA_suppyrFRB_to_nontuftRS/2.d0   /
      REAL*8 tauNMDA_suppyrFRB_to_nontuftRS/130.d0 /

      REAL*8 tauGABA_supbask_to_suppyrRS   /6.d0  /
      REAL*8 tauGABA_supbask_to_suppyrFRB  /6.d0  /
      REAL*8 tauGABA_supbask_to_supbask    /3.d0  /
      REAL*8 tauGABA_supbask_to_supaxax    /3.d0  /
      REAL*8 tauGABA_supbask_to_supLTS     /3.d0  /
      REAL*8 tauGABA_supbask_to_spinstell  /6.d0  /

      REAL*8 tauGABA_supaxax_to_suppyrRS   /6.d0  /
      REAL*8 tauGABA_supaxax_to_suppyrFRB  /6.d0  /
      REAL*8 tauGABA_supaxax_to_spinstell  /6.d0  /
      REAL*8 tauGABA_supaxax_to_tuftIB     /6.d0  /
      REAL*8 tauGABA_supaxax_to_tuftRS     /6.d0  /
      REAL*8 tauGABA_supaxax_to_nontuftRS  /6.d0  /

      REAL*8 tauGABA_supLTS_to_suppyrRS    /20.d0 /
      REAL*8 tauGABA_supLTS_to_suppyrFRB   /20.d0 /
      REAL*8 tauGABA_supLTS_to_supbask     /20.d0 /
      REAL*8 tauGABA_supLTS_to_supaxax     /20.d0 /
      REAL*8 tauGABA_supLTS_to_supLTS      /20.d0 /
      REAL*8 tauGABA_supLTS_to_spinstell   /20.d0 /
      REAL*8 tauGABA_supLTS_to_tuftIB      /20.d0 /
      REAL*8 tauGABA_supLTS_to_tuftRS      /20.d0 /
      REAL*8 tauGABA_supLTS_to_deepbask    /20.d0 /
      REAL*8 tauGABA_supLTS_to_deepaxax    /20.d0 /
      REAL*8 tauGABA_supLTS_to_deepLTS     /20.d0 /
      REAL*8 tauGABA_supLTS_to_nontuftRS   /20.d0  /

      REAL*8 tauAMPA_spinstell_to_suppyrRS /2.d0  /
      REAL*8 tauNMDA_spinstell_to_suppyrRS /130.d0 /
      REAL*8 tauAMPA_spinstell_to_suppyrFRB/2.d0  /
      REAL*8 tauNMDA_spinstell_to_suppyrFRB/130.d0 /
      REAL*8 tauAMPA_spinstell_to_supbask  /.8d0  /
      REAL*8 tauNMDA_spinstell_to_supbask  /100.d0/
      REAL*8 tauAMPA_spinstell_to_supaxax  /.8d0  /
      REAL*8 tauNMDA_spinstell_to_supaxax  /100.d0/
      REAL*8 tauAMPA_spinstell_to_supLTS   /1.d0  /
      REAL*8 tauNMDA_spinstell_to_supLTS   /100.d0/
      REAL*8 tauAMPA_spinstell_to_spinstell/2.d0  /
      REAL*8 tauNMDA_spinstell_to_spinstell/130.d0 /
      REAL*8 tauAMPA_spinstell_to_tuftIB   /2.d0  /
      REAL*8 tauNMDA_spinstell_to_tuftIB   /130.d0 /
      REAL*8 tauAMPA_spinstell_to_tuftRS   /2.d0  /
      REAL*8 tauNMDA_spinstell_to_tuftRS   /130.d0/
      REAL*8 tauAMPA_spinstell_to_deepbask /.8d0  /
      REAL*8 tauNMDA_spinstell_to_deepbask /100.d0/
      REAL*8 tauAMPA_spinstell_to_deepaxax /.8d0  /
      REAL*8 tauNMDA_spinstell_to_deepaxax /100.d0/
      REAL*8 tauAMPA_spinstell_to_deepLTS  /1.d0  /
      REAL*8 tauNMDA_spinstell_to_deepLTS  /100.d0/
      REAL*8 tauAMPA_spinstell_to_nontuftRS/2.d0  /
      REAL*8 tauNMDA_spinstell_to_nontuftRS/130.d0/

      REAL*8 tauAMPA_tuftIB_to_suppyrRS    /2.d0 /
      REAL*8 tauNMDA_tuftIB_to_suppyrRS    /130.d0/
      REAL*8 tauAMPA_tuftIB_to_suppyrFRB   /2.d0 /
      REAL*8 tauNMDA_tuftIB_to_suppyrFRB   /130.d0/
      REAL*8 tauAMPA_tuftIB_to_supbask     /.8d0  /
      REAL*8 tauNMDA_tuftIB_to_supbask     /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_supaxax     /.8d0  /
      REAL*8 tauNMDA_tuftIB_to_supaxax     /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_supLTS      /1.d0  /
      REAL*8 tauNMDA_tuftIB_to_supLTS      /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_spinstell   /2.d0   /
      REAL*8 tauNMDA_tuftIB_to_spinstell   /130.d0 /
      REAL*8 tauAMPA_tuftIB_to_tuftIB      /2.d0  /
      REAL*8 tauNMDA_tuftIB_to_tuftIB      /130.d0 /
      REAL*8 tauAMPA_tuftIB_to_tuftRS      /2.0d0 /
      REAL*8 tauNMDA_tuftIB_to_tuftRS      /130.d0 /
      REAL*8 tauAMPA_tuftIB_to_deepbask    /.8d0  /
      REAL*8 tauNMDA_tuftIB_to_deepbask    /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_deepaxax    /.8d0  /
      REAL*8 tauNMDA_tuftIB_to_deepaxax    /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_deepLTS     /1.d0  /
      REAL*8 tauNMDA_tuftIB_to_deepLTS     /100.d0 /
      REAL*8 tauAMPA_tuftIB_to_nontuftRS   /2.0d0 /
      REAL*8 tauNMDA_tuftIB_to_nontuftRS   /130.d0 /

      REAL*8 tauAMPA_tuftRS_to_suppyrRS    /2.d0 /
      REAL*8 tauNMDA_tuftRS_to_suppyrRS    /130.d0/
      REAL*8 tauAMPA_tuftRS_to_suppyrFRB   /2.d0 /
      REAL*8 tauNMDA_tuftRS_to_suppyrFRB   /130.d0/
      REAL*8 tauAMPA_tuftRS_to_supbask     /.8d0  /
      REAL*8 tauNMDA_tuftRS_to_supbask     /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_supaxax     /.8d0  /
      REAL*8 tauNMDA_tuftRS_to_supaxax     /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_supLTS      /1.d0  /
      REAL*8 tauNMDA_tuftRS_to_supLTS      /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_spinstell   /2.d0  /
      REAL*8 tauNMDA_tuftRS_to_spinstell   /130.d0 /
      REAL*8 tauAMPA_tuftRS_to_tuftIB      /2.d0  /
      REAL*8 tauNMDA_tuftRS_to_tuftIB      /130.d0 /
      REAL*8 tauAMPA_tuftRS_to_tuftRS      /2.d0  /
      REAL*8 tauNMDA_tuftRS_to_tuftRS      /130.d0 /
      REAL*8 tauAMPA_tuftRS_to_deepbask    /.8d0  /
      REAL*8 tauNMDA_tuftRS_to_deepbask    /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_deepaxax    /.8d0  /
      REAL*8 tauNMDA_tuftRS_to_deepaxax    /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_deepLTS     /1.d0   /
      REAL*8 tauNMDA_tuftRS_to_deepLTS     /100.d0 /
      REAL*8 tauAMPA_tuftRS_to_nontuftRS   /2.d0  /
      REAL*8 tauNMDA_tuftRS_to_nontuftRS   /130.d0 /

      REAL*8 tauGABA_deepbask_to_spinstell /6.d0  /
      REAL*8 tauGABA_deepbask_to_tuftIB    /6.d0  /
      REAL*8 tauGABA_deepbask_to_tuftRS    /6.d0  /
      REAL*8 tauGABA_deepbask_to_deepbask  /3.d0  /
      REAL*8 tauGABA_deepbask_to_deepaxax  /3.d0  /
      REAL*8 tauGABA_deepbask_to_deepLTS   /3.d0  /
      REAL*8 tauGABA_deepbask_to_nontuftRS /6.d0  /

      REAL*8 tauGABA_deepaxax_to_suppyrRS   /6.d0  /
      REAL*8 tauGABA_deepaxax_to_suppyrFRB  /6.d0  /
      REAL*8 tauGABA_deepaxax_to_spinstell  /6.d0  /
      REAL*8 tauGABA_deepaxax_to_tuftIB     /6.d0  /
      REAL*8 tauGABA_deepaxax_to_tuftRS     /6.d0  /
      REAL*8 tauGABA_deepaxax_to_nontuftRS  /6.d0  /

      REAL*8 tauGABA_deepLTS_to_suppyrRS    /20.d0 /
      REAL*8 tauGABA_deepLTS_to_suppyrFRB   /20.d0 /
      REAL*8 tauGABA_deepLTS_to_supbask     /20.d0 /
      REAL*8 tauGABA_deepLTS_to_supaxax     /20.d0 /
      REAL*8 tauGABA_deepLTS_to_supLTS      /20.d0 /
      REAL*8 tauGABA_deepLTS_to_spinstell   /20.d0 /
      REAL*8 tauGABA_deepLTS_to_tuftIB      /20.d0 /
      REAL*8 tauGABA_deepLTS_to_tuftRS      /20.d0 /
      REAL*8 tauGABA_deepLTS_to_deepbask    /20.d0 /
      REAL*8 tauGABA_deepLTS_to_deepaxax    /20.d0 /
      REAL*8 tauGABA_deepLTS_to_deepLTS     /20.d0 /
      REAL*8 tauGABA_deepLTS_to_nontuftRS   /20.d0 /

      REAL*8 tauAMPA_TCR_to_suppyrRS        /2.d0  /
      REAL*8 tauNMDA_TCR_to_suppyrRS        /130.d0/
      REAL*8 tauAMPA_TCR_to_suppyrFRB       /2.d0  /
      REAL*8 tauNMDA_TCR_to_suppyrFRB       /130.d0/
      REAL*8 tauAMPA_TCR_to_supbask         /1.d0  /
      REAL*8 tauNMDA_TCR_to_supbask         /100.d0/
      REAL*8 tauAMPA_TCR_to_supaxax         /1.d0  /
      REAL*8 tauNMDA_TCR_to_supaxax         /100.d0 /
      REAL*8 tauAMPA_TCR_to_spinstell       /2.0d0 /
      REAL*8 tauNMDA_TCR_to_spinstell       /130.d0/
      REAL*8 tauAMPA_TCR_to_tuftIB          /2.d0  /
      REAL*8 tauNMDA_TCR_to_tuftIB          /130.d0/
      REAL*8 tauAMPA_TCR_to_tuftRS          /2.d0  /
      REAL*8 tauNMDA_TCR_to_tuftRS          /130.d0/
      REAL*8 tauAMPA_TCR_to_deepbask        /1.d0  /
      REAL*8 tauNMDA_TCR_to_deepbask        /100.d0/
      REAL*8 tauAMPA_TCR_to_deepaxax        /1.d0  /
      REAL*8 tauNMDA_TCR_to_deepaxax        /100.d0/
      REAL*8 tauAMPA_TCR_to_nRT             /2.0d0      /
      REAL*8 tauNMDA_TCR_to_nRT             /150.d0/
      REAL*8 tauAMPA_TCR_to_nontuftRS       /2.0d0     /
      REAL*8 tauNMDA_TCR_to_nontuftRS       /130.d0/

!     REAL*8 tauGABA1_nRT_to_TCR             /10.d0 /
!     REAL*8 tauGABA2_nRT_to_TCR             /30.d0 /
!     REAL*8 tauGABA1_nRT_to_nRT             /18.d0 /
!     REAL*8 tauGABA2_nRT_to_nRT             /89.d0 /
! See notebook entry of 17 Feb. 2004.
! Speed these up per Huntsman & REAL*82000)
      real*8 tauGABA1_nRT_to_TCR             /3.30d0 /
      REAL*8 tauGABA2_nRT_to_TCR             /10.d0 /
      REAL*8 tauGABA1_nRT_to_nRT             / 9.d0 /
      REAL*8 tauGABA2_nRT_to_nRT             /44.5d0 /

      REAL*8 tauAMPA_nontuftRS_to_suppyrRS  /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_suppyrRS  /130.d0/
      REAL*8 tauAMPA_nontuftRS_to_suppyrFRB /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_suppyrFRB /130.d0/
      REAL*8 tauAMPA_nontuftRS_to_supbask   /.8d0  /
      REAL*8 tauNMDA_nontuftRS_to_supbask   /100.d0/
      REAL*8 tauAMPA_nontuftRS_to_supaxax   /.8d0  /
      REAL*8 tauNMDA_nontuftRS_to_supaxax   /100.d0 /
      REAL*8 tauAMPA_nontuftRS_to_supLTS    /1.0d0 /
      REAL*8 tauNMDA_nontuftRS_to_supLTS    /100.d0/
      REAL*8 tauAMPA_nontuftRS_to_spinstell /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_spinstell /130.d0/
      REAL*8 tauAMPA_nontuftRS_to_tuftIB    /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_tuftIB    /130.d0/
      REAL*8 tauAMPA_nontuftRS_to_tuftRS    /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_tuftRS    /130.d0/
      REAL*8 tauAMPA_nontuftRS_to_deepbask  /.8d0  /
      REAL*8 tauNMDA_nontuftRS_to_deepbask  /100.d0/
      REAL*8 tauAMPA_nontuftRS_to_deepaxax  /.8d0   /
      REAL*8 tauNMDA_nontuftRS_to_deepaxax  /100.d0/
      REAL*8 tauAMPA_nontuftRS_to_deepLTS   /1.d0  /
      REAL*8 tauNMDA_nontuftRS_to_deepLTS   /100.d0/
      REAL*8 tauAMPA_nontuftRS_to_TCR       /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_TCR       /130.d0 /
      REAL*8 tauAMPA_nontuftRS_to_nRT       /2.0d0 /
      REAL*8 tauNMDA_nontuftRS_to_nRT       /100.d0 /
      REAL*8 tauAMPA_nontuftRS_to_nontuftRS /2.d0  /
      REAL*8 tauNMDA_nontuftRS_to_nontuftRS /130.d0 /
c End definition of synaptic time constants

c conversion of f90 style to f77
      INTEGER:: num_suppyrRS = num_suppyrRS_p, 
     & num_suppyrFRB = num_suppyrFRB_p,
     & num_supbask = num_supbask_p,
     & num_supaxax = num_supaxax_p,
     & num_supLTS = num_supLTS_p,
     & num_spinstell = num_spinstell_p, 
     & num_tuftIB = num_tuftIB_p,
     & num_tuftRS = num_tuftRS_p,
     & num_nontuftRS = num_nontuftRS_p,
     & num_deepbask = num_deepbask_p, 
     & num_deepaxax = num_deepaxax_p,
     & num_deepLTS = num_deepLTS_p,
     & num_TCR = num_TCR_p,
     & num_nRT = num_nRT_p


c Synaptic conductance scaling factors.
      real*8 gAMPA_suppyrRS_to_suppyrRS /0.25d-3/
      real*8 gNMDA_suppyrRS_to_suppyrRS / 0.025d-3/
      real*8 gAMPA_suppyrRS_to_suppyrFRB / 0.25d-3/
      real*8 gNMDA_suppyrRS_to_suppyrFRB / 0.025d-3/
      real*8 gAMPA_suppyrRS_to_supbask  /3.00d-3/
      real*8 gNMDA_suppyrRS_to_supbask  /0.15d-3/
      real*8 gAMPA_suppyrRS_to_supaxax  /3.0d-3/
      real*8 gNMDA_suppyrRS_to_supaxax  /0.15d-3/
      real*8 gAMPA_suppyrRS_to_supLTS   /2.0d-3/
      real*8 gNMDA_suppyrRS_to_supLTS   /0.15d-3/
      real*8 gAMPA_suppyrRS_to_spinstell / 0.10d-3/
      real*8 gNMDA_suppyrRS_to_spinstell / 0.01d-3/
      real*8 gAMPA_suppyrRS_to_tuftIB   /0.10d-3/
      real*8 gNMDA_suppyrRS_to_tuftIB   /0.01d-3/
      real*8 gAMPA_suppyrRS_to_tuftRS   /0.10d-3/
      real*8 gNMDA_suppyrRS_to_tuftRS   /0.01d-3/
      real*8 gAMPA_suppyrRS_to_deepbask /1.00d-3/
      real*8 gNMDA_suppyrRS_to_deepbask /0.10d-3/
      real*8 gAMPA_suppyrRS_to_deepaxax /1.00d-3/
      real*8 gNMDA_suppyrRS_to_deepaxax /0.10d-3/
      real*8 gAMPA_suppyrRS_to_deepLTS  /1.00d-3/
      real*8 gNMDA_suppyrRS_to_deepLTS  /0.15d-3/
      real*8 gAMPA_suppyrRS_to_nontuftRS / 0.50d-3/
      real*8 gNMDA_suppyrRS_to_nontuftRS / 0.05d-3/

      real*8 gAMPA_suppyrFRB_to_suppyrRS / 0.25d-3/
      real*8 gNMDA_suppyrFRB_to_suppyrRS / 0.025d-3/
      real*8 gAMPA_suppyrFRB_to_suppyrFRB / 0.25d-3/
      real*8 gNMDA_suppyrFRB_to_suppyrFRB / .025d-3/
      real*8 gAMPA_suppyrFRB_to_supbask  /3.00d-3/
      real*8 gNMDA_suppyrFRB_to_supbask  /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_supaxax  /3.0d-3/
      real*8 gNMDA_suppyrFRB_to_supaxax  /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_supLTS   /2.0d-3/
      real*8 gNMDA_suppyrFRB_to_supLTS   /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_spinstell / 0.10d-3/
      real*8 gNMDA_suppyrFRB_to_spinstell / 0.01d-3/
      real*8 gAMPA_suppyrFRB_to_tuftIB   /0.10d-3/
      real*8 gNMDA_suppyrFRB_to_tuftIB   /0.01d-3/
      real*8 gAMPA_suppyrFRB_to_tuftRS   /0.10d-3/
      real*8 gNMDA_suppyrFRB_to_tuftRS   /0.01d-3/
      real*8 gAMPA_suppyrFRB_to_deepbask /1.00d-3/
      real*8 gNMDA_suppyrFRB_to_deepbask /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_deepaxax /1.00d-3/
      real*8 gNMDA_suppyrFRB_to_deepaxax /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_deepLTS  /1.00d-3/
      real*8 gNMDA_suppyrFRB_to_deepLTS  /0.10d-3/
      real*8 gAMPA_suppyrFRB_to_nontuftRS / 0.50d-3/
      real*8 gNMDA_suppyrFRB_to_nontuftRS / 0.05d-3/

      real*8 gGABA_supbask_to_suppyrRS   /1.2d-3/
      real*8 gGABA_supbask_to_suppyrFRB  /1.2d-3/
      real*8 gGABA_supbask_to_supbask    /0.2d-3/
      real*8 gGABA_supbask_to_supaxax    /0.2d-3/
      real*8 gGABA_supbask_to_supLTS     /0.5d-3/
!     real*8 gGABA_supbask_to_spinstell  /0.7d-3/
      real*8 gGABA_supbask_to_spinstell  /0.1d-3/ ! if main inhib. to spinstell from deep int.

      real*8 gGABA_supaxax_to_suppyrRS   /1.2d-3/
      real*8 gGABA_supaxax_to_suppyrFRB  /1.2d-3/
!     real*8 gGABA_supaxax_to_spinstell  /1.0d-3/
      real*8 gGABA_supaxax_to_spinstell  /0.1d-3/ ! if main inhib. to spinstell from deep int.
      real*8 gGABA_supaxax_to_tuftIB     /1.0d-3/
      real*8 gGABA_supaxax_to_tuftRS     /1.0d-3/
      real*8 gGABA_supaxax_to_nontuftRS  /1.0d-3/


      real*8 gGABA_supLTS_to_suppyrRS    /.01d-3/
      real*8 gGABA_supLTS_to_suppyrFRB   /.01d-3/
      real*8 gGABA_supLTS_to_supbask     /.01d-3/
      real*8 gGABA_supLTS_to_supaxax     /.01d-3/
      real*8 gGABA_supLTS_to_supLTS      /.05d-3/
      real*8 gGABA_supLTS_to_spinstell   /.01d-3/
      real*8 gGABA_supLTS_to_tuftIB      /.02d-3/
      real*8 gGABA_supLTS_to_tuftRS      /.02d-3/
      real*8 gGABA_supLTS_to_deepbask    /.01d-3/
      real*8 gGABA_supLTS_to_deepaxax    /.01d-3/
      real*8 gGABA_supLTS_to_deepLTS     /.05d-3/
      real*8 gGABA_supLTS_to_nontuftRS   /.01d-3/

      real*8 gAMPA_spinstell_to_suppyrRS /1.0d-3/
      real*8 gNMDA_spinstell_to_suppyrRS /0.1d-3/
      real*8 gAMPA_spinstell_to_suppyrFRB / 1.0d-3/
      real*8 gNMDA_spinstell_to_suppyrFRB / 0.1d-3/
      real*8 gAMPA_spinstell_to_supbask  /1.0d-3/
      real*8 gNMDA_spinstell_to_supbask  /.15d-3/
      real*8 gAMPA_spinstell_to_supaxax  /1.0d-3/
      real*8 gNMDA_spinstell_to_supaxax  /.15d-3/
      real*8 gAMPA_spinstell_to_supLTS   /1.0d-3/
      real*8 gNMDA_spinstell_to_supLTS   /.15d-3/
      real*8 gAMPA_spinstell_to_spinstell / 1.0d-3/
      real*8 gNMDA_spinstell_to_spinstell / 0.1d-3/
      real*8 gAMPA_spinstell_to_tuftIB   /1.0d-3/
      real*8 gNMDA_spinstell_to_tuftIB   /0.1d-3/
      real*8 gAMPA_spinstell_to_tuftRS   /1.0d-3/
      real*8 gNMDA_spinstell_to_tuftRS   /0.1d-3/
      real*8 gAMPA_spinstell_to_deepbask /1.0d-3/
      real*8 gNMDA_spinstell_to_deepbask /.15d-3/
      real*8 gAMPA_spinstell_to_deepaxax /1.0d-3/
      real*8 gNMDA_spinstell_to_deepaxax /.15d-3/
      real*8 gAMPA_spinstell_to_deepLTS  /1.0d-3/
      real*8 gNMDA_spinstell_to_deepLTS  /.15d-3/
      real*8 gAMPA_spinstell_to_nontuftRS / 1.0d-3/
      real*8 gNMDA_spinstell_to_nontuftRS / 0.1d-3/

      real*8 gAMPA_tuftIB_to_suppyrRS    /0.5d-3/
      real*8 gNMDA_tuftIB_to_suppyrRS    /0.05d-3/
      real*8 gAMPA_tuftIB_to_suppyrFRB   /0.5d-3/
      real*8 gNMDA_tuftIB_to_suppyrFRB   /0.05d-3/
      real*8 gAMPA_tuftIB_to_supbask     /1.0d-3/
      real*8 gNMDA_tuftIB_to_supbask     /0.15d-3/
      real*8 gAMPA_tuftIB_to_supaxax     /1.0d-3/
      real*8 gNMDA_tuftIB_to_supaxax     /0.15d-3/
      real*8 gAMPA_tuftIB_to_supLTS      /1.0d-3/
      real*8 gNMDA_tuftIB_to_supLTS      /0.15d-3/
      real*8 gAMPA_tuftIB_to_spinstell   /0.5d-3/
      real*8 gNMDA_tuftIB_to_spinstell   /0.05d-3/
      real*8 gAMPA_tuftIB_to_tuftIB      /2.0d-3/
      real*8 gNMDA_tuftIB_to_tuftIB      /0.20d-3/
      real*8 gAMPA_tuftIB_to_tuftRS      /2.0d-3/
      real*8 gNMDA_tuftIB_to_tuftRS      /0.20d-3/
      real*8 gAMPA_tuftIB_to_deepbask    /3.0d-3/
      real*8 gNMDA_tuftIB_to_deepbask    /0.15d-3/
      real*8 gAMPA_tuftIB_to_deepaxax    /3.0d-3/
      real*8 gNMDA_tuftIB_to_deepaxax    /0.15d-3/
      real*8 gAMPA_tuftIB_to_deepLTS     /2.0d-3/
      real*8 gNMDA_tuftIB_to_deepLTS     /0.15d-3/
      real*8 gAMPA_tuftIB_to_nontuftRS   /2.0d-3/
      real*8 gNMDA_tuftIB_to_nontuftRS   /0.20d-3/

      real*8 gAMPA_tuftRS_to_suppyrRS    /0.5d-3/
      real*8 gNMDA_tuftRS_to_suppyrRS    /0.05d-3/
      real*8 gAMPA_tuftRS_to_suppyrFRB   /0.5d-3/
      real*8 gNMDA_tuftRS_to_suppyrFRB   /0.05d-3/
      real*8 gAMPA_tuftRS_to_supbask     /1.0d-3/
      real*8 gNMDA_tuftRS_to_supbask     /0.15d-3/
      real*8 gAMPA_tuftRS_to_supaxax     /1.0d-3/
      real*8 gNMDA_tuftRS_to_supaxax     /0.15d-3/
      real*8 gAMPA_tuftRS_to_supLTS      /1.0d-3/
      real*8 gNMDA_tuftRS_to_supLTS      /0.15d-3/
      real*8 gAMPA_tuftRS_to_spinstell   /0.5d-3/
      real*8 gNMDA_tuftRS_to_spinstell   /0.05d-3/
      real*8 gAMPA_tuftRS_to_tuftIB      /1.0d-3/
      real*8 gNMDA_tuftRS_to_tuftIB      /0.10d-3/
      real*8 gAMPA_tuftRS_to_tuftRS      /1.0d-3/
      real*8 gNMDA_tuftRS_to_tuftRS      /0.10d-3/
      real*8 gAMPA_tuftRS_to_deepbask    /3.0d-3/
      real*8 gNMDA_tuftRS_to_deepbask    /0.10d-3/
      real*8 gAMPA_tuftRS_to_deepaxax    /3.0d-3/
      real*8 gNMDA_tuftRS_to_deepaxax    /0.10d-3/
      real*8 gAMPA_tuftRS_to_deepLTS     /2.0d-3/
      real*8 gNMDA_tuftRS_to_deepLTS     /0.10d-3/
      real*8 gAMPA_tuftRS_to_nontuftRS   /1.0d-3/
      real*8 gNMDA_tuftRS_to_nontuftRS   /0.10d-3/

!     real*8 gGABA_deepbask_to_spinstell /1.0d-3/
      real*8 gGABA_deepbask_to_spinstell /1.5d-3/ ! ? suppress spiny stellate bursts ?
      real*8 gGABA_deepbask_to_tuftIB    /0.7d-3/
      real*8 gGABA_deepbask_to_tuftRS    /0.7d-3/
      real*8 gGABA_deepbask_to_deepbask  /0.2d-3/
      real*8 gGABA_deepbask_to_deepaxax  /0.2d-3/
      real*8 gGABA_deepbask_to_deepLTS   /0.7d-3/
      real*8 gGABA_deepbask_to_nontuftRS /0.7d-3/

      real*8 gGABA_deepaxax_to_suppyrRS   /1.0d-3/
      real*8 gGABA_deepaxax_to_suppyrFRB  /1.0d-3/
!     real*8 gGABA_deepaxax_to_spinstell  /1.0d-3/
      real*8 gGABA_deepaxax_to_spinstell  /1.5d-3/ ! ? suppress spiny stellate bursts ?
      real*8 gGABA_deepaxax_to_tuftIB     /1.0d-3/
      real*8 gGABA_deepaxax_to_tuftRS     /1.0d-3/
      real*8 gGABA_deepaxax_to_nontuftRS  /1.0d-3/

      real*8 gGABA_deepLTS_to_suppyrRS    /.01d-3/
      real*8 gGABA_deepLTS_to_suppyrFRB   /.01d-3/
      real*8 gGABA_deepLTS_to_supbask     /.01d-3/
      real*8 gGABA_deepLTS_to_supaxax     /.01d-3/
      real*8 gGABA_deepLTS_to_supLTS      /.05d-3/
      real*8 gGABA_deepLTS_to_spinstell   /.01d-3/
!     real*8 gGABA_deepLTS_to_tuftIB      /.02d-3/
      real*8 gGABA_deepLTS_to_tuftIB      /.05d-3/ ! will this help suppress bursting?
      real*8 gGABA_deepLTS_to_tuftRS      /.02d-3/
      real*8 gGABA_deepLTS_to_deepbask    /.01d-3/
      real*8 gGABA_deepLTS_to_deepaxax    /.01d-3/
      real*8 gGABA_deepLTS_to_deepLTS     /.05d-3/
      real*8 gGABA_deepLTS_to_nontuftRS   /.01d-3/

      real*8 gAMPA_TCR_to_suppyrRS        /0.5d-3/
      real*8 gNMDA_TCR_to_suppyrRS        /0.05d-3/
      real*8 gAMPA_TCR_to_suppyrFRB       /0.5d-3/
      real*8 gNMDA_TCR_to_suppyrFRB       /0.05d-3/
!     real*8 gAMPA_TCR_to_supbask         /1.0d-3/
      real*8 gAMPA_TCR_to_supbask         /0.1d-3/
! try a variation in which main feedforward inhibtion from thalamus
! is via deep interneurons.  May be necessary later to include special
! layer 4 interneurons
!     real*8 gNMDA_TCR_to_supbask         /.10d-3/
      real*8 gNMDA_TCR_to_supbask         /.01d-3/
!     real*8 gAMPA_TCR_to_supaxax         /1.0d-3/
      real*8 gAMPA_TCR_to_supaxax         /0.1d-3/
!     real*8 gNMDA_TCR_to_supaxax         /.10d-3/
      real*8 gNMDA_TCR_to_supaxax         /.01d-3/
      real*8 gAMPA_TCR_to_spinstell       /1.0d-3/
      real*8 gNMDA_TCR_to_spinstell       /.10d-3/
      real*8 gAMPA_TCR_to_tuftIB          /1.5d-3/
      real*8 gNMDA_TCR_to_tuftIB          /.15d-3/
      real*8 gAMPA_TCR_to_tuftRS          /1.5d-3/
      real*8 gNMDA_TCR_to_tuftRS          /.15d-3/
!     real*8 gAMPA_TCR_to_deepbask        /1.0d-3/
      real*8 gAMPA_TCR_to_deepbask        /1.5d-3/
      real*8 gNMDA_TCR_to_deepbask        /.10d-3/
      real*8 gAMPA_TCR_to_deepaxax        /1.0d-3/
      real*8 gNMDA_TCR_to_deepaxax        /.10d-3/
      real*8 gAMPA_TCR_to_nRT             /0.75d-3   /
      real*8 gNMDA_TCR_to_nRT             /.15d-3/
      real*8 gAMPA_TCR_to_nontuftRS       /1.0d-3    /
      real*8 gNMDA_TCR_to_nontuftRS       /.10d-3/

!     real*8 gGABA_nRT_to_TCR             /1.0d-3/
      real*8:: gGABA_nRT_to_TCR(num_nRT_p)
! Values here need to be set below  
      real*8 gGABA_nRT_to_nRT             /0.30d-3/

      real*8 gAMPA_nontuftRS_to_suppyrRS  /0.5d-3/
      real*8 gNMDA_nontuftRS_to_suppyrRS  /0.05d-3/
      real*8 gAMPA_nontuftRS_to_suppyrFRB /0.5d-3/
      real*8 gNMDA_nontuftRS_to_suppyrFRB /0.05d-3/
      real*8 gAMPA_nontuftRS_to_supbask   /1.0d-3/
      real*8 gNMDA_nontuftRS_to_supbask   /0.1d-3/
      real*8 gAMPA_nontuftRS_to_supaxax   /1.0d-3/
      real*8 gNMDA_nontuftRS_to_supaxax   /0.1d-3/
      real*8 gAMPA_nontuftRS_to_supLTS    /1.0d-3/
      real*8 gNMDA_nontuftRS_to_supLTS    /0.1d-3/
      real*8 gAMPA_nontuftRS_to_spinstell /0.5d-3/
      real*8 gNMDA_nontuftRS_to_spinstell /0.05d-3/
      real*8 gAMPA_nontuftRS_to_tuftIB    /1.0d-3/
      real*8 gNMDA_nontuftRS_to_tuftIB    /0.1d-3/
      real*8 gAMPA_nontuftRS_to_tuftRS    /1.0d-3/
      real*8 gNMDA_nontuftRS_to_tuftRS    /0.1d-3/
      real*8 gAMPA_nontuftRS_to_deepbask  /3.0d-3/
      real*8 gNMDA_nontuftRS_to_deepbask  /.10d-3/
      real*8 gAMPA_nontuftRS_to_deepaxax  /3.0d-3/
      real*8 gNMDA_nontuftRS_to_deepaxax  /.10d-3/
      real*8 gAMPA_nontuftRS_to_deepLTS   /2.0d-3/
      real*8 gNMDA_nontuftRS_to_deepLTS   /.10d-3/
      real*8 gAMPA_nontuftRS_to_TCR       /.75d-3/
      real*8 gNMDA_nontuftRS_to_TCR       /.075d-3/
      real*8 gAMPA_nontuftRS_to_nRT       /0.5d-3/
      real*8 gNMDA_nontuftRS_to_nRT       /0.05d-3/
      real*8 gAMPA_nontuftRS_to_nontuftRS /1.0d-3/
      real*8 gNMDA_nontuftRS_to_nontuftRS /0.1d-3/
c End defining synaptic conductance scaling factors

c Begin definition of compartments where synaptic connections
c can form.
       INTEGER:: 
     & compallow_suppyrRS_to_suppyrRS(ncompallow_suppyrRS_to_suppyrRS_p)
     &  /2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,26,
     & 27,28,29,30,31,32,33,10,11,12,13,22,23,24,25,
     & 34,35,36,37/
       INTEGER:: compallow_suppyrRS_to_suppyrFRB(
     &  ncompallow_suppyrRS_to_suppyrFRB_p)
     &  /2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,26,
     & 27,28,29,30,31,32,33,10,11,12,13,22,23,24,25,
     & 34,35,36,37/
       INTEGER:: compallow_suppyrRS_to_supbask  
     &  (ncompallow_suppyrRS_to_supbask_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_supaxax  
     &  (ncompallow_suppyrRS_to_supaxax_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_supLTS   
     &  (ncompallow_suppyrRS_to_supLTS_p   )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_spinstell
     &  (ncompallow_suppyrRS_to_spinstell_p)
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_tuftIB   
     &  (ncompallow_suppyrRS_to_tuftIB_p   )
     &  /39,40,41,42,43,44,45,46/
       INTEGER:: compallow_suppyrRS_to_tuftRS   
     &  (ncompallow_suppyrRS_to_tuftRS_p   )
     &  /39,40,41,42,43,44,45,46/
       INTEGER:: compallow_suppyrRS_to_deepbask 
     &  (ncompallow_suppyrRS_to_deepbask_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_deepaxax 
     &  (ncompallow_suppyrRS_to_deepaxax_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_deepLTS  
     &  (ncompallow_suppyrRS_to_deepLTS_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrRS_to_nontuftRS
     &  (ncompallow_suppyrRS_to_nontuftRS_p)
     &  /38,39,40,41,42,43,44/

       INTEGER:: compallow_suppyrFRB_to_suppyrRS 
     &  (ncompallow_suppyrFRB_to_suppyrRS_p)
     &  /2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,26,
     & 27,28,29,30,31,32,33,10,11,12,13,22,23,24,25,
     & 34,35,36,37/
       INTEGER:: compallow_suppyrFRB_to_suppyrFRB
     &  (ncompallow_suppyrFRB_to_suppyrFRB_p)
     &  /2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,26,
     & 27,28,29,30,31,32,33,10,11,12,13,22,23,24,25,
     & 34,35,36,37/
       INTEGER:: compallow_suppyrFRB_to_supbask  
     &  (ncompallow_suppyrFRB_to_supbask_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_supaxax  
     &  (ncompallow_suppyrFRB_to_supaxax_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_supLTS   
     &  (ncompallow_suppyrFRB_to_supLTS_p   )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_spinstell
     &  (ncompallow_suppyrFRB_to_spinstell_p)
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_tuftIB   
     &  (ncompallow_suppyrFRB_to_tuftIB_p   )
     &  /39,40,41,42,43,44,45,46/
       INTEGER:: compallow_suppyrFRB_to_tuftRS   
     &  (ncompallow_suppyrFRB_to_tuftRS_p   )
     &  /39,40,41,42,43,44,45,46/
       INTEGER:: compallow_suppyrFRB_to_deepbask 
     &  (ncompallow_suppyrFRB_to_deepbask_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_deepaxax 
     &  (ncompallow_suppyrFRB_to_deepaxax_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_deepLTS  
     &  (ncompallow_suppyrFRB_to_deepLTS_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_suppyrFRB_to_nontuftRS
     &  (ncompallow_suppyrFRB_to_nontuftRS_p)
     &  /38,39,40,41,42,43,44/

       INTEGER:: compallow_supbask_to_suppyrRS
     &  (ncompallow_supbask_to_suppyrRS_p)
     & /1,2,3,4,5,6,7,8,9,38,39/
       INTEGER:: compallow_supbask_to_suppyrFRB
     &  (ncompallow_supbask_to_suppyrFRB_p)
     & /1,2,3,4,5,6,7,8,9,38,39/
       INTEGER:: compallow_supbask_to_supbask  
     &  (ncompallow_supbask_to_supbask_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_supbask_to_supaxax  
     &  (ncompallow_supbask_to_supaxax_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_supbask_to_supLTS   
     &  (ncompallow_supbask_to_supLTS_p   )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_supbask_to_spinstell
     &  (ncompallow_supbask_to_spinstell_p)
     &  /1,2,15,28,41/

       INTEGER:: compallow_supLTS_to_suppyrRS
     &  (ncompallow_supLTS_to_suppyrRS_p)
     & /14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
     &  31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,
     &  50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,
     &  67,68/
       INTEGER:: compallow_supLTS_to_suppyrFRB
     &  (ncompallow_supLTS_to_suppyrFRB_p)
     & /14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
     &  31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,
     &  50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,
     &  67,68/
       INTEGER:: compallow_supLTS_to_supbask  
     &  (ncompallow_supLTS_to_supbask_p)  
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_supLTS_to_supaxax  
     &  (ncompallow_supLTS_to_supaxax_p)  
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_supLTS_to_supLTS   
     &  (ncompallow_supLTS_to_supLTS_p )  
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_supLTS_to_spinstell
     &  (ncompallow_supLTS_to_spinstell_p)
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_supLTS_to_tuftIB   
     &  (ncompallow_supLTS_to_tuftIB_p   )
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44,45,46,47,
     &   48,49,50,51,52,53,54,55/
       INTEGER:: compallow_supLTS_to_tuftRS   
     &  (ncompallow_supLTS_to_tuftRS_p   )
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44,45,46,47,
     &   48,49,50,51,52,53,54,55/
       INTEGER:: compallow_supLTS_to_deepbask 
     &  (ncompallow_supLTS_to_deepbask_p )
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_supLTS_to_deepaxax 
     &  (ncompallow_supLTS_to_deepaxax_p )
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_supLTS_to_deepLTS  
     &  (ncompallow_supLTS_to_deepLTS_p  )
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_supLTS_to_nontuftRS
     &  (ncompallow_supLTS_to_nontuftRS_p)
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44/ 

c      INTEGER:: compallow_spinstell_to_suppyrRS
c    &   (ncompallow_spinstell_to_suppyrRS)
c    & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
c      INTEGER:: compallow_spinstell_to_suppyrFRB
c    &   (ncompallow_spinstell_to_suppyrFRB)
c    & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
! 3 Mar. 2004: Feldmeyer, ..., Sakmann, J Physiol 2002 assert
! that in barrel ctx, spiny stellates go to basal dendrites of
! layer 2/3 pyramids
       INTEGER:: compallow_spinstell_to_suppyrRS
     &   (ncompallow_spinstell_to_suppyrRS_p)
     & /  2, 3, 4, 5, 6, 7, 8, 9,14,15,16,17,18,19,20,21,
     &   26,27,28,29,30,31,32,33/
       INTEGER:: compallow_spinstell_to_suppyrFRB
     &   (ncompallow_spinstell_to_suppyrFRB_p)
     & /  2, 3, 4, 5, 6, 7, 8, 9,14,15,16,17,18,19,20,21,
     &   26,27,28,29,30,31,32,33/
       INTEGER:: compallow_spinstell_to_supbask  
     &   (ncompallow_spinstell_to_supbask_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_supaxax  
     &   (ncompallow_spinstell_to_supaxax_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_supLTS   
     &   (ncompallow_spinstell_to_supLTS_p   )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_spinstell
     &   (ncompallow_spinstell_to_spinstell_p)
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_tuftIB   
     &   (ncompallow_spinstell_to_tuftIB_p   )
     &  / 7,8,9,10,11,12,36,37,38,39,40,41/
       INTEGER:: compallow_spinstell_to_tuftRS   
     &   (ncompallow_spinstell_to_tuftRS_p   )
     &  / 7,8,9,10,11,12,36,37,38,39,40,41/
       INTEGER:: compallow_spinstell_to_deepbask 
     &   (ncompallow_spinstell_to_deepbask_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_deepaxax 
     &   (ncompallow_spinstell_to_deepaxax_p )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_deepLTS  
     &   (ncompallow_spinstell_to_deepLTS_p  )
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_spinstell_to_nontuftRS
     &   (ncompallow_spinstell_to_nontuftRS_p)
     &  / 37,38,39,40,41/

       INTEGER:: compallow_tuftIB_to_suppyrRS
     &   (ncompallow_tuftIB_to_suppyrRS_p)
     & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
       INTEGER:: compallow_tuftIB_to_suppyrFRB
     &   (ncompallow_tuftIB_to_suppyrFRB_p)
     & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
       INTEGER:: compallow_tuftIB_to_supbask  
     &   (ncompallow_tuftIB_to_supbask_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_supaxax  
     &   (ncompallow_tuftIB_to_supaxax_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_supLTS   
     &   (ncompallow_tuftIB_to_supLTS_p )  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_spinstell
     &   (ncompallow_tuftIB_to_spinstell_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_tuftIB   
     &   (ncompallow_tuftIB_to_tuftIB_p)    
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
       INTEGER:: compallow_tuftIB_to_tuftRS   
     &   (ncompallow_tuftIB_to_tuftRS_p)    
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
       INTEGER:: compallow_tuftIB_to_deepbask 
     &   (ncompallow_tuftIB_to_deepbask_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_deepaxax 
     &   (ncompallow_tuftIB_to_deepaxax_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_deepLTS  
     &   (ncompallow_tuftIB_to_deepLTS_p )  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftIB_to_nontuftRS
     &   (ncompallow_tuftIB_to_nontuftRS_p) 
     &  /2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,
     &   37,38,39,40,41,42,43,44/

       INTEGER:: compallow_tuftRS_to_suppyrRS
     &   (ncompallow_tuftRS_to_suppyrRS_p)
     & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
       INTEGER:: compallow_tuftRS_to_suppyrFRB
     &   (ncompallow_tuftRS_to_suppyrFRB_p)
     & / 40,41,42,43,44,45,46,47,48,49,50,51,52/
       INTEGER:: compallow_tuftRS_to_supbask  
     &   (ncompallow_tuftRS_to_supbask_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_supaxax  
     &   (ncompallow_tuftRS_to_supaxax_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_supLTS   
     &   (ncompallow_tuftRS_to_supLTS_p )  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_spinstell
     &   (ncompallow_tuftRS_to_spinstell_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_tuftIB   
     &   (ncompallow_tuftRS_to_tuftIB_p)    
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
       INTEGER:: compallow_tuftRS_to_tuftRS   
     &   (ncompallow_tuftRS_to_tuftRS_p)    
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
       INTEGER:: compallow_tuftRS_to_deepbask 
     &   (ncompallow_tuftRS_to_deepbask_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_deepaxax 
     &   (ncompallow_tuftRS_to_deepaxax_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_deepLTS  
     &   (ncompallow_tuftRS_to_deepLTS_p )  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_tuftRS_to_nontuftRS
     &   (ncompallow_tuftRS_to_nontuftRS_p) 
     &  /2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,
     &   37,38,39,40,41,42,43,44/

       INTEGER:: compallow_deepbask_to_spinstell
     &   (ncompallow_deepbask_to_spinstell_p)
     &  /1,2,15,28,41/
       INTEGER:: compallow_deepbask_to_tuftIB   
     &   (ncompallow_deepbask_to_tuftIB_p)   
     & / 1,2,3,4,5,6,35,36/
       INTEGER:: compallow_deepbask_to_tuftRS   
     &   (ncompallow_deepbask_to_tuftRS_p)   
     & / 1,2,3,4,5,6,35,36/
       INTEGER:: compallow_deepbask_to_deepbask 
     &   (ncompallow_deepbask_to_deepbask_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_deepbask_to_deepaxax 
     &   (ncompallow_deepbask_to_deepaxax_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_deepbask_to_deepLTS  
     &   (ncompallow_deepbask_to_deepLTS_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
       INTEGER:: compallow_deepbask_to_nontuftRS
     &   (ncompallow_deepbask_to_nontuftRS_p)
     &  /1,2,3,4,5,6,35,36/

       INTEGER:: compallow_deepLTS_to_suppyrRS
     &   (ncompallow_deepLTS_to_suppyrRS_p)
     & /14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
     &  31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,
     &  50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,
     &  67,68/
       INTEGER:: compallow_deepLTS_to_suppyrFRB
     &   (ncompallow_deepLTS_to_suppyrFRB_p)
     & /14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
     &  31,32,33,34,35,36,37,40,41,42,43,44,45,46,47,48,49,
     &  50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,
     &  67,68/
       INTEGER:: compallow_deepLTS_to_supbask  
     &   (ncompallow_deepLTS_to_supbask_p)  
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_deepLTS_to_supaxax  
     &   (ncompallow_deepLTS_to_supaxax_p)  
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_deepLTS_to_supLTS   
     &   (ncompallow_deepLTS_to_supLTS_p)   
     & / 8,9,10,11,12,21,22,23,24,25,34,35,36,37,38,
     &   47,48,49,50,51/ 
       INTEGER:: compallow_deepLTS_to_spinstell
     &   (ncompallow_deepLTS_to_spinstell_p)
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_deepLTS_to_tuftIB   
     &   (ncompallow_deepLTS_to_tuftIB_p)    
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44,45,46,47,
     &   48,49,50,51,52,53,54,55/
       INTEGER:: compallow_deepLTS_to_tuftRS   
     &   (ncompallow_deepLTS_to_tuftRS_p)    
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44,45,46,47,
     &   48,49,50,51,52,53,54,55/
       INTEGER:: compallow_deepLTS_to_deepbask 
     &   (ncompallow_deepLTS_to_deepbask_p)  
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_deepLTS_to_deepaxax 
     &   (ncompallow_deepLTS_to_deepaxax_p)  
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_deepLTS_to_deepLTS  
     &   (ncompallow_deepLTS_to_deepLTS_p)   
     & /5,6,7,8,9,10,11,12,13,14,18,19,20,21,22,23,24,25,
     &  26,27,31,32,33,34,35,36,37,38,39,40,
     &  44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_deepLTS_to_nontuftRS
     &   (ncompallow_deepLTS_to_nontuftRS_p) 
     & / 13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,
     &   29,30,31,32,33,34,38,39,40,41,42,43,44/ 

       INTEGER:: compallow_TCR_to_suppyrRS
     &   (ncompallow_TCR_to_suppyrRS_p)
     &  /45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
     &   61,62,63,64,65,66,67,68/
       INTEGER:: compallow_TCR_to_suppyrFRB
     &   (ncompallow_TCR_to_suppyrFRB_p)
     &  /45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
     &   61,62,63,64,65,66,67,68/
       INTEGER:: compallow_TCR_to_supbask  
     &   (ncompallow_TCR_to_supbask_p)  
     &  /2,3,4,15,16,17,28,29,30,41,42,43/
       INTEGER:: compallow_TCR_to_supaxax  
     &   (ncompallow_TCR_to_supaxax_p)  
     &  /2,3,4,15,16,17,28,29,30,41,42,43/
       INTEGER:: compallow_TCR_to_spinstell
     &   (ncompallow_TCR_to_spinstell_p)
     &  /2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,
     &   37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53/
       INTEGER:: compallow_TCR_to_tuftIB   
     &   (ncompallow_TCR_to_tuftIB_p)   
     &  / 47,48,49,50,51,52,53,54,55/
       INTEGER:: compallow_TCR_to_tuftRS   
     &   (ncompallow_TCR_to_tuftRS_p)   
     &  / 47,48,49,50,51,52,53,54,55/
       INTEGER:: compallow_TCR_to_deepbask 
     &   (ncompallow_TCR_to_deepbask_p) 
     &  /2,3,4,15,16,17,28,29,30,41,42,43/
       INTEGER:: compallow_TCR_to_deepaxax 
     &   (ncompallow_TCR_to_deepaxax_p) 
     &  /2,3,4,15,16,17,28,29,30,41,42,43/
       INTEGER:: compallow_TCR_to_nRT      
     &   (ncompallow_TCR_to_nRT_p)      
     &  /2,3,4,15,16,17,28,29,30,41,42,43/
       INTEGER:: compallow_TCR_to_nontuftRS
     &   (ncompallow_TCR_to_nontuftRS_p)
     &  /40,41,42,43,44/

       INTEGER:: compallow_nRT_to_TCR
     &   (ncompallow_nRT_to_TCR_p)
     &  /1,2,15,28,41,54,67,80,93,106,119/
       INTEGER:: compallow_nRT_to_nRT
     &   (ncompallow_nRT_to_nRT_p)
     &  /1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
     &   20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,
     &   36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,
     &   52,53/

        INTEGER:: compallow_nontuftRS_to_suppyrRS
     &    (ncompallow_nontuftRS_to_suppyrRS_p)
     &   / 41,42,43,44 /
        INTEGER:: compallow_nontuftRS_to_suppyrFRB
     &    (ncompallow_nontuftRS_to_suppyrFRB_p)
     &   / 41,42,43,44 /
        INTEGER:: compallow_nontuftRS_to_supbask  
     &    (ncompallow_nontuftRS_to_supbask_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_supaxax  
     &    (ncompallow_nontuftRS_to_supaxax_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_supLTS   
     &    (ncompallow_nontuftRS_to_supLTS_p)   
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_spinstell
     &    (ncompallow_nontuftRS_to_spinstell_p)
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_tuftIB   
     &    (ncompallow_nontuftRS_to_tuftIB_p)   
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
        INTEGER:: compallow_nontuftRS_to_tuftRS   
     &    (ncompallow_nontuftRS_to_tuftRS_p)   
     &  / 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,
     &   38,39,40,41,42,43,44,45,46,47/
        INTEGER:: compallow_nontuftRS_to_deepbask 
     &    (ncompallow_nontuftRS_to_deepbask_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_deepaxax 
     &    (ncompallow_nontuftRS_to_deepaxax_p) 
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_deepLTS  
     &    (ncompallow_nontuftRS_to_deepLTS_p)  
     &  /5,6,7,8,9,10,18,19,20,21,22,23,31,32,33,34,35,36,
     &   44,45,46,47,48,49/
        INTEGER:: compallow_nontuftRS_to_TCR      
     &    (ncompallow_nontuftRS_to_TCR_p)      
     &  /  6,  7,  8,  9, 10, 11, 12, 13, 14,
     &    19, 20, 21, 22, 23, 24, 25, 26, 27,
     &    32, 33, 34, 35, 36, 37, 38, 39, 40,
     &    45, 46, 47, 48, 49, 50, 51, 52, 53,
     &    58, 59, 60, 61, 62, 63, 64, 65, 66,
     &    71, 72, 73, 74, 75, 76, 77, 78, 79,
     &    84, 85, 86, 87, 88, 89, 90, 91, 92,
     &    97, 98, 99,100,101,102,103,104,105,
     &   110,111,112,113,114,115,116,117,118,
     &   123,124,125,126,127,128,129,130,131/
        INTEGER:: compallow_nontuftRS_to_nRT      
     &    (ncompallow_nontuftRS_to_nRT_p)      
     & / 2,3,4,15,16,17,28,29,30,41,42,43/
        INTEGER:: compallow_nontuftRS_to_nontuftRS
     &    (ncompallow_nontuftRS_to_nontuftRS_p)
     &  /2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
     &   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,
     &   37,38,39,40,41,42,43,44/


c Maps of synaptic connectivity.  For simplicity, all contacts
c only made to one compartment.  Axoaxonic cells forced to contact 
c initial axon segments; other compartments will be listed in arrays.
        INTEGER:: 
     & map_suppyrRS_to_suppyrRS(num_suppyrRS_to_suppyrRS_p,
     &                           num_suppyrRS_p),
     & map_suppyrRS_to_suppyrFRB(num_suppyrRS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & map_suppyrRS_to_supbask(num_suppyrRS_to_supbask_p,  
     &                           num_supbask_p), 
     & map_suppyrRS_to_supaxax(num_suppyrRS_to_supaxax_p, 
     &                           num_supaxax_p),
     & map_suppyrRS_to_supLTS(num_suppyrRS_to_supLTS_p,   
     &                           num_supLTS_p),
     & map_suppyrRS_to_spinstell(num_suppyrRS_to_spinstell_p,
     &                           num_spinstell_p),
     & map_suppyrRS_to_tuftIB(num_suppyrRS_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & map_suppyrRS_to_tuftRS(num_suppyrRS_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & map_suppyrRS_to_deepbask(num_suppyrRS_to_deepbask_p,
     &                           num_deepbask_p), 
     & map_suppyrRS_to_deepaxax(num_suppyrRS_to_deepaxax_p,
     &                           num_deepaxax_p), 
     & map_suppyrRS_to_deepLTS(num_suppyrRS_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & map_suppyrRS_to_nontuftrS(num_suppyrRS_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & map_suppyrFRB_to_suppyrRS(num_suppyrFRB_to_suppyrRS_p,
     &                           num_suppyrRS_p) 
              INTEGER::
     & map_suppyrFRB_to_suppyrFRB(num_suppyrFRB_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & map_suppyrFRB_to_supbask(num_suppyrFRB_to_supbask_p,
     &                           num_supbask_p), 
     & map_suppyrFRB_to_supaxax(num_suppyrFRB_to_supaxax_p,
     &                           num_supaxax_p),
     & map_suppyrFRB_to_supLTS(num_suppyrFRB_to_supLTS_p,
     &                           num_supLTS_p),
     & map_suppyrFRB_to_spinstell(num_suppyrFRB_to_spinstell_p,
     &                           num_spinstell_p),
     & map_suppyrFRB_to_tuftIB(num_suppyrFRB_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & map_suppyrFRB_to_tuftRS(num_suppyrFRB_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & map_suppyrFRB_to_deepbask(num_suppyrFRB_to_deepbask_p,
     &                           num_deepbask_p),
     & map_suppyrFRB_to_deepaxax(num_suppyrFRB_to_deepaxax_p,
     &                           num_deepaxax_p),
     & map_suppyrFRB_to_deepLTS(num_suppyrFRB_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & map_suppyrFRB_to_nontuftRS(num_suppyrFRB_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & map_supbask_to_suppyrRS(num_supbask_to_suppyrRS_p,
     &                           num_suppyrRS_p),  
     & map_supbask_to_suppyrFRB(num_supbask_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & map_supbask_to_supbask(num_supbask_to_supbask_p,
     &                           num_supbask_p), 
     & map_supbask_to_supaxax(num_supbask_to_supaxax_p,
     &                           num_supaxax_p),
     & map_supbask_to_supLTS(num_supbask_to_supLTS_p,
     &                           num_supLTS_p),  
     & map_supbask_to_spinstell(num_supbask_to_spinstell_p,
     &                           num_spinstell_p), 
     & map_supaxax_to_suppyrRS(num_supaxax_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & map_supaxax_to_suppyrFRB(num_supaxax_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_supaxax_to_spinstell(num_supaxax_to_spinstell_p,
     &                           num_spinstell_p),
     & map_supaxax_to_tuftIB(num_supaxax_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & map_supaxax_to_tuftRS(num_supaxax_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & map_supaxax_to_nontuftRS(num_supaxax_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & map_supLTS_to_suppyrRS(num_supLTS_to_suppyrRS_p,
     &                           num_suppyrRS_p),  
     & map_supLTS_to_suppyrFRB(num_supLTS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_supLTS_to_supbask(num_supLTS_to_supbask_p,
     &                           num_supbask_p),  
     & map_supLTS_to_supaxax(num_supLTS_to_supaxax_p,
     &                           num_supaxax_p), 
     & map_supLTS_to_supLTS(num_supLTS_to_supLTS_p,
     &                           num_supLTS_p), 
     & map_supLTS_to_spinstell(num_supLTS_to_spinstell_p,
     &                           num_spinstell_p), 
     & map_supLTS_to_tuftIB(num_supLTS_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & map_supLTS_to_tuftRS(num_supLTS_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & map_supLTS_to_deepbask(num_supLTS_to_deepbask_p,
     &                           num_deepbask_p), 
     & map_supLTS_to_deepaxax(num_supLTS_to_deepaxax_p,
     &                           num_deepaxax_p), 
     & map_supLTS_to_deepLTS(num_supLTS_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & map_supLTS_to_nontuftRS(num_supLTS_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & map_spinstell_to_suppyrRS(num_spinstell_to_suppyrRS_p,
     &                           num_suppyrRS_p),
     & map_spinstell_to_suppyrFRB(num_spinstell_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & map_spinstell_to_supbask(num_spinstell_to_supbask_p,
     &                           num_supbask_p) 
               INTEGER::
     & map_spinstell_to_supaxax(num_spinstell_to_supaxax_p,
     &                           num_supaxax_p),
     & map_spinstell_to_supLTS(num_spinstell_to_supLTS_p,
     &                           num_supLTS_p), 
     & map_spinstell_to_spinstell(num_spinstell_to_spinstell_p,
     &                           num_spinstell_p),
     & map_spinstell_to_tuftIB(num_spinstell_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & map_spinstell_to_tuftRS(num_spinstell_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & map_spinstell_to_deepbask(num_spinstell_to_deepbask_p,
     &                           num_deepbask_p), 
     & map_spinstell_to_deepaxax(num_spinstell_to_deepaxax_p,
     &                           num_deepaxax_p),
     & map_spinstell_to_deepLTS(num_spinstell_to_deepLTS_p,
     &                           num_deepLTS_p),
     & map_spinstell_to_nontuftRS(num_spinstell_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & map_tuftIB_to_suppyrRS(num_tuftIB_to_suppyrRS_p,
     &                           num_suppyrRS_p),   
     & map_tuftIB_to_suppyrFRB(num_tuftIB_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_tuftIB_to_supbask(num_tuftIB_to_supbask_p,
     &                           num_supbask_p),  
     & map_tuftIB_to_supaxax(num_tuftIB_to_supaxax_p,
     &                           num_supaxax_p), 
     & map_tuftIB_to_supLTS(num_tuftIB_to_supLTS_p,
     &                           num_supLTS_p), 
     & map_tuftIB_to_spinstell(num_tuftIB_to_spinstell_p,
     &                           num_spinstell_p), 
     & map_tuftIB_to_tuftIB(num_tuftIB_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & map_tuftIB_to_tuftRS(num_tuftIB_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & map_tuftIB_to_deepbask(num_tuftIB_to_deepbask_p,
     &                           num_deepbask_p), 
     & map_tuftIB_to_deepaxax(num_tuftIB_to_deepaxax_p,
     &                           num_deepaxax_p),  
     & map_tuftIB_to_deepLTS(num_tuftIB_to_deepLTS_p,
     &                           num_deepLTS_p),  
     & map_tuftIB_to_nontuftRS(num_tuftIB_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & map_tuftRS_to_suppyrRS(num_tuftRS_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & map_tuftRS_to_suppyrFRB(num_tuftRS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_tuftRS_to_supbask(num_tuftRS_to_supbask_p,
     &                           num_supbask_p),  
     & map_tuftRS_to_supaxax(num_tuftRS_to_supaxax_p,
     &                           num_supaxax_p),   
     & map_tuftRS_to_supLTS(num_tuftRS_to_supLTS_p,
     &                           num_supLTS_p)     
            INTEGER::
     & map_tuftRS_to_spinstell(num_tuftRS_to_spinstell_p,
     &                           num_spinstell_p), 
     & map_tuftRS_to_tuftIB(num_tuftRS_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & map_tuftRS_to_tuftRS(num_tuftRS_to_tuftRS_p,
     &                           num_tuftRS_p),     
     & map_tuftRS_to_deepbask(num_tuftRS_to_deepbask_p,
     &                           num_deepbask_p),  
     & map_tuftRS_to_deepaxax(num_tuftRS_to_deepaxax_p,
     &                           num_deepaxax_p),   
     & map_tuftRS_to_deepLTS(num_tuftRS_to_deepLTS_p,
     &                           num_deepLTS_p),   
     & map_tuftRS_to_nontuftRS(num_tuftRS_to_nontuftRS_p,
     &                           num_nontuftRS_p),  
     & map_deepbask_to_spinstell(num_deepbask_to_spinstell_p,
     &                           num_spinstell_p), 
     & map_deepbask_to_tuftIB(num_deepbask_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & map_deepbask_to_tuftRS(num_deepbask_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & map_deepbask_to_deepbask(num_deepbask_to_deepbask_p,
     &                           num_deepbask_p), 
     & map_deepbask_to_deepaxax(num_deepbask_to_deepaxax_p,
     &                           num_deepaxax_p),  
     & map_deepbask_to_deepLTS(num_deepbask_to_deepLTS_p,
     &                           num_deepLTS_p)  
                INTEGER
     & map_deepbask_to_nontuftRS(num_deepbask_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & map_deepaxax_to_suppyrRS(num_deepaxax_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & map_deepaxax_to_suppyrFRB(num_deepaxax_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_deepaxax_to_spinstell(num_deepaxax_to_spinstell_p,
     &                           num_spinstell_p),
     & map_deepaxax_to_tuftIB(num_deepaxax_to_tuftIB_p,
     &                           num_tuftIB_p), 
     & map_deepaxax_to_tuftRS(num_deepaxax_to_tuftRS_p,
     &                           num_tuftRS_p),    
     & map_deepaxax_to_nontuftRS(num_deepaxax_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & map_deepLTS_to_suppyrRS(num_deepLTS_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & map_deepLTS_to_suppyrFRB(num_deepLTS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & map_deepLTS_to_supbask(num_deepLTS_to_supbask_p,
     &                           num_supbask_p),  
     & map_deepLTS_to_supaxax(num_deepLTS_to_supaxax_p,
     &                           num_supaxax_p), 
     & map_deepLTS_to_supLTS(num_deepLTS_to_supLTS_p,
     &                           num_supLTS_p), 
     & map_deepLTS_to_spinstell(num_deepLTS_to_spinstell_p,
     &                           num_spinstell_p),
     & map_deepLTS_to_tuftIB(num_deepLTS_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & map_deepLTS_to_tuftRS(num_deepLTS_to_tuftRS_p,
     &                            num_tuftRS_p), 
     & map_deepLTS_to_deepbask(num_deepLTS_to_deepbask_p,
     &                            num_deepbask_p), 
     & map_deepLTS_to_deepaxax(num_deepLTS_to_deepaxax_p,
     &                            num_deepaxax_p),  
     & map_deepLTS_to_deepLTS(num_deepLTS_to_deepLTS_p,
     &                            num_deepLTS_p),  
     & map_deepLTS_to_nontuftRS(num_deepLTS_to_nontuftRS_p,
     &                            num_nontuftRS_p), 
     & map_TCR_to_suppyrRS(num_TCR_to_suppyrRS_p,
     &                            num_suppyrRS_p),     
     & map_TCR_to_suppyrFRB(num_TCR_to_suppyrFRB_p,
     &                            num_suppyrFRB_p),   
     & map_TCR_to_supbask(num_TCR_to_supbask_p,
     &                            num_supbask_p)    
               INTEGER
     & map_TCR_to_supaxax(num_TCR_to_supaxax_p, num_supaxax_p),   
     & map_TCR_to_spinstell(num_TCR_to_spinstell_p, num_spinstell_p),
     & map_TCR_to_tuftIB(num_TCR_to_tuftIB_p, num_tuftIB_p),  
     & map_TCR_to_tuftRS(num_TCR_to_tuftRS_p, num_tuftRS_p),    
     & map_TCR_to_deepbask(num_TCR_to_deepbask_p, num_deepbask_p), 
     & map_TCR_to_deepaxax(num_TCR_to_deepaxax_p, num_deepaxax_p),
     & map_TCR_to_nRT(num_TCR_to_nRT_p, num_nRT_p),    
     & map_TCR_to_nontuftRS(num_TCR_to_nontuftRS_p, num_nontuftRS_p), 
     & map_nRT_to_TCR(num_nRT_to_TCR_p, num_TCR_p),      
     & map_nRT_to_nRT(num_nRT_to_nRT_p, num_nRT_p),     
     & map_nontuftRS_to_suppyrRS(num_nontuftRS_to_suppyrRS_p,
     &                             num_suppyrRS_p), 
     & map_nontuftRS_to_suppyrFRB(num_nontuftRS_to_suppyrFRB_p,
     &                             num_suppyrFRB_p),
     & map_nontuftRS_to_supbask(num_nontuftRS_to_supbask_p,
     &                             num_supbask_p), 
     & map_nontuftRS_to_supaxax(num_nontuftRS_to_supaxax_p,
     &                             num_supaxax_p),
     & map_nontuftRS_to_supLTS(num_nontuftRS_to_supLTS_p,
     &                             num_supLTS_p),  
     & map_nontuftRS_to_spinstell(num_nontuftRS_to_spinstell_p,
     &                             num_spinstell_p),
     & map_nontuftRS_to_tuftIB(num_nontuftRS_to_tuftIB_p,
     &                             num_tuftIB_p),  
     & map_nontuftRS_to_tuftRS(num_nontuftRS_to_tuftRS_p,
     &                             num_tuftRS_p),  
     & map_nontuftRS_to_deepbask(num_nontuftRS_to_deepbask_p,
     &                             num_deepbask_p), 
     & map_nontuftRS_to_deepaxax(num_nontuftRS_to_deepaxax_p,
     &                             num_deepaxax_p),
     & map_nontuftRS_to_deepLTS(num_nontuftRS_to_deepLTS_p,
     &                             num_deepLTS_p),
     & map_nontuftRS_to_TCR(num_nontuftRS_to_TCR_p,num_TCR_p),
     & map_nontuftRS_to_nRT(num_nontuftRS_to_nRT_p,num_nRT_p),  
     & map_nontuftRS_to_nontuftRS(num_nontuftRS_to_nontuftRS_p,
     &                             num_nontuftRS_p)

c Maps of synaptic compartments.  For simplicity, all contacts
c only made to one compartment.  Axoaxonic cells forced to contact 
c initial axon segments; other compartments will be listed in arrays.
        INTEGER 
     & com_suppyrRS_to_suppyrRS(num_suppyrRS_to_suppyrRS_p,
     &                           num_suppyrRS_p),
     & com_suppyrRS_to_suppyrFRB(num_suppyrRS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & com_suppyrRS_to_supbask(num_suppyrRS_to_supbask_p,  
     &                           num_supbask_p), 
     & com_suppyrRS_to_supaxax(num_suppyrRS_to_supaxax_p, 
     &                           num_supaxax_p),
     & com_suppyrRS_to_supLTS(num_suppyrRS_to_supLTS_p,   
     &                           num_supLTS_p),
     & com_suppyrRS_to_spinstell(num_suppyrRS_to_spinstell_p,
     &                           num_spinstell_p),
     & com_suppyrRS_to_tuftIB(num_suppyrRS_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & com_suppyrRS_to_tuftRS(num_suppyrRS_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & com_suppyrRS_to_deepbask(num_suppyrRS_to_deepbask_p,
     &                           num_deepbask_p), 
     & com_suppyrRS_to_deepaxax(num_suppyrRS_to_deepaxax_p,
     &                           num_deepaxax_p), 
     & com_suppyrRS_to_deepLTS(num_suppyrRS_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & com_suppyrRS_to_nontuftrS(num_suppyrRS_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & com_suppyrFRB_to_suppyrRS(num_suppyrFRB_to_suppyrRS_p,
     &                           num_suppyrRS_p) 
              INTEGER
     & com_suppyrFRB_to_suppyrFRB(num_suppyrFRB_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & com_suppyrFRB_to_supbask(num_suppyrFRB_to_supbask_p,
     &                           num_supbask_p), 
     & com_suppyrFRB_to_supaxax(num_suppyrFRB_to_supaxax_p,
     &                           num_supaxax_p),
     & com_suppyrFRB_to_supLTS(num_suppyrFRB_to_supLTS_p,
     &                           num_supLTS_p),
     & com_suppyrFRB_to_spinstell(num_suppyrFRB_to_spinstell_p,
     &                           num_spinstell_p),
     & com_suppyrFRB_to_tuftIB(num_suppyrFRB_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & com_suppyrFRB_to_tuftRS(num_suppyrFRB_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & com_suppyrFRB_to_deepbask(num_suppyrFRB_to_deepbask_p,
     &                           num_deepbask_p),
     & com_suppyrFRB_to_deepaxax(num_suppyrFRB_to_deepaxax_p,
     &                           num_deepaxax_p),
     & com_suppyrFRB_to_deepLTS(num_suppyrFRB_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & com_suppyrFRB_to_nontuftRS(num_suppyrFRB_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & com_supbask_to_suppyrRS(num_supbask_to_suppyrRS_p,
     &                           num_suppyrRS_p),  
     & com_supbask_to_suppyrFRB(num_supbask_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & com_supbask_to_supbask(num_supbask_to_supbask_p,
     &                           num_supbask_p), 
     & com_supbask_to_supaxax(num_supbask_to_supaxax_p,
     &                           num_supaxax_p),
     & com_supbask_to_supLTS(num_supbask_to_supLTS_p,
     &                           num_supLTS_p),  
     & com_supbask_to_spinstell(num_supbask_to_spinstell_p,
     &                           num_spinstell_p), 
     & com_supaxax_to_suppyrRS(num_supaxax_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & com_supaxax_to_suppyrFRB(num_supaxax_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_supaxax_to_spinstell(num_supaxax_to_spinstell_p,
     &                           num_spinstell_p)
           INTEGER
     & com_supaxax_to_tuftIB(num_supaxax_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & com_supaxax_to_tuftRS(num_supaxax_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & com_supaxax_to_nontuftRS(num_supaxax_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & com_supLTS_to_suppyrRS(num_supLTS_to_suppyrRS_p,
     &                           num_suppyrRS_p),  
     & com_supLTS_to_suppyrFRB(num_supLTS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_supLTS_to_supbask(num_supLTS_to_supbask_p,
     &                           num_supbask_p),  
     & com_supLTS_to_supaxax(num_supLTS_to_supaxax_p,
     &                           num_supaxax_p), 
     & com_supLTS_to_supLTS(num_supLTS_to_supLTS_p,
     &                           num_supLTS_p), 
     & com_supLTS_to_spinstell(num_supLTS_to_spinstell_p,
     &                           num_spinstell_p), 
     & com_supLTS_to_tuftIB(num_supLTS_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & com_supLTS_to_tuftRS(num_supLTS_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & com_supLTS_to_deepbask(num_supLTS_to_deepbask_p,
     &                           num_deepbask_p), 
     & com_supLTS_to_deepaxax(num_supLTS_to_deepaxax_p,
     &                           num_deepaxax_p), 
     & com_supLTS_to_deepLTS(num_supLTS_to_deepLTS_p,
     &                           num_deepLTS_p), 
     & com_supLTS_to_nontuftRS(num_supLTS_to_nontuftRS_p,
     &                           num_nontuftRS_p), 
     & com_spinstell_to_suppyrRS(num_spinstell_to_suppyrRS_p,
     &                           num_suppyrRS_p),
     & com_spinstell_to_suppyrFRB(num_spinstell_to_suppyrFRB_p,
     &                           num_suppyrFRB_p),
     & com_spinstell_to_supbask(num_spinstell_to_supbask_p,
     &                           num_supbask_p), 
     & com_spinstell_to_supaxax(num_spinstell_to_supaxax_p,
     &                           num_supaxax_p)
                INTEGER
     & com_spinstell_to_supLTS(num_spinstell_to_supLTS_p,
     &                           num_supLTS_p), 
     & com_spinstell_to_spinstell(num_spinstell_to_spinstell_p,
     &                           num_spinstell_p),
     & com_spinstell_to_tuftIB(num_spinstell_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & com_spinstell_to_tuftRS(num_spinstell_to_tuftRS_p,
     &                           num_tuftRS_p), 
     & com_spinstell_to_deepbask(num_spinstell_to_deepbask_p,
     &                           num_deepbask_p), 
     & com_spinstell_to_deepaxax(num_spinstell_to_deepaxax_p,
     &                           num_deepaxax_p),
     & com_spinstell_to_deepLTS(num_spinstell_to_deepLTS_p,
     &                           num_deepLTS_p),
     & com_spinstell_to_nontuftRS(num_spinstell_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & com_tuftIB_to_suppyrRS(num_tuftIB_to_suppyrRS_p,
     &                           num_suppyrRS_p),   
     & com_tuftIB_to_suppyrFRB(num_tuftIB_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_tuftIB_to_supbask(num_tuftIB_to_supbask_p,
     &                           num_supbask_p),  
     & com_tuftIB_to_supaxax(num_tuftIB_to_supaxax_p,
     &                           num_supaxax_p), 
     & com_tuftIB_to_supLTS(num_tuftIB_to_supLTS_p,
     &                           num_supLTS_p), 
     & com_tuftIB_to_spinstell(num_tuftIB_to_spinstell_p,
     &                           num_spinstell_p), 
     & com_tuftIB_to_tuftIB(num_tuftIB_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & com_tuftIB_to_tuftRS(num_tuftIB_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & com_tuftIB_to_deepbask(num_tuftIB_to_deepbask_p,
     &                           num_deepbask_p), 
     & com_tuftIB_to_deepaxax(num_tuftIB_to_deepaxax_p,
     &                           num_deepaxax_p),  
     & com_tuftIB_to_deepLTS(num_tuftIB_to_deepLTS_p,
     &                           num_deepLTS_p),  
     & com_tuftIB_to_nontuftRS(num_tuftIB_to_nontuftRS_p,
     &                           num_nontuftRS_p) 
              INTEGER
     & com_tuftRS_to_suppyrRS(num_tuftRS_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & com_tuftRS_to_suppyrFRB(num_tuftRS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_tuftRS_to_supbask(num_tuftRS_to_supbask_p,
     &                           num_supbask_p),  
     & com_tuftRS_to_supaxax(num_tuftRS_to_supaxax_p,
     &                           num_supaxax_p),   
     & com_tuftRS_to_supLTS(num_tuftRS_to_supLTS_p,
     &                           num_supLTS_p),     
     & com_tuftRS_to_spinstell(num_tuftRS_to_spinstell_p,
     &                           num_spinstell_p), 
     & com_tuftRS_to_tuftIB(num_tuftRS_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & com_tuftRS_to_tuftRS(num_tuftRS_to_tuftRS_p,
     &                           num_tuftRS_p),     
     & com_tuftRS_to_deepbask(num_tuftRS_to_deepbask_p,
     &                           num_deepbask_p),  
     & com_tuftRS_to_deepaxax(num_tuftRS_to_deepaxax_p,
     &                           num_deepaxax_p),   
     & com_tuftRS_to_deepLTS(num_tuftRS_to_deepLTS_p,
     &                           num_deepLTS_p),   
     & com_tuftRS_to_nontuftRS(num_tuftRS_to_nontuftRS_p,
     &                           num_nontuftRS_p),  
     & com_deepbask_to_spinstell(num_deepbask_to_spinstell_p,
     &                           num_spinstell_p), 
     & com_deepbask_to_tuftIB(num_deepbask_to_tuftIB_p,
     &                           num_tuftIB_p),   
     & com_deepbask_to_tuftRS(num_deepbask_to_tuftRS_p,
     &                           num_tuftRS_p),  
     & com_deepbask_to_deepbask(num_deepbask_to_deepbask_p,
     &                           num_deepbask_p), 
     & com_deepbask_to_deepaxax(num_deepbask_to_deepaxax_p,
     &                           num_deepaxax_p),  
     & com_deepbask_to_deepLTS(num_deepbask_to_deepLTS_p,
     &                           num_deepLTS_p),  
     & com_deepbask_to_nontuftRS(num_deepbask_to_nontuftRS_p,
     &                           num_nontuftRS_p) 
            INTEGER
     & com_deepaxax_to_suppyrRS(num_deepaxax_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & com_deepaxax_to_suppyrFRB(num_deepaxax_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_deepaxax_to_spinstell(num_deepaxax_to_spinstell_p,
     &                           num_spinstell_p),
     & com_deepaxax_to_tuftIB(num_deepaxax_to_tuftIB_p,
     &                           num_tuftIB_p), 
     & com_deepaxax_to_tuftRS(num_deepaxax_to_tuftRS_p,
     &                           num_tuftRS_p),    
     & com_deepaxax_to_nontuftRS(num_deepaxax_to_nontuftRS_p,
     &                           num_nontuftRS_p),
     & com_deepLTS_to_suppyrRS(num_deepLTS_to_suppyrRS_p,
     &                           num_suppyrRS_p), 
     & com_deepLTS_to_suppyrFRB(num_deepLTS_to_suppyrFRB_p,
     &                           num_suppyrFRB_p), 
     & com_deepLTS_to_supbask(num_deepLTS_to_supbask_p,
     &                           num_supbask_p),  
     & com_deepLTS_to_supaxax(num_deepLTS_to_supaxax_p,
     &                           num_supaxax_p), 
     & com_deepLTS_to_supLTS(num_deepLTS_to_supLTS_p,
     &                           num_supLTS_p), 
     & com_deepLTS_to_spinstell(num_deepLTS_to_spinstell_p,
     &                           num_spinstell_p),
     & com_deepLTS_to_tuftIB(num_deepLTS_to_tuftIB_p,
     &                           num_tuftIB_p),  
     & com_deepLTS_to_tuftRS(num_deepLTS_to_tuftRS_p,
     &                            num_tuftRS_p), 
     & com_deepLTS_to_deepbask(num_deepLTS_to_deepbask_p,
     &                            num_deepbask_p), 
     & com_deepLTS_to_deepaxax(num_deepLTS_to_deepaxax_p,
     &                            num_deepaxax_p),  
     & com_deepLTS_to_deepLTS(num_deepLTS_to_deepLTS_p,
     &                            num_deepLTS_p)  
           INTEGER
     & com_deepLTS_to_nontuftRS(num_deepLTS_to_nontuftRS_p,
     &                            num_nontuftRS_p), 
     & com_TCR_to_suppyrRS(num_TCR_to_suppyrRS_p,
     &                            num_suppyrRS_p),     
     & com_TCR_to_suppyrFRB(num_TCR_to_suppyrFRB_p,
     &                            num_suppyrFRB_p),   
     & com_TCR_to_supbask(num_TCR_to_supbask_p,
     &                            num_supbask_p),    
     & com_TCR_to_supaxax(num_TCR_to_supaxax_p, num_supaxax_p),   
     & com_TCR_to_spinstell(num_TCR_to_spinstell_p, num_spinstell_p),
     & com_TCR_to_tuftIB(num_TCR_to_tuftIB_p, num_tuftIB_p),  
     & com_TCR_to_tuftRS(num_TCR_to_tuftRS_p, num_tuftRS_p),    
     & com_TCR_to_deepbask(num_TCR_to_deepbask_p, num_deepbask_p), 
     & com_TCR_to_deepaxax(num_TCR_to_deepaxax_p, num_deepaxax_p),
     & com_TCR_to_nRT(num_TCR_to_nRT_p, num_nRT_p),    
     & com_TCR_to_nontuftRS(num_TCR_to_nontuftRS_p, num_nontuftRS_p), 
     & com_nRT_to_TCR(num_nRT_to_TCR_p, num_TCR_p),      
     & com_nRT_to_nRT(num_nRT_to_nRT_p, num_nRT_p),     
     & com_nontuftRS_to_suppyrRS(num_nontuftRS_to_suppyrRS_p,
     &                             num_suppyrRS_p), 
     & com_nontuftRS_to_suppyrFRB(num_nontuftRS_to_suppyrFRB_p,
     &                             num_suppyrFRB_p),
     & com_nontuftRS_to_supbask(num_nontuftRS_to_supbask_p,
     &                             num_supbask_p), 
     & com_nontuftRS_to_supaxax(num_nontuftRS_to_supaxax_p,
     &                             num_supaxax_p),
     & com_nontuftRS_to_supLTS(num_nontuftRS_to_supLTS_p,
     &                             num_supLTS_p),  
     & com_nontuftRS_to_spinstell(num_nontuftRS_to_spinstell_p,
     &                             num_spinstell_p),
     & com_nontuftRS_to_tuftIB(num_nontuftRS_to_tuftIB_p,
     &                             num_tuftIB_p)  
              INTEGER
     & com_nontuftRS_to_tuftRS(num_nontuftRS_to_tuftRS_p,
     &                             num_tuftRS_p),  
     & com_nontuftRS_to_deepbask(num_nontuftRS_to_deepbask_p,
     &                             num_deepbask_p), 
     & com_nontuftRS_to_deepaxax(num_nontuftRS_to_deepaxax_p,
     &                             num_deepaxax_p),
     & com_nontuftRS_to_deepLTS(num_nontuftRS_to_deepLTS_p,
     &                             num_deepLTS_p),
     & com_nontuftRS_to_TCR(num_nontuftRS_to_TCR_p, num_TCR_p),
     & com_nontuftRS_to_nRT(num_nontuftRS_to_nRT_p, num_nRT_p),  
     & com_nontuftRS_to_nontuftRS(num_nontuftRS_to_nontuftRS_p, 
     &                             num_nontuftRS_p)

c Entries in gjtable are cell a, compart. of cell a with gj,
c  cell b, compart. of cell b with gj; entries not repeated,
c which means that, for given cell being integrated, table
c must be searched through cols. 1 and 3.
       integer gjtable_suppyrRS(totaxgj_suppyrRS_p,4),
     &   gjtable_suppyrFRB(totaxgj_suppyrFRB_p,4),
     &   gjtable_suppyr   (totaxgj_suppyr_p,4),
     &   gjtable_supbask  (totSDgj_supbask_p,4),
     &   gjtable_supaxax  (1              ,4),
     &   gjtable_supLTS   (totSDgj_supLTS_p,4),
     &   gjtable_spinstell(totaxgj_spinstell_p,4),
     &   gjtable_tuftIB   (totaxgj_tuftIB_p,4),
     &   gjtable_tuftRS   (totaxgj_tuftRS_p,4),
     &   gjtable_tuft     (totaxgj_tuft_p,4),
     &   gjtable_nontuftRS(totaxgj_nontuftRS_p,4),
     &   gjtable_deepbask (totSDgj_deepbask_p,4),
     &   gjtable_deepaxax (1               ,4),
     &   gjtable_deepLTS  (totSDgj_deepLTS_p,4),
     &   gjtable_TCR      (totaxgj_TCR_p,4),
     &   gjtable_nRT      (totSDgj_nRT_p,4)

c     comment for above:
! gjtable_suppyr for suppyrRS/suppyrFRB gj, with RS cell
! in col. 1 and FRB cell in col. 3
! gjtable_tuft for tuftIB/tuftRS gj, with IB cell
! in col. 1 and RS cell in col. 3.


c define compartments on which gj can form
       INTEGER
     &table_axgjcompallow_suppyrRS(num_axgjcompallow_suppyrRS_p)
     &          /74/,
     &table_axgjcompallow_suppyrFRB(num_axgjcompallow_suppyrFRB_p)
     &          /74/,
     &table_SDgjcompallow_supbask  (num_SDgjcompallow_supbask_p  )
     &          /3,4,16,17,29,30,42,43/,
     &table_SDgjcompallow_supLTS   (num_SDgjcompallow_supLTS_p   )
     &          /3,4,16,17,29,30,42,43/,
     &table_axgjcompallow_spinstell(num_axgjcompallow_spinstell_p)
     &          /59/,
     &table_axgjcompallow_tuftIB   (num_axgjcompallow_tuftIB_p   )
     &          /61/,
     &table_axgjcompallow_tuftRS   (num_axgjcompallow_tuftRS_p   )
     &          /61/,
     &table_axgjcompallow_nontuftRS(num_axgjcompallow_nontuftRS_p)
     &          /50/,
     &table_SDgjcompallow_deepbask (num_SDgjcompallow_deepbask_p )
     &          /3,4,16,17,29,30,42,43/,
     &table_SDgjcompallow_deepLTS  (num_SDgjcompallow_deepLTS_p  )
     &          /3,4,16,17,29,30,42,43/,
     &table_axgjcompallow_TCR      (num_axgjcompallow_TCR_p      )
     &          /137/,
     &table_SDgjcompallow_nRT      (num_SDgjcompallow_nRT_p      )
     &          /3,4,16,17,29,30,42,43/

!     in the below the ! comments were uncommented above:
c Ectopics to superficial pyr. cells then go to #72, see
c   supergj.f
!     &table_SDgjcompallow_supbask  (num_SDgjcompallow_supbask_p  )
!     &          /3,4,16,17,29,30,42,43/,
!     &table_SDgjcompallow_supLTS   (num_SDgjcompallow_supLTS_p   )
!     &          /3,4,16,17,29,30,42,43/,
!     &table_axgjcompallow_spinstell(num_axgjcompallow_spinstell_p)
!     &          /59/,
c Ectopics to spiny stellates then go to #57
!     &table_axgjcompallow_tuftIB   (num_axgjcompallow_tuftIB_p   )
!     &          /61/,
!     &table_axgjcompallow_tuftRS   (num_axgjcompallow_tuftRS_p   )
!     &          /61/,
c Ectopics to tufted pyr. cells then go to #60
!     &table_axgjcompallow_nontuftRS(num_axgjcompallow_nontuftRS_p)
!     &          /50/,
c Ectopics to nontufted deep pyr. cells then to #48
!     &table_SDgjcompallow_deepbask (num_SDgjcompallow_deepbask_p )
!     &          /3,4,16,17,29,30,42,43/,
!     &table_SDgjcompallow_deepLTS  (num_SDgjcompallow_deepLTS_p  )
!     &          /3,4,16,17,29,30,42,43/,
!     &table_axgjcompallow_TCR      (num_axgjcompallow_TCR_p      )
!     &          /137/,
c Ectopics to TCR cells to #135
!     &table_SDgjcompallow_nRT      (num_SDgjcompallow_nRT_p      )
!     &          /3,4,16,17,29,30,42,43/



       integer ectr_suppyrRS, ectr_suppyrFRB, ectr_supbask,
     &  ectr_supaxax, ectr_supLTS, ectr_spinstell,
     &  ectr_tuftIB, ectr_tuftRS, ectr_nontuftRS,
     &  ectr_deepbask, ectr_deepaxax, ectr_deepLTS,
     &  ectr_TCR, ectr_nRT

       real*8 field_1mm_suppyrRS, field_1mm_suppyrFRB,
     &  field_1mm_nontuftRS, field_1mm_tuftIB, field_1mm_tuftRS
       real*8 field_2mm_suppyrRS, field_2mm_suppyrFRB,
     &  field_2mm_nontuftRS, field_2mm_tuftIB, field_2mm_tuftRS

c Define tables used for computing dexp:
c dexptablesmall(i) = dexp(-z), i = int (z*1000.), 0<=z<=5.
c dexptablebig  (i) = dexp(-z), i = int (z*10.), 0<=z<=100.
        double precision:: dexptablesmall(0:5000)
        double precision::  dexptablebig  (0:1000)

c Define arrays, constants, for voltages, applied currents,
c synaptic conductances, random numbers, etc.

       double precision::
     &  V_suppyrRS  (numcomp_suppyrRS_p,  num_suppyrRS_p),
     &  V_suppyrFRB (numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     &  V_supbask   (numcomp_supbask_p,   num_supbask_p),  
     &  V_supaxax   (numcomp_supaxax_p,   num_supaxax_p), 
     &  V_supLTS    (numcomp_supLTS_p,    num_supLTS_p), 
     &  V_spinstell (numcomp_spinstell_p, num_spinstell_p),
     &  V_tuftIB    (numcomp_tuftIB_p,    num_tuftIB_p),  
     &  V_tuftRS    (numcomp_tuftRS_p,    num_tuftRS_p), 
     &  V_nontuftRS (numcomp_nontuftRS_p, num_nontuftRS_p),
     &  V_deepbask  (numcomp_deepbask_p,  num_deepbask_p),
     &  V_deepaxax  (numcomp_deepaxax_p,  num_deepaxax_p),
     &  V_deepLTS   (numcomp_deepLTS_p,   num_deepLTS_p),
     &  V_TCR       (numcomp_TCR_p,       num_TCR_p),   
     &  V_nRT       (numcomp_nRT_p,       num_nRT_p) 

       double precision::
     &  curr_suppyrRS   (numcomp_suppyrRS_p,  num_suppyrRS_p),
     &  curr_suppyrFRB  (numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     &  curr_supbask    (numcomp_supbask_p,   num_supbask_p),  
     &  curr_supaxax    (numcomp_supaxax_p,   num_supaxax_p), 
     &  curr_supLTS     (numcomp_supLTS_p,    num_supLTS_p), 
     &  curr_spinstell  (numcomp_spinstell_p, num_spinstell_p),
     &  curr_tuftIB     (numcomp_tuftIB_p,    num_tuftIB_p),  
     &  curr_tuftRS     (numcomp_tuftRS_p,    num_tuftRS_p), 
     &  curr_nontuftRS  (numcomp_nontuftRS_p, num_nontuftRS_p),
     &  curr_deepbask   (numcomp_deepbask_p,  num_deepbask_p),
     &  curr_deepaxax   (numcomp_deepaxax_p,  num_deepaxax_p),
     &  curr_deepLTS    (numcomp_deepLTS_p,   num_deepLTS_p),
     &  curr_TCR        (numcomp_TCR_p,       num_TCR_p),   
     &  curr_nRT        (numcomp_nRT_p,       num_nRT_p) 

       double precision::
     & gAMPA_suppyrRS   (numcomp_suppyrRS_p,  num_suppyrRS_p),
     & gAMPA_suppyrFRB  (numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     & gAMPA_supbask    (numcomp_supbask_p,   num_supbask_p),  
     & gAMPA_supaxax    (numcomp_supaxax_p,   num_supaxax_p), 
     & gAMPA_supLTS     (numcomp_supLTS_p,    num_supLTS_p), 
     & gAMPA_spinstell  (numcomp_spinstell_p, num_spinstell_p),
     & gAMPA_tuftIB     (numcomp_tuftIB_p,    num_tuftIB_p),  
     & gAMPA_tuftRS     (numcomp_tuftRS_p,    num_tuftRS_p), 
     & gAMPA_nontuftRS  (numcomp_nontuftRS_p, num_nontuftRS_p),
     & gAMPA_deepbask   (numcomp_deepbask_p,  num_deepbask_p),
     & gAMPA_deepaxax   (numcomp_deepaxax_p,  num_deepaxax_p),
     & gAMPA_deepLTS    (numcomp_deepLTS_p,   num_deepLTS_p),
     & gAMPA_TCR        (numcomp_TCR_p,       num_TCR_p),   
     & gAMPA_nRT        (numcomp_nRT_p,       num_nRT_p) 

       double precision::
     & gNMDA_suppyrRS   (numcomp_suppyrRS_p,  num_suppyrRS_p),
     & gNMDA_suppyrFRB  (numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     & gNMDA_supbask    (numcomp_supbask_p,   num_supbask_p),  
     & gNMDA_supaxax    (numcomp_supaxax_p,   num_supaxax_p), 
     & gNMDA_supLTS     (numcomp_supLTS_p,    num_supLTS_p), 
     & gNMDA_spinstell  (numcomp_spinstell_p, num_spinstell_p),
     & gNMDA_tuftIB     (numcomp_tuftIB_p,    num_tuftIB_p),  
     & gNMDA_tuftRS     (numcomp_tuftRS_p,    num_tuftRS_p), 
     & gNMDA_nontuftRS  (numcomp_nontuftRS_p, num_nontuftRS_p),
     & gNMDA_deepbask   (numcomp_deepbask_p,  num_deepbask_p),
     & gNMDA_deepaxax   (numcomp_deepaxax_p,  num_deepaxax_p),
     & gNMDA_deepLTS    (numcomp_deepLTS_p,   num_deepLTS_p),
     & gNMDA_TCR        (numcomp_TCR_p,       num_TCR_p),   
     & gNMDA_nRT        (numcomp_nRT_p,       num_nRT_p) 

       double precision::
     & gGABA_A_suppyrRS (numcomp_suppyrRS_p,  num_suppyrRS_p),
     & gGABA_A_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     & gGABA_A_supbask  (numcomp_supbask_p,   num_supbask_p),  
     & gGABA_A_supaxax  (numcomp_supaxax_p,   num_supaxax_p), 
     & gGABA_A_supLTS   (numcomp_supLTS_p,    num_supLTS_p), 
     & gGABA_A_spinstell(numcomp_spinstell_p, num_spinstell_p),
     & gGABA_A_tuftIB   (numcomp_tuftIB_p,    num_tuftIB_p),  
     & gGABA_A_tuftRS   (numcomp_tuftRS_p,    num_tuftRS_p), 
     & gGABA_A_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     & gGABA_A_deepbask (numcomp_deepbask_p,  num_deepbask_p),
     & gGABA_A_deepaxax (numcomp_deepaxax_p,  num_deepaxax_p),
     & gGABA_A_deepLTS  (numcomp_deepLTS_p,   num_deepLTS_p),
     & gGABA_A_TCR      (numcomp_TCR_p,       num_TCR_p),   
     & gGABA_A_nRT      (numcomp_nRT_p,       num_nRT_p) 

! define membrane and Ca state variables that must be passed
! to subroutines
       real*8  chi_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p)
       real*8  mnaf_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     & mnap_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x hnaf_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mkdr_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mka_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x hka_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mk2_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p), 
     x hk2_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mkm_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mkc_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mkahp_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mcat_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x hcat_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mcal_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p),
     x mar_suppyrRS(numcomp_suppyrRS_p, num_suppyrRS_p)

       real*8  chi_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p)
       real*8  mnaf_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     & mnap_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x hnaf_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mkdr_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mka_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x hka_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mk2_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p), 
     x hk2_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mkm_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mkc_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mkahp_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mcat_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x hcat_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mcal_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p),
     x mar_suppyrFRB(numcomp_suppyrFRB_p, num_suppyrFRB_p)

       real*8  chi_supbask (numcomp_supbask_p, num_supbask_p)
       real*8  mnaf_supbask (numcomp_supbask_p, num_supbask_p ),
     & mnap_supbask (numcomp_supbask_p, num_supbask_p ),
     x hnaf_supbask (numcomp_supbask_p, num_supbask_p ),
     x mkdr_supbask (numcomp_supbask_p, num_supbask_p ),
     x mka_supbask (numcomp_supbask_p, num_supbask_p ),
     x hka_supbask (numcomp_supbask_p, num_supbask_p ),
     x mk2_supbask (numcomp_supbask_p, num_supbask_p ), 
     x hk2_supbask (numcomp_supbask_p, num_supbask_p ),
     x mkm_supbask (numcomp_supbask_p, num_supbask_p ),
     x mkc_supbask (numcomp_supbask_p, num_supbask_p ),
     x mkahp_supbask (numcomp_supbask_p, num_supbask_p ),
     x mcat_supbask (numcomp_supbask_p, num_supbask_p ),
     x hcat_supbask (numcomp_supbask_p, num_supbask_p ),
     x mcal_supbask (numcomp_supbask_p, num_supbask_p ),
     x mar_supbask (numcomp_supbask_p, num_supbask_p )

       real*8  chi_supaxax (numcomp_supaxax_p, num_supaxax_p )
       real*8  mnaf_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     & mnap_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x hnaf_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mkdr_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mka_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x hka_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mk2_supaxax (numcomp_supaxax_p, num_supaxax_p ), 
     x hk2_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mkm_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mkc_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mkahp_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mcat_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x hcat_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mcal_supaxax (numcomp_supaxax_p, num_supaxax_p ),
     x mar_supaxax (numcomp_supaxax_p, num_supaxax_p )

       real*8  chi_supLTS(numcomp_supLTS_p, num_supLTS_p)
       real*8  mnaf_supLTS(numcomp_supLTS_p, num_supLTS_p),
     & mnap_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x hnaf_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mkdr_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mka_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x hka_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mk2_supLTS(numcomp_supLTS_p, num_supLTS_p), 
     x hk2_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mkm_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mkc_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mkahp_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mcat_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x hcat_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mcal_supLTS(numcomp_supLTS_p, num_supLTS_p),
     x mar_supLTS(numcomp_supLTS_p, num_supLTS_p)

      real*8  chi_spinstell(numcomp_spinstell_p, num_spinstell_p)
      real*8  mnaf_spinstell(numcomp_spinstell_p, num_spinstell_p),
     & mnap_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x hnaf_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mkdr_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mka_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x hka_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mk2_spinstell(numcomp_spinstell_p, num_spinstell_p), 
     x hk2_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mkm_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mkc_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mkahp_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mcat_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x hcat_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mcal_spinstell(numcomp_spinstell_p, num_spinstell_p),
     x mar_spinstell(numcomp_spinstell_p, num_spinstell_p)


       real*8  chi_tuftIB(numcomp_tuftIB_p, num_tuftIB_p)
       real*8  mnaf_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     & mnap_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x hnaf_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mkdr_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mka_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x hka_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mk2_tuftIB(numcomp_tuftIB_p, num_tuftIB_p), 
     x hk2_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mkm_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mkc_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mkahp_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mcat_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x hcat_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mcal_tuftIB(numcomp_tuftIB_p, num_tuftIB_p),
     x mar_tuftIB(numcomp_tuftIB_p, num_tuftIB_p)

       real*8  chi_tuftRS(numcomp_tuftRS_p, num_tuftRS_p)
       real*8  mnaf_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     & mnap_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x hnaf_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mkdr_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mka_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x hka_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mk2_tuftRS(numcomp_tuftRS_p, num_tuftRS_p), 
     x hk2_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mkm_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mkc_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mkahp_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mcat_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x hcat_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mcal_tuftRS(numcomp_tuftRS_p, num_tuftRS_p),
     x mar_tuftRS(numcomp_tuftRS_p, num_tuftRS_p)

       real*8  chi_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p)
       real*8  mnaf_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     & mnap_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x hnaf_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mkdr_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mka_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x hka_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mk2_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p), 
     x hk2_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mkm_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mkc_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mkahp_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mcat_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x hcat_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mcal_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p),
     x mar_nontuftRS(numcomp_nontuftRS_p, num_nontuftRS_p)

       real*8  chi_deepbask(numcomp_deepbask_p, num_deepbask_p)
       real*8  mnaf_deepbask(numcomp_deepbask_p, num_deepbask_p),
     & mnap_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x hnaf_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mkdr_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mka_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x hka_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mk2_deepbask(numcomp_deepbask_p, num_deepbask_p), 
     x hk2_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mkm_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mkc_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mkahp_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mcat_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x hcat_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mcal_deepbask(numcomp_deepbask_p, num_deepbask_p),
     x mar_deepbask(numcomp_deepbask_p, num_deepbask_p)

       real*8  chi_deepaxax(numcomp_deepaxax_p, num_deepaxax_p)
       real*8  mnaf_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     & mnap_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x hnaf_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mkdr_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mka_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x hka_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mk2_deepaxax(numcomp_deepaxax_p, num_deepaxax_p), 
     x hk2_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mkm_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mkc_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mkahp_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mcat_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x hcat_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mcal_deepaxax(numcomp_deepaxax_p, num_deepaxax_p),
     x mar_deepaxax(numcomp_deepaxax_p, num_deepaxax_p)

       real*8  chi_deepLTS(numcomp_deepLTS_p, num_deepLTS_p)
       real*8  mnaf_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     & mnap_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x hnaf_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mkdr_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mka_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x hka_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mk2_deepLTS(numcomp_deepLTS_p, num_deepLTS_p), 
     x hk2_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mkm_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mkc_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mkahp_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mcat_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x hcat_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mcal_deepLTS(numcomp_deepLTS_p, num_deepLTS_p),
     x mar_deepLTS(numcomp_deepLTS_p, num_deepLTS_p)

       real*8  chi_tcr(numcomp_tcr_p, num_tcr_p)
       real*8  mnaf_tcr(numcomp_tcr_p, num_tcr_p),
     & mnap_tcr(numcomp_tcr_p, num_tcr_p),
     x hnaf_tcr(numcomp_tcr_p, num_tcr_p),
     x mkdr_tcr(numcomp_tcr_p, num_tcr_p),
     x mka_tcr(numcomp_tcr_p, num_tcr_p),
     x hka_tcr(numcomp_tcr_p, num_tcr_p),
     x mk2_tcr(numcomp_tcr_p, num_tcr_p), 
     x hk2_tcr(numcomp_tcr_p, num_tcr_p),
     x mkm_tcr(numcomp_tcr_p, num_tcr_p),
     x mkc_tcr(numcomp_tcr_p, num_tcr_p),
     x mkahp_tcr(numcomp_tcr_p, num_tcr_p),
     x mcat_tcr(numcomp_tcr_p, num_tcr_p),
     x hcat_tcr(numcomp_tcr_p, num_tcr_p),
     x mcal_tcr(numcomp_tcr_p, num_tcr_p),
     x mar_tcr(numcomp_tcr_p, num_tcr_p)

       real*8  chi_nRT(numcomp_nRT_p, num_nRT_p)
       real*8  mnaf_nRT(numcomp_nRT_p, num_nRT_p),
     & mnap_nRT(numcomp_nRT_p, num_nRT_p),
     x hnaf_nRT(numcomp_nRT_p, num_nRT_p),
     x mkdr_nRT(numcomp_nRT_p, num_nRT_p),
     x mka_nRT(numcomp_nRT_p, num_nRT_p),
     x hka_nRT(numcomp_nRT_p, num_nRT_p),
     x mk2_nRT(numcomp_nRT_p, num_nRT_p), 
     x hk2_nRT(numcomp_nRT_p, num_nRT_p),
     x mkm_nRT(numcomp_nRT_p, num_nRT_p),
     x mkc_nRT(numcomp_nRT_p, num_nRT_p),
     x mkahp_nRT(numcomp_nRT_p, num_nRT_p),
     x mcat_nRT(numcomp_nRT_p, num_nRT_p),
     x hcat_nRT(numcomp_nRT_p, num_nRT_p),
     x mcal_nRT(numcomp_nRT_p, num_nRT_p),
     x mar_nRT(numcomp_nRT_p, num_nRT_p)

       double precision
     &    ranvec_suppyrRS  (num_suppyrRS_p),
     &    ranvec_suppyrFRB (num_suppyrFRB_p), 
     &    ranvec_supbask   (num_supbask_p),  
     &    ranvec_supaxax   (num_supaxax_p), 
     &    ranvec_supLTS    (num_supLTS_p), 
     &    ranvec_spinstell (num_spinstell_p),
     &    ranvec_tuftIB    (num_tuftIB_p),  
     &    ranvec_tuftRS    (num_tuftRS_p), 
     &    ranvec_nontuftRS (num_nontuftRS_p),
     &    ranvec_deepbask  (num_deepbask_p),
     &    ranvec_deepaxax  (num_deepaxax_p),
     &    ranvec_deepLTS   (num_deepLTS_p),
     &    ranvec_TCR       (num_TCR_p),   
     &    ranvec_nRT       (num_nRT_p),
     &    seed /137.d0/

c Define arrays for distal axon voltages which will be shared
c between nodes.
         double precision::
     &  distal_axon_suppyrRS  (1000),
     &  distal_axon_suppyrFRB (1000),
     &  distal_axon_supbask   (1000),
     &  distal_axon_supaxax   (1000),
     &  distal_axon_supLTS    (1000), 
     &  distal_axon_spinstell (1000),  
     &  distal_axon_tuftIB    (1000),
     &  distal_axon_tuftRS    (1000),
     &  distal_axon_nontuftRS (1000), 
     &  distal_axon_deepbask  (1000),
     &  distal_axon_deepaxax  (1000),
     &  distal_axon_deepLTS   (1000),
     &  distal_axon_TCR       (1000), 
     &  distal_axon_nRT       (1000),
     &  distal_axon_global    (14000) !14000 = 14 x num_suppyrRS

c     about above:
!    &  distal_axon_suppyrFRB (num_suppyrFRB_p),
! make all distal_axon have the length max (num_celltype)

! distal_axon_global will be concatenation of individual
! distal_axon vectors       
! positions 1      -  1000  suppyrRS axons
!           1001   -  2000  suppyrFRB axons
!           2001   -  3000  supbask
!           3001   -  4000  supaxax
!           4001   -  5000  supLTS
!           5001   -  6000  spinstell
!           6001   -  7000  tuftIB
!           7001   -  8000  tuftRS
!           8001   -  9000  nontuftRS
!           9001   - 10000  deepbask
!          10001   - 11000  deepaxax
!          11001   - 12000  deepLTS
!          12001   - 13000  TCR
!          13001   - 14000  nRT

! define arrays for axonal voltges, needed for mixed gj
         double precision ::
     &    vax_suppyrRS (num_suppyrRS_p), 
     &    vax_suppyrFRB (num_suppyrFRB_p),
     &    vax_tuftIB (num_tuftIB_p), vax_tuftRS (num_tuftRS_p)

         double precision::
     &  outtime_suppyrRS  (5000, num_suppyrRS_p),
     &  outtime_suppyrFRB (5000, num_suppyrFRB_p),
     &  outtime_supbask   (5000, num_supbask_p), 
     &  outtime_supaxax   (5000, num_supaxax_p), 
     &  outtime_supLTS    (5000, num_supLTS_p),   
     &  outtime_spinstell (5000, num_spinstell_p), 
     &  outtime_tuftIB    (5000, num_tuftIB_p), 
     &  outtime_tuftRS    (5000, num_tuftRS_p),  
     &  outtime_nontuftRS (5000, num_nontuftRS_p),
     &  outtime_deepbask  (5000, num_deepbask_p),
     &  outtime_deepaxax  (5000, num_deepaxax_p),
     &  outtime_deepLTS   (5000, num_deepLTS_p), 
     &  outtime_TCR       (5000, num_TCR_p),      
     &  outtime_nRT       (5000, num_nRT_p)       

         INTEGER
     &  outctr_suppyrRS  (num_suppyrRS_p), 
     &  outctr_suppyrFRB (num_suppyrFRB_p),
     &  outctr_supbask   (num_supbask_p), 
     &  outctr_supaxax   (num_supaxax_p),
     &  outctr_supLTS    (num_supLTS_p),
     &  outctr_spinstell (num_spinstell_p),
     &  outctr_tuftIB    (num_tuftIB_p), 
     &  outctr_tuftRS    (num_tuftRS_p),
     &  outctr_nontuftRS (num_nontuftRS_p),
     &  outctr_deepbask  (num_deepbask_p),
     &  outctr_deepaxax  (num_deepaxax_p),
     &  outctr_deepLTS   (num_deepLTS_p),
     &  outctr_TCR       (num_TCR_p), 
     &  outctr_nRT       (num_nRT_p)


!       REAL*8 gettime, time1, time2, time, timtot, gettime  ! original declar
       REAL dtime, t_time(2), e_time      ! e_time is dtime output
!       REAL*8:: dt=dt_p, Mg = Mg_p
       REAL*8 time1, time2, time, timtot
       REAL*8 presyntime, delta, dexparg, dexparg1, dexparg2
       INTEGER:: thisno, display /1/, O
       integer:: info, nodes
       REAL*8 z, z1, z2, outrcd(20)
          include 'mpif.h'
 	character* (MPI_MAX_PROCESSOR_NAME) name
	integer resultlength
        integer:: debug=0 ! will write extra files for debugging purposes
c     the following are numbers that can be added to a cell number
c     (1 to the number of cells of a particular type of cell) to 
c     find the unique NEURON global identifier (gid) for that cell
c     amoung all the cells.
        integer:: current_injection=1 ! turn on curr_cell injection when =1
        integer suppyrRS_base/-1/, suppyrFRB_base/999/,
     x  supbask_base/1049/, supaxax_base/1139/,
     x  supLTS_base/1229/, spinstell_base/1319/,
     x  tuftIB_base/1559/, tuftRS_base/2359/,
     x  nontuftRS_base/2559/, deepbask_base/3059/,
     x  deepaxax_base/3159/, deepLTS_base/3259/,
     x  TCR_base/3359/, nRT_base/3459/
        real*8 delay, default_delay ! values written to a file for NEURON comparison
        integer synapse_counter/0/
        integer turn_off_chemical_synapses/0/ ! 1 to turn off, 0 to connect
        num_suppyrRS = num_suppyrRS_p
        num_suppyrFRB = num_suppyrFRB_p
        num_supbask =num_supbask_p  
        num_supaxax =num_supaxax_p
        num_supLTS = num_supLTS_p
        num_spinstell = num_spinstell_p
        num_tuftIB = num_tuftIB_p
        num_tuftRS = num_tuftRS_p
        num_nontuftRS = num_nontuftRS_p
        num_deepbask = num_deepbask_p
        num_deepaxax = num_deepaxax_p
        num_deepLTS = num_deepLTS_p
        num_TCR = num_TCR_p
        num_nRT = num_nRT_p

	suppyrRS_base = -1
	suppyrFRB_base = suppyrRS_base + num_suppyrRS
	supbask_base = suppyrFRB_base + num_suppyrFRB
	supaxax_base = supbask_base + num_supbask
	supLTS_base = supaxax_base + num_supaxax
	spinstell_base = supLTS_base + num_supLTS
	tuftIB_base = spinstell_base + num_spinstell
	tuftRS_base = tuftIB_base + num_tuftIB
	nontuftRS_base = tuftRS_base + num_tuftRS
	deepbask_base = nontuftRS_base + num_nontuftRS
	deepaxax_base = deepbask_base + num_deepbask
	deepLTS_base = deepaxax_base + num_deepaxax
	TCR_base = deepLTS_base + num_deepLTS
	nRT_base = TCR_base + num_TCR

        numcomp_suppyrRS = numcomp_suppyrRS_p
        numcomp_suppyrFRB = numcomp_suppyrFRB_p
        numcomp_supbask = numcomp_supbask_p
        numcomp_supaxax = numcomp_supaxax_p
        numcomp_supLTS = numcomp_supLTS_p
        numcomp_spinstell = numcomp_spinstell_p
        numcomp_tuftIB = numcomp_tuftIB_p
        numcomp_tuftRS = numcomp_tuftRS_p
        numcomp_nontuftRS = numcomp_nontuftRS_p
        numcomp_deepbask = numcomp_deepbask_p
        numcomp_deepaxax = numcomp_deepaxax_p
        numcomp_deepLTS = numcomp_deepLTS_p
        numcomp_TCR = numcomp_TCR_p
        numcomp_nRT = numcomp_nRT_p

      if (turn_off_chemical_synapses.eq.1) then
        
         num_suppyrRS_to_suppyrRS = 0
         num_suppyrRS_to_suppyrFRB = 0
         num_suppyrRS_to_supbask = 0
         num_suppyrRS_to_supaxax = 0
         num_suppyrRS_to_supLTS = 0
         num_suppyrRS_to_spinstell = 0
         num_suppyrRS_to_tuftIB = 0
         num_suppyrRS_to_tuftRS = 0
         num_suppyrRS_to_deepbask = 0
         num_suppyrRS_to_deepaxax = 0
         num_suppyrRS_to_deepLTS = 0
         num_suppyrRS_to_nontuftRS = 0
         num_suppyrFRB_to_suppyrRS = 0
         num_suppyrFRB_to_suppyrFRB = 0
         num_suppyrFRB_to_supbask = 0
         num_suppyrFRB_to_supaxax = 0
         num_suppyrFRB_to_supLTS = 0
         num_suppyrFRB_to_spinstell = 0
         num_suppyrFRB_to_tuftIB = 0
         num_suppyrFRB_to_tuftRS = 0
         num_suppyrFRB_to_deepbask = 0
         num_suppyrFRB_to_deepaxax = 0
         num_suppyrFRB_to_deepLTS = 0
         num_suppyrFRB_to_nontuftRS = 0
        num_supbask_to_suppyrRS   = 0
        num_supbask_to_suppyrFRB  = 0
        num_supbask_to_supbask    = 0
        num_supbask_to_supaxax    = 0
        num_supbask_to_supLTS     = 0
        num_supbask_to_spinstell  = 0
        num_supaxax_to_suppyrRS   = 0
        num_supaxax_to_suppyrFRB  = 0
        num_supaxax_to_spinstell  = 0
        num_supaxax_to_tuftIB     = 0
        num_supaxax_to_tuftRS     = 0
        num_supaxax_to_nontuftRS  = 0
        num_supLTS_to_suppyrRS    = 0
        num_supLTS_to_suppyrFRB   = 0
        num_supLTS_to_supbask     = 0
        num_supLTS_to_supaxax     = 0
        num_supLTS_to_supLTS      = 0
        num_supLTS_to_spinstell   = 0
        num_supLTS_to_tuftIB      = 0
        num_supLTS_to_tuftRS      = 0
        num_supLTS_to_deepbask    = 0
        num_supLTS_to_deepaxax    = 0
        num_supLTS_to_deepLTS     = 0
        num_supLTS_to_nontuftRS   = 0
        num_spinstell_to_suppyrRS = 0
        num_spinstell_to_suppyrFRB= 0
        num_spinstell_to_supbask  = 0
        num_spinstell_to_supaxax  = 0
        num_spinstell_to_supLTS   = 0
        num_spinstell_to_spinstell= 0
        num_spinstell_to_tuftIB   = 0
        num_spinstell_to_tuftRS   = 0
        num_spinstell_to_deepbask = 0
        num_spinstell_to_deepaxax = 0
        num_spinstell_to_deepLTS  = 0
        num_spinstell_to_nontuftRS= 0
        num_tuftIB_to_suppyrRS    = 0
        num_tuftIB_to_suppyrFRB   = 0
        num_tuftIB_to_supbask     = 0
        num_tuftIB_to_supaxax     = 0
        num_tuftIB_to_supLTS      = 0
        num_tuftIB_to_spinstell   = 0
        num_tuftIB_to_tuftIB      = 0
        num_tuftIB_to_tuftRS      = 0
        num_tuftIB_to_deepbask    = 0
        num_tuftIB_to_deepaxax    = 0
        num_tuftIB_to_deepLTS     = 0
        num_tuftIB_to_nontuftRS   = 0
        num_tuftRS_to_suppyrRS    = 0
        num_tuftRS_to_suppyrFRB   = 0
        num_tuftRS_to_supbask     = 0
        num_tuftRS_to_supaxax     = 0
        num_tuftRS_to_supLTS      = 0
        num_tuftRS_to_spinstell   = 0
        num_tuftRS_to_tuftIB      = 0
        num_tuftRS_to_tuftRS      = 0
        num_tuftRS_to_deepbask    = 0
        num_tuftRS_to_deepaxax    = 0
        num_tuftRS_to_deepLTS     = 0
        num_tuftRS_to_nontuftRS   = 0
        num_deepbask_to_spinstell = 0
        num_deepbask_to_tuftIB    = 0
        num_deepbask_to_tuftRS    = 0
        num_deepbask_to_deepbask  = 0
        num_deepbask_to_deepaxax  = 0
        num_deepbask_to_deepLTS   = 0
        num_deepbask_to_nontuftRS = 0
        num_deepaxax_to_suppyrRS  = 0
        num_deepaxax_to_suppyrFRB = 0
        num_deepaxax_to_spinstell = 0
        num_deepaxax_to_tuftIB    = 0
        num_deepaxax_to_tuftRS    = 0
        num_deepaxax_to_nontuftRS = 0
        num_deepLTS_to_suppyrRS   = 0
        num_deepLTS_to_suppyrFRB  = 0
        num_deepLTS_to_supbask    = 0
        num_deepLTS_to_supaxax    = 0
        num_deepLTS_to_supLTS     = 0
        num_deepLTS_to_spinstell  = 0
        num_deepLTS_to_tuftIB     = 0
        num_deepLTS_to_tuftRS     = 0
        num_deepLTS_to_deepbask   = 0
        num_deepLTS_to_deepaxax   = 0
        num_deepLTS_to_deepLTS    = 0
        num_deepLTS_to_nontuftRS  = 0
        num_TCR_to_suppyrRS       = 0
        num_TCR_to_suppyrFRB      = 0
        num_TCR_to_supbask        = 0
        num_TCR_to_supaxax        = 0
        num_TCR_to_spinstell      = 0
        num_TCR_to_tuftIB         = 0
        num_TCR_to_tuftRS         = 0
        num_TCR_to_deepbask       = 0
        num_TCR_to_deepaxax       = 0
        num_TCR_to_nRT            = 0
        num_TCR_to_nontuftRS      = 0
        num_nRT_to_TCR            = 0
        num_nRT_to_nRT            = 0
        num_nontuftRS_to_suppyrRS = 0
        num_nontuftRS_to_suppyrFRB= 0
        num_nontuftRS_to_supbask  = 0
        num_nontuftRS_to_supaxax  = 0
        num_nontuftRS_to_supLTS   = 0
        num_nontuftRS_to_spinstell= 0
        num_nontuftRS_to_tuftIB   = 0
        num_nontuftRS_to_tuftRS   = 0
        num_nontuftRS_to_deepbask = 0
        num_nontuftRS_to_deepaxax = 0
        num_nontuftRS_to_deepLTS  = 0
        num_nontuftRS_to_TCR      = 0
        num_nontuftRS_to_nRT      = 0
        num_nontuftRS_to_nontuftRS= 0
      end if ! turn off chemical synapses

      noisepe_suppyrRS = 1.d0 / (2.5d0 * 10000.d0)
!    &            1.d0 / (2.5d0 * 1000.d0) ! USUAL

      noisepe_suppyrFRB=1.d0 / (2.5d0 * 10000.d0) 
!    &            1.d0 / (2.5d0 * 1000.d0) ! USUAL

      noisepe_spinstell= 1.d0 / (2.5d0 * 1000.d0)
      noisepe_tuftIB = 1.d0 / (2.5d0 * 1000.d0)
      noisepe_tuftRS = 1.d0 / (2.5d0 * 1000.d0)
      noisepe_nontuftRS = 1.d0 / (2.5d0 * 1000.d0)
      noisepe_TCR = 1.d0 / (2.5d0 * 1000.d0)

c START EXECUTION PHASE
! this version will be mpif77
          call trapfpe() ! allows floating point exceptions to be trapped in gdb
          call mpi_init (info)
          call mpi_comm_rank(mpi_comm_world, thisno, info)
          call mpi_comm_size(mpi_comm_world, nodes , info)

	call MPI_GET_PROCESSOR_NAME(name,resultlength,ierr)
!	print *, 'Process ', rank, ' of ', size, ' is alive on ',name
        write (*,2220)thisno, nodes, name
 2220	FORMAT("Process ",I2," of ",I2," is alive on ",A18)
        if (thisno.eq.0) then
           print *,'dt = ',dt
        endif

          time1 = 0.d0	!	 used to be =gettime()
          ! dtime when called will give elapsed time from start of program
         
         do i = 1, 5000
           do j = 1, num_suppyrRS
        outtime_suppyrRS(i,j)             = -1.d5
           end do ! j
           do j = 1, num_suppyrFRB
        outtime_suppyrFRB(i,j)            = -1.d5 
           end do ! j
           do j = 1, num_supbask  
        outtime_supbask(i,j)              = -1.d5
           end do ! j
           do j = 1, num_supaxax  
        outtime_supaxax(i,j)              = -1.d5
           end do ! j
           do j = 1, num_supLTS   
        outtime_supLTS(i,j)               = -1.d5
           end do ! j
           do j = 1, num_spinstell
        outtime_spinstell(i,j)            = -1.d5 
           end do ! j
           do j = 1, num_tuftIB   
        outtime_tuftIB(i,j)               = -1.d5
           end do ! j
           do j = 1, num_tuftRS   
        outtime_tuftRS(i,j)               = -1.d5
           end do ! j
           do j = 1, num_nontuftRS   
        outtime_nontuftRS(i,j)            = -1.d5
           end do ! j
           do j = 1, num_deepbask    
        outtime_deepbask(i,j)             = -1.d5
           end do ! j
           do j = 1, num_deepaxax    
        outtime_deepaxax(i,j)             = -1.d5
           end do ! j
           do j = 1, num_deepLTS     
        outtime_deepLTS(i,j)              = -1.d5
           end do ! j
           do j = 1, num_TCR         
        outtime_TCR(i,j)                  = -1.d5
           end do ! j
           do j = 1, num_nRT         
        outtime_nRT(i,j)                  = -1.d5
           end do ! j
         end do ! do i

!         timtot =  750.d0
!         timtot = 1600.d0
!          timtot = 0.02d0 ! tiny debug time doesn't test 0.05 interval
!          timtot = 0.104d0 ! debug time does test 0.05 interval (~40 secs to run)
                          ! and writes one set of time points to the GROUNCO110 files
!          timtot = 0.5d0 ! minimal time for 5 write's of output voltages (21 minutes)
!          timtot = 1.2d0 ! debug time does test 0.05 interval 
!          timtot = dt     ! enough for one time step
!          timtot =13.72d0 ! took about 38 minutes to get to 6.8 ms then crashed in continued
                          ! debuging
!         timtot =64.4d0   ! projected to take 6 hours at 5.59 minutes computing / msec model time
         timtot =100.d0   ! projected to take about an hour (took 1 hour 45 min)
!          timtot = 0.2d0 ! minimal time for 2 write's of output voltages (~10 minutes)

c Setup tables for calculating exponentials
          call dexptablesmall_setup (dexptablesmall)
          call dexptablebig_setup   (dexptablebig)

c Compartments contacted by axoaxonic interneurons are IS only
          do i = 1, num_suppyrRS 
          do j = 1, num_supaxax_to_suppyrRS 
             com_supaxax_to_suppyrRS (j,i) = 69
          end do
          end do
          do i = 1, num_suppyrFRB
          do j = 1, num_supaxax_to_suppyrFRB
             com_supaxax_to_suppyrFRB(j,i) = 69
          end do
          end do
          do i = 1, num_spinstell
          do j = 1, num_supaxax_to_spinstell
             com_supaxax_to_spinstell(j,i) = 54
          end do
          end do
          do i = 1, num_tuftIB   
          do j = 1, num_supaxax_to_tuftIB   
             com_supaxax_to_tuftIB   (j,i) = 56
          end do
          end do
          do i = 1, num_tuftRS   
          do j = 1, num_supaxax_to_tuftRS   
             com_supaxax_to_tuftRS   (j,i) = 56
          end do
          end do
          do i = 1, num_nontuftRS   
          do j = 1, num_supaxax_to_nontuftRS   
             com_supaxax_to_nontuftRS   (j,i) = 45
          end do
          end do
          do i = 1, num_suppyrRS    
          do j = 1, num_deepaxax_to_suppyrRS    
             com_deepaxax_to_suppyrRS    (j,i) = 69
          end do
          end do
          do i = 1, num_suppyrFRB   
          do j = 1, num_deepaxax_to_suppyrFRB   
             com_deepaxax_to_suppyrFRB   (j,i) = 69
          end do
          end do
          do i = 1, num_spinstell   
          do j = 1, num_deepaxax_to_spinstell   
             com_deepaxax_to_spinstell   (j,i) = 54
          end do
          end do
          do i = 1, num_tuftIB      
          do j = 1, num_deepaxax_to_tuftIB      
             com_deepaxax_to_tuftIB      (j,i) = 56 
          end do
          end do
          do i = 1, num_tuftRS      
          do j = 1, num_deepaxax_to_tuftRS      
             com_deepaxax_to_tuftRS      (j,i) = 56 
          end do
          end do
          do i = 1, num_nontuftRS      
          do j = 1, num_deepaxax_to_nontuftRS      
             com_deepaxax_to_nontuftRS      (j,i) = 45 
          end do
          end do
c End section on making axoaxonic cells connect to IS's

c Construct synaptic connectivity tables
                display = 0

!        do thisno = 0, 13   ! simulate multiple processors

          if (thisno.eq.0) then
             open(40,FILE='map/map_suppyrRS_to_suppyrRS.dat')
          end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_suppyrRS,           
     &     map_suppyrRS_to_suppyrRS,
     &     num_suppyrRS_to_suppyrRS,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_suppyrRS,           
     &     map_suppyrRS_to_suppyrRS,
     &     num_suppyrRS_to_suppyrRS,    display)
          if (thisno.eq.0) then
              open(40,FILE='map/map_suppyrRS_to_suppyrFRB.dat')
          end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_suppyrFRB,          
     &     map_suppyrRS_to_suppyrFRB,
     &     num_suppyrRS_to_suppyrFRB,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_suppyrFRB,          
     &     map_suppyrRS_to_suppyrFRB,
     &     num_suppyrRS_to_suppyrFRB,   display)

          if (thisno.eq.0) then
              open(40,FILE='map/map_suppyrRS_to_supbask.dat')
          end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supbask,            
     &     map_suppyrRS_to_supbask,  
     &     num_suppyrRS_to_supbask,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supbask,            
     &     map_suppyrRS_to_supbask,  
     &     num_suppyrRS_to_supbask,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supaxax,            
     &     map_suppyrRS_to_supaxax,  
     &     num_suppyrRS_to_supaxax,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supaxax,            
     &     map_suppyrRS_to_supaxax,  
     &     num_suppyrRS_to_supaxax,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supLTS,             
     &     map_suppyrRS_to_supLTS,   
     &     num_suppyrRS_to_supLTS,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_supLTS,             
     &     map_suppyrRS_to_supLTS,   
     &     num_suppyrRS_to_supLTS,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_spinstell,          
     &     map_suppyrRS_to_spinstell,
     &     num_suppyrRS_to_spinstell,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_spinstell,          
     &     map_suppyrRS_to_spinstell,
     &     num_suppyrRS_to_spinstell,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_tuftIB,             
     &     map_suppyrRS_to_tuftIB,   
     &     num_suppyrRS_to_tuftIB,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_tuftIB,             
     &     map_suppyrRS_to_tuftIB,   
     &     num_suppyrRS_to_tuftIB,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_tuftRS,             
     &     map_suppyrRS_to_tuftRS,   
     &     num_suppyrRS_to_tuftRS,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_tuftRS,             
     &     map_suppyrRS_to_tuftRS,   
     &     num_suppyrRS_to_tuftRS,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepbask,           
     &     map_suppyrRS_to_deepbask, 
     &     num_suppyrRS_to_deepbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepbask,           
     &     map_suppyrRS_to_deepbask, 
     &     num_suppyrRS_to_deepbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepaxax,           
     &     map_suppyrRS_to_deepaxax, 
     &     num_suppyrRS_to_deepaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepaxax,           
     &     map_suppyrRS_to_deepaxax, 
     &     num_suppyrRS_to_deepaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepLTS,            
     &     map_suppyrRS_to_deepLTS,  
     &     num_suppyrRS_to_deepLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_deepLTS,            
     &     map_suppyrRS_to_deepLTS,  
     &     num_suppyrRS_to_deepLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrRS_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrRS, num_nontuftRS,          
     &     map_suppyrRS_to_nontuftRS,
     &     num_suppyrRS_to_nontuftRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrRS, num_nontuftRS,          
     &     map_suppyrRS_to_nontuftRS,
     &     num_suppyrRS_to_nontuftRS,   display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_suppyrRS,           
     &     map_suppyrFRB_to_suppyrRS, 
     &     num_suppyrFRB_to_suppyrRS,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_suppyrRS,           
     &     map_suppyrFRB_to_suppyrRS, 
     &     num_suppyrFRB_to_suppyrRS,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_suppyrFRB,          
     &     map_suppyrFRB_to_suppyrFRB,
     &     num_suppyrFRB_to_suppyrFRB,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_suppyrFRB,          
     &     map_suppyrFRB_to_suppyrFRB,
     &     num_suppyrFRB_to_suppyrFRB,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supbask,            
     &     map_suppyrFRB_to_supbask,  
     &     num_suppyrFRB_to_supbask,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supbask,            
     &     map_suppyrFRB_to_supbask,  
     &     num_suppyrFRB_to_supbask,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supaxax,            
     &     map_suppyrFRB_to_supaxax,  
     &     num_suppyrFRB_to_supaxax,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supaxax,            
     &     map_suppyrFRB_to_supaxax,  
     &     num_suppyrFRB_to_supaxax,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supLTS,             
     &     map_suppyrFRB_to_supLTS,   
     &     num_suppyrFRB_to_supLTS,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_supLTS,             
     &     map_suppyrFRB_to_supLTS,   
     &     num_suppyrFRB_to_supLTS,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_spinstell,          
     &     map_suppyrFRB_to_spinstell,
     &     num_suppyrFRB_to_spinstell,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_spinstell,          
     &     map_suppyrFRB_to_spinstell,
     &     num_suppyrFRB_to_spinstell,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_tuftIB,             
     &     map_suppyrFRB_to_tuftIB,   
     &     num_suppyrFRB_to_tuftIB,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_tuftIB,             
     &     map_suppyrFRB_to_tuftIB,   
     &     num_suppyrFRB_to_tuftIB,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_tuftRS,             
     &     map_suppyrFRB_to_tuftRS,   
     &     num_suppyrFRB_to_tuftRS,      display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_tuftRS,             
     &     map_suppyrFRB_to_tuftRS,   
     &     num_suppyrFRB_to_tuftRS,      display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepbask,           
     &     map_suppyrFRB_to_deepbask, 
     &     num_suppyrFRB_to_deepbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepbask,           
     &     map_suppyrFRB_to_deepbask, 
     &     num_suppyrFRB_to_deepbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepaxax,           
     &     map_suppyrFRB_to_deepaxax, 
     &     num_suppyrFRB_to_deepaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepaxax,           
     &     map_suppyrFRB_to_deepaxax, 
     &     num_suppyrFRB_to_deepaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepLTS,            
     &     map_suppyrFRB_to_deepLTS,  
     &     num_suppyrFRB_to_deepLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_deepLTS,            
     &     map_suppyrFRB_to_deepLTS,  
     &     num_suppyrFRB_to_deepLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_suppyrFRB_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_nontuftRS,          
     &     map_suppyrFRB_to_nontuftRS,
     &     num_suppyrFRB_to_nontuftRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_suppyrFRB, num_nontuftRS,          
     &     map_suppyrFRB_to_nontuftRS,
     &     num_suppyrFRB_to_nontuftRS,   display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_suppyrRS,           
     &     map_supbask_to_suppyrRS, 
     &     num_supbask_to_suppyrRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_suppyrRS,           
     &     map_supbask_to_suppyrRS, 
     &     num_supbask_to_suppyrRS,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_suppyrFRB,          
     &     map_supbask_to_suppyrFRB,
     &     num_supbask_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_suppyrFRB,          
     &     map_supbask_to_suppyrFRB,
     &     num_supbask_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_supbask,            
     &     map_supbask_to_supbask,  
     &     num_supbask_to_supbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_supbask,            
     &     map_supbask_to_supbask,  
     &     num_supbask_to_supbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_supaxax,            
     &     map_supbask_to_supaxax,  
     &     num_supbask_to_supaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_supaxax,            
     &     map_supbask_to_supaxax,  
     &     num_supbask_to_supaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_supLTS,             
     &     map_supbask_to_supLTS,   
     &     num_supbask_to_supLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_supLTS,             
     &     map_supbask_to_supLTS,   
     &     num_supbask_to_supLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supbask_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supbask, num_spinstell,          
     &     map_supbask_to_spinstell,
     &     num_supbask_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supbask, num_spinstell,          
     &     map_supbask_to_spinstell,
     &     num_supbask_to_spinstell,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_suppyrRS,           
     &     map_supaxax_to_suppyrRS, 
     &     num_supaxax_to_suppyrRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_suppyrRS,           
     &     map_supaxax_to_suppyrRS, 
     &     num_supaxax_to_suppyrRS,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_suppyrFRB,          
     &     map_supaxax_to_suppyrFRB,
     &     num_supaxax_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_suppyrFRB,          
     &     map_supaxax_to_suppyrFRB,
     &     num_supaxax_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_spinstell,          
     &     map_supaxax_to_spinstell,
     &     num_supaxax_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_spinstell,          
     &     map_supaxax_to_spinstell,
     &     num_supaxax_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_tuftIB,             
     &     map_supaxax_to_tuftIB,   
     &     num_supaxax_to_tuftIB,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_tuftIB,             
     &     map_supaxax_to_tuftIB,   
     &     num_supaxax_to_tuftIB,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_tuftRS,             
     &     map_supaxax_to_tuftRS,   
     &     num_supaxax_to_tuftRS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_tuftRS,             
     &     map_supaxax_to_tuftRS,   
     &     num_supaxax_to_tuftRS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supaxax_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supaxax, num_nontuftRS,             
     &     map_supaxax_to_nontuftRS,   
     &     num_supaxax_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supaxax, num_nontuftRS,             
     &     map_supaxax_to_nontuftRS,   
     &     num_supaxax_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_suppyrRS,              
     &     map_supLTS_to_suppyrRS,    
     &     num_supLTS_to_suppyrRS ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_suppyrRS,              
     &     map_supLTS_to_suppyrRS,    
     &     num_supLTS_to_suppyrRS ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_suppyrFRB,             
     &     map_supLTS_to_suppyrFRB,   
     &     num_supLTS_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_suppyrFRB,             
     &     map_supLTS_to_suppyrFRB,   
     &     num_supLTS_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_supbask,               
     &     map_supLTS_to_supbask,     
     &     num_supLTS_to_supbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_supbask,               
     &     map_supLTS_to_supbask,     
     &     num_supLTS_to_supbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_supaxax,               
     &     map_supLTS_to_supaxax,     
     &     num_supLTS_to_supaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_supaxax,               
     &     map_supLTS_to_supaxax,     
     &     num_supLTS_to_supaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_supLTS,                
     &     map_supLTS_to_supLTS,      
     &     num_supLTS_to_supLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_supLTS,                
     &     map_supLTS_to_supLTS,      
     &     num_supLTS_to_supLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_spinstell,             
     &     map_supLTS_to_spinstell,   
     &     num_supLTS_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_spinstell,             
     &     map_supLTS_to_spinstell,   
     &     num_supLTS_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_tuftIB,                
     &     map_supLTS_to_tuftIB,      
     &     num_supLTS_to_tuftIB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_tuftIB,                
     &     map_supLTS_to_tuftIB,      
     &     num_supLTS_to_tuftIB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_tuftRS,                
     &     map_supLTS_to_tuftRS,      
     &     num_supLTS_to_tuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_tuftRS,                
     &     map_supLTS_to_tuftRS,      
     &     num_supLTS_to_tuftRS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepbask,              
     &     map_supLTS_to_deepbask,    
     &     num_supLTS_to_deepbask ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepbask,              
     &     map_supLTS_to_deepbask,    
     &     num_supLTS_to_deepbask ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepaxax,              
     &     map_supLTS_to_deepaxax,    
     &     num_supLTS_to_deepaxax ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepaxax,              
     &     map_supLTS_to_deepaxax,    
     &     num_supLTS_to_deepaxax ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepLTS,               
     &     map_supLTS_to_deepLTS,     
     &     num_supLTS_to_deepLTS,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_deepLTS,               
     &     map_supLTS_to_deepLTS,     
     &     num_supLTS_to_deepLTS,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_supLTS_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_supLTS,  num_nontuftRS,             
     &     map_supLTS_to_nontuftRS,   
     &     num_supLTS_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_supLTS,  num_nontuftRS,             
     &     map_supLTS_to_nontuftRS,   
     &     num_supLTS_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_suppyrRS,              
     &     map_spinstell_to_suppyrRS,    
     &     num_spinstell_to_suppyrRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_suppyrRS,              
     &     map_spinstell_to_suppyrRS,    
     &     num_spinstell_to_suppyrRS,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_suppyrFRB,             
     &     map_spinstell_to_suppyrFRB,   
     &     num_spinstell_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_suppyrFRB,             
     &     map_spinstell_to_suppyrFRB,   
     &     num_spinstell_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_supbask,               
     &     map_spinstell_to_supbask,     
     &     num_spinstell_to_supbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_supbask,               
     &     map_spinstell_to_supbask,     
     &     num_spinstell_to_supbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_supaxax,               
     &     map_spinstell_to_supaxax,     
     &     num_spinstell_to_supaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_supaxax,               
     &     map_spinstell_to_supaxax,     
     &     num_spinstell_to_supaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_supLTS,                
     &     map_spinstell_to_supLTS,      
     &     num_spinstell_to_supLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_supLTS,                
     &     map_spinstell_to_supLTS,      
     &     num_spinstell_to_supLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_spinstell,             
     &     map_spinstell_to_spinstell,   
     &     num_spinstell_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_spinstell,             
     &     map_spinstell_to_spinstell,   
     &     num_spinstell_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_tuftIB,                
     &     map_spinstell_to_tuftIB,      
     &     num_spinstell_to_tuftIB,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_tuftIB,                
     &     map_spinstell_to_tuftIB,      
     &     num_spinstell_to_tuftIB,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_tuftRS,                
     &     map_spinstell_to_tuftRS,      
     &     num_spinstell_to_tuftRS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_tuftRS,                
     &     map_spinstell_to_tuftRS,      
     &     num_spinstell_to_tuftRS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepbask,              
     &     map_spinstell_to_deepbask,    
     &     num_spinstell_to_deepbask,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepbask,              
     &     map_spinstell_to_deepbask,    
     &     num_spinstell_to_deepbask,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepaxax,              
     &     map_spinstell_to_deepaxax,    
     &     num_spinstell_to_deepaxax,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepaxax,              
     &     map_spinstell_to_deepaxax,    
     &     num_spinstell_to_deepaxax,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepLTS,               
     &     map_spinstell_to_deepLTS,     
     &     num_spinstell_to_deepLTS,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_deepLTS,               
     &     map_spinstell_to_deepLTS,     
     &     num_spinstell_to_deepLTS,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_spinstell_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_spinstell,  num_nontuftRS,             
     &     map_spinstell_to_nontuftRS,   
     &     num_spinstell_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_spinstell,  num_nontuftRS,             
     &     map_spinstell_to_nontuftRS,   
     &     num_spinstell_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_suppyrRS,              
     &     map_tuftIB_to_suppyrRS,    
     &     num_tuftIB_to_suppyrRS,   display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_suppyrRS,              
     &     map_tuftIB_to_suppyrRS,    
     &     num_tuftIB_to_suppyrRS,   display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_suppyrFRB,             
     &     map_tuftIB_to_suppyrFRB,   
     &     num_tuftIB_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_suppyrFRB,             
     &     map_tuftIB_to_suppyrFRB,   
     &     num_tuftIB_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supbask,               
     &     map_tuftIB_to_supbask,     
     &     num_tuftIB_to_supbask,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supbask,               
     &     map_tuftIB_to_supbask,     
     &     num_tuftIB_to_supbask,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supaxax,               
     &     map_tuftIB_to_supaxax,     
     &     num_tuftIB_to_supaxax,    display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supaxax,               
     &     map_tuftIB_to_supaxax,     
     &     num_tuftIB_to_supaxax,    display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supLTS,                
     &     map_tuftIB_to_supLTS,      
     &     num_tuftIB_to_supLTS,     display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_supLTS,                
     &     map_tuftIB_to_supLTS,      
     &     num_tuftIB_to_supLTS,     display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_spinstell,             
     &     map_tuftIB_to_spinstell,   
     &     num_tuftIB_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_spinstell,             
     &     map_tuftIB_to_spinstell,   
     &     num_tuftIB_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_tuftIB   ,             
     &     map_tuftIB_to_tuftIB   ,   
     &     num_tuftIB_to_tuftIB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_tuftIB   ,             
     &     map_tuftIB_to_tuftIB   ,   
     &     num_tuftIB_to_tuftIB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_tuftRS   ,             
     &     map_tuftIB_to_tuftRS   ,   
     &     num_tuftIB_to_tuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_tuftRS   ,             
     &     map_tuftIB_to_tuftRS   ,   
     &     num_tuftIB_to_tuftRS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepbask ,             
     &     map_tuftIB_to_deepbask ,   
     &     num_tuftIB_to_deepbask ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepbask ,             
     &     map_tuftIB_to_deepbask ,   
     &     num_tuftIB_to_deepbask ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepaxax ,             
     &     map_tuftIB_to_deepaxax ,   
     &     num_tuftIB_to_deepaxax ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepaxax ,             
     &     map_tuftIB_to_deepaxax ,   
     &     num_tuftIB_to_deepaxax ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepLTS  ,             
     &     map_tuftIB_to_deepLTS  ,   
     &     num_tuftIB_to_deepLTS  ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_deepLTS  ,             
     &     map_tuftIB_to_deepLTS  ,   
     &     num_tuftIB_to_deepLTS  ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftIB_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftIB,  num_nontuftRS,             
     &     map_tuftIB_to_nontuftRS,   
     &     num_tuftIB_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftIB,  num_nontuftRS,             
     &     map_tuftIB_to_nontuftRS,   
     &     num_tuftIB_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_suppyrRS ,             
     &     map_tuftRS_to_suppyrRS ,   
     &     num_tuftRS_to_suppyrRS ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_suppyrRS ,             
     &     map_tuftRS_to_suppyrRS ,   
     &     num_tuftRS_to_suppyrRS ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_suppyrFRB,             
     &     map_tuftRS_to_suppyrFRB,   
     &     num_tuftRS_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_suppyrFRB,             
     &     map_tuftRS_to_suppyrFRB,   
     &     num_tuftRS_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supbask  ,             
     &     map_tuftRS_to_supbask  ,   
     &     num_tuftRS_to_supbask  ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supbask  ,             
     &     map_tuftRS_to_supbask  ,   
     &     num_tuftRS_to_supbask  ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supaxax  ,             
     &     map_tuftRS_to_supaxax  ,   
     &     num_tuftRS_to_supaxax  ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supaxax  ,             
     &     map_tuftRS_to_supaxax  ,   
     &     num_tuftRS_to_supaxax  ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supLTS   ,             
     &     map_tuftRS_to_supLTS   ,   
     &     num_tuftRS_to_supLTS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_supLTS   ,             
     &     map_tuftRS_to_supLTS   ,   
     &     num_tuftRS_to_supLTS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_spinstell,             
     &     map_tuftRS_to_spinstell,   
     &     num_tuftRS_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_spinstell,             
     &     map_tuftRS_to_spinstell,   
     &     num_tuftRS_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_tuftIB   ,             
     &     map_tuftRS_to_tuftIB   ,   
     &     num_tuftRS_to_tuftIB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_tuftIB   ,             
     &     map_tuftRS_to_tuftIB   ,   
     &     num_tuftRS_to_tuftIB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_tuftRS   ,             
     &     map_tuftRS_to_tuftRS   ,   
     &     num_tuftRS_to_tuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_tuftRS   ,             
     &     map_tuftRS_to_tuftRS   ,   
     &     num_tuftRS_to_tuftRS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepbask ,             
     &     map_tuftRS_to_deepbask ,   
     &     num_tuftRS_to_deepbask ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepbask ,             
     &     map_tuftRS_to_deepbask ,   
     &     num_tuftRS_to_deepbask ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepaxax ,             
     &     map_tuftRS_to_deepaxax ,   
     &     num_tuftRS_to_deepaxax ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepaxax ,             
     &     map_tuftRS_to_deepaxax ,   
     &     num_tuftRS_to_deepaxax ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepLTS  ,             
     &     map_tuftRS_to_deepLTS  ,   
     &     num_tuftRS_to_deepLTS  ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_deepLTS  ,             
     &     map_tuftRS_to_deepLTS  ,   
     &     num_tuftRS_to_deepLTS  ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_tuftRS_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_tuftRS,  num_nontuftRS,             
     &     map_tuftRS_to_nontuftRS,   
     &     num_tuftRS_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_tuftRS,  num_nontuftRS,             
     &     map_tuftRS_to_nontuftRS,   
     &     num_tuftRS_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_spinstell,             
     &     map_deepbask_to_spinstell,   
     &     num_deepbask_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_spinstell,             
     &     map_deepbask_to_spinstell,   
     &     num_deepbask_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_tuftIB   ,             
     &     map_deepbask_to_tuftIB   ,   
     &     num_deepbask_to_tuftIB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_tuftIB   ,             
     &     map_deepbask_to_tuftIB   ,   
     &     num_deepbask_to_tuftIB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_tuftRS   ,             
     &     map_deepbask_to_tuftRS   ,   
     &     num_deepbask_to_tuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_tuftRS   ,             
     &     map_deepbask_to_tuftRS   ,   
     &     num_deepbask_to_tuftRS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepbask ,             
     &     map_deepbask_to_deepbask ,   
     &     num_deepbask_to_deepbask ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepbask ,             
     &     map_deepbask_to_deepbask ,   
     &     num_deepbask_to_deepbask ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepaxax ,             
     &     map_deepbask_to_deepaxax ,   
     &     num_deepbask_to_deepaxax ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepaxax ,             
     &     map_deepbask_to_deepaxax ,   
     &     num_deepbask_to_deepaxax ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepLTS  ,             
     &     map_deepbask_to_deepLTS  ,   
     &     num_deepbask_to_deepLTS  ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_deepLTS  ,             
     &     map_deepbask_to_deepLTS  ,   
     &     num_deepbask_to_deepLTS  ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepbask_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepbask,  num_nontuftRS,             
     &     map_deepbask_to_nontuftRS,   
     &     num_deepbask_to_nontuftRS,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepbask,  num_nontuftRS,             
     &     map_deepbask_to_nontuftRS,   
     &     num_deepbask_to_nontuftRS,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_suppyrRS ,             
     &     map_deepaxax_to_suppyrRS ,   
     &     num_deepaxax_to_suppyrRS ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_suppyrRS ,             
     &     map_deepaxax_to_suppyrRS ,   
     &     num_deepaxax_to_suppyrRS ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_suppyrFRB,             
     &     map_deepaxax_to_suppyrFRB,   
     &     num_deepaxax_to_suppyrFRB,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_suppyrFRB,             
     &     map_deepaxax_to_suppyrFRB,   
     &     num_deepaxax_to_suppyrFRB,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_spinstell,             
     &     map_deepaxax_to_spinstell,   
     &     num_deepaxax_to_spinstell,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_spinstell,             
     &     map_deepaxax_to_spinstell,   
     &     num_deepaxax_to_spinstell,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_tuftIB   ,             
     &     map_deepaxax_to_tuftIB   ,   
     &     num_deepaxax_to_tuftIB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_tuftIB   ,             
     &     map_deepaxax_to_tuftIB   ,   
     &     num_deepaxax_to_tuftIB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_tuftRS   ,             
     &     map_deepaxax_to_tuftRS   ,   
     &     num_deepaxax_to_tuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_tuftRS   ,             
     &     map_deepaxax_to_tuftRS   ,   
     &     num_deepaxax_to_tuftRS   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepaxax_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepaxax,  num_nontuftRS   ,             
     &     map_deepaxax_to_nontuftRS   ,   
     &     num_deepaxax_to_nontuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepaxax,  num_nontuftRS   ,             
     &     map_deepaxax_to_nontuftRS   ,   
     &     num_deepaxax_to_nontuftRS   ,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_suppyrRS    ,             
     &     map_deepLTS_to_suppyrRS    ,   
     &     num_deepLTS_to_suppyrRS    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_suppyrRS    ,             
     &     map_deepLTS_to_suppyrRS    ,   
     &     num_deepLTS_to_suppyrRS    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_suppyrFRB   ,             
     &     map_deepLTS_to_suppyrFRB   ,   
     &     num_deepLTS_to_suppyrFRB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_suppyrFRB   ,             
     &     map_deepLTS_to_suppyrFRB   ,   
     &     num_deepLTS_to_suppyrFRB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supbask     ,             
     &     map_deepLTS_to_supbask     ,   
     &     num_deepLTS_to_supbask     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supbask     ,             
     &     map_deepLTS_to_supbask     ,   
     &     num_deepLTS_to_supbask     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supaxax     ,             
     &     map_deepLTS_to_supaxax     ,   
     &     num_deepLTS_to_supaxax     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supaxax     ,             
     &     map_deepLTS_to_supaxax     ,   
     &     num_deepLTS_to_supaxax     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supLTS      ,             
     &     map_deepLTS_to_supLTS      ,   
     &     num_deepLTS_to_supLTS      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_supLTS      ,             
     &     map_deepLTS_to_supLTS      ,   
     &     num_deepLTS_to_supLTS      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_spinstell   ,             
     &     map_deepLTS_to_spinstell   ,   
     &     num_deepLTS_to_spinstell   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_spinstell   ,             
     &     map_deepLTS_to_spinstell   ,   
     &     num_deepLTS_to_spinstell   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_tuftIB      ,             
     &     map_deepLTS_to_tuftIB      ,   
     &     num_deepLTS_to_tuftIB      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_tuftIB      ,             
     &     map_deepLTS_to_tuftIB      ,   
     &     num_deepLTS_to_tuftIB      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_tuftRS      ,             
     &     map_deepLTS_to_tuftRS      ,   
     &     num_deepLTS_to_tuftRS      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_tuftRS      ,             
     &     map_deepLTS_to_tuftRS      ,   
     &     num_deepLTS_to_tuftRS      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepbask    ,             
     &     map_deepLTS_to_deepbask    ,   
     &     num_deepLTS_to_deepbask    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepbask    ,             
     &     map_deepLTS_to_deepbask    ,   
     &     num_deepLTS_to_deepbask    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepaxax    ,             
     &     map_deepLTS_to_deepaxax    ,   
     &     num_deepLTS_to_deepaxax    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepaxax    ,             
     &     map_deepLTS_to_deepaxax    ,   
     &     num_deepLTS_to_deepaxax    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepLTS     ,             
     &     map_deepLTS_to_deepLTS     ,   
     &     num_deepLTS_to_deepLTS     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_deepLTS     ,             
     &     map_deepLTS_to_deepLTS     ,   
     &     num_deepLTS_to_deepLTS     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_deepLTS_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_nontuftRS   ,             
     &     map_deepLTS_to_nontuftRS   ,   
     &     num_deepLTS_to_nontuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_deepLTS ,  num_nontuftRS   ,             
     &     map_deepLTS_to_nontuftRS   ,   
     &     num_deepLTS_to_nontuftRS   ,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_suppyrRS    ,             
     &     map_TCR_to_suppyrRS    ,   
     &     num_TCR_to_suppyrRS    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_suppyrRS    ,             
     &     map_TCR_to_suppyrRS    ,   
     &     num_TCR_to_suppyrRS    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_suppyrFRB   ,             
     &     map_TCR_to_suppyrFRB   ,   
     &     num_TCR_to_suppyrFRB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_suppyrFRB   ,             
     &     map_TCR_to_suppyrFRB   ,   
     &     num_TCR_to_suppyrFRB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_supbask     ,             
     &     map_TCR_to_supbask     ,   
     &     num_TCR_to_supbask     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_supbask     ,             
     &     map_TCR_to_supbask     ,   
     &     num_TCR_to_supbask     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_supaxax     ,             
     &     map_TCR_to_supaxax     ,   
     &     num_TCR_to_supaxax     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_supaxax     ,             
     &     map_TCR_to_supaxax     ,   
     &     num_TCR_to_supaxax     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_spinstell   ,             
     &     map_TCR_to_spinstell   ,   
     &     num_TCR_to_spinstell   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_spinstell   ,             
     &     map_TCR_to_spinstell   ,   
     &     num_TCR_to_spinstell   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_tuftIB      ,             
     &     map_TCR_to_tuftIB      ,   
     &     num_TCR_to_tuftIB      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_tuftIB      ,             
     &     map_TCR_to_tuftIB      ,   
     &     num_TCR_to_tuftIB      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_tuftRS      ,             
     &     map_TCR_to_tuftRS      ,   
     &     num_TCR_to_tuftRS      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_tuftRS      ,             
     &     map_TCR_to_tuftRS      ,   
     &     num_TCR_to_tuftRS      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_deepbask    ,             
     &     map_TCR_to_deepbask    ,   
     &     num_TCR_to_deepbask    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_deepbask    ,             
     &     map_TCR_to_deepbask    ,   
     &     num_TCR_to_deepbask    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_deepaxax    ,             
     &     map_TCR_to_deepaxax    ,   
     &     num_TCR_to_deepaxax    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_deepaxax    ,             
     &     map_TCR_to_deepaxax    ,   
     &     num_TCR_to_deepaxax    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_nRT.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_nRT         ,             
     &     map_TCR_to_nRT         ,   
     &     num_TCR_to_nRT         ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_nRT         ,             
     &     map_TCR_to_nRT         ,   
     &     num_TCR_to_nRT         ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_TCR_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_TCR ,  num_nontuftRS   ,             
     &     map_TCR_to_nontuftRS   ,   
     &     num_TCR_to_nontuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_TCR ,  num_nontuftRS   ,             
     &     map_TCR_to_nontuftRS   ,   
     &     num_TCR_to_nontuftRS   ,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_nRT_to_TCR.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nRT ,  num_TCR         ,             
     &     map_nRT_to_TCR         ,   
     &     num_nRT_to_TCR         ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nRT ,  num_TCR         ,             
     &     map_nRT_to_TCR         ,   
     &     num_nRT_to_TCR         ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nRT_to_nRT.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nRT ,  num_nRT         ,             
     &     map_nRT_to_nRT         ,   
     &     num_nRT_to_nRT         ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nRT ,  num_nRT         ,             
     &     map_nRT_to_nRT         ,   
     &     num_nRT_to_nRT         ,  display)


        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_suppyrRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_suppyrRS    ,             
     &     map_nontuftRS_to_suppyrRS    ,   
     &     num_nontuftRS_to_suppyrRS    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_suppyrRS    ,             
     &     map_nontuftRS_to_suppyrRS    ,   
     &     num_nontuftRS_to_suppyrRS    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_suppyrFRB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_suppyrFRB   ,             
     &     map_nontuftRS_to_suppyrFRB   ,   
     &     num_nontuftRS_to_suppyrFRB   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_suppyrFRB   ,             
     &     map_nontuftRS_to_suppyrFRB   ,   
     &     num_nontuftRS_to_suppyrFRB   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_supbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supbask     ,             
     &     map_nontuftRS_to_supbask     ,   
     &     num_nontuftRS_to_supbask     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supbask     ,             
     &     map_nontuftRS_to_supbask     ,   
     &     num_nontuftRS_to_supbask     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_supaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supaxax     ,             
     &     map_nontuftRS_to_supaxax     ,   
     &     num_nontuftRS_to_supaxax     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supaxax     ,             
     &     map_nontuftRS_to_supaxax     ,   
     &     num_nontuftRS_to_supaxax     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_supLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supLTS      ,             
     &     map_nontuftRS_to_supLTS      ,   
     &     num_nontuftRS_to_supLTS      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_supLTS      ,             
     &     map_nontuftRS_to_supLTS      ,   
     &     num_nontuftRS_to_supLTS      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_spinstell.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_spinstell   ,             
     &     map_nontuftRS_to_spinstell   ,   
     &     num_nontuftRS_to_spinstell   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_spinstell   ,             
     &     map_nontuftRS_to_spinstell   ,   
     &     num_nontuftRS_to_spinstell   ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_tuftIB.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_tuftIB      ,             
     &     map_nontuftRS_to_tuftIB      ,   
     &     num_nontuftRS_to_tuftIB      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_tuftIB      ,             
     &     map_nontuftRS_to_tuftIB      ,   
     &     num_nontuftRS_to_tuftIB      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_tuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_tuftRS      ,             
     &     map_nontuftRS_to_tuftRS      ,   
     &     num_nontuftRS_to_tuftRS      ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_tuftRS      ,             
     &     map_nontuftRS_to_tuftRS      ,   
     &     num_nontuftRS_to_tuftRS      ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_deepbask.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepbask    ,             
     &     map_nontuftRS_to_deepbask    ,   
     &     num_nontuftRS_to_deepbask    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepbask    ,             
     &     map_nontuftRS_to_deepbask    ,   
     &     num_nontuftRS_to_deepbask    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_deepaxax.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepaxax    ,             
     &     map_nontuftRS_to_deepaxax    ,   
     &     num_nontuftRS_to_deepaxax    ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepaxax    ,             
     &     map_nontuftRS_to_deepaxax    ,   
     &     num_nontuftRS_to_deepaxax    ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_deepLTS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepLTS     ,             
     &     map_nontuftRS_to_deepLTS     ,   
     &     num_nontuftRS_to_deepLTS     ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_deepLTS     ,             
     &     map_nontuftRS_to_deepLTS     ,   
     &     num_nontuftRS_to_deepLTS     ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_TCR.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_TCR         ,             
     &     map_nontuftRS_to_TCR         ,   
     &     num_nontuftRS_to_TCR         ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_TCR         ,             
     &     map_nontuftRS_to_TCR         ,   
     &     num_nontuftRS_to_TCR         ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_nRT.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_nRT         ,             
     &     map_nontuftRS_to_nRT         ,   
     &     num_nontuftRS_to_nRT         ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_nRT         ,             
     &     map_nontuftRS_to_nRT         ,   
     &     num_nontuftRS_to_nRT         ,  display)

        if (thisno.eq.0) then
           open(40,FILE='map/map_nontuftRS_to_nontuftRS.dat')
        end if
          CALL synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_nontuftRS   ,             
     &     map_nontuftRS_to_nontuftRS   ,   
     &     num_nontuftRS_to_nontuftRS   ,  display)
          CALL write_synaptic_map_construct (thisno,
     &     num_nontuftRS ,  num_nontuftRS   ,             
     &     map_nontuftRS_to_nontuftRS   ,   
     &     num_nontuftRS_to_nontuftRS   ,  display)
c Finish construction of synaptic connection tables.

c Construct synaptic compartment maps.  
                display = 0
          if (thisno.eq.0) then
            open(40,FILE='compmap/com_suppyrRS_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS, com_suppyrRS_to_suppyrRS,           
     &     num_suppyrRS_to_suppyrRS,
     &  ncompallow_suppyrRS_to_suppyrRS,
     &   compallow_suppyrRS_to_suppyrRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS, com_suppyrRS_to_suppyrRS,           
     &     num_suppyrRS_to_suppyrRS,
     &  ncompallow_suppyrRS_to_suppyrRS,
     &   compallow_suppyrRS_to_suppyrRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_suppyrRS_to_suppyrFRB,          
     &     num_suppyrRS_to_suppyrFRB,
     &    ncompallow_suppyrRS_to_suppyrFRB,
     &     compallow_suppyrRS_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_suppyrRS_to_suppyrFRB,          
     &     num_suppyrRS_to_suppyrFRB,
     &    ncompallow_suppyrRS_to_suppyrFRB,
     &     compallow_suppyrRS_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_suppyrRS_to_supbask,            
     &     num_suppyrRS_to_supbask,
     &    ncompallow_suppyrRS_to_supbask,  
     &     compallow_suppyrRS_to_supbask,   display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_suppyrRS_to_supbask,            
     &     num_suppyrRS_to_supbask,
     &    ncompallow_suppyrRS_to_supbask,  
     &     compallow_suppyrRS_to_supbask,   display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_suppyrRS_to_supaxax,            
     &     num_suppyrRS_to_supaxax,  
     &    ncompallow_suppyrRS_to_supaxax,  
     &     compallow_suppyrRS_to_supaxax,   display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_suppyrRS_to_supaxax,            
     &     num_suppyrRS_to_supaxax,  
     &    ncompallow_suppyrRS_to_supaxax,  
     &     compallow_suppyrRS_to_supaxax,   display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_suppyrRS_to_supLTS,             
     &     num_suppyrRS_to_supLTS,   
     &    ncompallow_suppyrRS_to_supLTS,   
     &     compallow_suppyrRS_to_supLTS,    display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_suppyrRS_to_supLTS,             
     &     num_suppyrRS_to_supLTS,   
     &    ncompallow_suppyrRS_to_supLTS,   
     &     compallow_suppyrRS_to_supLTS,    display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_suppyrRS_to_spinstell,          
     &     num_suppyrRS_to_spinstell,
     &    ncompallow_suppyrRS_to_spinstell,
     &     compallow_suppyrRS_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_suppyrRS_to_spinstell,          
     &     num_suppyrRS_to_spinstell,
     &    ncompallow_suppyrRS_to_spinstell,
     &     compallow_suppyrRS_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_suppyrRS_to_tuftIB   ,          
     &     num_suppyrRS_to_tuftIB   ,
     &    ncompallow_suppyrRS_to_tuftIB   ,
     &     compallow_suppyrRS_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_suppyrRS_to_tuftIB   ,          
     &     num_suppyrRS_to_tuftIB   ,
     &    ncompallow_suppyrRS_to_tuftIB   ,
     &     compallow_suppyrRS_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_suppyrRS_to_tuftRS   ,          
     &     num_suppyrRS_to_tuftRS   ,
     &    ncompallow_suppyrRS_to_tuftRS   ,
     &     compallow_suppyrRS_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_suppyrRS_to_tuftRS   ,          
     &     num_suppyrRS_to_tuftRS   ,
     &    ncompallow_suppyrRS_to_tuftRS   ,
     &     compallow_suppyrRS_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_suppyrRS_to_deepbask ,          
     &     num_suppyrRS_to_deepbask ,
     &    ncompallow_suppyrRS_to_deepbask ,
     &     compallow_suppyrRS_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_suppyrRS_to_deepbask ,          
     &     num_suppyrRS_to_deepbask ,
     &    ncompallow_suppyrRS_to_deepbask ,
     &     compallow_suppyrRS_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_suppyrRS_to_deepaxax ,          
     &     num_suppyrRS_to_deepaxax ,
     &    ncompallow_suppyrRS_to_deepaxax ,
     &     compallow_suppyrRS_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_suppyrRS_to_deepaxax ,          
     &     num_suppyrRS_to_deepaxax ,
     &    ncompallow_suppyrRS_to_deepaxax ,
     &     compallow_suppyrRS_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_suppyrRS_to_deepLTS  ,          
     &     num_suppyrRS_to_deepLTS  ,
     &    ncompallow_suppyrRS_to_deepLTS  ,
     &     compallow_suppyrRS_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_suppyrRS_to_deepLTS  ,          
     &     num_suppyrRS_to_deepLTS  ,
     &    ncompallow_suppyrRS_to_deepLTS  ,
     &     compallow_suppyrRS_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrRS_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_suppyrRS_to_nontuftRS,          
     &     num_suppyrRS_to_nontuftRS,
     &    ncompallow_suppyrRS_to_nontuftRS,
     &     compallow_suppyrRS_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_suppyrRS_to_nontuftRS,          
     &     num_suppyrRS_to_nontuftRS,
     &    ncompallow_suppyrRS_to_nontuftRS,
     &     compallow_suppyrRS_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_suppyrFRB_to_suppyrRS ,          
     &     num_suppyrFRB_to_suppyrRS ,
     &    ncompallow_suppyrFRB_to_suppyrRS ,
     &     compallow_suppyrFRB_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_suppyrFRB_to_suppyrRS ,          
     &     num_suppyrFRB_to_suppyrRS ,
     &    ncompallow_suppyrFRB_to_suppyrRS ,
     &     compallow_suppyrFRB_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_suppyrFRB_to_suppyrFRB,          
     &     num_suppyrFRB_to_suppyrFRB,
     &    ncompallow_suppyrFRB_to_suppyrFRB,
     &     compallow_suppyrFRB_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_suppyrFRB_to_suppyrFRB,          
     &     num_suppyrFRB_to_suppyrFRB,
     &    ncompallow_suppyrFRB_to_suppyrFRB,
     &     compallow_suppyrFRB_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_suppyrFRB_to_supbask  ,          
     &     num_suppyrFRB_to_supbask  ,
     &    ncompallow_suppyrFRB_to_supbask  ,
     &     compallow_suppyrFRB_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_suppyrFRB_to_supbask  ,          
     &     num_suppyrFRB_to_supbask  ,
     &    ncompallow_suppyrFRB_to_supbask  ,
     &     compallow_suppyrFRB_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_suppyrFRB_to_supaxax  ,          
     &     num_suppyrFRB_to_supaxax  ,
     &    ncompallow_suppyrFRB_to_supaxax  ,
     &     compallow_suppyrFRB_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_suppyrFRB_to_supaxax  ,          
     &     num_suppyrFRB_to_supaxax  ,
     &    ncompallow_suppyrFRB_to_supaxax  ,
     &     compallow_suppyrFRB_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_suppyrFRB_to_supLTS   ,          
     &     num_suppyrFRB_to_supLTS   ,
     &    ncompallow_suppyrFRB_to_supLTS   ,
     &     compallow_suppyrFRB_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_suppyrFRB_to_supLTS   ,          
     &     num_suppyrFRB_to_supLTS   ,
     &    ncompallow_suppyrFRB_to_supLTS   ,
     &     compallow_suppyrFRB_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_suppyrFRB_to_spinstell,          
     &     num_suppyrFRB_to_spinstell,
     &    ncompallow_suppyrFRB_to_spinstell,
     &     compallow_suppyrFRB_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_suppyrFRB_to_spinstell,          
     &     num_suppyrFRB_to_spinstell,
     &    ncompallow_suppyrFRB_to_spinstell,
     &     compallow_suppyrFRB_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_suppyrFRB_to_tuftIB   ,          
     &     num_suppyrFRB_to_tuftIB   ,
     &    ncompallow_suppyrFRB_to_tuftIB   ,
     &     compallow_suppyrFRB_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_suppyrFRB_to_tuftIB   ,          
     &     num_suppyrFRB_to_tuftIB   ,
     &    ncompallow_suppyrFRB_to_tuftIB   ,
     &     compallow_suppyrFRB_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_suppyrFRB_to_tuftRS   ,          
     &     num_suppyrFRB_to_tuftRS   ,
     &    ncompallow_suppyrFRB_to_tuftRS   ,
     &     compallow_suppyrFRB_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_suppyrFRB_to_tuftRS   ,          
     &     num_suppyrFRB_to_tuftRS   ,
     &    ncompallow_suppyrFRB_to_tuftRS   ,
     &     compallow_suppyrFRB_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_suppyrFRB_to_deepbask ,          
     &     num_suppyrFRB_to_deepbask ,
     &    ncompallow_suppyrFRB_to_deepbask ,
     &     compallow_suppyrFRB_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_suppyrFRB_to_deepbask ,          
     &     num_suppyrFRB_to_deepbask ,
     &    ncompallow_suppyrFRB_to_deepbask ,
     &     compallow_suppyrFRB_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_suppyrFRB_to_deepaxax ,          
     &     num_suppyrFRB_to_deepaxax ,
     &    ncompallow_suppyrFRB_to_deepaxax ,
     &     compallow_suppyrFRB_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_suppyrFRB_to_deepaxax ,          
     &     num_suppyrFRB_to_deepaxax ,
     &    ncompallow_suppyrFRB_to_deepaxax ,
     &     compallow_suppyrFRB_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_suppyrFRB_to_deepLTS  ,          
     &     num_suppyrFRB_to_deepLTS  ,
     &    ncompallow_suppyrFRB_to_deepLTS  ,
     &     compallow_suppyrFRB_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_suppyrFRB_to_deepLTS  ,          
     &     num_suppyrFRB_to_deepLTS  ,
     &    ncompallow_suppyrFRB_to_deepLTS  ,
     &     compallow_suppyrFRB_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_suppyrFRB_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_suppyrFRB_to_nontuftRS,          
     &     num_suppyrFRB_to_nontuftRS,
     &    ncompallow_suppyrFRB_to_nontuftRS,
     &     compallow_suppyrFRB_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_suppyrFRB_to_nontuftRS,          
     &     num_suppyrFRB_to_nontuftRS,
     &    ncompallow_suppyrFRB_to_nontuftRS,
     &     compallow_suppyrFRB_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_supbask_to_suppyrRS ,          
     &     num_supbask_to_suppyrRS ,
     &    ncompallow_supbask_to_suppyrRS ,
     &     compallow_supbask_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_supbask_to_suppyrRS ,          
     &     num_supbask_to_suppyrRS ,
     &    ncompallow_supbask_to_suppyrRS ,
     &     compallow_supbask_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_supbask_to_suppyrFRB,          
     &     num_supbask_to_suppyrFRB,
     &    ncompallow_supbask_to_suppyrFRB,
     &     compallow_supbask_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_supbask_to_suppyrFRB,          
     &     num_supbask_to_suppyrFRB,
     &    ncompallow_supbask_to_suppyrFRB,
     &     compallow_supbask_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_supbask_to_supbask  ,          
     &     num_supbask_to_supbask  ,
     &    ncompallow_supbask_to_supbask  ,
     &     compallow_supbask_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_supbask_to_supbask  ,          
     &     num_supbask_to_supbask  ,
     &    ncompallow_supbask_to_supbask  ,
     &     compallow_supbask_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_supbask_to_supaxax  ,          
     &     num_supbask_to_supaxax  ,
     &    ncompallow_supbask_to_supaxax  ,
     &     compallow_supbask_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_supbask_to_supaxax  ,          
     &     num_supbask_to_supaxax  ,
     &    ncompallow_supbask_to_supaxax  ,
     &     compallow_supbask_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_supbask_to_supLTS   ,          
     &     num_supbask_to_supLTS   ,
     &    ncompallow_supbask_to_supLTS   ,
     &     compallow_supbask_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_supbask_to_supLTS   ,          
     &     num_supbask_to_supLTS   ,
     &    ncompallow_supbask_to_supLTS   ,
     &     compallow_supbask_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supbask_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_supbask_to_spinstell,          
     &     num_supbask_to_spinstell,
     &    ncompallow_supbask_to_spinstell,
     &     compallow_supbask_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_supbask_to_spinstell,          
     &     num_supbask_to_spinstell,
     &    ncompallow_supbask_to_spinstell,
     &     compallow_supbask_to_spinstell, display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_suppyrRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_suppyrRS , com_supaxax_to_suppyrRS ,          
c    &     num_supaxax_to_suppyrRS ,
c    &    ncompallow_supaxax_to_suppyrRS ,
c    &     compallow_supaxax_to_suppyrRS , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_suppyrRS , com_supaxax_to_suppyrRS ,          
c    &     num_supaxax_to_suppyrRS ,
c    &    ncompallow_supaxax_to_suppyrRS ,
c    &     compallow_supaxax_to_suppyrRS , display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_suppyrFRB.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_suppyrFRB, com_supaxax_to_suppyrFRB,          
c    &     num_supaxax_to_suppyrFRB,
c    &    ncompallow_supaxax_to_suppyrFRB,
c    &     compallow_supaxax_to_suppyrFRB, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_suppyrFRB, com_supaxax_to_suppyrFRB,          
c    &     num_supaxax_to_suppyrFRB,
c    &    ncompallow_supaxax_to_suppyrFRB,
c    &     compallow_supaxax_to_suppyrFRB, display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_spinstell.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_spinstell, com_supaxax_to_spinstell,          
c    &     num_supaxax_to_spinstell,
c    &    ncompallow_supaxax_to_spinstell,
c    &     compallow_supaxax_to_spinstell, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_spinstell, com_supaxax_to_spinstell,          
c    &     num_supaxax_to_spinstell,
c    &    ncompallow_supaxax_to_spinstell,
c    &     compallow_supaxax_to_spinstell, display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_tuftIB.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_tuftIB   , com_supaxax_to_tuftIB   ,          
c    &     num_supaxax_to_tuftIB   ,
c    &    ncompallow_supaxax_to_tuftIB   ,
c    &     compallow_supaxax_to_tuftIB   , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_tuftIB   , com_supaxax_to_tuftIB   ,          
c    &     num_supaxax_to_tuftIB   ,
c    &    ncompallow_supaxax_to_tuftIB   ,
c    &     compallow_supaxax_to_tuftIB   , display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_tuftRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_tuftRS   , com_supaxax_to_tuftRS   ,          
c    &     num_supaxax_to_tuftRS   ,
c    &    ncompallow_supaxax_to_tuftRS   ,
c    &     compallow_supaxax_to_tuftRS   , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_tuftRS   , com_supaxax_to_tuftRS   ,          
c    &     num_supaxax_to_tuftRS   ,
c    &    ncompallow_supaxax_to_tuftRS   ,
c    &     compallow_supaxax_to_tuftRS   , display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_supaxax_to_nontuftRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_nontuftRS, com_supaxax_to_nontuftRS,          
c    &     num_supaxax_to_nontuftRS,
c    &    ncompallow_supaxax_to_nontuftRS,
c    &     compallow_supaxax_to_nontuftRS, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_nontuftRS, com_supaxax_to_nontuftRS,          
c    &     num_supaxax_to_nontuftRS,
c    &    ncompallow_supaxax_to_nontuftRS,
c    &     compallow_supaxax_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_supLTS_to_suppyrRS ,          
     &     num_supLTS_to_suppyrRS ,
     &    ncompallow_supLTS_to_suppyrRS ,
     &     compallow_supLTS_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_supLTS_to_suppyrRS ,          
     &     num_supLTS_to_suppyrRS ,
     &    ncompallow_supLTS_to_suppyrRS ,
     &     compallow_supLTS_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_supLTS_to_suppyrFRB,          
     &     num_supLTS_to_suppyrFRB,
     &    ncompallow_supLTS_to_suppyrFRB,
     &     compallow_supLTS_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_supLTS_to_suppyrFRB,          
     &     num_supLTS_to_suppyrFRB,
     &    ncompallow_supLTS_to_suppyrFRB,
     &     compallow_supLTS_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_supLTS_to_supbask  ,          
     &     num_supLTS_to_supbask  ,
     &    ncompallow_supLTS_to_supbask  ,
     &     compallow_supLTS_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_supLTS_to_supbask  ,          
     &     num_supLTS_to_supbask  ,
     &    ncompallow_supLTS_to_supbask  ,
     &     compallow_supLTS_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_supLTS_to_supaxax  ,          
     &     num_supLTS_to_supaxax  ,
     &    ncompallow_supLTS_to_supaxax  ,
     &     compallow_supLTS_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_supLTS_to_supaxax  ,          
     &     num_supLTS_to_supaxax  ,
     &    ncompallow_supLTS_to_supaxax  ,
     &     compallow_supLTS_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_supLTS_to_supLTS   ,          
     &     num_supLTS_to_supLTS   ,
     &    ncompallow_supLTS_to_supLTS   ,
     &     compallow_supLTS_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_supLTS_to_supLTS   ,          
     &     num_supLTS_to_supLTS   ,
     &    ncompallow_supLTS_to_supLTS   ,
     &     compallow_supLTS_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_supLTS_to_spinstell,          
     &     num_supLTS_to_spinstell,
     &    ncompallow_supLTS_to_spinstell,
     &     compallow_supLTS_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_supLTS_to_spinstell,          
     &     num_supLTS_to_spinstell,
     &    ncompallow_supLTS_to_spinstell,
     &     compallow_supLTS_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_supLTS_to_tuftIB   ,          
     &     num_supLTS_to_tuftIB   ,
     &    ncompallow_supLTS_to_tuftIB   ,
     &     compallow_supLTS_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_supLTS_to_tuftIB   ,          
     &     num_supLTS_to_tuftIB   ,
     &    ncompallow_supLTS_to_tuftIB   ,
     &     compallow_supLTS_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_supLTS_to_tuftRS   ,          
     &     num_supLTS_to_tuftRS   ,
     &    ncompallow_supLTS_to_tuftRS   ,
     &     compallow_supLTS_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_supLTS_to_tuftRS   ,          
     &     num_supLTS_to_tuftRS   ,
     &    ncompallow_supLTS_to_tuftRS   ,
     &     compallow_supLTS_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_supLTS_to_deepbask ,          
     &     num_supLTS_to_deepbask ,
     &    ncompallow_supLTS_to_deepbask ,
     &     compallow_supLTS_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_supLTS_to_deepbask ,          
     &     num_supLTS_to_deepbask ,
     &    ncompallow_supLTS_to_deepbask ,
     &     compallow_supLTS_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_supLTS_to_deepaxax ,          
     &     num_supLTS_to_deepaxax ,
     &    ncompallow_supLTS_to_deepaxax ,
     &     compallow_supLTS_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_supLTS_to_deepaxax ,          
     &     num_supLTS_to_deepaxax ,
     &    ncompallow_supLTS_to_deepaxax ,
     &     compallow_supLTS_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_supLTS_to_deepLTS  ,          
     &     num_supLTS_to_deepLTS  ,
     &    ncompallow_supLTS_to_deepLTS  ,
     &     compallow_supLTS_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_supLTS_to_deepLTS  ,          
     &     num_supLTS_to_deepLTS  ,
     &    ncompallow_supLTS_to_deepLTS  ,
     &     compallow_supLTS_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_supLTS_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_supLTS_to_nontuftRS,          
     &     num_supLTS_to_nontuftRS,
     &    ncompallow_supLTS_to_nontuftRS,
     &     compallow_supLTS_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_supLTS_to_nontuftRS,          
     &     num_supLTS_to_nontuftRS,
     &    ncompallow_supLTS_to_nontuftRS,
     &     compallow_supLTS_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_spinstell_to_suppyrRS ,          
     &     num_spinstell_to_suppyrRS ,
     &    ncompallow_spinstell_to_suppyrRS ,
     &     compallow_spinstell_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_spinstell_to_suppyrRS ,          
     &     num_spinstell_to_suppyrRS ,
     &    ncompallow_spinstell_to_suppyrRS ,
     &     compallow_spinstell_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_spinstell_to_suppyrFRB,          
     &     num_spinstell_to_suppyrFRB,
     &    ncompallow_spinstell_to_suppyrFRB,
     &     compallow_spinstell_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_spinstell_to_suppyrFRB,          
     &     num_spinstell_to_suppyrFRB,
     &    ncompallow_spinstell_to_suppyrFRB,
     &     compallow_spinstell_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_spinstell_to_supbask  ,          
     &     num_spinstell_to_supbask  ,
     &    ncompallow_spinstell_to_supbask  ,
     &     compallow_spinstell_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_spinstell_to_supbask  ,          
     &     num_spinstell_to_supbask  ,
     &    ncompallow_spinstell_to_supbask  ,
     &     compallow_spinstell_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_spinstell_to_supaxax  ,          
     &     num_spinstell_to_supaxax  ,
     &    ncompallow_spinstell_to_supaxax  ,
     &     compallow_spinstell_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_spinstell_to_supaxax  ,          
     &     num_spinstell_to_supaxax  ,
     &    ncompallow_spinstell_to_supaxax  ,
     &     compallow_spinstell_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_spinstell_to_supLTS   ,          
     &     num_spinstell_to_supLTS   ,
     &    ncompallow_spinstell_to_supLTS   ,
     &     compallow_spinstell_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_spinstell_to_supLTS   ,          
     &     num_spinstell_to_supLTS   ,
     &    ncompallow_spinstell_to_supLTS   ,
     &     compallow_spinstell_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_spinstell_to_spinstell,          
     &     num_spinstell_to_spinstell,
     &    ncompallow_spinstell_to_spinstell,
     &     compallow_spinstell_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_spinstell_to_spinstell,          
     &     num_spinstell_to_spinstell,
     &    ncompallow_spinstell_to_spinstell,
     &     compallow_spinstell_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_spinstell_to_tuftIB   ,          
     &     num_spinstell_to_tuftIB   ,
     &    ncompallow_spinstell_to_tuftIB   ,
     &     compallow_spinstell_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_spinstell_to_tuftIB   ,          
     &     num_spinstell_to_tuftIB   ,
     &    ncompallow_spinstell_to_tuftIB   ,
     &     compallow_spinstell_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_spinstell_to_tuftRS   ,          
     &     num_spinstell_to_tuftRS   ,
     &    ncompallow_spinstell_to_tuftRS   ,
     &     compallow_spinstell_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_spinstell_to_tuftRS   ,          
     &     num_spinstell_to_tuftRS   ,
     &    ncompallow_spinstell_to_tuftRS   ,
     &     compallow_spinstell_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_spinstell_to_deepbask ,          
     &     num_spinstell_to_deepbask ,
     &    ncompallow_spinstell_to_deepbask ,
     &     compallow_spinstell_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_spinstell_to_deepbask ,          
     &     num_spinstell_to_deepbask ,
     &    ncompallow_spinstell_to_deepbask ,
     &     compallow_spinstell_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_spinstell_to_deepaxax ,          
     &     num_spinstell_to_deepaxax ,
     &    ncompallow_spinstell_to_deepaxax ,
     &     compallow_spinstell_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_spinstell_to_deepaxax ,          
     &     num_spinstell_to_deepaxax ,
     &    ncompallow_spinstell_to_deepaxax ,
     &     compallow_spinstell_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_spinstell_to_deepLTS  ,          
     &     num_spinstell_to_deepLTS  ,
     &    ncompallow_spinstell_to_deepLTS  ,
     &     compallow_spinstell_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_spinstell_to_deepLTS  ,          
     &     num_spinstell_to_deepLTS  ,
     &    ncompallow_spinstell_to_deepLTS  ,
     &     compallow_spinstell_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_spinstell_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_spinstell_to_nontuftRS,          
     &     num_spinstell_to_nontuftRS,
     &    ncompallow_spinstell_to_nontuftRS,
     &     compallow_spinstell_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_spinstell_to_nontuftRS,          
     &     num_spinstell_to_nontuftRS,
     &    ncompallow_spinstell_to_nontuftRS,
     &     compallow_spinstell_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_tuftIB_to_suppyrRS ,          
     &     num_tuftIB_to_suppyrRS ,
     &    ncompallow_tuftIB_to_suppyrRS ,
     &     compallow_tuftIB_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_tuftIB_to_suppyrRS ,          
     &     num_tuftIB_to_suppyrRS ,
     &    ncompallow_tuftIB_to_suppyrRS ,
     &     compallow_tuftIB_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_tuftIB_to_suppyrFRB,          
     &     num_tuftIB_to_suppyrFRB,
     &    ncompallow_tuftIB_to_suppyrFRB,
     &     compallow_tuftIB_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_tuftIB_to_suppyrFRB,          
     &     num_tuftIB_to_suppyrFRB,
     &    ncompallow_tuftIB_to_suppyrFRB,
     &     compallow_tuftIB_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_tuftIB_to_supbask  ,          
     &     num_tuftIB_to_supbask  ,
     &    ncompallow_tuftIB_to_supbask  ,
     &     compallow_tuftIB_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_tuftIB_to_supbask  ,          
     &     num_tuftIB_to_supbask  ,
     &    ncompallow_tuftIB_to_supbask  ,
     &     compallow_tuftIB_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_tuftIB_to_supaxax  ,          
     &     num_tuftIB_to_supaxax  ,
     &    ncompallow_tuftIB_to_supaxax  ,
     &     compallow_tuftIB_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_tuftIB_to_supaxax  ,          
     &     num_tuftIB_to_supaxax  ,
     &    ncompallow_tuftIB_to_supaxax  ,
     &     compallow_tuftIB_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_tuftIB_to_supLTS   ,          
     &     num_tuftIB_to_supLTS   ,
     &    ncompallow_tuftIB_to_supLTS   ,
     &     compallow_tuftIB_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_tuftIB_to_supLTS   ,          
     &     num_tuftIB_to_supLTS   ,
     &    ncompallow_tuftIB_to_supLTS   ,
     &     compallow_tuftIB_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_tuftIB_to_spinstell,          
     &     num_tuftIB_to_spinstell,
     &    ncompallow_tuftIB_to_spinstell,
     &     compallow_tuftIB_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_tuftIB_to_spinstell,          
     &     num_tuftIB_to_spinstell,
     &    ncompallow_tuftIB_to_spinstell,
     &     compallow_tuftIB_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_tuftIB_to_tuftIB   ,          
     &     num_tuftIB_to_tuftIB   ,
     &    ncompallow_tuftIB_to_tuftIB   ,
     &     compallow_tuftIB_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_tuftIB_to_tuftIB   ,          
     &     num_tuftIB_to_tuftIB   ,
     &    ncompallow_tuftIB_to_tuftIB   ,
     &     compallow_tuftIB_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_tuftIB_to_tuftRS   ,          
     &     num_tuftIB_to_tuftRS   ,
     &    ncompallow_tuftIB_to_tuftRS   ,
     &     compallow_tuftIB_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_tuftIB_to_tuftRS   ,          
     &     num_tuftIB_to_tuftRS   ,
     &    ncompallow_tuftIB_to_tuftRS   ,
     &     compallow_tuftIB_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_tuftIB_to_deepbask ,          
     &     num_tuftIB_to_deepbask ,
     &    ncompallow_tuftIB_to_deepbask ,
     &     compallow_tuftIB_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_tuftIB_to_deepbask ,          
     &     num_tuftIB_to_deepbask ,
     &    ncompallow_tuftIB_to_deepbask ,
     &     compallow_tuftIB_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_tuftIB_to_deepaxax ,          
     &     num_tuftIB_to_deepaxax ,
     &    ncompallow_tuftIB_to_deepaxax ,
     &     compallow_tuftIB_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_tuftIB_to_deepaxax ,          
     &     num_tuftIB_to_deepaxax ,
     &    ncompallow_tuftIB_to_deepaxax ,
     &     compallow_tuftIB_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_tuftIB_to_deepLTS  ,          
     &     num_tuftIB_to_deepLTS  ,
     &    ncompallow_tuftIB_to_deepLTS  ,
     &     compallow_tuftIB_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_tuftIB_to_deepLTS  ,          
     &     num_tuftIB_to_deepLTS  ,
     &    ncompallow_tuftIB_to_deepLTS  ,
     &     compallow_tuftIB_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftIB_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_tuftIB_to_nontuftRS,          
     &     num_tuftIB_to_nontuftRS,
     &    ncompallow_tuftIB_to_nontuftRS,
     &     compallow_tuftIB_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_tuftIB_to_nontuftRS,          
     &     num_tuftIB_to_nontuftRS,
     &    ncompallow_tuftIB_to_nontuftRS,
     &     compallow_tuftIB_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_tuftRS_to_suppyrRS ,          
     &     num_tuftRS_to_suppyrRS ,
     &    ncompallow_tuftRS_to_suppyrRS ,
     &     compallow_tuftRS_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_tuftRS_to_suppyrRS ,          
     &     num_tuftRS_to_suppyrRS ,
     &    ncompallow_tuftRS_to_suppyrRS ,
     &     compallow_tuftRS_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_tuftRS_to_suppyrFRB,          
     &     num_tuftRS_to_suppyrFRB,
     &    ncompallow_tuftRS_to_suppyrFRB,
     &     compallow_tuftRS_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_tuftRS_to_suppyrFRB,          
     &     num_tuftRS_to_suppyrFRB,
     &    ncompallow_tuftRS_to_suppyrFRB,
     &     compallow_tuftRS_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_tuftRS_to_supbask  ,          
     &     num_tuftRS_to_supbask  ,
     &    ncompallow_tuftRS_to_supbask  ,
     &     compallow_tuftRS_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_tuftRS_to_supbask  ,          
     &     num_tuftRS_to_supbask  ,
     &    ncompallow_tuftRS_to_supbask  ,
     &     compallow_tuftRS_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_tuftRS_to_supaxax  ,          
     &     num_tuftRS_to_supaxax  ,
     &    ncompallow_tuftRS_to_supaxax  ,
     &     compallow_tuftRS_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_tuftRS_to_supaxax  ,          
     &     num_tuftRS_to_supaxax  ,
     &    ncompallow_tuftRS_to_supaxax  ,
     &     compallow_tuftRS_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_tuftRS_to_supLTS   ,          
     &     num_tuftRS_to_supLTS   ,
     &    ncompallow_tuftRS_to_supLTS   ,
     &     compallow_tuftRS_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_tuftRS_to_supLTS   ,          
     &     num_tuftRS_to_supLTS   ,
     &    ncompallow_tuftRS_to_supLTS   ,
     &     compallow_tuftRS_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_tuftRS_to_spinstell,          
     &     num_tuftRS_to_spinstell,
     &    ncompallow_tuftRS_to_spinstell,
     &     compallow_tuftRS_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_tuftRS_to_spinstell,          
     &     num_tuftRS_to_spinstell,
     &    ncompallow_tuftRS_to_spinstell,
     &     compallow_tuftRS_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_tuftRS_to_tuftIB   ,          
     &     num_tuftRS_to_tuftIB   ,
     &    ncompallow_tuftRS_to_tuftIB   ,
     &     compallow_tuftRS_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_tuftRS_to_tuftIB   ,          
     &     num_tuftRS_to_tuftIB   ,
     &    ncompallow_tuftRS_to_tuftIB   ,
     &     compallow_tuftRS_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_tuftRS_to_tuftRS   ,          
     &     num_tuftRS_to_tuftRS   ,
     &    ncompallow_tuftRS_to_tuftRS   ,
     &     compallow_tuftRS_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_tuftRS_to_tuftRS   ,          
     &     num_tuftRS_to_tuftRS   ,
     &    ncompallow_tuftRS_to_tuftRS   ,
     &     compallow_tuftRS_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_tuftRS_to_deepbask ,          
     &     num_tuftRS_to_deepbask ,
     &    ncompallow_tuftRS_to_deepbask ,
     &     compallow_tuftRS_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_tuftRS_to_deepbask ,          
     &     num_tuftRS_to_deepbask ,
     &    ncompallow_tuftRS_to_deepbask ,
     &     compallow_tuftRS_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_tuftRS_to_deepaxax ,          
     &     num_tuftRS_to_deepaxax ,
     &    ncompallow_tuftRS_to_deepaxax ,
     &     compallow_tuftRS_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_tuftRS_to_deepaxax ,          
     &     num_tuftRS_to_deepaxax ,
     &    ncompallow_tuftRS_to_deepaxax ,
     &     compallow_tuftRS_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_tuftRS_to_deepLTS  ,          
     &     num_tuftRS_to_deepLTS  ,
     &    ncompallow_tuftRS_to_deepLTS  ,
     &     compallow_tuftRS_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_tuftRS_to_deepLTS  ,          
     &     num_tuftRS_to_deepLTS  ,
     &    ncompallow_tuftRS_to_deepLTS  ,
     &     compallow_tuftRS_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_tuftRS_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_tuftRS_to_nontuftRS,          
     &     num_tuftRS_to_nontuftRS,
     &    ncompallow_tuftRS_to_nontuftRS,
     &     compallow_tuftRS_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_tuftRS_to_nontuftRS,          
     &     num_tuftRS_to_nontuftRS,
     &    ncompallow_tuftRS_to_nontuftRS,
     &     compallow_tuftRS_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_deepbask_to_spinstell,          
     &     num_deepbask_to_spinstell,
     &    ncompallow_deepbask_to_spinstell,
     &     compallow_deepbask_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_deepbask_to_spinstell,          
     &     num_deepbask_to_spinstell,
     &    ncompallow_deepbask_to_spinstell,
     &     compallow_deepbask_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_deepbask_to_tuftIB   ,          
     &     num_deepbask_to_tuftIB   ,
     &    ncompallow_deepbask_to_tuftIB   ,
     &     compallow_deepbask_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_deepbask_to_tuftIB   ,          
     &     num_deepbask_to_tuftIB   ,
     &    ncompallow_deepbask_to_tuftIB   ,
     &     compallow_deepbask_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_deepbask_to_tuftRS   ,          
     &     num_deepbask_to_tuftRS   ,
     &    ncompallow_deepbask_to_tuftRS   ,
     &     compallow_deepbask_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_deepbask_to_tuftRS   ,          
     &     num_deepbask_to_tuftRS   ,
     &    ncompallow_deepbask_to_tuftRS   ,
     &     compallow_deepbask_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_deepbask_to_deepbask ,          
     &     num_deepbask_to_deepbask ,
     &    ncompallow_deepbask_to_deepbask ,
     &     compallow_deepbask_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_deepbask_to_deepbask ,          
     &     num_deepbask_to_deepbask ,
     &    ncompallow_deepbask_to_deepbask ,
     &     compallow_deepbask_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_deepbask_to_deepaxax ,          
     &     num_deepbask_to_deepaxax ,
     &    ncompallow_deepbask_to_deepaxax ,
     &     compallow_deepbask_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_deepbask_to_deepaxax ,          
     &     num_deepbask_to_deepaxax ,
     &    ncompallow_deepbask_to_deepaxax ,
     &     compallow_deepbask_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_deepbask_to_deepLTS  ,          
     &     num_deepbask_to_deepLTS  ,
     &    ncompallow_deepbask_to_deepLTS  ,
     &     compallow_deepbask_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_deepbask_to_deepLTS  ,          
     &     num_deepbask_to_deepLTS  ,
     &    ncompallow_deepbask_to_deepLTS  ,
     &     compallow_deepbask_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepbask_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_deepbask_to_nontuftRS,          
     &     num_deepbask_to_nontuftRS,
     &    ncompallow_deepbask_to_nontuftRS,
     &     compallow_deepbask_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_deepbask_to_nontuftRS,          
     &     num_deepbask_to_nontuftRS,
     &    ncompallow_deepbask_to_nontuftRS,
     &     compallow_deepbask_to_nontuftRS, display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_deepaxax_to_suppyrRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_suppyrRS , com_deepaxax_to_suppyrRS ,          
c    &     num_deepaxax_to_suppyrRS ,
c    &    ncompallow_deepaxax_to_suppyrRS ,
c    &     compallow_deepaxax_to_suppyrRS , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_suppyrRS , com_deepaxax_to_suppyrRS ,          
c    &     num_deepaxax_to_suppyrRS ,
c    &    ncompallow_deepaxax_to_suppyrRS ,
c    &     compallow_deepaxax_to_suppyrRS , display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_deepaxax_to_suppyrFRB.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_suppyrFRB, com_deepaxax_to_suppyrFRB,          
c    &     num_deepaxax_to_suppyrFRB,
c    &    ncompallow_deepaxax_to_suppyrFRB,
c    &     compallow_deepaxax_to_suppyrFRB, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_suppyrFRB, com_deepaxax_to_suppyrFRB,          
c    &     num_deepaxax_to_suppyrFRB,
c    &    ncompallow_deepaxax_to_suppyrFRB,
c    &     compallow_deepaxax_to_suppyrFRB, display)

c c         if (thisno.eq.0) then
c             open(40,FILE='compmap/com_deepaxax_to_spinstell.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_spinstell, com_deepaxax_to_spinstell,          
c    &     num_deepaxax_to_spinstell,
c    &    ncompallow_deepaxax_to_spinstell,
c    &     compallow_deepaxax_to_spinstell, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_spinstell, com_deepaxax_to_spinstell,          
c    &     num_deepaxax_to_spinstell,
c    &    ncompallow_deepaxax_to_spinstell,
c    &     compallow_deepaxax_to_spinstell, display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_deepaxax_to_tuftIB.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_tuftIB   , com_deepaxax_to_tuftIB   ,          
c    &     num_deepaxax_to_tuftIB   ,
c    &    ncompallow_deepaxax_to_tuftIB   ,
c    &     compallow_deepaxax_to_tuftIB   , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_tuftIB   , com_deepaxax_to_tuftIB   ,          
c    &     num_deepaxax_to_tuftIB   ,
c    &    ncompallow_deepaxax_to_tuftIB   ,
c    &     compallow_deepaxax_to_tuftIB   , display)

c          if (thisno.eq.0) then
c             open(40,FILE='compmap/com_deepaxax_to_tuftRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_tuftRS   , com_deepaxax_to_tuftRS   ,          
c    &     num_deepaxax_to_tuftRS   ,
c    &    ncompallow_deepaxax_to_tuftRS   ,
c    &     compallow_deepaxax_to_tuftRS   , display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_tuftRS   , com_deepaxax_to_tuftRS   ,          
c    &     num_deepaxax_to_tuftRS   ,
c    &    ncompallow_deepaxax_to_tuftRS   ,
c    &     compallow_deepaxax_to_tuftRS   , display)

c          if (thisno.eq.0) then
cc             open(40,FILE='compmap/com_deepaxax_to_nontuftRS.dat')
c          end if
c         CALL synaptic_compmap_construct (thisno,
c    &     num_nontuftRS, com_deepaxax_to_nontuftRS,          
c    &     num_deepaxax_to_nontuftRS,
c    &    ncompallow_deepaxax_to_nontuftRS,
c    &     compallow_deepaxax_to_nontuftRS, display)
c         CALL write_synaptic_compmap_construct (thisno,
c    &     num_nontuftRS, com_deepaxax_to_nontuftRS,          
c    &     num_deepaxax_to_nontuftRS,
c    &    ncompallow_deepaxax_to_nontuftRS,
c    &     compallow_deepaxax_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_deepLTS_to_suppyrRS ,          
     &     num_deepLTS_to_suppyrRS ,
     &    ncompallow_deepLTS_to_suppyrRS ,
     &     compallow_deepLTS_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_deepLTS_to_suppyrRS ,          
     &     num_deepLTS_to_suppyrRS ,
     &    ncompallow_deepLTS_to_suppyrRS ,
     &     compallow_deepLTS_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_deepLTS_to_suppyrFRB,          
     &     num_deepLTS_to_suppyrFRB,
     &    ncompallow_deepLTS_to_suppyrFRB,
     &     compallow_deepLTS_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_deepLTS_to_suppyrFRB,          
     &     num_deepLTS_to_suppyrFRB,
     &    ncompallow_deepLTS_to_suppyrFRB,
     &     compallow_deepLTS_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_deepLTS_to_supbask  ,          
     &     num_deepLTS_to_supbask  ,
     &    ncompallow_deepLTS_to_supbask  ,
     &     compallow_deepLTS_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_deepLTS_to_supbask  ,          
     &     num_deepLTS_to_supbask  ,
     &    ncompallow_deepLTS_to_supbask  ,
     &     compallow_deepLTS_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_deepLTS_to_supaxax  ,          
     &     num_deepLTS_to_supaxax  ,
     &    ncompallow_deepLTS_to_supaxax  ,
     &     compallow_deepLTS_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_deepLTS_to_supaxax  ,          
     &     num_deepLTS_to_supaxax  ,
     &    ncompallow_deepLTS_to_supaxax  ,
     &     compallow_deepLTS_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_deepLTS_to_supLTS   ,          
     &     num_deepLTS_to_supLTS   ,
     &    ncompallow_deepLTS_to_supLTS   ,
     &     compallow_deepLTS_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_deepLTS_to_supLTS   ,          
     &     num_deepLTS_to_supLTS   ,
     &    ncompallow_deepLTS_to_supLTS   ,
     &     compallow_deepLTS_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_deepLTS_to_spinstell,          
     &     num_deepLTS_to_spinstell,
     &    ncompallow_deepLTS_to_spinstell,
     &     compallow_deepLTS_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_deepLTS_to_spinstell,          
     &     num_deepLTS_to_spinstell,
     &    ncompallow_deepLTS_to_spinstell,
     &     compallow_deepLTS_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_deepLTS_to_tuftIB   ,          
     &     num_deepLTS_to_tuftIB   ,
     &    ncompallow_deepLTS_to_tuftIB   ,
     &     compallow_deepLTS_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_deepLTS_to_tuftIB   ,          
     &     num_deepLTS_to_tuftIB   ,
     &    ncompallow_deepLTS_to_tuftIB   ,
     &     compallow_deepLTS_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_deepLTS_to_tuftRS   ,          
     &     num_deepLTS_to_tuftRS   ,
     &    ncompallow_deepLTS_to_tuftRS   ,
     &     compallow_deepLTS_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_deepLTS_to_tuftRS   ,          
     &     num_deepLTS_to_tuftRS   ,
     &    ncompallow_deepLTS_to_tuftRS   ,
     &     compallow_deepLTS_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_deepLTS_to_deepbask ,          
     &     num_deepLTS_to_deepbask ,
     &    ncompallow_deepLTS_to_deepbask ,
     &     compallow_deepLTS_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_deepLTS_to_deepbask ,          
     &     num_deepLTS_to_deepbask ,
     &    ncompallow_deepLTS_to_deepbask ,
     &     compallow_deepLTS_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_deepLTS_to_deepaxax ,          
     &     num_deepLTS_to_deepaxax ,
     &    ncompallow_deepLTS_to_deepaxax ,
     &     compallow_deepLTS_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_deepLTS_to_deepaxax ,          
     &     num_deepLTS_to_deepaxax ,
     &    ncompallow_deepLTS_to_deepaxax ,
     &     compallow_deepLTS_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_deepLTS_to_deepLTS  ,          
     &     num_deepLTS_to_deepLTS  ,
     &    ncompallow_deepLTS_to_deepLTS  ,
     &     compallow_deepLTS_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_deepLTS_to_deepLTS  ,          
     &     num_deepLTS_to_deepLTS  ,
     &    ncompallow_deepLTS_to_deepLTS  ,
     &     compallow_deepLTS_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_deepLTS_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_deepLTS_to_nontuftRS,          
     &     num_deepLTS_to_nontuftRS,
     &    ncompallow_deepLTS_to_nontuftRS,
     &     compallow_deepLTS_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_deepLTS_to_nontuftRS,          
     &     num_deepLTS_to_nontuftRS,
     &    ncompallow_deepLTS_to_nontuftRS,
     &     compallow_deepLTS_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_TCR_to_suppyrRS ,          
     &     num_TCR_to_suppyrRS ,
     &    ncompallow_TCR_to_suppyrRS ,
     &     compallow_TCR_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_TCR_to_suppyrRS ,          
     &     num_TCR_to_suppyrRS ,
     &    ncompallow_TCR_to_suppyrRS ,
     &     compallow_TCR_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_TCR_to_suppyrFRB,          
     &     num_TCR_to_suppyrFRB,
     &    ncompallow_TCR_to_suppyrFRB,
     &     compallow_TCR_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_TCR_to_suppyrFRB,          
     &     num_TCR_to_suppyrFRB,
     &    ncompallow_TCR_to_suppyrFRB,
     &     compallow_TCR_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_TCR_to_supbask  ,          
     &     num_TCR_to_supbask  ,
     &    ncompallow_TCR_to_supbask  ,
     &     compallow_TCR_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_TCR_to_supbask  ,          
     &     num_TCR_to_supbask  ,
     &    ncompallow_TCR_to_supbask  ,
     &     compallow_TCR_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_TCR_to_supaxax  ,          
     &     num_TCR_to_supaxax  ,
     &    ncompallow_TCR_to_supaxax  ,
     &     compallow_TCR_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_TCR_to_supaxax  ,          
     &     num_TCR_to_supaxax  ,
     &    ncompallow_TCR_to_supaxax  ,
     &     compallow_TCR_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_TCR_to_spinstell,          
     &     num_TCR_to_spinstell,
     &    ncompallow_TCR_to_spinstell,
     &     compallow_TCR_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_TCR_to_spinstell,          
     &     num_TCR_to_spinstell,
     &    ncompallow_TCR_to_spinstell,
     &     compallow_TCR_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_TCR_to_tuftIB   ,          
     &     num_TCR_to_tuftIB   ,
     &    ncompallow_TCR_to_tuftIB   ,
     &     compallow_TCR_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_TCR_to_tuftIB   ,          
     &     num_TCR_to_tuftIB   ,
     &    ncompallow_TCR_to_tuftIB   ,
     &     compallow_TCR_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_TCR_to_tuftRS   ,          
     &     num_TCR_to_tuftRS   ,
     &    ncompallow_TCR_to_tuftRS   ,
     &     compallow_TCR_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_TCR_to_tuftRS   ,          
     &     num_TCR_to_tuftRS   ,
     &    ncompallow_TCR_to_tuftRS   ,
     &     compallow_TCR_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_TCR_to_deepbask ,          
     &     num_TCR_to_deepbask ,
     &    ncompallow_TCR_to_deepbask ,
     &     compallow_TCR_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_TCR_to_deepbask ,          
     &     num_TCR_to_deepbask ,
     &    ncompallow_TCR_to_deepbask ,
     &     compallow_TCR_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_TCR_to_deepaxax ,          
     &     num_TCR_to_deepaxax ,
     &    ncompallow_TCR_to_deepaxax ,
     &     compallow_TCR_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_TCR_to_deepaxax ,          
     &     num_TCR_to_deepaxax ,
     &    ncompallow_TCR_to_deepaxax ,
     &     compallow_TCR_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_nRT.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nRT      , com_TCR_to_nRT      ,          
     &     num_TCR_to_nRT      ,
     &    ncompallow_TCR_to_nRT      ,
     &     compallow_TCR_to_nRT      , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nRT      , com_TCR_to_nRT      ,          
     &     num_TCR_to_nRT      ,
     &    ncompallow_TCR_to_nRT      ,
     &     compallow_TCR_to_nRT      , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_TCR_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_TCR_to_nontuftRS,          
     &     num_TCR_to_nontuftRS,
     &    ncompallow_TCR_to_nontuftRS,
     &     compallow_TCR_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_TCR_to_nontuftRS,          
     &     num_TCR_to_nontuftRS,
     &    ncompallow_TCR_to_nontuftRS,
     &     compallow_TCR_to_nontuftRS, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nRT_to_TCR.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_TCR      , com_nRT_to_TCR      ,          
     &     num_nRT_to_TCR      ,
     &    ncompallow_nRT_to_TCR      ,
     &     compallow_nRT_to_TCR      , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_TCR      , com_nRT_to_TCR      ,          
     &     num_nRT_to_TCR      ,
     &    ncompallow_nRT_to_TCR      ,
     &     compallow_nRT_to_TCR      , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nRT_to_nRT.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nRT      , com_nRT_to_nRT      ,          
     &     num_nRT_to_nRT      ,
     &    ncompallow_nRT_to_nRT      ,
     &     compallow_nRT_to_nRT      , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nRT      , com_nRT_to_nRT      ,          
     &     num_nRT_to_nRT      ,
     &    ncompallow_nRT_to_nRT      ,
     &     compallow_nRT_to_nRT      , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_suppyrRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_nontuftRS_to_suppyrRS ,          
     &     num_nontuftRS_to_suppyrRS ,
     &    ncompallow_nontuftRS_to_suppyrRS ,
     &     compallow_nontuftRS_to_suppyrRS , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrRS , com_nontuftRS_to_suppyrRS ,          
     &     num_nontuftRS_to_suppyrRS ,
     &    ncompallow_nontuftRS_to_suppyrRS ,
     &     compallow_nontuftRS_to_suppyrRS , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_suppyrFRB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_nontuftRS_to_suppyrFRB,          
     &     num_nontuftRS_to_suppyrFRB,
     &    ncompallow_nontuftRS_to_suppyrFRB,
     &     compallow_nontuftRS_to_suppyrFRB, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_suppyrFRB, com_nontuftRS_to_suppyrFRB,          
     &     num_nontuftRS_to_suppyrFRB,
     &    ncompallow_nontuftRS_to_suppyrFRB,
     &     compallow_nontuftRS_to_suppyrFRB, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_supbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supbask  , com_nontuftRS_to_supbask  ,          
     &     num_nontuftRS_to_supbask  ,
     &    ncompallow_nontuftRS_to_supbask  ,
     &     compallow_nontuftRS_to_supbask  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supbask  , com_nontuftRS_to_supbask  ,          
     &     num_nontuftRS_to_supbask  ,
     &    ncompallow_nontuftRS_to_supbask  ,
     &     compallow_nontuftRS_to_supbask  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_supaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_nontuftRS_to_supaxax  ,          
     &     num_nontuftRS_to_supaxax  ,
     &    ncompallow_nontuftRS_to_supaxax  ,
     &     compallow_nontuftRS_to_supaxax  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supaxax  , com_nontuftRS_to_supaxax  ,          
     &     num_nontuftRS_to_supaxax  ,
     &    ncompallow_nontuftRS_to_supaxax  ,
     &     compallow_nontuftRS_to_supaxax  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_supLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_nontuftRS_to_supLTS   ,          
     &     num_nontuftRS_to_supLTS   ,
     &    ncompallow_nontuftRS_to_supLTS   ,
     &     compallow_nontuftRS_to_supLTS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_supLTS   , com_nontuftRS_to_supLTS   ,          
     &     num_nontuftRS_to_supLTS   ,
     &    ncompallow_nontuftRS_to_supLTS   ,
     &     compallow_nontuftRS_to_supLTS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_spinstell.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_spinstell, com_nontuftRS_to_spinstell,          
     &     num_nontuftRS_to_spinstell,
     &    ncompallow_nontuftRS_to_spinstell,
     &     compallow_nontuftRS_to_spinstell, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_spinstell, com_nontuftRS_to_spinstell,          
     &     num_nontuftRS_to_spinstell,
     &    ncompallow_nontuftRS_to_spinstell,
     &     compallow_nontuftRS_to_spinstell, display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_tuftIB.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_nontuftRS_to_tuftIB   ,          
     &     num_nontuftRS_to_tuftIB   ,
     &    ncompallow_nontuftRS_to_tuftIB   ,
     &     compallow_nontuftRS_to_tuftIB   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftIB   , com_nontuftRS_to_tuftIB   ,          
     &     num_nontuftRS_to_tuftIB   ,
     &    ncompallow_nontuftRS_to_tuftIB   ,
     &     compallow_nontuftRS_to_tuftIB   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_tuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_nontuftRS_to_tuftRS   ,          
     &     num_nontuftRS_to_tuftRS   ,
     &    ncompallow_nontuftRS_to_tuftRS   ,
     &     compallow_nontuftRS_to_tuftRS   , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_tuftRS   , com_nontuftRS_to_tuftRS   ,          
     &     num_nontuftRS_to_tuftRS   ,
     &    ncompallow_nontuftRS_to_tuftRS   ,
     &     compallow_nontuftRS_to_tuftRS   , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_deepbask.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepbask , com_nontuftRS_to_deepbask ,          
     &     num_nontuftRS_to_deepbask ,
     &    ncompallow_nontuftRS_to_deepbask ,
     &     compallow_nontuftRS_to_deepbask , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepbask , com_nontuftRS_to_deepbask ,          
     &     num_nontuftRS_to_deepbask ,
     &    ncompallow_nontuftRS_to_deepbask ,
     &     compallow_nontuftRS_to_deepbask , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_deepaxax.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_nontuftRS_to_deepaxax ,          
     &     num_nontuftRS_to_deepaxax ,
     &    ncompallow_nontuftRS_to_deepaxax ,
     &     compallow_nontuftRS_to_deepaxax , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepaxax , com_nontuftRS_to_deepaxax ,          
     &     num_nontuftRS_to_deepaxax ,
     &    ncompallow_nontuftRS_to_deepaxax ,
     &     compallow_nontuftRS_to_deepaxax , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_deepLTS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_nontuftRS_to_deepLTS  ,          
     &     num_nontuftRS_to_deepLTS  ,
     &    ncompallow_nontuftRS_to_deepLTS  ,
     &     compallow_nontuftRS_to_deepLTS  , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_deepLTS  , com_nontuftRS_to_deepLTS  ,          
     &     num_nontuftRS_to_deepLTS  ,
     &    ncompallow_nontuftRS_to_deepLTS  ,
     &     compallow_nontuftRS_to_deepLTS  , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_TCR.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_TCR      , com_nontuftRS_to_TCR      ,          
     &     num_nontuftRS_to_TCR      ,
     &    ncompallow_nontuftRS_to_TCR      ,
     &     compallow_nontuftRS_to_TCR      , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_TCR      , com_nontuftRS_to_TCR      ,          
     &     num_nontuftRS_to_TCR      ,
     &    ncompallow_nontuftRS_to_TCR      ,
     &     compallow_nontuftRS_to_TCR      , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_nRT.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nRT      , com_nontuftRS_to_nRT      ,          
     &     num_nontuftRS_to_nRT      ,
     &    ncompallow_nontuftRS_to_nRT      ,
     &     compallow_nontuftRS_to_nRT      , display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nRT      , com_nontuftRS_to_nRT      ,          
     &     num_nontuftRS_to_nRT      ,
     &    ncompallow_nontuftRS_to_nRT      ,
     &     compallow_nontuftRS_to_nRT      , display)

          if (thisno.eq.0) then
             open(40,FILE='compmap/com_nontuftRS_to_nontuftRS.dat')
          end if
          CALL synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_nontuftRS_to_nontuftRS,          
     &     num_nontuftRS_to_nontuftRS,
     &    ncompallow_nontuftRS_to_nontuftRS,
     &     compallow_nontuftRS_to_nontuftRS, display)
          CALL write_synaptic_compmap_construct (thisno,
     &     num_nontuftRS, com_nontuftRS_to_nontuftRS,          
     &     num_nontuftRS_to_nontuftRS,
     &    ncompallow_nontuftRS_to_nontuftRS,
     &     compallow_nontuftRS_to_nontuftRS, display)

c Finish construction of synaptic compartment maps. 


c Construct gap-junction tables
! axax interneurons a special case(s)
! where the 1st and second cells are connected
! with a gap jnc at comp[12] if number of gapjunctions
! was increased from it's current zero setting)
           gjtable_supaxax(1,1) = 1
           gjtable_supaxax(1,2) = 12
           gjtable_supaxax(1,3) = 2
           gjtable_supaxax(1,4) = 12
           open(40,FILE='gapbld/gjtable_supaxax.dat')
           write(40,FMT='(4I6)') (gjtable_supaxax(1,j),j=1,4)

           gjtable_deepaxax(1,1) = 1
           gjtable_deepaxax(1,2) = 12
           gjtable_deepaxax(1,3) = 2
           gjtable_deepaxax(1,4) = 12
           open(40,FILE='gapbld/gjtable_deepaxax.dat')
           write(40,FMT='(4I6)') (gjtable_deepaxax(1,j),j=1,4)

!           print *, " calling groucho_gapbld"
           if (thisno.eq.0) then
              open(40,FILE='gapbld/gjtable_suppyrRS.dat')
           end if
      CALL groucho_gapbld (thisno, num_suppyrRS,
     & totaxgj_suppyrRS  , gjtable_suppyrRS,
     & table_axgjcompallow_suppyrRS, 
     & num_axgjcompallow_suppyrRS, 0) 
      CALL write_groucho_gapbld (thisno, num_suppyrRS,
     & totaxgj_suppyrRS  , gjtable_suppyrRS,
     & table_axgjcompallow_suppyrRS, 
     & num_axgjcompallow_suppyrRS, 0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_suppyrFRB.dat')
      end if
      CALL groucho_gapbld (thisno, num_suppyrFRB,
     & totaxgj_suppyrFRB , gjtable_suppyrFRB,
     & table_axgjcompallow_suppyrFRB,
     & num_axgjcompallow_suppyrFRB,  0) 
      CALL write_groucho_gapbld (thisno, num_suppyrFRB,
     & totaxgj_suppyrFRB , gjtable_suppyrFRB,
     & table_axgjcompallow_suppyrFRB,
     & num_axgjcompallow_suppyrFRB,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_suppyr.dat')
      end if
      call GROUCHO_gapbld_mix (thisno, num_suppyrRS,        
     & num_suppyrFRB, totaxgj_suppyr, gjtable_suppyr,
     & table_axgjcompallow_suppyrRS,
     & num_axgjcompallow_suppyrRS, 0)
      call write_GROUCHO_gapbld_mix (thisno, num_suppyrRS,        
     & num_suppyrFRB, totaxgj_suppyr, gjtable_suppyr,
     & table_axgjcompallow_suppyrRS,
     & num_axgjcompallow_suppyrRS, 0)
      
      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_spinstell.dat')
      end if
      CALL groucho_gapbld (thisno, num_spinstell,
     & totaxgj_spinstell , gjtable_spinstell,
     & table_axgjcompallow_spinstell,
     & num_axgjcompallow_spinstell,  0) 
      CALL write_groucho_gapbld (thisno, num_spinstell,
     & totaxgj_spinstell , gjtable_spinstell,
     & table_axgjcompallow_spinstell,
     & num_axgjcompallow_spinstell,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_tuftIB.dat')
      end if
      CALL groucho_gapbld (thisno, num_tuftIB,   
     & totaxgj_tuftIB    , gjtable_tuftIB   ,
     & table_axgjcompallow_tuftIB   ,
     & num_axgjcompallow_tuftIB   ,  0) 
      CALL write_groucho_gapbld (thisno, num_tuftIB,   
     & totaxgj_tuftIB    , gjtable_tuftIB   ,
     & table_axgjcompallow_tuftIB   ,
     & num_axgjcompallow_tuftIB   ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_tuftRS.dat')
      end if
      CALL groucho_gapbld (thisno, num_tuftRS,   
     & totaxgj_tuftRS    , gjtable_tuftRS   ,
     & table_axgjcompallow_tuftRS   ,
     & num_axgjcompallow_tuftRS   ,  0) 
      CALL write_groucho_gapbld (thisno, num_tuftRS,   
     & totaxgj_tuftRS    , gjtable_tuftRS   ,
     & table_axgjcompallow_tuftRS   ,
     & num_axgjcompallow_tuftRS   ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_tuft.dat')
      end if
      call GROUCHO_gapbld_mix (thisno, num_tuftIB,        
     & num_tuftRS, totaxgj_tuft, gjtable_tuft,
     & table_axgjcompallow_tuftIB,
     & num_axgjcompallow_tuftIB, 0)
      call write_GROUCHO_gapbld_mix (thisno, num_tuftIB,        
     & num_tuftRS, totaxgj_tuft, gjtable_tuft,
     & table_axgjcompallow_tuftIB,
     & num_axgjcompallow_tuftIB, 0)
      
      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_nontuftRS.dat')
      end if
      CALL groucho_gapbld (thisno, num_nontuftRS,   
     & totaxgj_nontuftRS    , gjtable_nontuftRS   ,
     & table_axgjcompallow_nontuftRS   ,
     & num_axgjcompallow_nontuftRS   ,  0) 
      CALL write_groucho_gapbld (thisno, num_nontuftRS,   
     & totaxgj_nontuftRS    , gjtable_nontuftRS   ,
     & table_axgjcompallow_nontuftRS   ,
     & num_axgjcompallow_nontuftRS   ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_supbask.dat')
      end if
      CALL groucho_gapbld (thisno, num_supbask  ,   
     & totSDgj_supbask      , gjtable_supbask     ,
     & table_SDgjcompallow_supbask     ,
     & num_SDgjcompallow_supbask     ,  0) 
      CALL write_groucho_gapbld (thisno, num_supbask  ,   
     & totSDgj_supbask      , gjtable_supbask     ,
     & table_SDgjcompallow_supbask     ,
     & num_SDgjcompallow_supbask     ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_supLTS.dat')
      end if
      CALL groucho_gapbld (thisno, num_supLTS   ,   
     & totSDgj_supLTS       , gjtable_supLTS      ,
     & table_SDgjcompallow_supLTS      ,
     & num_SDgjcompallow_supLTS      ,  0) 
      CALL write_groucho_gapbld (thisno, num_supLTS   ,   
     & totSDgj_supLTS       , gjtable_supLTS      ,
     & table_SDgjcompallow_supLTS      ,
     & num_SDgjcompallow_supLTS      ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_deepbask.dat')
      end if
      CALL groucho_gapbld (thisno, num_deepbask ,   
     & totSDgj_deepbask     , gjtable_deepbask    ,
     & table_SDgjcompallow_deepbask    ,
     & num_SDgjcompallow_deepbask    ,  0) 
      CALL write_groucho_gapbld (thisno, num_deepbask ,   
     & totSDgj_deepbask     , gjtable_deepbask    ,
     & table_SDgjcompallow_deepbask    ,
     & num_SDgjcompallow_deepbask    ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_deepLTS.dat')
      end if
      CALL groucho_gapbld (thisno, num_deepLTS  ,   
     & totSDgj_deepLTS      , gjtable_deepLTS     ,
     & table_SDgjcompallow_deepLTS     ,
     & num_SDgjcompallow_deepLTS     ,  0) 
      CALL write_groucho_gapbld (thisno, num_deepLTS  ,   
     & totSDgj_deepLTS      , gjtable_deepLTS     ,
     & table_SDgjcompallow_deepLTS     ,
     & num_SDgjcompallow_deepLTS     ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_TCR.dat')
      end if
      CALL groucho_gapbld (thisno, num_TCR      ,   
     & totaxgj_TCR          , gjtable_TCR         ,
     & table_axgjcompallow_TCR         ,
     & num_axgjcompallow_TCR         ,  0) 
      CALL write_groucho_gapbld (thisno, num_TCR      ,   
     & totaxgj_TCR          , gjtable_TCR         ,
     & table_axgjcompallow_TCR         ,
     & num_axgjcompallow_TCR         ,  0) 

      if (thisno.eq.0) then
         open(40,FILE='gapbld/gjtable_nRT.dat')
      end if
      CALL groucho_gapbld (thisno, num_nRT      ,   
     & totSDgj_nRT          , gjtable_nRT         ,
     & table_SDgjcompallow_nRT         ,
     & num_SDgjcompallow_nRT         ,  0) 
      CALL write_groucho_gapbld (thisno, num_nRT      ,   
     & totSDgj_nRT          , gjtable_nRT         ,
     & table_SDgjcompallow_nRT         ,
     & num_SDgjcompallow_nRT         ,  0) 

!      end do ! loop over thisno to simulate multiple processors

! Define spread of values for gGABA_nRT_to_TCR
       call durand(seed,num_nRT,ranvec_nRT)
       do L = 1, num_nRT
        gGABA_nRT_to_TCR(L) = 0.7d-3 + 1.4d-3 * ranvec_nRT(L)
       end do
       if (thisno.eq.0) then
         open(40,FILE='other_rnd/gGABA_nRT_to_TCR.dat')
         do L = 1, num_nRT
            write(40,FMT='(F20.15)') gGABA_nRT_to_TCR(L)
         end do
         open(40,FILE='other_rnd/tmp') ! will cause file to be rewritten
         ! when name changed back gGABA...
       end if
! Define tonic currents to different cell types
! ********* for debugging purposes occasionally turn on/off currents by modifiying below
       if (current_injection.eq.1) then
         call durand(seed,num_suppyrRS ,ranvec_suppyrRS )
         do L = 1, num_suppyr_RS 
            curr_suppyrRS  (1,L) = -0.025d0 + 0.05d0 *
     &      ranvec_suppyrRS (L)
         end do

         call durand(seed,num_suppyrFRB,ranvec_suppyrFRB)
         do L = 1, num_suppyr_FRB
           curr_suppyrFRB (1,L) = 0.25d0 + 0.1d0 *
     &     ranvec_suppyrFRB(L)
         end do

         call durand(seed,num_supbask  ,ranvec_supbask  )
         do L = 1, num_supbask    
            curr_supbask   (1,L) = 0.00d0 + 0.02d0 *
     &      ranvec_supbask  (L)
         end do

         call durand(seed,num_spinstell,ranvec_spinstell)
         do L = 1, num_spinstell  
           curr_spinstell (1,L) = 0.00d0 + 0.00d0 *
     &     ranvec_spinstell(L)
         end do

         call durand(seed,num_tuftIB   ,ranvec_tuftIB   )
         do L = 1, num_tuftIB    
!            curr_tuftIB    (1,L) = 0.10d0 + 0.1d0 *
            curr_tuftIB    (1,L) = 0.00d0 + 0.1d0 *
     &      ranvec_tuftIB   (L)
!            curr_tuftIB    (1,L) = -1.00d0 + 0.1d0 * ! ? suppress intrinsic bursting
!            curr_tuftIB    (1,L) = 1.00d0 + 0.1d0 *  !  ? wake up cortex ?
         end do

         call durand(seed,num_tuftRS   ,ranvec_tuftRS   )
         do L = 1, num_tuftRS    
!            curr_tuftRS    (1,L) = 0.10d0 + 0.1d0 *
            curr_tuftRS    (1,L) = 0.00d0 + 0.1d0 *
     &      ranvec_tuftRS   (L)
!            curr_tuftRS    (1,L) = 1.00d0 + 0.1d0 *  !  ? wake up cortex?
         end do

!     choose an L for debug print
         L=1
!        print *,thisno,": curr_tuftRS(1,",L,") = ",curr_tuftRS(1,L),
!     &   ", ranvec_tuftRS(L) = ",ranvec_tuftRS(L),
!     &   ", curr_suppyrFRB (1,",L,") = ", curr_suppyrFRB (1,L),
!     &   ",  ranvec_suppyrFRB(L) = ", ranvec_suppyrFRB(L)

         call durand(seed,num_nontuftRS ,ranvec_nontuftRS )
         do L = 1, num_nontuftRS    
            curr_nontuftRS  (1,L) = 0.00d0 + 0.1d0 *
     &      ranvec_nontuftRS (L)
!            curr_nontuftRS  (1,L) = 0.75d0 + 0.1d0 *  ! ? wake up cortex
         end do

         call durand(seed,num_nRT       ,ranvec_nRT       )
         do L = 1, num_nRT          
            curr_nRT        (1,L) = 0.10d0 + 0.05d0 *
     &      ranvec_nRT       (L)
         end do

! During sz, curr to TCR can be zero
         call durand(seed,num_TCR       ,ranvec_TCR       )
         do L = 1, num_TCR          
            curr_TCR        (1,L) = 0.00d0 + 0.01d0 *
     &      ranvec_TCR       (L)
!            curr_TCR        (1,L) = 1.40d0 + 0.01d0 *
         end do
       end if ! current_injection debugging flag

       seed = 137.d0

       O = 0
       time = 0.d0

c CODE BELOW FOR "PICROTOXIN": scale all GABA-A
!        GOTO 30
         z1 = 0.06d0  ! for intracortical IPSCs
         z2 = 1.00d0  ! for intrathalamic IPSCs, usual 1.00
      gGABA_supbask_to_suppyrRS   =  z1 * gGABA_supbask_to_suppyrRS
      gGABA_supbask_to_suppyrFRB  =  z1 * gGABA_supbask_to_suppyrFRB
      gGABA_supbask_to_supbask    =  z1 * gGABA_supbask_to_supbask
      gGABA_supbask_to_supaxax    =  z1 * gGABA_supbask_to_supaxax
      gGABA_supbask_to_supLTS     =  z1 * gGABA_supbask_to_supLTS
      gGABA_supbask_to_spinstell  =  z1 * gGABA_supbask_to_spinstell

      gGABA_supaxax_to_suppyrRS   =  z1 * gGABA_supaxax_to_suppyrRS
      gGABA_supaxax_to_suppyrFRB  =  z1 * gGABA_supaxax_to_suppyrFRB
      gGABA_supaxax_to_spinstell  =  z1 * gGABA_supaxax_to_spinstell
      gGABA_supaxax_to_tuftIB     =  z1 * gGABA_supaxax_to_tuftIB
      gGABA_supaxax_to_tuftRS     =  z1 * gGABA_supaxax_to_tuftRS
      gGABA_supaxax_to_nontuftRS  =  z1 * gGABA_supaxax_to_nontuftRS

      gGABA_supLTS_to_suppyrRS    =  z1 * gGABA_supLTS_to_suppyrRS
      gGABA_supLTS_to_suppyrFRB   =  z1 * gGABA_supLTS_to_suppyrFRB
      gGABA_supLTS_to_supbask     =  z1 * gGABA_supLTS_to_supbask
      gGABA_supLTS_to_supaxax     =  z1 * gGABA_supLTS_to_supaxax
      gGABA_supLTS_to_supLTS      =  z1 * gGABA_supLTS_to_supLTS
      gGABA_supLTS_to_spinstell   =  z1 * gGABA_supLTS_to_spinstell
      gGABA_supLTS_to_tuftIB      =  z1 * gGABA_supLTS_to_tuftIB
      gGABA_supLTS_to_tuftRS      =  z1 * gGABA_supLTS_to_tuftRS
      gGABA_supLTS_to_deepbask    =  z1 * gGABA_supLTS_to_deepbask
      gGABA_supLTS_to_deepaxax    =  z1 * gGABA_supLTS_to_deepaxax
      gGABA_supLTS_to_deepLTS     =  z1 * gGABA_supLTS_to_deepLTS
      gGABA_supLTS_to_nontuftRS   =  z1 * gGABA_supLTS_to_nontuftRS

      gGABA_deepbask_to_spinstell =  z1 * gGABA_deepbask_to_spinstell
      gGABA_deepbask_to_tuftIB    =  z1 * gGABA_deepbask_to_tuftIB
      gGABA_deepbask_to_tuftRS    =  z1 * gGABA_deepbask_to_tuftRS
      gGABA_deepbask_to_deepbask  =  z1 * gGABA_deepbask_to_deepbask
      gGABA_deepbask_to_deepaxax  =  z1 * gGABA_deepbask_to_deepaxax
      gGABA_deepbask_to_deepLTS   =  z1 * gGABA_deepbask_to_deepLTS
      gGABA_deepbask_to_nontuftRS =  z1 * gGABA_deepbask_to_nontuftRS

      gGABA_deepaxax_to_suppyrRS   = z1 * gGABA_deepaxax_to_suppyrRS
      gGABA_deepaxax_to_suppyrFRB  = z1 * gGABA_deepaxax_to_suppyrFRB
      gGABA_deepaxax_to_spinstell  = z1 * gGABA_deepaxax_to_spinstell
      gGABA_deepaxax_to_tuftIB     = z1 * gGABA_deepaxax_to_tuftIB
      gGABA_deepaxax_to_tuftRS     = z1 * gGABA_deepaxax_to_tuftRS
      gGABA_deepaxax_to_nontuftRS  = z1 * gGABA_deepaxax_to_nontuftRS

      gGABA_deepLTS_to_suppyrRS    = z1 * gGABA_deepLTS_to_suppyrRS
      gGABA_deepLTS_to_suppyrFRB   = z1 * gGABA_deepLTS_to_suppyrFRB
      gGABA_deepLTS_to_supbask     = z1 * gGABA_deepLTS_to_supbask
      gGABA_deepLTS_to_supaxax     = z1 * gGABA_deepLTS_to_supaxax
      gGABA_deepLTS_to_supLTS      = z1 * gGABA_deepLTS_to_supLTS
      gGABA_deepLTS_to_spinstell   = z1 * gGABA_deepLTS_to_spinstell
      gGABA_deepLTS_to_tuftIB      = z1 * gGABA_deepLTS_to_tuftIB
      gGABA_deepLTS_to_tuftRS      = z1 * gGABA_deepLTS_to_tuftRS
      gGABA_deepLTS_to_deepbask    = z1 * gGABA_deepLTS_to_deepbask
      gGABA_deepLTS_to_deepaxax    = z1 * gGABA_deepLTS_to_deepaxax
      gGABA_deepLTS_to_deepLTS     = z1 * gGABA_deepLTS_to_deepLTS
      gGABA_deepLTS_to_nontuftRS   = z1 * gGABA_deepLTS_to_nontuftRS

        do L = 1, num_nRT
      gGABA_nRT_to_TCR(L)          = z2 * gGABA_nRT_to_TCR(L) 
        end do
!     rewrite the max conductance file if rescaled
       if (thisno.eq.0) then
         open(40,FILE='other_rnd/gGABA_nRT_to_TCR.dat')
         do L = 1, num_nRT
            write(40,FMT='(F20.15)') gGABA_nRT_to_TCR(L)
         end do
       end if
      gGABA_nRT_to_nRT             = z2 * gGABA_nRT_to_nRT
30          CONTINUE
c End "PICROTOXIN" code

! Code below is "NBQX": scale all AMPA
!        GOTO 35
!          z1 = 1.00d0  ! intracortical e/i
           z1 = 1.00d0  ! intracortical e/i ! usual 1.00
           z3 = 1.00d0  ! TCR -> cortical i ! usual 1.0
           z4 = 1.00d0  ! TCR -> nRT & nontuftRS ->nRT ! usual 1.00
           z2 = 2.00d0  ! everything else; note that this may be INCREASED, usual 1.0

      gAMPA_suppyrRS_to_suppyrRS= z2 * gAMPA_suppyrRS_to_suppyrRS
      gAMPA_suppyrRS_to_suppyrFRB= z2 * gAMPA_suppyrRS_to_suppyrFRB
      gAMPA_suppyrRS_to_supbask  = z1 * gAMPA_suppyrRS_to_supbask
      gAMPA_suppyrRS_to_supaxax  = z1 * gAMPA_suppyrRS_to_supaxax
      gAMPA_suppyrRS_to_supLTS   = z1 * gAMPA_suppyrRS_to_supLTS
      gAMPA_suppyrRS_to_spinstell= z2 * gAMPA_suppyrRS_to_spinstell
      gAMPA_suppyrRS_to_tuftIB   = z2 * gAMPA_suppyrRS_to_tuftIB
      gAMPA_suppyrRS_to_tuftRS   = z2 * gAMPA_suppyrRS_to_tuftRS
      gAMPA_suppyrRS_to_deepbask = z1 * gAMPA_suppyrRS_to_deepbask
      gAMPA_suppyrRS_to_deepaxax = z1 * gAMPA_suppyrRS_to_deepaxax
      gAMPA_suppyrRS_to_deepLTS  = z1 * gAMPA_suppyrRS_to_deepLTS
      gAMPA_suppyrRS_to_nontuftRS= z2 * gAMPA_suppyrRS_to_nontuftRS

      gAMPA_suppyrFRB_to_suppyrRS= z2 * gAMPA_suppyrFRB_to_suppyrRS
      gAMPA_suppyrFRB_to_suppyrFRB=z2 * gAMPA_suppyrFRB_to_suppyrFRB
      gAMPA_suppyrFRB_to_supbask  =z1 * gAMPA_suppyrFRB_to_supbask
      gAMPA_suppyrFRB_to_supaxax  =z1 * gAMPA_suppyrFRB_to_supaxax
      gAMPA_suppyrFRB_to_supLTS   =z1 * gAMPA_suppyrFRB_to_supLTS
      gAMPA_suppyrFRB_to_spinstell=z2 * gAMPA_suppyrFRB_to_spinstell
      gAMPA_suppyrFRB_to_tuftIB   =z2 * gAMPA_suppyrFRB_to_tuftIB
      gAMPA_suppyrFRB_to_tuftRS   =z2 * gAMPA_suppyrFRB_to_tuftRS
      gAMPA_suppyrFRB_to_deepbask =z1 * gAMPA_suppyrFRB_to_deepbask
      gAMPA_suppyrFRB_to_deepaxax =z1 * gAMPA_suppyrFRB_to_deepaxax
      gAMPA_suppyrFRB_to_deepLTS  =z1 * gAMPA_suppyrFRB_to_deepLTS
      gAMPA_suppyrFRB_to_nontuftRS=z2 * gAMPA_suppyrFRB_to_nontuftRS

      gAMPA_spinstell_to_suppyrRS = z2 * gAMPA_spinstell_to_suppyrRS
      gAMPA_spinstell_to_suppyrFRB= z2 * gAMPA_spinstell_to_suppyrFRB
      gAMPA_spinstell_to_supbask  = z1 * gAMPA_spinstell_to_supbask
      gAMPA_spinstell_to_supaxax  = z1 * gAMPA_spinstell_to_supaxax
      gAMPA_spinstell_to_supLTS   = z1 * gAMPA_spinstell_to_supLTS
      gAMPA_spinstell_to_spinstell= z2 * gAMPA_spinstell_to_spinstell
      gAMPA_spinstell_to_tuftIB   = z2 * gAMPA_spinstell_to_tuftIB
      gAMPA_spinstell_to_tuftRS   = z2 * gAMPA_spinstell_to_tuftRS
      gAMPA_spinstell_to_deepbask = z1 * gAMPA_spinstell_to_deepbask
      gAMPA_spinstell_to_deepaxax = z1 * gAMPA_spinstell_to_deepaxax
      gAMPA_spinstell_to_deepLTS  = z1 * gAMPA_spinstell_to_deepLTS
      gAMPA_spinstell_to_nontuftRS= z2 * gAMPA_spinstell_to_nontuftRS

      gAMPA_tuftIB_to_suppyrRS    = z2 * gAMPA_tuftIB_to_suppyrRS
      gAMPA_tuftIB_to_suppyrFRB   = z2 * gAMPA_tuftIB_to_suppyrFRB
      gAMPA_tuftIB_to_supbask     = z1 * gAMPA_tuftIB_to_supbask
      gAMPA_tuftIB_to_supaxax     = z1 * gAMPA_tuftIB_to_supaxax
      gAMPA_tuftIB_to_supLTS      = z1 * gAMPA_tuftIB_to_supLTS
      gAMPA_tuftIB_to_spinstell   = z2 * gAMPA_tuftIB_to_spinstell
      gAMPA_tuftIB_to_tuftIB      = z2 * gAMPA_tuftIB_to_tuftIB
      gAMPA_tuftIB_to_tuftRS      = z2 * gAMPA_tuftIB_to_tuftRS
      gAMPA_tuftIB_to_deepbask    = z1 * gAMPA_tuftIB_to_deepbask
      gAMPA_tuftIB_to_deepaxax    = z1 * gAMPA_tuftIB_to_deepaxax
      gAMPA_tuftIB_to_deepLTS     = z1 * gAMPA_tuftIB_to_deepLTS
      gAMPA_tuftIB_to_nontuftRS   = z2 * gAMPA_tuftIB_to_nontuftRS

      gAMPA_tuftRS_to_suppyrRS    = z2 * gAMPA_tuftRS_to_suppyrRS
      gAMPA_tuftRS_to_suppyrFRB   = z2 * gAMPA_tuftRS_to_suppyrFRB
      gAMPA_tuftRS_to_supbask     = z1 * gAMPA_tuftRS_to_supbask 
      gAMPA_tuftRS_to_supaxax     = z1 * gAMPA_tuftRS_to_supaxax
      gAMPA_tuftRS_to_supLTS      = z1 * gAMPA_tuftRS_to_supLTS
      gAMPA_tuftRS_to_spinstell   = z2 * gAMPA_tuftRS_to_spinstell
      gAMPA_tuftRS_to_tuftIB      = z2 * gAMPA_tuftRS_to_tuftIB
      gAMPA_tuftRS_to_tuftRS      = z2 * gAMPA_tuftRS_to_tuftRS
      gAMPA_tuftRS_to_deepbask    = z1 * gAMPA_tuftRS_to_deepbask
      gAMPA_tuftRS_to_deepaxax    = z1 * gAMPA_tuftRS_to_deepaxax
      gAMPA_tuftRS_to_deepLTS     = z1 * gAMPA_tuftRS_to_deepLTS
      gAMPA_tuftRS_to_nontuftRS   = z2 * gAMPA_tuftRS_to_nontuftRS

      gAMPA_TCR_to_suppyrRS        = z2 * gAMPA_TCR_to_suppyrRS
      gAMPA_TCR_to_suppyrFRB       = z2 * gAMPA_TCR_to_suppyrFRB
      gAMPA_TCR_to_supbask         = z3 * gAMPA_TCR_to_supbask
      gAMPA_TCR_to_supaxax         = z3 * gAMPA_TCR_to_supaxax
      gAMPA_TCR_to_spinstell       = z2 * gAMPA_TCR_to_spinstell
      gAMPA_TCR_to_tuftIB          = z2 * gAMPA_TCR_to_tuftIB
      gAMPA_TCR_to_tuftRS          = z2 * gAMPA_TCR_to_tuftRS
      gAMPA_TCR_to_deepbask        = z3 * gAMPA_TCR_to_deepbask
      gAMPA_TCR_to_deepaxax        = z3 * gAMPA_TCR_to_deepaxax
      gAMPA_TCR_to_nRT             = z4 * gAMPA_TCR_to_nRT
      gAMPA_TCR_to_nontuftRS       = z2 * gAMPA_TCR_to_nontuftRS

      gAMPA_nontuftRS_to_suppyrRS  = z2 * gAMPA_nontuftRS_to_suppyrRS
      gAMPA_nontuftRS_to_suppyrFRB = z2 * gAMPA_nontuftRS_to_suppyrFRB
      gAMPA_nontuftRS_to_supbask   = z1 * gAMPA_nontuftRS_to_supbask
      gAMPA_nontuftRS_to_supaxax   = z1 * gAMPA_nontuftRS_to_supaxax
      gAMPA_nontuftRS_to_supLTS    = z1 * gAMPA_nontuftRS_to_supLTS
      gAMPA_nontuftRS_to_spinstell = z2 * gAMPA_nontuftRS_to_spinstell
      gAMPA_nontuftRS_to_tuftIB    = z2 * gAMPA_nontuftRS_to_tuftIB
      gAMPA_nontuftRS_to_tuftRS    = z2 * gAMPA_nontuftRS_to_tuftRS
      gAMPA_nontuftRS_to_deepbask  = z1 * gAMPA_nontuftRS_to_deepbask
      gAMPA_nontuftRS_to_deepaxax  = z1 * gAMPA_nontuftRS_to_deepaxax
      gAMPA_nontuftRS_to_deepLTS   = z1 * gAMPA_nontuftRS_to_deepLTS
      gAMPA_nontuftRS_to_TCR       = z2 * gAMPA_nontuftRS_to_TCR
      gAMPA_nontuftRS_to_nRT       = z4 * gAMPA_nontuftRS_to_nRT
      gAMPA_nontuftRS_to_nontuftRS = z2 * gAMPA_nontuftRS_to_nontuftRS
35         CONTINUE
c End "NBQX" section.

c Code below scales TCR output to cortex (not to nRT), AMPA & NMDA
!     goto 60
       z = 0.d0

      gAMPA_TCR_to_suppyrRS = z * gAMPA_TCR_to_suppyrRS
      gNMDA_TCR_to_suppyrRS = z * gNMDA_TCR_to_suppyrRS
      gAMPA_TCR_to_suppyrFRB = z * gAMPA_TCR_to_suppyrFRB
      gNMDA_TCR_to_suppyrFRB = z * gNMDA_TCR_to_suppyrFRB
      gAMPA_TCR_to_supbask = z * gAMPA_TCR_to_supbask
      gNMDA_TCR_to_supbask = z * gNMDA_TCR_to_supbask
      gAMPA_TCR_to_supaxax = z * gAMPA_TCR_to_supaxax
      gNMDA_TCR_to_supaxax = z * gNMDA_TCR_to_supaxax
      gAMPA_TCR_to_spinstell = z * gAMPA_TCR_to_spinstell
      gNMDA_TCR_to_spinstell = z * gNMDA_TCR_to_spinstell
      gAMPA_TCR_to_tuftIB = z * gAMPA_TCR_to_tuftIB
      gNMDA_TCR_to_tuftIB = z * gNMDA_TCR_to_tuftIB
      gAMPA_TCR_to_tuftRS = z * gAMPA_TCR_to_tuftRS
      gNMDA_TCR_to_tuftRS = z * gNMDA_TCR_to_tuftRS
      gAMPA_TCR_to_deepbask = z * gAMPA_TCR_to_deepbask
      gNMDA_TCR_to_deepbask = z * gNMDA_TCR_to_deepbask
      gAMPA_TCR_to_deepaxax = z * gAMPA_TCR_to_deepaxax
      gNMDA_TCR_to_deepaxax = z * gNMDA_TCR_to_deepaxax
      gAMPA_TCR_to_nontuftRS = z * gAMPA_TCR_to_nontuftRS
      gNMDA_TCR_to_nontuftRS = z * gNMDA_TCR_to_nontuftRS

60          CONTINUE

c Code below scales some/all NMDA conductances.
!        GOTO 40
         z1 = 0.2d0 ! to interneurons
c        z1 = 0.5d0 ! to interneurons
! Usual scaling of NMDA to princ. cells, including FRB, is 0.5
         z2 = 2.5d0 ! to  cort. principal cells, except FRB
         z3 = 2.5d0 ! to suppyrFRB
         z4 = 0.2d0  ! to TCR and nRT and from TCR to cort. princ.
      gNMDA_suppyrRS_to_suppyrRS= z2 *
     &  gNMDA_suppyrRS_to_suppyrRS
      gNMDA_suppyrRS_to_suppyrFRB= z3 *
     &  gNMDA_suppyrRS_to_suppyrFRB
      gNMDA_suppyrRS_to_supbask  = z1 *
     &  gNMDA_suppyrRS_to_supbask
      gNMDA_suppyrRS_to_supaxax  = z1 *
     &  gNMDA_suppyrRS_to_supaxax
      gNMDA_suppyrRS_to_supLTS   = z1 *
     &  gNMDA_suppyrRS_to_supLTS   
      gNMDA_suppyrRS_to_spinstell= z2 *
     &  gNMDA_suppyrRS_to_spinstell
      gNMDA_suppyrRS_to_tuftIB   = z2 *
     &  gNMDA_suppyrRS_to_tuftIB
      gNMDA_suppyrRS_to_tuftRS   = z2 *
     &  gNMDA_suppyrRS_to_tuftRS  
      gNMDA_suppyrRS_to_deepbask = z1 *
     &  gNMDA_suppyrRS_to_deepbask 
      gNMDA_suppyrRS_to_deepaxax = z1 *
     &  gNMDA_suppyrRS_to_deepaxax
      gNMDA_suppyrRS_to_deepLTS  = z1 *
     &  gNMDA_suppyrRS_to_deepLTS 
      gNMDA_suppyrRS_to_nontuftRS= z2 *
     &  gNMDA_suppyrRS_to_nontuftRS
 
      gNMDA_suppyrFRB_to_suppyrRS= z2 *
     &  gNMDA_suppyrFRB_to_suppyrRS
      gNMDA_suppyrFRB_to_suppyrFRB= z3 *
     &  gNMDA_suppyrFRB_to_suppyrFRB
      gNMDA_suppyrFRB_to_supbask  = z1 *
     &  gNMDA_suppyrFRB_to_supbask 
      gNMDA_suppyrFRB_to_supaxax  = z1 *
     &  gNMDA_suppyrFRB_to_supaxax 
      gNMDA_suppyrFRB_to_supLTS   = z1 *
     &  gNMDA_suppyrFRB_to_supLTS
      gNMDA_suppyrFRB_to_spinstell= z2 *
     &  gNMDA_suppyrFRB_to_spinstell
      gNMDA_suppyrFRB_to_tuftIB   = z2 *
     &  gNMDA_suppyrFRB_to_tuftIB
      gNMDA_suppyrFRB_to_tuftRS   = z2 *
     &  gNMDA_suppyrFRB_to_tuftRS   
      gNMDA_suppyrFRB_to_deepbask = z1 *
     &  gNMDA_suppyrFRB_to_deepbask
      gNMDA_suppyrFRB_to_deepaxax = z1 *
     &  gNMDA_suppyrFRB_to_deepaxax
      gNMDA_suppyrFRB_to_deepLTS  = z1 *
     &  gNMDA_suppyrFRB_to_deepLTS
      gNMDA_suppyrFRB_to_nontuftRS= z2 *
     &  gNMDA_suppyrFRB_to_nontuftRS

      gNMDA_spinstell_to_suppyrRS = z2 *
     &  gNMDA_spinstell_to_suppyrRS
      gNMDA_spinstell_to_suppyrFRB= z3 *
     &  gNMDA_spinstell_to_suppyrFRB
      gNMDA_spinstell_to_supbask  = z1 *
     &  gNMDA_spinstell_to_supbask
      gNMDA_spinstell_to_supaxax  = z1 *
     &  gNMDA_spinstell_to_supaxax 
      gNMDA_spinstell_to_supLTS   = z1 *
     &  gNMDA_spinstell_to_supLTS
      gNMDA_spinstell_to_spinstell= z2 *
     &  gNMDA_spinstell_to_spinstell
      gNMDA_spinstell_to_tuftIB   = z2 *
     &  gNMDA_spinstell_to_tuftIB 
      gNMDA_spinstell_to_tuftRS   = z2 *
     &  gNMDA_spinstell_to_tuftRS 
      gNMDA_spinstell_to_deepbask = z1 *
     &  gNMDA_spinstell_to_deepbask 
      gNMDA_spinstell_to_deepaxax = z1 *
     &  gNMDA_spinstell_to_deepaxax
      gNMDA_spinstell_to_deepLTS  = z1 *
     &  gNMDA_spinstell_to_deepLTS 
      gNMDA_spinstell_to_nontuftRS= z2 *
     &  gNMDA_spinstell_to_nontuftRS

      gNMDA_tuftIB_to_suppyrRS    = z2 *
     &  gNMDA_tuftIB_to_suppyrRS 
      gNMDA_tuftIB_to_suppyrFRB   = z3 *
     &  gNMDA_tuftIB_to_suppyrFRB
      gNMDA_tuftIB_to_supbask     = z1 *
     &  gNMDA_tuftIB_to_supbask 
      gNMDA_tuftIB_to_supaxax     = z1 *
     &  gNMDA_tuftIB_to_supaxax 
      gNMDA_tuftIB_to_supLTS      = z1 *
     &  gNMDA_tuftIB_to_supLTS 
      gNMDA_tuftIB_to_spinstell   = z2 *
     &  gNMDA_tuftIB_to_spinstell 
      gNMDA_tuftIB_to_tuftIB      = z2 *
     &  gNMDA_tuftIB_to_tuftIB 
      gNMDA_tuftIB_to_tuftRS      = z2 *
     &  gNMDA_tuftIB_to_tuftRS  
      gNMDA_tuftIB_to_deepbask    = z1 *
     &  gNMDA_tuftIB_to_deepbask 
      gNMDA_tuftIB_to_deepaxax    = z1 *
     &  gNMDA_tuftIB_to_deepaxax
      gNMDA_tuftIB_to_deepLTS     = z1 *
     &  gNMDA_tuftIB_to_deepLTS   
      gNMDA_tuftIB_to_nontuftRS   = z2 *
     &  gNMDA_tuftIB_to_nontuftRS  

      gNMDA_tuftRS_to_suppyrRS    = z2 *
     &  gNMDA_tuftRS_to_suppyrRS
      gNMDA_tuftRS_to_suppyrFRB   = z3 *
     &  gNMDA_tuftRS_to_suppyrFRB
      gNMDA_tuftRS_to_supbask     = z1 *
     &  gNMDA_tuftRS_to_supbask 
      gNMDA_tuftRS_to_supaxax     = z1 *
     &  gNMDA_tuftRS_to_supaxax 
      gNMDA_tuftRS_to_supLTS      = z1 *
     &  gNMDA_tuftRS_to_supLTS   
      gNMDA_tuftRS_to_spinstell   = z2 *
     &  gNMDA_tuftRS_to_spinstell  
      gNMDA_tuftRS_to_tuftIB      = z2 *
     &  gNMDA_tuftRS_to_tuftIB
      gNMDA_tuftRS_to_tuftRS      = z2 *
     &  gNMDA_tuftRS_to_tuftRS 
      gNMDA_tuftRS_to_deepbask    = z1 *
     &  gNMDA_tuftRS_to_deepbask
      gNMDA_tuftRS_to_deepaxax    = z1 *
     &  gNMDA_tuftRS_to_deepaxax
      gNMDA_tuftRS_to_deepLTS     = z1 *
     &  gNMDA_tuftRS_to_deepLTS   
      gNMDA_tuftRS_to_nontuftRS   = z2 *
     &  gNMDA_tuftRS_to_nontuftRS 

      gNMDA_TCR_to_suppyrRS        = z4 *
     &  gNMDA_TCR_to_suppyrRS 
      gNMDA_TCR_to_suppyrFRB       = z4 *
     &  gNMDA_TCR_to_suppyrFRB 
      gNMDA_TCR_to_supbask         = z1 *
     &  gNMDA_TCR_to_supbask
      gNMDA_TCR_to_supaxax         = z1 *
     &  gNMDA_TCR_to_supaxax 
      gNMDA_TCR_to_spinstell       = z4 *
     &  gNMDA_TCR_to_spinstell 
      gNMDA_TCR_to_tuftIB          = z4 *
     &  gNMDA_TCR_to_tuftIB   
      gNMDA_TCR_to_tuftRS          = z4 *
     &  gNMDA_TCR_to_tuftRS 
      gNMDA_TCR_to_deepbask        = z1 *
     &  gNMDA_TCR_to_deepbask 
      gNMDA_TCR_to_deepaxax        = z1 *
     &  gNMDA_TCR_to_deepaxax 
      gNMDA_TCR_to_nRT             = z1 *
     &  gNMDA_TCR_to_nRT  
      gNMDA_TCR_to_nontuftRS       = z4 *
     &  gNMDA_TCR_to_nontuftRS  

      gNMDA_nontuftRS_to_suppyrRS  = z2 *
     &  gNMDA_nontuftRS_to_suppyrRS
      gNMDA_nontuftRS_to_suppyrFRB = z3 *
     & gNMDA_nontuftRS_to_suppyrFRB 
      gNMDA_nontuftRS_to_supbask   = z1 *
     &  gNMDA_nontuftRS_to_supbask 
      gNMDA_nontuftRS_to_supaxax   = z1 *
     &  gNMDA_nontuftRS_to_supaxax  
      gNMDA_nontuftRS_to_supLTS    = z1 *
     &  gNMDA_nontuftRS_to_supLTS 
      gNMDA_nontuftRS_to_spinstell = z2 *
     &  gNMDA_nontuftRS_to_spinstell 
      gNMDA_nontuftRS_to_tuftIB    = z2 *
     &  gNMDA_nontuftRS_to_tuftIB 
      gNMDA_nontuftRS_to_tuftRS    = z2 *
     &  gNMDA_nontuftRS_to_tuftRS 
      gNMDA_nontuftRS_to_deepbask  = z1 *
     & gNMDA_nontuftRS_to_deepbask
      gNMDA_nontuftRS_to_deepaxax  = z1 *
     &  gNMDA_nontuftRS_to_deepaxax 
      gNMDA_nontuftRS_to_deepLTS   = z1 *
     &  gNMDA_nontuftRS_to_deepLTS
      gNMDA_nontuftRS_to_TCR       = z4 *
     &  gNMDA_nontuftRS_to_TCR 
      gNMDA_nontuftRS_to_nRT       = z4 *
     &  gNMDA_nontuftRS_to_nRT    
      gNMDA_nontuftRS_to_nontuftRS = z2 *
     &  gNMDA_nontuftRS_to_nontuftRS 
40    CONTINUE
c End section scaling all NMDA conductances.       

c     Special section to turn off gap junctions for debugging
c     could use variable like gap_junction_off or gj_off
c     Since only occurs here 1.eq.1 (gjs off) or 0.eq.1 (gj's on)
c     if it is desired to turn gj's off and on during simulation
c     then can move this code inside loop and use time inequality
c     tests instead
      if (0.eq.1) then
       totaxgj_suppyrRS = 0
       totaxgj_suppyr = 0
       totaxgj_suppyrFRB  = 0
       totaxgj_suppyr = 0
       totaxgj_spinstell = 0
       totaxgj_tuftIB = 0
       totaxgj_tuft = 0
       totaxgj_tuftRS = 0
       totaxgj_nontuftRS = 0
       totaxgj_tcr = 0
       
       totSDgj_supbask = 0
       totSDgj_supaxax = 0
       totSDgj_supLTS = 0
       totSDgj_deepbask = 0
       totSDgj_deepaxax = 0
       totSDgj_deepLTS = 0
      end if

c ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c
c BEGIN guts of main program.
c Each node takes care of all the cells of a particular type.
c On a node: enumerate the cells of its type; calculate their
c  synaptic inputs; set applied currents, including those
c  required by ectopic generation; call the numerical integration
c  subroutine; set up the distal_axon vector.  Each node 
c  broadcasts its own distal_axon vector to all the others, and also
c  receives distal_axon vectors from all the others.
c Then, update outtime array and outctr vector.  Repeat.
c
c ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

1000    O = O + 1
        time = time + dt
        if (time.gt.timtot) goto 2000

!      do thisno=0,13   ! simulates 14 processors

       IF (THISNO.EQ.0) THEN
c suppyrRS

          IF (MOD(O,how_often).eq.0) then
c 1st set suppyrRS synaptic conductances to 0:

          do i = 1, numcomp_suppyrRS
          do j = 1, num_suppyrRS
         gAMPA_suppyrRS(i,j)   = 0.d0
         gNMDA_suppyrRS(i,j)   = 0.d0
         gGABA_A_suppyrRS(i,j) = 0.d0
          end do
          end do

         do L = 1, num_suppyrRS

c Handle suppyrRS   -> suppyrRS
      do i = 1, num_suppyrRS_to_suppyrRS
       j = map_suppyrRS_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_suppyrRS_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_suppyrRS_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_suppyrRS_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i

c Handle suppyrFRB  -> suppyrRS
      do i = 1, num_suppyrFRB_to_suppyrRS
       j = map_suppyrFRB_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_suppyrFRB_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_suppyrFRB_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_suppyrFRB_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i

c Handle supbask    -> suppyrRS
      do i = 1, num_supbask_to_suppyrRS
       j = map_supbask_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_supbask_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrRS(k,L)  = gGABA_A_suppyrRS(k,L) +
     &  gGABA_supbask_to_suppyrRS * z      
! end GABA-A part

       end do ! m
      end do ! i
!      print *, "a1:"
!      print *,"  gAMPA_suppyrRS(",k,",",L,") = ", gAMPA_suppyrRS(k,L)
!      print *,"  gAMPA_suppyrRS(",k,",",L,") = ", gAMPA_suppyrRS(k,L)
!      print *,"  gNMDA_suppyrRS(",k,",",L,") = ", gNMDA_suppyrRS(k,L)

c Handle supaxax    -> suppyrRS
      do i = 1, num_supaxax_to_suppyrRS
       j = map_supaxax_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_supaxax_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrRS(k,L)  = gGABA_A_suppyrRS(k,L) +
     &  gGABA_supaxax_to_suppyrRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> suppyrRS
      do i = 1, num_supLTS_to_suppyrRS
       j = map_supLTS_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_supLTS_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrRS(k,L)  = gGABA_A_suppyrRS(k,L) +
     &  gGABA_supLTS_to_suppyrRS * z      
! end GABA-A part

       end do ! m
      end do ! i

!      print *, "a2:"
!      print *,"  gAMPA_suppyrRS(",k,",",L,") = ", gAMPA_suppyrRS(k,L)
!      print *,"  gAMPA_suppyrRS(",k,",",L,") = ", gAMPA_suppyrRS(k,L)
!      print *,"  gNMDA_suppyrRS(",k,",",L,") = ", gNMDA_suppyrRS(k,L)

c Handle spinstell  -> suppyrRS
      do i = 1, num_spinstell_to_suppyrRS
       j = map_spinstell_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_spinstell_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_spinstell_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_spinstell_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_spinstell_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> suppyrRS
      do i = 1, num_tuftIB_to_suppyrRS
       j = map_tuftIB_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_tuftIB_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_tuftIB_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_tuftIB_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> suppyrRS
      do i = 1, num_tuftRS_to_suppyrRS
       j = map_tuftRS_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_tuftRS_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_tuftRS_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_tuftRS_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepaxax   -> suppyrRS
      do i = 1, num_deepaxax_to_suppyrRS
       j = map_deepaxax_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrRS(k,L)  = gGABA_A_suppyrRS(k,L) +
     &  gGABA_deepaxax_to_suppyrRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> suppyrRS
      do i = 1, num_deepLTS_to_suppyrRS
       j = map_deepLTS_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrRS(k,L)  = gGABA_A_suppyrRS(k,L) +
     &  gGABA_deepLTS_to_suppyrRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> suppyrRS
      do i = 1, num_TCR_to_suppyrRS
       j = map_TCR_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_TCR_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_TCR_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_TCR_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_TCR_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> suppyrRS
      
      do i = 1, num_nontuftRS_to_suppyrRS
       j = map_nontuftRS_to_suppyrRS(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_suppyrRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_suppyrRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
!         print *,"g1: ",gAMPA_nontuftRS_to_suppyrRS,delta, z      
      gAMPA_suppyrRS(k,L)  = gAMPA_suppyrRS(k,L) +
     &  gAMPA_nontuftRS_to_suppyrRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_nontuftRS_to_suppyrRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_suppyrRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrRS(k,L) = gNMDA_suppyrRS(k,L) +
     &  gNMDA_nontuftRS_to_suppyrRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_suppyrRS
       if (gNMDA_suppyrRS(k,L).gt.z)
     &  gNMDA_suppyrRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i

         end do
c End enumeration of suppyrRS
       ENDIF ! if (mod(O,how_often).eq.0)...

! Define phasic currents to suppyrRS cells, ectopic spikes,
! tonic synaptic conductances

      if (mod(O,200).eq.0) then
       call durand(seed,num_suppyrRS,ranvec_suppyrRS) 
        do L = 1, num_suppyrRS
         if ((ranvec_suppyrRS(L).gt.0.d0).and.
     &     (ranvec_suppyrRS(L).le.noisepe_suppyrRS).and.
     &     (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_suppyrRS(72,L) = 0.4d0
          ectr_suppyrRS = ectr_suppyrRS + 1
         else
          curr_suppyrRS(72,L) = 0.d0
         endif 
        end do
      endif


! Call integration routine for suppyrRS cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(25,FILE='data/suppyrrs.txt')
         write( 25, 2501) time
 2501    format(' Entering/Returning INTEGRATE_suppyrRS:t= ',F10.4)
      endif

       CALL INTEGRATE_suppyrRS (O, time, num_suppyrRS,
     &    V_suppyrRS, curr_suppyrRS,
     & gAMPA_suppyrRS, gNMDA_suppyrRS, gGABA_A_suppyrRS,
     & Mg, 
     & gapcon_suppyrRS  ,totaxgj_suppyrRS   ,gjtable_suppyrRS, dt,
     & totaxgj_suppyr, gjtable_suppyr, num_suppyrFRB,
     & vax_suppyrFRB,
     &  chi_suppyrRS,mnaf_suppyrRS,mnap_suppyrRS,
     &  hnaf_suppyrRS,mkdr_suppyrRS,mka_suppyrRS,
     &  hka_suppyrRS,mk2_suppyrRS,hk2_suppyrRS,
     &  mkm_suppyrRS,mkc_suppyrRS,mkahp_suppyrRS,
     &  mcat_suppyrRS,hcat_suppyrRS,mcal_suppyrRS,
     &  mar_suppyrRS,field_1mm_suppyrRS,field_2mm_suppyrRS)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(25,FILE='data/suppyrrs.txt')
         write( 25, 2501) time
      endif


       IF (mod(O,5).eq.0) then
! Set up axonal gj voltage array and broadcast it to node 1
! (FRB cells) and receive FRB array - for mixed gj.
       do L = 1, num_suppyrRS
        vax_suppyrRS (L) = V_suppyrRS (74,L)
       end do

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      ENDIF ! vax set-up, broadcasting and receiving
  

       IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_suppyrRS
        distal_axon_suppyrRS (L) = V_suppyrRS (72,L)
       end do
  
           call mpi_allgather (distal_axon_suppyrRS,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD,info)
 
        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
                        
        ENDIF ! if (mod(O,how_often).eq.0) ....

c         if (mod(O,250).eq.0) then ! write voltages to sysprint
c     write(6,213) time,
c    & distal_axon_suppyrRS  (1),
c    & distal_axon_suppyrFRB (1),
c    & distal_axon_supbask   (1),
c    & distal_axon_supaxax   (1),
c    & distal_axon_supLTS    (1),
c    & distal_axon_spinstell (1),
c    & distal_axon_tuftIB    (1),
c    & distal_axon_tuftRS    (1),
c    & distal_axon_nontuftRS (1),
c    & distal_axon_deepbask  (1),
c    & distal_axon_deepaxax  (1),
c    & distal_axon_deepLTS   (1),
c    & distal_axon_TCR       (1),
c    & distal_axon_nRT       (1)
213    FORMAT(f7.2,14f6.0)
c         endif ! end writing to sysprint



! END thisno = 0

       ELSE IF (THISNO.EQ.1) THEN
c suppyrFRB

         IF (MOD(O,how_often).eq.0) then
c 1st set suppyrFRB synaptic conductances to 0:

          do i = 1, numcomp_suppyrFRB
          do j = 1, num_suppyrFRB
         gAMPA_suppyrFRB(i,j)   = 0.d0 
         gNMDA_suppyrFRB(i,j)   = 0.d0
         gGABA_A_suppyrFRB(i,j) = 0.d0
          end do
          end do

         do L = 1, num_suppyrFRB
c Handle suppyrRS   -> suppyrFRB
      do i = 1, num_suppyrRS_to_suppyrFRB
       j = map_suppyrRS_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_suppyrRS_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_suppyrRS_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_suppyrRS_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> suppyrFRB
      do i = 1, num_suppyrFRB_to_suppyrFRB
       j = map_suppyrFRB_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_suppyrFRB_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_suppyrFRB_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_suppyrFRB_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supbask    -> suppyrFRB
      do i = 1, num_supbask_to_suppyrFRB
       j = map_supbask_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_supbask_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrFRB(k,L)  = gGABA_A_suppyrFRB(k,L) +
     &  gGABA_supbask_to_suppyrFRB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supaxax    -> suppyrFRB
      do i = 1, num_supaxax_to_suppyrFRB
       j = map_supaxax_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_supaxax_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrFRB(k,L)  = gGABA_A_suppyrFRB(k,L) +
     &  gGABA_supaxax_to_suppyrFRB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> suppyrFRB
      do i = 1, num_supLTS_to_suppyrFRB
       j = map_supLTS_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_supLTS_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrFRB(k,L)  = gGABA_A_suppyrFRB(k,L) +
     &  gGABA_supLTS_to_suppyrFRB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> suppyrFRB
      do i = 1, num_spinstell_to_suppyrFRB
       j = map_spinstell_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_spinstell_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_spinstell_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_spinstell_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_spinstell_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> suppyrFRB
      do i = 1, num_tuftIB_to_suppyrFRB
       j = map_tuftIB_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_tuftIB_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_tuftIB_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_tuftIB_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> suppyrFRB
      do i = 1, num_tuftRS_to_suppyrFRB
       j = map_tuftRS_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_tuftRS_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_tuftRS_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_tuftRS_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepaxax   -> suppyrFRB
      do i = 1, num_deepaxax_to_suppyrFRB
       j = map_deepaxax_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrFRB(k,L)  = gGABA_A_suppyrFRB(k,L) +
     &  gGABA_deepaxax_to_suppyrFRB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> suppyrFRB
      do i = 1, num_deepLTS_to_suppyrFRB
       j = map_deepLTS_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_suppyrFRB(k,L)  = gGABA_A_suppyrFRB(k,L) +
     &  gGABA_deepLTS_to_suppyrFRB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> suppyrFRB
      do i = 1, num_TCR_to_suppyrFRB
       j = map_TCR_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_TCR_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_TCR_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_TCR_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_TCR_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> suppyrFRB
      do i = 1, num_nontuftRS_to_suppyrFRB
       j = map_nontuftRS_to_suppyrFRB(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_suppyrFRB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_suppyrFRB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_suppyrFRB(k,L)  = gAMPA_suppyrFRB(k,L) +
     &  gAMPA_nontuftRS_to_suppyrFRB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_nontuftRS_to_suppyrFRB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_suppyrFRB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_suppyrFRB(k,L) = gNMDA_suppyrFRB(k,L) +
     &  gNMDA_nontuftRS_to_suppyrFRB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_suppyrFRB
       if (gNMDA_suppyrFRB(k,L).gt.z)
     &  gNMDA_suppyrFRB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of suppyrFRB
         ENDIF ! if (mod(O,how_often).eq.0)...

! Define currents to suppyrFRB cells, ectopic spikes,
! tonic synaptic conductances

      if (mod(O,200).eq.0) then
       call durand(seed,num_suppyrFRB,ranvec_suppyrFRB) 
        do L = 1, num_suppyrFRB
         if ((ranvec_suppyrFRB(L).gt.0.d0).and.
     &     (ranvec_suppyrFRB(L).le.noisepe_suppyrFRB).and.
     &      (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_suppyrFRB(72,L) = 0.4d0
          ectr_suppyrFRB = ectr_suppyrFRB + 1
         else
          curr_suppyrFRB(72,L) = 0.d0
         endif 
        end do
      endif

! Call integration routine for suppyrFRB cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(26,FILE='data/suppyrfrb.txt')
         write( 26, 2502) time
 2502    format(' Entering/Returning INTEGRATE_:t= ',F10.4)
      endif

       CALL INTEGRATE_suppyrFRB (O, time, num_suppyrFRB,
     &    V_suppyrFRB, curr_suppyrFRB,
     & gAMPA_suppyrFRB, gNMDA_suppyrFRB, gGABA_A_suppyrFRB,
     & Mg, 
     & gapcon_suppyrFRB ,totaxgj_suppyrFRB  ,gjtable_suppyrFRB, dt,
     & totaxgj_suppyr, gjtable_suppyr, num_suppyrRS,
     & vax_suppyrRS,
     &  chi_suppyrFRB,mnaf_suppyrFRB,mnap_suppyrFRB,
     &  hnaf_suppyrFRB,mkdr_suppyrFRB,mka_suppyrFRB,
     &  hka_suppyrFRB,mk2_suppyrFRB,hk2_suppyrFRB,
     &  mkm_suppyrFRB,mkc_suppyrFRB,mkahp_suppyrFRB,
     &  mcat_suppyrFRB,hcat_suppyrFRB,mcal_suppyrFRB,
     &  mar_suppyrFRB,field_1mm_suppyrFRB,field_2mm_suppyrFRB)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(26,FILE='data/suppyrfrb.txt')
         write( 26, 2502) time
      endif

       IF (mod(O,5).eq.0) then
! Set up axonal gj voltage array and broadcast it to node 0
! (RS cells) and receive RS array - for mixed gj.
       do L = 1, num_suppyrFRB
        vax_suppyrFRB (L) = V_suppyrFRB (74,L)
       end do

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      ENDIF ! vax set-up, broadcasting and receiving
  

       IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_suppyrFRB
        distal_axon_suppyrFRB (L) = V_suppyrFRB (72,L)
       end do
  
           call mpi_allgather (distal_axon_suppyrFRB,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD,info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
                        
        ENDIF ! if (mod(O,how_often).eq.0) ....


! END thisno = 1

       ELSE IF (THISNO.EQ.2) THEN
c supbask

        IF (mod(O,how_often).eq.0) then
c 1st set supbask synaptic conductances to 0:

          do i = 1, numcomp_supbask
          do j = 1, num_supbask
         gAMPA_supbask(i,j)     = 0.d0
         gNMDA_supbask(i,j)     = 0.d0
         gGABA_A_supbask(i,j)   = 0.d0
          end do
          end do

         do L = 1, num_supbask  
c Handle suppyrRS   -> supbask
      do i = 1, num_suppyrRS_to_supbask  
       j = map_suppyrRS_to_supbask(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_suppyrRS_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_suppyrRS_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_suppyrRS_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> supbask
      do i = 1, num_suppyrFRB_to_supbask  
       j = map_suppyrFRB_to_supbask(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_suppyrFRB_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_suppyrFRB_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_suppyrFRB_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supbask    -> supbask
      do i = 1, num_supbask_to_supbask  
       j = map_supbask_to_supbask(i,L) ! j = presynaptic cell
       k = com_supbask_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supbask(k,L)  = gGABA_A_supbask(k,L) +
     &  gGABA_supbask_to_supbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> supbask
      do i = 1, num_supLTS_to_supbask  
       j = map_supLTS_to_supbask(i,L) ! j = presynaptic cell
       k = com_supLTS_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supbask(k,L)  = gGABA_A_supbask(k,L) +
     &  gGABA_supLTS_to_supbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> supbask
      do i = 1, num_spinstell_to_supbask  
       j = map_spinstell_to_supbask(i,L) ! j = presynaptic cell
       k = com_spinstell_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_spinstell_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_spinstell_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_spinstell_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> supbask
      do i = 1, num_tuftIB_to_supbask  
       j = map_tuftIB_to_supbask(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_tuftIB_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_tuftIB_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_tuftIB_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> supbask
      do i = 1, num_tuftRS_to_supbask  
       j = map_tuftRS_to_supbask(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_tuftRS_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_tuftRS_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_tuftRS_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepLTS    -> supbask
      do i = 1, num_deepLTS_to_supbask  
       j = map_deepLTS_to_supbask(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supbask(k,L)  = gGABA_A_supbask(k,L) +
     &  gGABA_deepLTS_to_supbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepTCR    -> supbask
      do i = 1, num_TCR_to_supbask  
       j = map_TCR_to_supbask(i,L) ! j = presynaptic cell
       k = com_TCR_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_TCR_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_TCR_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_TCR_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> supbask
      do i = 1, num_nontuftRS_to_supbask  
       j = map_nontuftRS_to_supbask(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_supbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_supbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supbask(k,L)  = gAMPA_supbask(k,L) +
     &  gAMPA_nontuftRS_to_supbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_nontuftRS_to_supbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_supbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supbask(k,L) = gNMDA_supbask(k,L) +
     &  gNMDA_nontuftRS_to_supbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_supbask  
       if (gNMDA_supbask(k,L).gt.z)
     &  gNMDA_supbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of supbask  
        ENDIF  ! if (mod(O,how_often).eq.0) ....

! Define currents to supbask   cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for supbask   cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(27,FILE='data/supbask.txt')
         write( 27, 2503) time
 2503    format(' Entering/Returning INTEGRATE_:t= ',F10.4)
      endif

       CALL INTEGRATE_supbask  (O, time, num_supbask ,
     &    V_supbask , curr_supbask ,
     & gAMPA_supbask , gNMDA_supbask , gGABA_A_supbask ,
     & Mg, 
     & gapcon_supbask   ,totSDgj_supbask    ,gjtable_supbask , dt,
     &  chi_supbask,mnaf_supbask,mnap_supbask,
     &  hnaf_supbask,mkdr_supbask,mka_supbask,
     &  hka_supbask,mk2_supbask,hk2_supbask,
     &  mkm_supbask,mkc_supbask,mkahp_supbask,
     &  mcat_supbask,hcat_supbask,mcal_supbask,
     &  mar_supbask)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(27,FILE='data/supbask.txt')
         write( 27, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

      IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_supbask  
        distal_axon_supbask   (L) = V_supbask   (59,L)
       end do
 
           call mpi_allgather (distal_axon_supbask,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD,info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
           ENDIF  ! if (mod(O,how_often).eq.0) ....

! END thisno = 2

       ELSE IF (THISNO.EQ.3) THEN
c supaxax

         IF (mod(O,how_often).eq.0) then
c 1st set supaxax synaptic conductances to 0:

          do i = 1, numcomp_supaxax
          do j = 1, num_supaxax
         gAMPA_supaxax(i,j)     = 0.d0
         gNMDA_supaxax(i,j)     = 0.d0
         gGABA_A_supaxax(i,j)   = 0.d0
          end do
          end do

         do L = 1, num_supaxax  
c Handle suppyrRS   -> supaxax
      do i = 1, num_suppyrRS_to_supaxax  
       j = map_suppyrRS_to_supaxax(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_suppyrRS_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_suppyrRS_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_suppyrRS_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> supaxax
      do i = 1, num_suppyrFRB_to_supaxax  
       j = map_suppyrFRB_to_supaxax(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_suppyrFRB_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_suppyrFRB_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_suppyrFRB_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supbask    -> supaxax
      do i = 1, num_supbask_to_supaxax  
       j = map_supbask_to_supaxax(i,L) ! j = presynaptic cell
       k = com_supbask_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supaxax(k,L)  = gGABA_A_supaxax(k,L) +
     &  gGABA_supbask_to_supaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> supaxax
      do i = 1, num_supLTS_to_supaxax  
       j = map_supLTS_to_supaxax(i,L) ! j = presynaptic cell
       k = com_supLTS_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supaxax(k,L)  = gGABA_A_supaxax(k,L) +
     &  gGABA_supLTS_to_supaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> supaxax
      do i = 1, num_spinstell_to_supaxax  
       j = map_spinstell_to_supaxax(i,L) ! j = presynaptic cell
       k = com_spinstell_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_spinstell_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_spinstell_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_spinstell_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> supaxax
      do i = 1, num_tuftIB_to_supaxax  
       j = map_tuftIB_to_supaxax(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_tuftIB_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_tuftIB_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_tuftIB_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> supaxax
      do i = 1, num_tuftRS_to_supaxax  
       j = map_tuftRS_to_supaxax(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_tuftRS_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_tuftRS_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_tuftRS_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepLTS    -> supaxax
      do i = 1, num_deepLTS_to_supaxax  
       j = map_deepLTS_to_supaxax(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supaxax(k,L)  = gGABA_A_supaxax(k,L) +
     &  gGABA_deepLTS_to_supaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> supaxax
      do i = 1, num_TCR_to_supaxax  
       j = map_TCR_to_supaxax(i,L) ! j = presynaptic cell
       k = com_TCR_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_TCR_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_TCR_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_TCR_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> supaxax
      do i = 1, num_nontuftRS_to_supaxax  
       j = map_nontuftRS_to_supaxax(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_supaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_supaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supaxax(k,L)  = gAMPA_supaxax(k,L) +
     &  gAMPA_nontuftRS_to_supaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_nontuftRS_to_supaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_supaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supaxax(k,L) = gNMDA_supaxax(k,L) +
     &  gNMDA_nontuftRS_to_supaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_supaxax  
       if (gNMDA_supaxax(k,L).gt.z)
     &  gNMDA_supaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of supaxax  
         ENDIF  ! if (mod(O,how_often).eq.0) ...


! Define currents to supaxax   cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for supaxax   cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(28,FILE='data/supaxax.txt')
         write( 28, 2503) time
      endif

       CALL INTEGRATE_supaxax  (O, time, num_supaxax ,
     &    V_supaxax , curr_supaxax ,
     & gAMPA_supaxax , gNMDA_supaxax , gGABA_A_supaxax ,
     & Mg, 
     & gapcon_supaxax   ,totSDgj_supaxax    ,gjtable_supaxax , dt,
     &  chi_supaxax,mnaf_supaxax,mnap_supaxax,
     &  hnaf_supaxax,mkdr_supaxax,mka_supaxax,
     &  hka_supaxax,mk2_supaxax,hk2_supaxax,
     &  mkm_supaxax,mkc_supaxax,mkahp_supaxax,
     &  mcat_supaxax,hcat_supaxax,mcal_supaxax,
     &  mar_supaxax)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(28,FILE='data/supaxax.txt')
         write( 28, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_supaxax  
        distal_axon_supaxax   (L) = V_supaxax   (59,L)
       end do
  
           call mpi_allgather (distal_axon_supaxax, 
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
             ENDIF !  if (mod(O,how_often).eq.0) ...

! END thisno = 3

       ELSE IF (THISNO.EQ.4) THEN
c supLTS

          IF (mod(O,how_often).eq.0) then
c 1st set supLTS  synaptic conductances to 0:

          do i = 1, numcomp_supLTS
          do j = 1, num_supLTS
         gAMPA_supLTS(i,j)      = 0.d0
         gNMDA_supLTS(i,j)      = 0.d0
         gGABA_A_supLTS(i,j)    = 0.d0
          end do
          end do

         do L = 1, num_supLTS   
c Handle suppyrRS   -> supLTS
      do i = 1, num_suppyrRS_to_supLTS   
       j = map_suppyrRS_to_supLTS(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_suppyrRS_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_suppyrRS_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_suppyrRS_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> supLTS
      do i = 1, num_suppyrFRB_to_supLTS   
       j = map_suppyrFRB_to_supLTS(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_suppyrFRB_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_suppyrFRB_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_suppyrFRB_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supbask    -> supLTS
      do i = 1, num_supbask_to_supLTS  
       j = map_supbask_to_supLTS(i,L) ! j = presynaptic cell
       k = com_supbask_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supLTS(k,L)  = gGABA_A_supLTS(k,L) +
     &  gGABA_supbask_to_supLTS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> supLTS
      do i = 1, num_supLTS_to_supLTS  
       j = map_supLTS_to_supLTS(i,L) ! j = presynaptic cell
       k = com_supLTS_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supLTS(k,L)  = gGABA_A_supLTS(k,L) +
     &  gGABA_supLTS_to_supLTS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> supLTS
      do i = 1, num_spinstell_to_supLTS  
       j = map_spinstell_to_supLTS(i,L) ! j = presynaptic cell
       k = com_spinstell_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_spinstell_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_spinstell_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_spinstell_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> supLTS
      do i = 1, num_tuftIB_to_supLTS  
       j = map_tuftIB_to_supLTS(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_tuftIB_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_tuftIB_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_tuftIB_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> supLTS
      do i = 1, num_tuftRS_to_supLTS  
       j = map_tuftRS_to_supLTS(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_tuftRS_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_tuftRS_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_tuftRS_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepLTS    -> supLTS
      do i = 1, num_deepLTS_to_supLTS   
       j = map_deepLTS_to_supLTS(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_supLTS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_supLTS(k,L)  = gGABA_A_supLTS(k,L) +
     &  gGABA_deepLTS_to_supLTS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle nontuftRS  -> supLTS
      do i = 1, num_nontuftRS_to_supLTS  
       j = map_nontuftRS_to_supLTS(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_supLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_supLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_supLTS(k,L)  = gAMPA_supLTS(k,L) +
     &  gAMPA_nontuftRS_to_supLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_nontuftRS_to_supLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_supLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_supLTS(k,L) = gNMDA_supLTS(k,L) +
     &  gNMDA_nontuftRS_to_supLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_supLTS  
       if (gNMDA_supLTS(k,L).gt.z)
     &  gNMDA_supLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of supLTS   
        ENDIF  ! if (mod(O,how_often).eq.0) ...

! Define currents to supLTS    cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for supLTS    cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(29,FILE='data/supLTS.txt')
         write( 29, 2503) time
      endif

       CALL INTEGRATE_supLTS   (O, time, num_supLTS  ,
     &    V_supLTS  , curr_supLTS  ,
     & gAMPA_supLTS  , gNMDA_supLTS  , gGABA_A_supLTS  ,
     & Mg, 
     & gapcon_supLTS    ,totSDgj_supLTS     ,gjtable_supLTS  , dt,
     &  chi_supLTS,mnaf_supLTS,mnap_supLTS,
     &  hnaf_supLTS,mkdr_supLTS,mka_supLTS,
     &  hka_supLTS,mk2_supLTS,hk2_supLTS,
     &  mkm_supLTS,mkc_supLTS,mkahp_supLTS,
     &  mcat_supLTS,hcat_supLTS,mcal_supLTS,
     &  mar_supLTS)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(29,FILE='data/supLTS.txt')
         write( 29, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_supLTS   
        distal_axon_supLTS    (L) = V_supLTS    (59,L)
       end do
  
           call mpi_allgather (distal_axon_supLTS,   
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
         ENDIF  ! if (mod(O,how_often).eq.0) ...

! END thisno = 4
 
       ELSE IF (THISNO.EQ.5) THEN
c spinstell

       IF (mod(O,how_often).eq.0) then
c 1st set spinstell synaptic conductances to 0:

          do i = 1, numcomp_spinstell
          do j = 1, num_spinstell
         gAMPA_spinstell(i,j)   = 0.d0
         gNMDA_spinstell(i,j)   = 0.d0
         gGABA_A_spinstell(i,j) = 0.d0
          end do
          end do

         do L = 1, num_spinstell
c Handle suppyrRS    -> spinstell
      do i = 1, num_suppyrRS_to_spinstell
       j = map_suppyrRS_to_spinstell(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_suppyrRS_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_suppyrRS_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_suppyrRS_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB   -> spinstell
      do i = 1, num_suppyrFRB_to_spinstell
       j = map_suppyrFRB_to_spinstell(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_suppyrFRB_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_suppyrFRB_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_suppyrFRB_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supbask     -> spinstell
      do i = 1, num_supbask_to_spinstell
       j = map_supbask_to_spinstell(i,L) ! j = presynaptic cell
       k = com_supbask_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_supbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supbask_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_supbask_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supaxax     -> spinstell
      do i = 1, num_supaxax_to_spinstell
       j = map_supaxax_to_spinstell(i,L) ! j = presynaptic cell
       k = com_supaxax_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_supaxax_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS      -> spinstell
      do i = 1, num_supLTS_to_spinstell
       j = map_supLTS_to_spinstell(i,L) ! j = presynaptic cell
       k = com_supLTS_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_supLTS_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell   -> spinstell
      do i = 1, num_spinstell_to_spinstell
       j = map_spinstell_to_spinstell(i,L) ! j = presynaptic cell
       k = com_spinstell_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_spinstell_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_spinstell_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_spinstell_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB      -> spinstell
      do i = 1, num_tuftIB_to_spinstell
       j = map_tuftIB_to_spinstell(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_tuftIB_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_tuftIB_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_tuftIB_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS      -> spinstell
      do i = 1, num_tuftRS_to_spinstell
       j = map_tuftRS_to_spinstell(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_tuftRS_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_tuftRS_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_tuftRS_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask    -> spinstell
      do i = 1, num_deepbask_to_spinstell
       j = map_deepbask_to_spinstell(i,L) ! j = presynaptic cell
       k = com_deepbask_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_deepbask_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepaxax    -> spinstell
      do i = 1, num_deepaxax_to_spinstell
       j = map_deepaxax_to_spinstell(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_deepaxax_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS     -> spinstell
      do i = 1, num_deepLTS_to_spinstell
       j = map_deepLTS_to_spinstell(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_spinstell(k,L)  = gGABA_A_spinstell(k,L) +
     &  gGABA_deepLTS_to_spinstell * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR         -> spinstell
      do i = 1, num_TCR_to_spinstell
       j = map_TCR_to_spinstell(i,L) ! j = presynaptic cell
       k = com_TCR_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_TCR_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_TCR_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_TCR_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_spinstell 
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS   -> spinstell
      do i = 1, num_nontuftRS_to_spinstell
       j = map_nontuftRS_to_spinstell(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_spinstell(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_spinstell
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_spinstell(k,L)  = gAMPA_spinstell(k,L) +
     &  gAMPA_nontuftRS_to_spinstell * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_nontuftRS_to_spinstell * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_spinstell
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_spinstell(k,L) = gNMDA_spinstell(k,L) +
     &  gNMDA_nontuftRS_to_spinstell * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_spinstell
       if (gNMDA_spinstell(k,L).gt.z)
     &  gNMDA_spinstell(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of spinstell
       ENDIF ! if (mod(O,how_often).eq.0) ...

! Define currents to spinstell cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for spinstell cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(30,FILE='data/spinstell.txt')
         write( 30, 2503) time
      endif

       CALL INTEGRATE_spinstell (O, time, num_spinstell,
     &    V_spinstell, curr_spinstell,
     & gAMPA_spinstell, gNMDA_spinstell, gGABA_A_spinstell,
     & Mg, 
     & gapcon_spinstell,totaxgj_spinstell,gjtable_spinstell, dt,
     &  chi_spinstell,mnaf_spinstell,mnap_spinstell,
     &  hnaf_spinstell,mkdr_spinstell,mka_spinstell,
     &  hka_spinstell,mk2_spinstell,hk2_spinstell,
     &  mkm_spinstell,mkc_spinstell,mkahp_spinstell,
     &  mcat_spinstell,hcat_spinstell,mcal_spinstell,
     &  mar_spinstell)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(30,FILE='data/spinstell.txt')
         write( 30, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

       IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_spinstell
        distal_axon_spinstell (L) = V_spinstell (57,L)
       end do
  
           call mpi_allgather (distal_axon_spinstell,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
           ENDIF !  if (mod(O,how_often).eq.0) ...

! END thisno = 5

       ELSE IF (THISNO.EQ.6) THEN
c tuftIB
         IF (mod(O,how_often).eq.0) then
c 1st set tuftIB    synaptic conductances to 0:

          do i = 1, numcomp_tuftIB
          do j = 1, num_tuftIB
         gAMPA_tuftIB(i,j)      = 0.d0
         gNMDA_tuftIB(i,j)      = 0.d0
         gGABA_A_tuftIB(i,j)    = 0.d0
          end do
          end do

         do L = 1, num_tuftIB   
c Handle suppyrRS    -> tuftIB
      do i = 1, num_suppyrRS_to_tuftIB   
       j = map_suppyrRS_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_suppyrRS_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_suppyrRS_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_tuftIB   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_suppyrRS_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_tuftIB
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB   -> tuftIB
      do i = 1, num_suppyrFRB_to_tuftIB   
       j = map_suppyrFRB_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_suppyrFRB_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_suppyrFRB_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_tuftIB   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_suppyrFRB_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_tuftIB
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supaxax     -> tuftIB
      do i = 1, num_supaxax_to_tuftIB   
       j = map_supaxax_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_supaxax_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftIB(k,L)  = gGABA_A_tuftIB(k,L) +
     &  gGABA_supaxax_to_tuftIB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS      -> tuftIB
      do i = 1, num_supLTS_to_tuftIB   
       j = map_supLTS_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_supLTS_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftIB(k,L)  = gGABA_A_tuftIB(k,L) +
     &  gGABA_supLTS_to_tuftIB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell   -> tuftIB
      do i = 1, num_spinstell_to_tuftIB  
       j = map_spinstell_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_spinstell_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_tuftIB  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_spinstell_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_spinstell_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_tuftIB  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_spinstell_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_tuftIB  
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB      -> tuftIB
      do i = 1, num_tuftIB_to_tuftIB  
       j = map_tuftIB_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_tuftIB  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_tuftIB_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_tuftIB_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_tuftIB  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_tuftIB_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_tuftIB  
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS      -> tuftIB
      do i = 1, num_tuftRS_to_tuftIB   
       j = map_tuftRS_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_tuftIB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_tuftRS_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_tuftRS_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_tuftIB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_tuftRS_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_tuftIB   
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask    -> tuftIB
      do i = 1, num_deepbask_to_tuftIB   
       j = map_deepbask_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_deepbask_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftIB(k,L)  = gGABA_A_tuftIB(k,L) +
     &  gGABA_deepbask_to_tuftIB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepaxax    -> tuftIB
      do i = 1, num_deepaxax_to_tuftIB   
       j = map_deepaxax_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftIB(k,L)  = gGABA_A_tuftIB(k,L) +
     &  gGABA_deepaxax_to_tuftIB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS     -> tuftIB
      do i = 1, num_deepLTS_to_tuftIB   
       j = map_deepLTS_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftIB(k,L)  = gGABA_A_tuftIB(k,L) +
     &  gGABA_deepLTS_to_tuftIB * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR         -> tuftIB
      do i = 1, num_TCR_to_tuftIB
       j = map_TCR_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_TCR_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_tuftIB
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_TCR_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_TCR_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_tuftIB
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_TCR_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_tuftIB 
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS   -> tuftIB
      do i = 1, num_nontuftRS_to_tuftIB
       j = map_nontuftRS_to_tuftIB(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_tuftIB(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_tuftIB   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftIB(k,L)  = gAMPA_tuftIB(k,L) +
     &  gAMPA_nontuftRS_to_tuftIB * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_nontuftRS_to_tuftIB * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_tuftIB   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftIB(k,L) = gNMDA_tuftIB(k,L) +
     &  gNMDA_nontuftRS_to_tuftIB * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_tuftIB   
       if (gNMDA_tuftIB(k,L).gt.z)
     &  gNMDA_tuftIB(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of tuftIB   
         ENDIF  ! if (mod(O,how_often).eq.0) ....

! Define currents to tuftIB    cells, ectopic spikes,
! tonic synaptic conductances

      if (mod(O,200).eq.0) then
       call durand(seed,num_tuftIB  ,ranvec_tuftIB  ) 
        do L = 1, num_tuftIB  
         if ((ranvec_tuftIB  (L).gt.0.d0).and.
     &     (ranvec_tuftIB  (L).le.noisepe_tuftIB  ).and.
     &     (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_tuftIB  (60,L) = 0.4d0
          ectr_tuftIB   = ectr_tuftIB   + 1
         else
          curr_tuftIB  (60,L) = 0.d0
         endif 
        end do
      endif

! Call integration routine for tuftIB    cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(31,FILE='data/tuftib.txt')
         write( 31, 2503) time
      endif

       CALL INTEGRATE_tuftIB (O, time, num_tuftIB,
     &    V_tuftIB, curr_tuftIB,
     & gAMPA_tuftIB, gNMDA_tuftIB, gGABA_A_tuftIB,
     & Mg, 
     & gapcon_tuftIB,totaxgj_tuftIB,gjtable_tuftIB, dt,
     & totaxgj_tuft  , gjtable_tuft  , num_tuftRS   ,
     & vax_tuftRS   ,
     &  chi_tuftIB,mnaf_tuftIB,mnap_tuftIB,
     &  hnaf_tuftIB,mkdr_tuftIB,mka_tuftIB,
     &  hka_tuftIB,mk2_tuftIB,hk2_tuftIB,
     &  mkm_tuftIB,mkc_tuftIB,mkahp_tuftIB,
     &  mcat_tuftIB,hcat_tuftIB,mcal_tuftIB,
     &  mar_tuftIB,field_1mm_tuftIB,field_2mm_tuftIB)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(31,FILE='data/tuftib.txt')
         write( 31, 2503) time
      endif

       IF (mod(O,5).eq.0) then
! Set up axonal gj voltage array and broadcast it to node 7
! (tuftRS cells) and receive tuftRS array - for mixed gj.
       do L = 1, num_tuftIB  
        vax_tuftIB (L) = V_tuftIB (61,L)
       end do

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)
      
      ENDIF ! vax set-up, broadcasting and receiving

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_tuftIB   
        distal_axon_tuftIB    (L) = V_tuftIB    (60,L)
       end do
  
           call mpi_allgather (distal_axon_tuftIB,  
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
           ENDIF  ! if (mod(O,how_often).eq.0) ...

! END thisno = 6

       ELSE IF (THISNO.EQ.7) THEN
c tuftRS

         IF (mod(O,how_often).eq.0) then
c 1st set tuftRS    synaptic conductances to 0:

          do i = 1, numcomp_tuftRS
          do j = 1, num_tuftRS
         gAMPA_tuftRS(i,j)      = 0.d0 
         gNMDA_tuftRS(i,j)      = 0.d0
         gGABA_A_tuftRS(i,j)    = 0.d0
          end do
          end do

         do L = 1, num_tuftRS   
c Handle suppyrRS    -> tuftRS
      do i = 1, num_suppyrRS_to_tuftRS   
       j = map_suppyrRS_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_suppyrRS_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_suppyrRS_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_tuftRS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_suppyrRS_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_tuftRS
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB   -> tuftRS 
      do i = 1, num_suppyrFRB_to_tuftRS   
       j = map_suppyrFRB_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_suppyrFRB_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_suppyrFRB_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_tuftRS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_suppyrFRB_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_tuftRS
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supaxax     -> tuftRS
      do i = 1, num_supaxax_to_tuftRS   
       j = map_supaxax_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_supaxax_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftRS(k,L)  = gGABA_A_tuftRS(k,L) +
     &  gGABA_supaxax_to_tuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS      -> tuftRS
      do i = 1, num_supLTS_to_tuftRS   
       j = map_supLTS_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_supLTS_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftRS(k,L)  = gGABA_A_tuftRS(k,L) +
     &  gGABA_supLTS_to_tuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell   -> tuftRS
      do i = 1, num_spinstell_to_tuftRS  
       j = map_spinstell_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_spinstell_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_tuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_spinstell_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_spinstell_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_tuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_spinstell_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_tuftRS  
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB      -> tuftRS
      do i = 1, num_tuftIB_to_tuftRS  
       j = map_tuftIB_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_tuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_tuftIB_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_tuftIB_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_tuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_tuftIB_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_tuftRS  
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS      -> tuftRS
      do i = 1, num_tuftRS_to_tuftRS  
       j = map_tuftRS_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_tuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_tuftRS_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_tuftRS_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_tuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_tuftRS_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_tuftRS  
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask    -> tuftRS
      do i = 1, num_deepbask_to_tuftRS   
       j = map_deepbask_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_deepbask_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftRS(k,L)  = gGABA_A_tuftRS(k,L) +
     &  gGABA_deepbask_to_tuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepaxax    -> tuftRS
      do i = 1, num_deepaxax_to_tuftRS   
       j = map_deepaxax_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftRS(k,L)  = gGABA_A_tuftRS(k,L) +
     &  gGABA_deepaxax_to_tuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS     -> tuftRS
      do i = 1, num_deepLTS_to_tuftRS   
       j = map_deepLTS_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_tuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_tuftRS(k,L)  = gGABA_A_tuftRS(k,L) +
     &  gGABA_deepLTS_to_tuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR         -> tuftRS
      do i = 1, num_TCR_to_tuftRS
       j = map_TCR_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_TCR_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_tuftRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_TCR_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_TCR_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_tuftRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_TCR_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_tuftRS 
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS   -> tuftRS
      do i = 1, num_nontuftRS_to_tuftRS  
       j = map_nontuftRS_to_tuftRS(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_tuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_tuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_tuftRS(k,L)  = gAMPA_tuftRS(k,L) +
     &  gAMPA_nontuftRS_to_tuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_nontuftRS_to_tuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_tuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_tuftRS(k,L) = gNMDA_tuftRS(k,L) +
     &  gNMDA_nontuftRS_to_tuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_tuftRS  
       if (gNMDA_tuftRS(k,L).gt.z)
     &  gNMDA_tuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of tuftRS   
        ENDIF  ! if (mod(O,how_often).eq.0) ...

! Define currents to tuftRS    cells, ectopic spikes,
! tonic synaptic conductances
      if (mod(O,200).eq.0) then
       call durand(seed,num_tuftRS  ,ranvec_tuftRS  ) 
        do L = 1, num_tuftRS  
         if ((ranvec_tuftRS  (L).gt.0.d0).and.
     &     (ranvec_tuftRS  (L).le.noisepe_tuftRS  ).and.
     &     (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_tuftRS  (60,L) = 0.4d0
          ectr_tuftRS   = ectr_tuftRS   + 1
         else
          curr_tuftRS  (60,L) = 0.d0
         endif 
        end do
      endif
! Call integration routine for tuftRS    cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(32,FILE='data/tuftRS.txt')
         write( 32, 2503) time
      endif
       CALL INTEGRATE_tuftRS (O, time, num_tuftRS,
     &    V_tuftRS, curr_tuftRS,
     & gAMPA_tuftRS, gNMDA_tuftRS, gGABA_A_tuftRS,
     & Mg, 
     & gapcon_tuftRS,totaxgj_tuftRS,gjtable_tuftRS, dt,
     & totaxgj_tuft  , gjtable_tuft  , num_tuftIB   ,
     & vax_tuftIB   ,
     &  chi_tuftRS,mnaf_tuftRS,mnap_tuftRS,
     &  hnaf_tuftRS,mkdr_tuftRS,mka_tuftRS,
     &  hka_tuftRS,mk2_tuftRS,hk2_tuftRS,
     &  mkm_tuftRS,mkc_tuftRS,mkahp_tuftRS,
     &  mcat_tuftRS,hcat_tuftRS,mcal_tuftRS,
     &  mar_tuftRS,field_1mm_tuftRS,field_2mm_tuftRS)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(32,FILE='data/tuftRS.txt')
         write( 32, 2503) time
      endif

       IF (mod(O,5).eq.0) then
! Set up axonal gj voltage array and broadcast it to node 6
! (tuftIB cells) and receive tuftIB array - for mixed gj.
       do L = 1, num_tuftRS  
        vax_tuftRS (L) = V_tuftRS (61,L)
       end do

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      ENDIF ! vax set-up, broadcasting and receiving
  

       IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_tuftRS   
        distal_axon_tuftRS    (L) = V_tuftRS    (60,L)
       end do
           call mpi_allgather (distal_axon_tuftRS,  
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do

        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do

        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
         ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 7

       ELSE IF (THISNO.EQ.8) THEN
c nontuftRS

         IF (mod(O,how_often).eq.0) then
c 1st set nontuftRS synaptic conductances to 0:

          do i = 1, numcomp_nontuftRS
          do j = 1, num_nontuftRS
         gAMPA_nontuftRS(i,j)   = 0.d0 
         gNMDA_nontuftRS(i,j)   = 0.d0 
         gGABA_A_nontuftRS(i,j) = 0.d0
          end do
          end do

         do L = 1, num_nontuftRS   
c Handle suppyrRS   -> nontuftRS
      do i = 1, num_suppyrRS_to_nontuftRS   
       j = map_suppyrRS_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_suppyrRS_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_suppyrRS_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_nontuftRS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_suppyrRS_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_nontuftRS
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> nontuftRS
      do i = 1, num_suppyrFRB_to_nontuftRS   
       j = map_suppyrFRB_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_suppyrFRB_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_suppyrFRB_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_nontuftRS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_suppyrFRB_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_nontuftRS
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supaxax    -> nontuftRS
      do i = 1, num_supaxax_to_nontuftRS   
       j = map_supaxax_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_supaxax_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_supaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supaxax_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_nontuftRS(k,L)  = gGABA_A_nontuftRS(k,L) +
     &  gGABA_supaxax_to_nontuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle supLTS     -> nontuftRS
      do i = 1, num_supLTS_to_nontuftRS   
       j = map_supLTS_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_supLTS_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_nontuftRS(k,L)  = gGABA_A_nontuftRS(k,L) +
     &  gGABA_supLTS_to_nontuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> nontuftRS
      do i = 1, num_spinstell_to_nontuftRS  
       j = map_spinstell_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_spinstell_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_nontuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_spinstell_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_spinstell_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_nontuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_spinstell_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_nontuftRS  
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> nontuftRS
      do i = 1, num_tuftIB_to_nontuftRS  
       j = map_tuftIB_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_nontuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_tuftIB_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_tuftIB_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_nontuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_tuftIB_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_nontuftRS  
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> nontuftRS
      do i = 1, num_tuftRS_to_nontuftRS  
       j = map_tuftRS_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_nontuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_tuftRS_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_tuftRS_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_nontuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_tuftRS_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_nontuftRS  
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask   -> nontuftRS
      do i = 1, num_deepbask_to_nontuftRS   
       j = map_deepbask_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_deepbask_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_nontuftRS(k,L)  = gGABA_A_nontuftRS(k,L) +
     &  gGABA_deepbask_to_nontuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepaxax   -> nontuftRS
      do i = 1, num_deepaxax_to_nontuftRS   
       j = map_deepaxax_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_deepaxax_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepaxax(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepaxax(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepaxax_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_nontuftRS(k,L)  = gGABA_A_nontuftRS(k,L) +
     &  gGABA_deepaxax_to_nontuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> nontuftRS
      do i = 1, num_deepLTS_to_nontuftRS   
       j = map_deepLTS_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_nontuftRS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_nontuftRS(k,L)  = gGABA_A_nontuftRS(k,L) +
     &  gGABA_deepLTS_to_nontuftRS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> nontuftRS
      do i = 1, num_TCR_to_nontuftRS
       j = map_TCR_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_TCR_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_nontuftRS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_TCR_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_TCR_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_nontuftRS
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_TCR_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_nontuftRS 
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> nontuftRS
      do i = 1, num_nontuftRS_to_nontuftRS  
       j = map_nontuftRS_to_nontuftRS(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_nontuftRS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_nontuftRS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nontuftRS(k,L)  = gAMPA_nontuftRS(k,L) +
     &  gAMPA_nontuftRS_to_nontuftRS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_nontuftRS_to_nontuftRS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_nontuftRS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nontuftRS(k,L) = gNMDA_nontuftRS(k,L) +
     &  gNMDA_nontuftRS_to_nontuftRS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_nontuftRS  
       if (gNMDA_nontuftRS(k,L).gt.z)
     &  gNMDA_nontuftRS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of nontuftRS   
          ENDIF  ! if (mod(O,how_often).eq.0) ...

! Define currents to nontuftRS    cells, ectopic spikes,
! tonic synaptic conductances

      if (mod(O,200).eq.0) then
       call durand(seed,num_nontuftRS  ,ranvec_nontuftRS  ) 
        do L = 1, num_nontuftRS  
         if ((ranvec_nontuftRS  (L).gt.0.d0).and.
     &     (ranvec_nontuftRS  (L).le.noisepe_nontuftRS  ).and.
     &     (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_nontuftRS  (48,L) = 0.4d0
          ectr_nontuftRS   = ectr_nontuftRS   + 1
         else
          curr_nontuftRS  (48,L) = 0.d0
         endif 
        end do
      endif

! Call integration routine for nontuftRS    cells

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(33,FILE='data/nontuftRS.txt')
         write( 33, 2503) time
      endif

       CALL INTEGRATE_nontuftRS (O, time, num_nontuftRS,
     &    V_nontuftRS, curr_nontuftRS,
     & gAMPA_nontuftRS, gNMDA_nontuftRS, gGABA_A_nontuftRS,
     & Mg, 
     & gapcon_nontuftRS,totaxgj_nontuftRS,gjtable_nontuftRS, dt,
     &  chi_nontuftRS,mnaf_nontuftRS,mnap_nontuftRS,
     &  hnaf_nontuftRS,mkdr_nontuftRS,mka_nontuftRS,
     &  hka_nontuftRS,mk2_nontuftRS,hk2_nontuftRS,
     &  mkm_nontuftRS,mkc_nontuftRS,mkahp_nontuftRS,
     &  mcat_nontuftRS,hcat_nontuftRS,mcal_nontuftRS,
     &  mar_nontuftRS,field_1mm_nontuftRS,field_2mm_nontuftRS)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(33,FILE='data/nontuftRS.txt')
         write( 33, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_nontuftRS   
        distal_axon_nontuftRS    (L) = V_nontuftRS    (48,L)
       end do
  
           call mpi_allgather (distal_axon_nontuftRS,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
         ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 8

       ELSE IF (THISNO.EQ.9) THEN
c deepbask

          IF (mod(O,how_often).eq.0) then
c 1st set deepbask  synaptic conductances to 0:

          do i = 1, numcomp_deepbask
          do j = 1, num_deepbask
         gAMPA_deepbask(i,j)    = 0.d0
         gNMDA_deepbask(i,j)    = 0.d0
         gGABA_A_deepbask(i,j)  = 0.d0
          end do
          end do

         do L = 1, num_deepbask    
c Handle suppyrRS   -> deepbask
      do i = 1, num_suppyrRS_to_deepbask  
       j = map_suppyrRS_to_deepbask(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_deepbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_suppyrRS_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_suppyrRS_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_deepbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_suppyrRS_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> deepbask
      do i = 1, num_suppyrFRB_to_deepbask  
       j = map_suppyrFRB_to_deepbask(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_deepbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_suppyrFRB_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_suppyrFRB_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_deepbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_suppyrFRB_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supLTS     -> deepbask
      do i = 1, num_supLTS_to_deepbask    
       j = map_supLTS_to_deepbask(i,L) ! j = presynaptic cell
       k = com_supLTS_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_deepbask    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepbask(k,L)  = gGABA_A_deepbask(k,L) +
     &  gGABA_supLTS_to_deepbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> deepbask
      do i = 1, num_spinstell_to_deepbask   
       j = map_spinstell_to_deepbask(i,L) ! j = presynaptic cell
       k = com_spinstell_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_deepbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_spinstell_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_spinstell_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_deepbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_spinstell_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> deepbask
      do i = 1, num_tuftIB_to_deepbask   
       j = map_tuftIB_to_deepbask(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_deepbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_tuftIB_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_tuftIB_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_deepbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_tuftIB_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> deepbask
      do i = 1, num_tuftRS_to_deepbask   
       j = map_tuftRS_to_deepbask(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_deepbask  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_tuftRS_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_tuftRS_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_deepbask  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_tuftRS_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask   -> deepbask
      do i = 1, num_deepbask_to_deepbask    
       j = map_deepbask_to_deepbask(i,L) ! j = presynaptic cell
       k = com_deepbask_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_deepbask    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepbask(k,L)  = gGABA_A_deepbask(k,L) +
     &  gGABA_deepbask_to_deepbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> deepbask
      do i = 1, num_deepLTS_to_deepbask    
       j = map_deepLTS_to_deepbask(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_deepbask    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepbask(k,L)  = gGABA_A_deepbask(k,L) +
     &  gGABA_deepLTS_to_deepbask * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> deepbask
      do i = 1, num_TCR_to_deepbask 
       j = map_TCR_to_deepbask(i,L) ! j = presynaptic cell
       k = com_TCR_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_deepbask 
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_TCR_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_TCR_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_deepbask 
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_TCR_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_deepbask  
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> deepbask
      do i = 1, num_nontuftRS_to_deepbask
       j = map_nontuftRS_to_deepbask(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_deepbask(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_deepbask
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepbask(k,L)  = gAMPA_deepbask(k,L) +
     &  gAMPA_nontuftRS_to_deepbask * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_nontuftRS_to_deepbask * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_deepbask
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepbask(k,L) = gNMDA_deepbask(k,L) +
     &  gNMDA_nontuftRS_to_deepbask * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_deepbask
       if (gNMDA_deepbask(k,L).gt.z)
     &  gNMDA_deepbask(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of deepbask    
         ENDIF ! if (mod(O,how_often).eq.0) ...

! Define currents to deepbask     cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for deepbask     cells

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(34,FILE='data/deepbask.txt')
         write( 34, 2503) time
      endif

       CALL INTEGRATE_deepbask  (O, time, num_deepbask ,
     &    V_deepbask , curr_deepbask ,
     & gAMPA_deepbask, gNMDA_deepbask, gGABA_A_deepbask,
     & Mg, 
     & gapcon_deepbask  ,totSDgj_deepbask   ,gjtable_deepbask, dt,
     &  chi_deepbask,mnaf_deepbask,mnap_deepbask,
     &  hnaf_deepbask,mkdr_deepbask,mka_deepbask,
     &  hka_deepbask,mk2_deepbask,hk2_deepbask,
     &  mkm_deepbask,mkc_deepbask,mkahp_deepbask,
     &  mcat_deepbask,hcat_deepbask,mcal_deepbask,
     &  mar_deepbask)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(34,FILE='data/deepbask.txt')
         write( 34, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_deepbask    
        distal_axon_deepbask     (L) = V_deepbask     (59,L)
       end do
  
           call mpi_allgather (distal_axon_deepbask,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
           ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 9

       ELSE IF (THISNO.EQ.10) THEN
c deepaxax

        IF (mod(O,how_often).eq.0) then
c 1st set deepaxax  synaptic conductances to 0:

          do i = 1, numcomp_deepaxax
          do j = 1, num_deepaxax
         gAMPA_deepaxax(i,j)    = 0.d0
         gNMDA_deepaxax(i,j)    = 0.d0
         gGABA_A_deepaxax(i,j)  = 0.d0 
          end do
          end do

         do L = 1, num_deepaxax    
c Handle suppyrRS   -> deepaxax
      do i = 1, num_suppyrRS_to_deepaxax  
       j = map_suppyrRS_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_deepaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_suppyrRS_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_suppyrRS_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_deepaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_suppyrRS_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> deepaxax
      do i = 1, num_suppyrFRB_to_deepaxax  
       j = map_suppyrFRB_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_deepaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_suppyrFRB_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_suppyrFRB_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_deepaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_suppyrFRB_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supLTS     -> deepaxax
      do i = 1, num_supLTS_to_deepaxax    
       j = map_supLTS_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_supLTS_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_deepaxax    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepaxax(k,L)  = gGABA_A_deepaxax(k,L) +
     &  gGABA_supLTS_to_deepaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle spinstell  -> deepaxax
      do i = 1, num_spinstell_to_deepaxax   
       j = map_spinstell_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_spinstell_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_deepaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_spinstell_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_spinstell_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_deepaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_spinstell_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> deepaxax
      do i = 1, num_tuftIB_to_deepaxax   
       j = map_tuftIB_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_deepaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_tuftIB_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_tuftIB_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_deepaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_tuftIB_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> deepaxax
      do i = 1, num_tuftRS_to_deepaxax   
       j = map_tuftRS_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_deepaxax  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_tuftRS_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_tuftRS_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_deepaxax  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_tuftRS_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask   -> deepaxax
      do i = 1, num_deepbask_to_deepaxax    
       j = map_deepbask_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_deepbask_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_deepaxax    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepaxax(k,L)  = gGABA_A_deepaxax(k,L) +
     &  gGABA_deepbask_to_deepaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> deepaxax
      do i = 1, num_deepLTS_to_deepaxax    
       j = map_deepLTS_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_deepaxax    
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepaxax(k,L)  = gGABA_A_deepaxax(k,L) +
     &  gGABA_deepLTS_to_deepaxax * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle TCR        -> deepaxax
      do i = 1, num_TCR_to_deepaxax 
       j = map_TCR_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_TCR_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime - thal_cort_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_TCR_to_deepaxax 
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_TCR_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_TCR_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_deepaxax 
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_TCR_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_deepaxax  
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


c Handle nontuftRS  -> deepaxax
      do i = 1, num_nontuftRS_to_deepaxax
       j = map_nontuftRS_to_deepaxax(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_deepaxax(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_deepaxax
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepaxax(k,L)  = gAMPA_deepaxax(k,L) +
     &  gAMPA_nontuftRS_to_deepaxax * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_nontuftRS_to_deepaxax * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_deepaxax
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepaxax(k,L) = gNMDA_deepaxax(k,L) +
     &  gNMDA_nontuftRS_to_deepaxax * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_deepaxax
       if (gNMDA_deepaxax(k,L).gt.z)
     &  gNMDA_deepaxax(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of deepaxax    
        ENDIF  !  if (mod(O,how_often).eq.0) ...

! Define currents to deepaxax     cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for deepaxax     cells

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(35,FILE='data/deepaxax.txt')
         write( 35, 2503) time
      endif

       CALL INTEGRATE_deepaxax  (O, time, num_deepaxax ,
     &    V_deepaxax , curr_deepaxax ,
     & gAMPA_deepaxax, gNMDA_deepaxax, gGABA_A_deepaxax,
     & Mg, 
     & gapcon_deepaxax  ,totSDgj_deepaxax   ,gjtable_deepaxax, dt,
     &  chi_deepaxax,mnaf_deepaxax,mnap_deepaxax,
     &  hnaf_deepaxax,mkdr_deepaxax,mka_deepaxax,
     &  hka_deepaxax,mk2_deepaxax,hk2_deepaxax,
     &  mkm_deepaxax,mkc_deepaxax,mkahp_deepaxax,
     &  mcat_deepaxax,hcat_deepaxax,mcal_deepaxax,
     &  mar_deepaxax)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(35,FILE='data/deepaxax.txt')
         write( 35, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_deepaxax    
        distal_axon_deepaxax     (L) = V_deepaxax     (59,L)
       end do
  
           call mpi_allgather (distal_axon_deepaxax,
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
        ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 10

       ELSE IF (THISNO.EQ.11) THEN
c deepLTS

       IF (mod(O,how_often).eq.0) then
c 1st set deepLTS   synaptic conductances to 0:

          do i = 1, numcomp_deepLTS
          do j = 1, num_deepLTS
         gAMPA_deepLTS(i,j)     = 0.d0
         gNMDA_deepLTS(i,j)     = 0.d0
         gGABA_A_deepLTS(i,j)   = 0.d0 
          end do
          end do

         do L = 1, num_deepLTS     
c Handle suppyrRS   -> deepLTS
      do i = 1, num_suppyrRS_to_deepLTS   
       j = map_suppyrRS_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_suppyrRS_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrRS_to_deepLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_suppyrRS_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_suppyrRS_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrRS_to_deepLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_suppyrRS_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrRS_to_deepLTS  
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle suppyrFRB  -> deepLTS
      do i = 1, num_suppyrFRB_to_deepLTS   
       j = map_suppyrFRB_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_suppyrFRB_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_suppyrFRB(j)  ! enumerate presyn. spikes
        presyntime = outtime_suppyrFRB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_suppyrFRB_to_deepLTS  
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_suppyrFRB_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_suppyrFRB_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_suppyrFRB_to_deepLTS  
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_suppyrFRB_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_suppyrFRB_to_deepLTS  
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle supLTS     -> deepLTS
      do i = 1, num_supLTS_to_deepLTS     
       j = map_supLTS_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_supLTS_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_supLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_supLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_supLTS_to_deepLTS     
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepLTS(k,L)  = gGABA_A_deepLTS(k,L) +
     &  gGABA_supLTS_to_deepLTS * z      
! end GABA-A part

       end do ! m
      end do ! i

c Handle spinstell  -> deepLTS
      do i = 1, num_spinstell_to_deepLTS    
       j = map_spinstell_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_spinstell_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_spinstell(j)  ! enumerate presyn. spikes
        presyntime = outtime_spinstell(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_spinstell_to_deepLTS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_spinstell_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_spinstell_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_spinstell_to_deepLTS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_spinstell_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_spinstell_to_deepLTS  
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftIB     -> deepLTS
      do i = 1, num_tuftIB_to_deepLTS    
       j = map_tuftIB_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_tuftIB_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftIB(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftIB(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftIB_to_deepLTS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_tuftIB_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_tuftIB_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftIB_to_deepLTS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_tuftIB_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftIB_to_deepLTS   
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle tuftRS     -> deepLTS
      do i = 1, num_tuftRS_to_deepLTS    
       j = map_tuftRS_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_tuftRS_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_tuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_tuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_tuftRS_to_deepLTS   
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_tuftRS_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_tuftRS_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_tuftRS_to_deepLTS   
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_tuftRS_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_tuftRS_to_deepLTS   
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle deepbask   -> deepLTS
      do i = 1, num_deepbask_to_deepLTS     
       j = map_deepbask_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_deepbask_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepbask(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepbask(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepbask_to_deepLTS     
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepLTS(k,L)  = gGABA_A_deepLTS(k,L) +
     &  gGABA_deepbask_to_deepLTS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle deepLTS    -> deepLTS
      do i = 1, num_deepLTS_to_deepLTS     
       j = map_deepLTS_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_deepLTS_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_deepLTS(j)  ! enumerate presyn. spikes
        presyntime = outtime_deepLTS(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg = delta / tauGABA_deepLTS_to_deepLTS     
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gGABA_A_deepLTS(k,L)  = gGABA_A_deepLTS(k,L) +
     &  gGABA_deepLTS_to_deepLTS * z      
! end GABA-A part

       end do ! m
      end do ! i


c Handle nontuftRS  -> deepLTS
      do i = 1, num_nontuftRS_to_deepLTS
       j = map_nontuftRS_to_deepLTS(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_deepLTS(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_deepLTS
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_deepLTS(k,L)  = gAMPA_deepLTS(k,L) +
     &  gAMPA_nontuftRS_to_deepLTS * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_nontuftRS_to_deepLTS * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_deepLTS 
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_deepLTS(k,L) = gNMDA_deepLTS(k,L) +
     &  gNMDA_nontuftRS_to_deepLTS * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_deepLTS
       if (gNMDA_deepLTS(k,L).gt.z)
     &  gNMDA_deepLTS(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


         end do
c End enumeration of deepLTS     
         ENDIF  !  if (mod(O,how_often).eq.0) ...

! Define currents to deepLTS      cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for deepLTS      cells

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(36,FILE='data/deepLTS.txt')
         write( 36, 2503) time
      endif

       CALL INTEGRATE_deepLTS   (O, time, num_deepLTS  ,
     &    V_deepLTS  , curr_deepLTS  ,
     & gAMPA_deepLTS  , gNMDA_deepLTS  , gGABA_A_deepLTS  ,
     & Mg, 
     & gapcon_deepLTS  ,totSDgj_deepLTS  ,gjtable_deepLTS  , dt,
     &  chi_deepLTS,mnaf_deepLTS,mnap_deepLTS,
     &  hnaf_deepLTS,mkdr_deepLTS,mka_deepLTS,
     &  hka_deepLTS,mk2_deepLTS,hk2_deepLTS,
     &  mkm_deepLTS,mkc_deepLTS,mkahp_deepLTS,
     &  mcat_deepLTS,hcat_deepLTS,mcal_deepLTS,
     &  mar_deepLTS)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(36,FILE='data/deepLTS.txt')
         write( 36, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

        IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_deepLTS     
        distal_axon_deepLTS      (L) = V_deepLTS      (59,L)
       end do
  
           call mpi_allgather (distal_axon_deepLTS, 
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
        ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 11

       ELSE IF (THISNO.EQ.12) THEN
c TCR

        IF (mod(O,how_often).eq.0) then
c 1st set TCR synaptic conductances to 0:

          do i = 1, numcomp_TCR
          do j = 1, num_TCR
         gAMPA_TCR(i,j)         = 0.d0 
         gNMDA_TCR(i,j)         = 0.d0
         gGABA_A_TCR(i,j)       = 0.d0 
          end do
          end do

         do L = 1, num_TCR         
c Handle nRT       -> TCR
      do i = 1, num_nRT_to_TCR     
       j = map_nRT_to_TCR(i,L) ! j = presynaptic cell
       k = com_nRT_to_TCR(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nRT(j)  ! enumerate presyn. spikes
        presyntime = outtime_nRT(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg1 = delta / tauGABA1_nRT_to_TCR     
c note that dexparg1 = MINUS the actual arg. to dexp
         if (dexparg1.le.5.d0) then
          z1 = dexptablesmall (int(dexparg1*1000.d0))
         else if (dexparg1.le.100.d0) then
          z1 = dexptablebig (int(dexparg1*10.d0))
         else
          z1 = 0.d0
         endif

        dexparg2 = delta / tauGABA2_nRT_to_TCR     
c note that dexparg2 = MINUS the actual arg. to dexp
         if (dexparg2.le.5.d0) then
          z2 = dexptablesmall (int(dexparg2*1000.d0))
         else if (dexparg2.le.100.d0) then
          z2 = dexptablebig (int(dexparg2*10.d0))
         else
          z2 = 0.d0
         endif

      gGABA_A_TCR(k,L)  = gGABA_A_TCR(k,L) +
     &  gGABA_nRT_to_TCR(j) * (0.625d0 * z1 + 0.375d0 * z2) 
! end GABA-A part

       end do ! m
      end do ! i


c Handle nontuftRS -> TCR
      do i = 1, num_nontuftRS_to_TCR
       j = map_nontuftRS_to_TCR(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_TCR(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime - cort_thal_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_TCR
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_TCR(k,L)  = gAMPA_TCR(k,L) +
     &  gAMPA_nontuftRS_to_TCR * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_TCR(k,L) = gNMDA_TCR(k,L) +
     &  gNMDA_nontuftRS_to_TCR * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_TCR
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_TCR(k,L) = gNMDA_TCR(k,L) +
     &  gNMDA_nontuftRS_to_TCR * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_TCR 
       if (gNMDA_TCR(k,L).gt.z)
     &  gNMDA_TCR(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


         end do
c End enumeration of TCR         
          ENDIF  !  if (mod(O,how_often).eq.0) ...

! Define currents to TCR          cells, ectopic spikes,
! tonic synaptic conductances

      if (mod(O,200).eq.0) then
       call durand(seed,num_TCR     ,ranvec_TCR     ) 
        do L = 1, num_TCR     
         if ((ranvec_TCR     (L).gt.0.d0).and.
     &     (ranvec_TCR     (L).le.noisepe_TCR     ).and.
     &     (current_injection.eq.1)) then ! here current_injection permits ectopic spikes
          curr_TCR     (135,L) = 0.4d0
          ectr_TCR      = ectr_TCR      + 1
         else
          curr_TCR     (135,L) = 0.d0
         endif 
        end do
      endif

! Call integration routine for TCR          cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(37,FILE='data/tcr.txt')
         write( 37, 2503) time
      endif

       CALL INTEGRATE_tcr       (O, time, num_tcr      ,
     &    V_tcr      , curr_tcr      ,
     & gAMPA_tcr      , gNMDA_tcr      , gGABA_A_tcr      ,
     & Mg, 
     & gapcon_tcr      ,totaxgj_tcr      ,gjtable_tcr      , dt,
     &  chi_tcr,mnaf_tcr,mnap_tcr,
     &  hnaf_tcr,mkdr_tcr,mka_tcr,
     &  hka_tcr,mk2_tcr,hk2_tcr,
     &  mkm_tcr,mkc_tcr,mkahp_tcr,
     &  mcat_tcr,hcat_tcr,mcal_tcr,
     &  mar_tcr)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(37,FILE='data/tcr.txt')
         write( 37, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

         IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_TCR         
        distal_axon_TCR          (L) = V_TCR          (135,L)
       end do
  
           call mpi_allgather (distal_axon_TCR,     
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
        ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 12

       ELSE IF (THISNO.EQ.13) THEN
c nRT

        IF (mod(O,how_often).eq.0) then
c 1st set nRT synaptic conductances to 0:

          do i = 1, numcomp_nRT
          do j = 1, num_nRT
         gAMPA_nRT(i,j)         = 0.d0 
         gNMDA_nRT(i,j)         = 0.d0
         gGABA_A_nRT(i,j)       = 0.d0
          end do
          end do

         do L = 1, num_nRT         
c Handle TCR        -> nRT
      do i = 1, num_TCR_to_nRT
       j = map_TCR_to_nRT(i,L) ! j = presynaptic cell
       k = com_TCR_to_nRT(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_TCR(j)  ! enumerate presyn. spikes
        presyntime = outtime_TCR(m,j)
        delta = time - presyntime

! AMPA part
        dexparg = delta / tauAMPA_TCR_to_nRT
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nRT(k,L)  = gAMPA_nRT(k,L) +
     &  gAMPA_TCR_to_nRT * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nRT(k,L) = gNMDA_nRT(k,L) +
     &  gNMDA_TCR_to_nRT * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_TCR_to_nRT 
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nRT(k,L) = gNMDA_nRT(k,L) +
     &  gNMDA_TCR_to_nRT * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_TCR_to_nRT
       if (gNMDA_nRT(k,L).gt.z)
     &  gNMDA_nRT(k,L) = z
! end NMDA part

       end do ! m
      end do ! i


c Handle nRT        -> nRT
      do i = 1, num_nRT_to_nRT     
       j = map_nRT_to_nRT(i,L) ! j = presynaptic cell
       k = com_nRT_to_nRT(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nRT(j)  ! enumerate presyn. spikes
        presyntime = outtime_nRT(m,j)
        delta = time - presyntime

! GABA-A part
        dexparg1 = delta / tauGABA1_nRT_to_nRT     
c note that dexparg1 = MINUS the actual arg. to dexp
         if (dexparg1.le.5.d0) then
          z1 = dexptablesmall (int(dexparg1*1000.d0))
         else if (dexparg1.le.100.d0) then
          z1 = dexptablebig (int(dexparg1*10.d0))
         else
          z1 = 0.d0
         endif

        dexparg2 = delta / tauGABA2_nRT_to_nRT     
c note that dexparg2 = MINUS the actual arg. to dexp
         if (dexparg2.le.5.d0) then
          z2 = dexptablesmall (int(dexparg2*1000.d0))
         else if (dexparg2.le.100.d0) then
          z2 = dexptablebig (int(dexparg2*10.d0))
         else
          z2 = 0.d0
         endif

      gGABA_A_nRT(k,L)  = gGABA_A_nRT(k,L) +
     &  gGABA_nRT_to_nRT * (0.56d0 * z1 + 0.44d0 * z2) 
! end GABA-A part

       end do ! m
      end do ! i


c Handle nontuftRS  -> nRT
      do i = 1, num_nontuftRS_to_nRT
       j = map_nontuftRS_to_nRT(i,L) ! j = presynaptic cell
       k = com_nontuftRS_to_nRT(i,L) ! k = comp. on postsyn. cell

       do m = 1, outctr_nontuftRS(j)  ! enumerate presyn. spikes
        presyntime = outtime_nontuftRS(m,j)
        delta = time - presyntime - cort_thal_delay

         IF (DELTA.GE.0.d0) THEN
! AMPA part
        dexparg = delta / tauAMPA_nontuftRS_to_nRT
c note that dexparg = MINUS the actual arg. to dexp
         if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif

      gAMPA_nRT(k,L)  = gAMPA_nRT(k,L) +
     &  gAMPA_nontuftRS_to_nRT * delta * z      
! end AMPA part

! NMDA part
        if (delta.le.5.d0) then
       gNMDA_nRT(k,L) = gNMDA_nRT(k,L) +
     &  gNMDA_nontuftRS_to_nRT * delta * 0.2d0
        else
       dexparg = (delta - 5.d0)/tauNMDA_nontuftRS_to_nRT
          if (dexparg.le.5.d0) then
          z = dexptablesmall (int(dexparg*1000.d0))
         else if (dexparg.le.100.d0) then
          z = dexptablebig (int(dexparg*10.d0))
         else
          z = 0.d0
         endif
       gNMDA_nRT(k,L) = gNMDA_nRT(k,L) +
     &  gNMDA_nontuftRS_to_nRT * z
        endif
c Test for NMDA saturation
       z = NMDA_saturation_fact * gNMDA_nontuftRS_to_nRT 
       if (gNMDA_nRT(k,L).gt.z)
     &  gNMDA_nRT(k,L) = z
! end NMDA part

        ENDIF  ! condition for checking that delta >= 0.
       end do ! m
      end do ! i


         end do
c End enumeration of nRT         
        ENDIF  !  if (mod(O,how_often).eq.0) ...

! Define currents to nRT          cells, ectopic spikes,
! tonic synaptic conductances

! Call integration routine for nRT          cells
      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(38,FILE='data/nrt.txt')
         write( 38, 2503) time
      endif

       CALL INTEGRATE_nRT       (O, time, num_nRT      ,
     &    V_nRT      , curr_nRT      ,
     & gAMPA_nRT      , gNMDA_nRT      , gGABA_A_nRT      ,
     & Mg, 
     & gapcon_nRT      ,totSDgj_nRT      ,gjtable_nRT      , dt,
     &  chi_nRT,mnaf_nRT,mnap_nRT,
     &  hnaf_nRT,mkdr_nRT,mka_nRT,
     &  hka_nRT,mk2_nRT,hk2_nRT,
     &  mkm_nRT,mkc_nRT,mkahp_nRT,
     &  mcat_nRT,hcat_nRT,mcal_nRT,
     &  mar_nRT)

      if ((debug.eq.1).and.((time.lt.0.004).or.(time.ge.6.9))) then
         open(38,FILE='data/nrt.txt')
         write( 38, 2503) time
      endif

      if (mod(O,5).eq.0) then

      call mpi_bcast (vax_suppyrRS  ,num_suppyrRS,
     &    mpi_double_precision, 0, mpi_comm_world, info)
      call mpi_bcast (vax_suppyrFRB ,num_suppyrFRB,
     &    mpi_double_precision, 1, mpi_comm_world, info)
      call mpi_bcast (vax_tuftIB    ,num_tuftIB  ,
     &    mpi_double_precision, 6, mpi_comm_world, info)
      call mpi_bcast (vax_tuftRS    ,num_tuftRS   ,
     &    mpi_double_precision, 7, mpi_comm_world, info)

      endif

         IF (mod(O,how_often).eq.0) then
! Set up distal axon voltage array and broadcast it.
       do L = 1, num_nRT         
        distal_axon_nRT          (L) = V_nRT          (59,L)
       end do
  
           call mpi_allgather (distal_axon_nRT,      
     &  1000, mpi_double_precision,
     &  distal_axon_global,1000,mpi_double_precision,
     &                      MPI_COMM_WORLD, info)

        do i = 1, num_suppyrRS
         distal_axon_suppyrRS(i      ) = distal_axon_global(i)
        end do
        do i = 1001, 1000 + num_suppyrFRB
         distal_axon_suppyrFRB(i-1000) = distal_axon_global(i)
        end do
        do i = 2001, 2000 + num_supbask
         distal_axon_supbask(i-2000)   = distal_axon_global(i)
        end do
        do i = 3001, 3000 + num_supaxax
         distal_axon_supaxax(i-3000)   = distal_axon_global(i)
        end do
        do i = 4001, 4000 + num_supLTS
         distal_axon_supLTS(i-4000)    = distal_axon_global(i)
        end do
        do i = 5001, 5000 + num_spinstell
         distal_axon_spinstell(i-5000) = distal_axon_global(i)
        end do
        do i = 6001, 6000 + num_tuftIB
         distal_axon_tuftIB(i-6000) = distal_axon_global(i)
        end do
        do i = 7001, 7000 + num_tuftRS
         distal_axon_tuftRS(i-7000) = distal_axon_global(i)
        end do
        do i = 8001, 8000 + num_nontuftRS
         distal_axon_nontuftRS(i-8000) = distal_axon_global(i)
        end do
        do i = 9001, 9000 + num_deepbask
         distal_axon_deepbask(i-9000) = distal_axon_global(i)
        end do
        do i = 10001, 10000 + num_deepaxax
         distal_axon_deepaxax(i-10000) = distal_axon_global(i)
        end do
        do i = 11001, 11000 + num_deepLTS
         distal_axon_deepLTS(i-11000) = distal_axon_global(i)
        end do
        do i = 12001, 12000 + num_TCR
         distal_axon_TCR(i-12000) = distal_axon_global(i)
        end do
        do i = 13001, 13000 + num_nRT
         distal_axon_nRT(i-13000) = distal_axon_global(i)
        end do
  
         ENDIF  !  if (mod(O,how_often).eq.0) ...

! END thisno = 13

       ENDIF  ! if (mod(O,how_often).eq.0) then ...

! Update outctr's and outtime tables.
! This code is common to all the nodes.
! This section adapted from supergj.f
      IF (mod(O,how_often).eq.0) then

       do L = 1, num_suppyrRS
	 if (distal_axon_suppyrRS(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_suppyrRS(L).eq.0) then
	    outctr_suppyrRS(L) = 1
	    outtime_suppyrRS(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L + suppyrRS_base
          else
      if ((time-outtime_suppyrRS(outctr_suppyrRS(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_suppyrRS(L) = outctr_suppyrRS(L) + 1
	     outtime_suppyrRS (outctr_suppyrRS(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L + suppyrRS_base

            endif
          endif
	 endif
       end do  ! do L = 1, num_suppyrRS

       do L = 1, num_suppyrFRB
	 if (distal_axon_suppyrFRB(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_suppyrFRB(L).eq.0) then
	    outctr_suppyrFRB(L) = 1
	    outtime_suppyrFRB(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+suppyrFRB_base !999 ! cell number adjusted to gid
          else
      if ((time-outtime_suppyrFRB(outctr_suppyrFRB(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_suppyrFRB(L) = outctr_suppyrFRB(L) + 1
	     outtime_suppyrFRB (outctr_suppyrFRB(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+suppyrFRB_base !999 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_suppyrFRB

       do L = 1, num_supbask   
	 if (distal_axon_supbask(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_supbask(L).eq.0) then
	    outctr_supbask(L) = 1
	    outtime_supbask(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supbask_base !1049 ! cell number adjusted to gid
          else
      if ((time-outtime_supbask(outctr_supbask(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_supbask(L) = outctr_supbask(L) + 1
	     outtime_supbask (outctr_supbask(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supbask_base !1049 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_supbask  

       do L = 1, num_supaxax   
	 if (distal_axon_supaxax(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_supaxax(L).eq.0) then
	    outctr_supaxax(L) = 1
	    outtime_supaxax(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supaxax_base !1139 ! cell number adjusted to gid
          else
      if ((time-outtime_supaxax(outctr_supaxax(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_supaxax(L) = outctr_supaxax(L) + 1
	     outtime_supaxax (outctr_supaxax(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supaxax_base !1139 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_supaxax  

       do L = 1, num_supLTS    
	 if (distal_axon_supLTS(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_supLTS(L).eq.0) then
	    outctr_supLTS(L) = 1
	    outtime_supLTS(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supLTS_base !1229 ! cell number adjusted to gid
          else
      if ((time-outtime_supLTS(outctr_supLTS(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_supLTS(L) = outctr_supLTS(L) + 1
	     outtime_supLTS (outctr_supLTS(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+supLTS_base !1229 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_supLTS  

       do L = 1, num_spinstell 
	 if (distal_axon_spinstell(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_spinstell(L).eq.0) then
	    outctr_spinstell(L) = 1
	    outtime_spinstell(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+spinstell_base !1319 ! cell number adjusted to gid
          else
      if ((time-outtime_spinstell(outctr_spinstell(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_spinstell(L) = outctr_spinstell(L) + 1
	     outtime_spinstell (outctr_spinstell(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+spinstell_base !1319 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_spinstell

       do L = 1, num_tuftIB    
	  if (distal_axon_tuftIB(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	     if (outctr_tuftIB(L).eq.0) then
	       outctr_tuftIB(L) = 1
	       outtime_tuftIB(1,L) = time
                 open(39,FILE='data/out.dat')
                 write(39,FMT='(F10.3,I5)' ) time, L+tuftIB_base !1559 ! cell number adjusted to gid
             else
               if ((time-outtime_tuftIB(outctr_tuftIB(L),L))
     &                  .gt. axon_refrac_time) then
	         outctr_tuftIB(L) = outctr_tuftIB(L) + 1
	         outtime_tuftIB (outctr_tuftIB(L),L) = time
                 open(39,FILE='data/out.dat')
                 write(39,FMT='(F10.3,I5)' ) time, L+tuftIB_base !1559 ! cell number adjusted to gid
               endif
             endif
	  endif
       end do  ! do L = 1, num_tuftIB   

       do L = 1, num_tuftRS    
	 if (distal_axon_tuftRS(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_tuftRS(L).eq.0) then
	    outctr_tuftRS(L) = 1
	    outtime_tuftRS(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+tuftRS_base !2359 ! cell number adjusted to gid
          else
      if ((time-outtime_tuftRS(outctr_tuftRS(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_tuftRS(L) = outctr_tuftRS(L) + 1
	     outtime_tuftRS (outctr_tuftRS(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+tuftRS_base !2359 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_tuftRS   

       do L = 1, num_nontuftRS    
	 if (distal_axon_nontuftRS(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_nontuftRS(L).eq.0) then
	    outctr_nontuftRS(L) = 1
	    outtime_nontuftRS(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+nontuftRS_base !2559 ! cell number adjusted to gid
          else
      if ((time-outtime_nontuftRS(outctr_nontuftRS(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_nontuftRS(L) = outctr_nontuftRS(L) + 1
	     outtime_nontuftRS (outctr_nontuftRS(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+nontuftRS_base !2559 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_nontuftRS   

       do L = 1, num_deepbask     
	 if (distal_axon_deepbask(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_deepbask(L).eq.0) then
	    outctr_deepbask(L) = 1
	    outtime_deepbask(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepbask_base !3059 ! cell number adjusted to gid
          else
      if ((time-outtime_deepbask(outctr_deepbask(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_deepbask(L) = outctr_deepbask(L) + 1
	     outtime_deepbask (outctr_deepbask(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepbask_base !3059 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_deepbask   

       do L = 1, num_deepaxax     
	 if (distal_axon_deepaxax(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_deepaxax(L).eq.0) then
	    outctr_deepaxax(L) = 1
	    outtime_deepaxax(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepaxax_base !3159 ! cell number adjusted to gid
          else
      if ((time-outtime_deepaxax(outctr_deepaxax(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_deepaxax(L) = outctr_deepaxax(L) + 1
	     outtime_deepaxax (outctr_deepaxax(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepaxax_base !3159 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_deepaxax   

       do L = 1, num_deepLTS      
	 if (distal_axon_deepLTS(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_deepLTS(L).eq.0) then
	    outctr_deepLTS(L) = 1
	    outtime_deepLTS(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepLTS_base !3259 ! cell number adjusted to gid
          else
      if ((time-outtime_deepLTS(outctr_deepLTS(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_deepLTS(L) = outctr_deepLTS(L) + 1
	     outtime_deepLTS (outctr_deepLTS(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+deepLTS_base !3259 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_deepLTS   

       do L = 1, num_TCR      
	 if (distal_axon_TCR(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_TCR(L).eq.0) then
	    outctr_TCR(L) = 1
	    outtime_TCR(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+TCR_base !3359 ! cell number adjusted to gid
          else
      if ((time-outtime_TCR(outctr_TCR(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_TCR(L) = outctr_TCR(L) + 1
	     outtime_TCR (outctr_TCR(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+TCR_base !3359 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_TCR   

       do L = 1, num_nRT      
	 if (distal_axon_nRT(L).ge.0.d0) then
c with threshold = 0, means axonal spike must be overshooting.
	  if (outctr_nRT(L).eq.0) then
	    outctr_nRT(L) = 1
	    outtime_nRT(1,L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+nRT_base !3459 ! cell number adjusted to gid
          else
      if ((time-outtime_nRT(outctr_nRT(L),L))
     &   .gt. axon_refrac_time) then
	     outctr_nRT(L) = outctr_nRT(L) + 1
	     outtime_nRT (outctr_nRT(L),L) = time
             open(39,FILE='data/out.dat')
             write(39,FMT='(F10.3,I5)' ) time, L+nRT_base !3459 ! cell number adjusted to gid
            endif
          endif
	 endif
       end do  ! do L = 1, num_nRT   

      ENDIF  ! if (mod(O,how_often).eq.0) ...
! End updating outctr's and outtime tables

! Set up output data to be written
       if (mod(O, 50) == 0) then
       if (thisno.eq.0) then
        outrcd( 1) = time
        outrcd( 2) = v_suppyrRS(1,2)
        outrcd( 3) = v_suppyrRS(numcomp_suppyrRS,2)
        outrcd( 4) = v_suppyrRS(43,2)
         z = 0.d0
          do i = 1, num_suppyrRS
           z = z - v_suppyrRS(1,i)
          end do
        outrcd( 5) = z / dble(num_suppyrRS) ! - av. cell somata 
         z = 0.d0
          do i = 1, numcomp_suppyrRS
           z = z + gAMPA_suppyrRS(i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_suppyrRS
           z = z + gNMDA_suppyrRS(i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_suppyrRS
           z = z + gGABA_A_suppyrRS(i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_suppyrRS(1,3)
        outrcd(10) = v_suppyrRS(1,4)
          z = 0.d0
          do i = 1, num_suppyrRS
           if(v_suppyrRS(numcomp_suppyrRS,i) .gt. 0.d0) z = z + 1.d0
          end do
        outrcd(11) = z   
        outrcd(12) = field_1mm_suppyrRS
        outrcd(13) = field_2mm_suppyrRS

      OPEN(11,FILE='data/GROUCHO110.suppyrRS')
      WRITE (11,FMT='(13F10.4)') (OUTRCD(I),I=1,13)

       else if (thisno.eq.1) then
        outrcd( 1) = time
        outrcd( 2) = v_suppyrFRB(1,2)
        outrcd( 3) = v_suppyrFRB(numcomp_suppyrFRB,2)
        outrcd( 4) = v_suppyrFRB(43,2)
         z = 0.d0
          do i = 1, num_suppyrFRB
           z = z - v_suppyrFRB(1,i)
          end do
        outrcd( 5) = z / dble(num_suppyrFRB) ! - av. cell somata 
         z = 0.d0
          do i = 1, numcomp_suppyrFRB
           z = z + gAMPA_suppyrFRB(i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_suppyrFRB
           z = z + gNMDA_suppyrFRB(i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_suppyrFRB
           z = z + gGABA_A_suppyrFRB(i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_suppyrFRB(1,3)
        outrcd(10) = v_suppyrFRB(1,4)
        outrcd(11) = field_1mm_suppyrFRB
        outrcd(12) = field_2mm_suppyrFRB

      OPEN(12,FILE='data/GROUCHO110.suppyrFRB')
      WRITE (12,FMT='(12F10.4)') (OUTRCD(I),I=1,12)

       else if (thisno.eq.2) then
        outrcd( 1) = time
        outrcd( 2) = v_supbask  (1,2)
        outrcd( 3) = v_supbask  (numcomp_supbask,2)
        outrcd( 4) = v_supbask  (43,2)
         z = 0.d0
          do i = 1, num_supbask  
           z = z - v_supbask(1,i)
          end do
        outrcd( 5) = z / dble(num_supbask  ) ! - av. cell somata 
         z = 0.d0
          do i = 1, numcomp_supbask   
           z = z + gAMPA_supbask  (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_supbask   
           z = z + gNMDA_supbask  (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_supbask  
           z = z + gGABA_A_supbask  (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_supbask  (1,3)
        outrcd(10) = v_supbask  (1,4)
      OPEN(13,FILE='data/GROUCHO110.supbask')
      WRITE (13,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.3) then
        outrcd( 1) = time
        outrcd( 2) = v_supaxax  (1,2)
        outrcd( 3) = v_supaxax  (numcomp_supaxax  ,2)
        outrcd( 4) = v_supaxax  (43,2)
         z = 0.d0
          do i = 1, num_supaxax  
           z = z - v_supaxax(1,i)
          end do
        outrcd( 5) = z / dble(num_supaxax  ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_supaxax  
           z = z + gAMPA_supaxax  (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_supaxax  
           z = z + gNMDA_supaxax  (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_supaxax  
           z = z + gGABA_A_supaxax  (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_supaxax  (1,3)
        outrcd(10) = v_supaxax  (1,4)
      OPEN(14,FILE='data/GROUCHO110.supaxax')
      WRITE (14,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.4) then
        outrcd( 1) = time
        outrcd( 2) = v_supLTS   (1,2)
        outrcd( 3) = v_supLTS   (numcomp_supLTS   ,2)
        outrcd( 4) = v_supLTS   (43,2)
         z = 0.d0
          do i = 1, num_supLTS   
           z = z - v_supLTS(1,i)
          end do
        outrcd( 5) = z / dble(num_supLTS   ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_supLTS   
           z = z + gAMPA_supLTS   (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_supLTS   
           z = z + gNMDA_supLTS   (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_supLTS   
           z = z + gGABA_A_supLTS   (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_supLTS   (1,3)
        outrcd(10) = v_supLTS   (1,4)
      OPEN(15,FILE='data/GROUCHO110.supLTS')
      WRITE (15,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.5) then
        outrcd( 1) = time
        outrcd( 2) = v_spinstell(1,2)
        outrcd( 3) = v_spinstell(numcomp_spinstell,2)
        outrcd( 4) = v_spinstell(43,2)
         z = 0.d0
          do i = 1, num_spinstell
           z = z - v_spinstell(1,i)
          end do
        outrcd( 5) = z / dble(num_spinstell) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_spinstell
           z = z + gAMPA_spinstell(i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_spinstell
           z = z + gNMDA_spinstell(i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_spinstell
           z = z + gGABA_A_spinstell(i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_spinstell(1,3)
        outrcd(10) = v_spinstell(1,4)
      OPEN(16,FILE='data/GROUCHO110.spinstell')
      WRITE (16,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.6) then
        outrcd( 1) = time
        outrcd( 2) = v_tuftIB   (1,4)
        outrcd( 3) = v_tuftIB   (numcomp_tuftIB   ,4)
        outrcd( 4) = v_tuftIB   (43,4)
         z = 0.d0
          do i = 1, num_tuftIB
           z = z - v_tuftIB(1,i)
          end do
        outrcd( 5) = z / dble(num_tuftIB   ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_tuftIB   
           z = z + gAMPA_tuftIB   (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_tuftIB   
           z = z + gNMDA_tuftIB   (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_tuftIB   
           z = z + gGABA_A_tuftIB   (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_tuftIB   (1,3)
        outrcd(10) = v_tuftIB   (1,2)
        outrcd(11) = field_1mm_tuftIB
        outrcd(12) = field_2mm_tuftIB
        outrcd(13) = v_tuftIB (numcomp_tuftIB, 2)
        outrcd(14) = v_tuftIB (1, 8)
        outrcd(15) = v_tuftIB (numcomp_tuftIB, 8)
        outrcd(16) = v_tuftIB (1, 9)
        outrcd(17) = v_tuftIB (numcomp_tuftIB, 9)
        outrcd(18) = v_tuftIB (1, 10)
        outrcd(19) = v_tuftIB (numcomp_tuftIB, 10)
      OPEN(17,FILE='data/GROUCHO110.tuftIB')
      WRITE (17,FMT='(19F10.4)') (OUTRCD(I),I=1,19)

       else if (thisno.eq.7) then
        outrcd( 1) = time
        outrcd( 2) = v_tuftRS   (1,2)
        outrcd( 3) = v_tuftRS   (numcomp_tuftRS   ,2)
        outrcd( 4) = v_tuftRS   (43,2)
         z = 0.d0
          do i = 1, num_tuftRS   
           z = z - v_tuftRS(1,i)
          end do
        outrcd( 5) = z / dble(num_tuftRS   ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_tuftRS   
           z = z + gAMPA_tuftRS   (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_tuftRS   
           z = z + gNMDA_tuftRS   (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_tuftRS   
           z = z + gGABA_A_tuftRS   (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_tuftRS   (1,3)
        outrcd(10) = v_tuftRS   (1,4)
        outrcd(11) = field_1mm_tuftRS
        outrcd(12) = field_2mm_tuftRS
      OPEN(18,FILE='data/GROUCHO110.tuftRS')
      WRITE (18,FMT='(12F10.4)') (OUTRCD(I),I=1,12)

       else if (thisno.eq.8) then
        outrcd( 1) = time
        outrcd( 2) = v_nontuftRS(1,2)
        outrcd( 3) = v_nontuftRS(numcomp_nontuftRS,2)
        outrcd( 4) = v_nontuftRS(43,2)
         z = 0.d0
          do i = 1, num_nontuftRS
           z = z - v_nontuftRS(1,i)
          end do
        outrcd( 5) = z / dble(num_nontuftRS) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_nontuftRS
           z = z + gAMPA_nontuftRS(i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_nontuftRS
           z = z + gNMDA_nontuftRS(i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_nontuftRS
           z = z + gGABA_A_nontuftRS(i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_nontuftRS(1,3)
        outrcd(10) = v_nontuftRS(1,4)
        outrcd(11) = field_1mm_nontuftRS
        outrcd(12) = field_2mm_nontuftRS
      OPEN(19,FILE='data/GROUCHO110.nontuftRS')
      WRITE (19,FMT='(12F10.4)') (OUTRCD(I),I=1,12)

       else if (thisno.eq.9) then
        outrcd( 1) = time
        outrcd( 2) = v_deepbask (1,2)
        outrcd( 3) = v_deepbask (numcomp_deepbask ,2)
        outrcd( 4) = v_deepbask (43,2)
         z = 0.d0
          do i = 1, num_deepbask 
           z = z - v_deepbask(1,i)
          end do
        outrcd( 5) = z / dble(num_deepbask ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_deepbask 
           z = z + gAMPA_deepbask (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepbask 
           z = z + gNMDA_deepbask (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepbask 
           z = z + gGABA_A_deepbask (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_deepbask (1,3)
        outrcd(10) = v_deepbask (1,4)
      OPEN(20,FILE='data/GROUCHO110.deepbask')
      WRITE (20,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.10) then
        outrcd( 1) = time
        outrcd( 2) = v_deepaxax (1,2)
        outrcd( 3) = v_deepaxax (numcomp_deepaxax ,2)
        outrcd( 4) = v_deepaxax (43,2)
         z = 0.d0
          do i = 1, num_deepaxax 
           z = z - v_deepaxax(1,i)
          end do
        outrcd( 5) = z / dble(num_deepaxax ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_deepaxax 
           z = z + gAMPA_deepaxax (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepaxax 
           z = z + gNMDA_deepaxax (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepaxax 
           z = z + gGABA_A_deepaxax (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_deepaxax (1,3)
        outrcd(10) = v_deepaxax (1,4)
      OPEN(21,FILE='data/GROUCHO110.deepaxax')
      WRITE (21,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.11) then
        outrcd( 1) = time
        outrcd( 2) = v_deepLTS  (1,2)
        outrcd( 3) = v_deepLTS  (numcomp_deepLTS  ,2)
        outrcd( 4) = v_deepLTS  (43,2)
         z = 0.d0
          do i = 1, num_deepLTS  
           z = z - v_deepLTS(1,i)
          end do
        outrcd( 5) = z / dble(num_deepLTS  ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_deepLTS  
           z = z + gAMPA_deepLTS  (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepLTS   
           z = z + gNMDA_deepLTS  (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_deepLTS  
           z = z + gGABA_A_deepLTS  (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_deepLTS  (1,3)
        outrcd(10) = v_deepLTS  (1,4)
      OPEN(22,FILE='data/GROUCHO110.deepLTS')
      WRITE (22,FMT='(10F10.4)') (OUTRCD(I),I=1,10)

       else if (thisno.eq.12) then
        outrcd( 1) = time
        outrcd( 2) = v_TCR      (1,2)
        outrcd( 3) = v_TCR      (numcomp_TCR      ,2)
        outrcd( 4) = v_TCR      (43,2)
         z = 0.d0
          do i = 1, num_TCR      
           z = z - v_TCR(1,i)
          end do
        outrcd( 5) = z / dble(num_TCR      ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_TCR      
           z = z + gAMPA_TCR      (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_TCR      
           z = z + gNMDA_TCR      (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_TCR      
           z = z + gGABA_A_TCR      (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_TCR      (1,3)
        outrcd(10) = v_TCR      (1,4)

          z = 0.d0
          do i = 1, num_TCR     
           if(v_TCR     (numcomp_TCR     ,i) .gt. 0.d0) z = z + 1.d0
          end do
        outrcd(11) = z   

      OPEN(23,FILE='data/GROUCHO110.TCR')
      WRITE (23,FMT='(11F10.4)') (OUTRCD(I),I=1,11)

       else if (thisno.eq.13) then
        outrcd( 1) = time
        outrcd( 2) = v_nRT      (1,2)
        outrcd( 3) = v_nRT      (numcomp_nRT      ,2)
        outrcd( 4) = v_nRT      (43,2)
         z = 0.d0
          do i = 1, num_nRT      
           z = z - v_nRT(1,i)
          end do
        outrcd( 5) = z / dble(num_nRT      ) !  -av. cell somata 
         z = 0.d0
          do i = 1, numcomp_nRT       
           z = z + gAMPA_nRT      (i,2)
          end do
        outrcd( 6) = z * 1000.d0 ! total AMPA cell 2 
         z = 0.d0
          do i = 1, numcomp_nRT         
           z = z + gNMDA_nRT      (i,2)
          end do
        outrcd( 7) = z * 1000.d0 ! total NMDA cell 2 
         z = 0.d0
          do i = 1, numcomp_nRT        
           z = z + gGABA_A_nRT      (i,2)
          end do
        outrcd( 8) = z * 1000.d0 ! total GABA-A, cell 2 
        outrcd( 9) = v_nRT      (1,3)
        outrcd(10) = v_nRT      (1,4)

          z = 0.d0
          do i = 1, num_nRT     
           if(v_nRT     (numcomp_nRT     ,i) .gt. 0.d0) z = z + 1.d0
          end do
        outrcd(11) = z   

      OPEN(24,FILE='data/GROUCHO110.nRT')
      WRITE (24,FMT='(11F10.4)') (OUTRCD(I),I=1,11)
       endif ! checking thisno

       endif ! mod(O,100) = 0

!       end do ! loop over 14 thisno's to emulate parallel machines

        goto 1000
c END guts of main program

2000    CONTINUE
        e_time = dtime(t_time)
        time2 = t_time(1)	! used to be = gettime()
         if (thisno.eq.0) then
        print *,'elapsed:',e_time,', user:',t_time(1),', sys:',t_time(2)
        write(6,3434) time2 - time1
         endif
3434    format(' elapsed time = ',f8.0,' secs')

        call mpi_finalize (info)
             END
c end main routine
