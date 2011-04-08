
rm -rf overwrite  # file created if user types all at: Overwrite (y/all/n)


## Format:          Syn_TYPE_Pre_Post        time(ms)  scaling(nS)  reversal potential(mV)

# 1 From RS (or Pyr or SupPyr)

python genSyn.py    Syn_AMPA_SupPyr_SupPyr      2       0.25    0
python genSyn.py    Syn_NMDA_SupPyr_SupPyr      130     0.025   0

python genSyn.py    Syn_Elect_SupPyr_SupPyr     -1      3       -1   # Note: rise time and rev pot not required for gap junction

python genSyn.py    Syn_AMPA_SupPyr_SupFS       0.8     3       0
python genSyn.py    Syn_NMDA_RSPyr_SupFS        100     0.15    0

python genSyn.py    Syn_AMPA_SupPyr_SupLTS      1       2       0
python genSyn.py    Syn_NMDA_RSPyr_SupLTS       100     0.15    0

python genSyn.py    Syn_AMPA_SupPyr_L4SS        2       0.1     0
python genSyn.py    Syn_NMDA_SupPyr_L4SS        130     0.01    0

python genSyn.py    Syn_AMPA_SupPyr_L5Pyr       2       0.1     0
python genSyn.py    Syn_NMDA_SupPyr_L5Pyr       130     0.01    0

python genSyn.py    Syn_AMPA_SupPyr_DeepFS      0.8     1       0
python genSyn.py    Syn_NMDA_SupPyr_DeepFS      100     0.1     0

python genSyn.py    Syn_AMPA_SupPyr_DeepLTS     1       1       0
python genSyn.py    Syn_NMDA_RSPyr_DeepLTS      100     0.15    0

python genSyn.py    Syn_AMPA_SupPyr_L6NT        2       0.5     0
python genSyn.py    Syn_NMDA_SupPyr_L6NT        130     0.05    0



# 2 From FRB Mostly included as SupPyr above...

python genSyn.py    Syn_NMDA_FRBPyr_SupFS       100     0.1     0
python genSyn.py    Syn_NMDA_FRBPyr_SupLTS      100     0.1     0

python genSyn.py    Syn_NMDA_FRBPyr_DeepLTS     100     0.1     0



# 3 from Sup Basket (or FS)

python genSyn.py    Syn_GABAA_SupBask_SupPyr    6       1.2     -81  # "-81mV for superficial pyramidals and TCR cells"

python genSyn.py    Syn_GABAA_SupBask_SupBask   3       0.2     -75
python genSyn.py    Syn_GABAA_SupBask_SupAxAx   3       0.2     -75
python genSyn.py    Syn_GABAA_SupBask_SupLTS    3       0.5     -75

python genSyn.py    Syn_Elect_CortIN_CortIN     -1      1       -1  

python genSyn.py    Syn_GABAA_SupBask_L4SS      6       0.1     -75



# 4 From Sup AxAx

python genSyn.py    Syn_GABAA_SupAxAx_SupPyr    6       1.2     -81

python genSyn.py    Syn_GABAA_SupAxAx_L4SS      6       0.1     -75

python genSyn.py    Syn_GABAA_SupAxAx_DeepPyr   6       1       -75



# 5 From Sup LTS (or LTS)

python genSyn.py    Syn_GABAA_SupLTS_SupPyr     20      0.01    -81

python genSyn.py    Syn_GABAA_SupLTS_FS         20      0.01    -75

python genSyn.py    Syn_GABAA_SupLTS_LTS        20      0.05    -75

python genSyn.py    Syn_GABAA_SupLTS_L4SS       20      0.01    -75

python genSyn.py    Syn_GABAA_SupLTS_L5Pyr      20      0.02    -81

python genSyn.py    Syn_GABAA_SupLTS_L6NT       20      0.01    -81




# 6 from L4 Spiny Stellate

python genSyn.py    Syn_AMPA_L4SS_Pyr           2       1       0
python genSyn.py    Syn_NMDA_L4SS_Pyr           130     0.1     0

python genSyn.py    Syn_AMPA_L4SS_IN            0.8     1       0   ## Note time course only mentioned for SS to FS
python genSyn.py    Syn_NMDA_L4SS_IN            100     0.15    0

python genSyn.py    Syn_AMPA_L4SS_L4SS          2       1       0
python genSyn.py    Syn_NMDA_L4SS_L4SS          130     0.1     0   ## Note: "with some exceptions..."

python genSyn.py    Syn_Elect_L4SS_L4SS         -1      3       -1



# 7 From L5 Tufted IB Pyr

python genSyn.py    Syn_AMPA_L5IB_SupPyr        2       0.5     0
python genSyn.py    Syn_NMDA_L5IB_SupPyr        130     0.05    0

python genSyn.py    Syn_AMPA_L5IB_SupFS         0.8     1       0
python genSyn.py    Syn_NMDA_L5IB_IN            100     0.15    0

python genSyn.py    Syn_AMPA_L5IB_SupLTS        1       1       0

python genSyn.py    Syn_AMPA_L5IB_L4SS          2       0.5     0
python genSyn.py    Syn_NMDA_L5IB_L4SS          130     0.05    0

python genSyn.py    Syn_AMPA_L5IB_L5Pyr         2       2       0
python genSyn.py    Syn_NMDA_L5IB_DeepPyr       130     0.2     0

python genSyn.py    Syn_Elect_DeepPyr_DeepPyr   -1      4       -1

python genSyn.py    Syn_AMPA_L5IB_DeepFS        0.8     3       0

python genSyn.py    Syn_AMPA_L5IB_DeepLTS       1       2       0

python genSyn.py    Syn_AMPA_L5IB_L6NT          2       2       0

# 8 From L5 Tufted RS Pyr

python genSyn.py    Syn_AMPA_L5RS_SupPyr        2       0.5     0
python genSyn.py    Syn_NMDA_L5RS_SupPyr        130     0.05    0

python genSyn.py    Syn_AMPA_L5RS_SupFS         0.8     1       0
python genSyn.py    Syn_NMDA_L5RS_SupIN         100     0.15    0

python genSyn.py    Syn_AMPA_L5RS_SupLTS        1       1       0

python genSyn.py    Syn_AMPA_L5RS_L4SS          2       0.5     0
python genSyn.py    Syn_NMDA_L5RS_L4SS          130     0.05    0

python genSyn.py    Syn_AMPA_L5RS_L5Pyr         2       1       0
python genSyn.py    Syn_NMDA_L5RS_DeepPyr       130     0.1     0

python genSyn.py    Syn_AMPA_L5RS_DeepFS        0.8     3       0
python genSyn.py    Syn_NMDA_L5RS_DeepIN        100     0.1     0

python genSyn.py    Syn_AMPA_L5RS_DeepLTS       1       2       0

python genSyn.py    Syn_AMPA_L5RS_L6NT          2       1       0


# 9 From L6 Non Tufted Pyr

python genSyn.py    Syn_AMPA_L6NT_SupPyr        2       0.5     0
python genSyn.py    Syn_NMDA_L6NT_SupPyr        130     0.05    0

python genSyn.py    Syn_AMPA_L6NT_SupFS         0.8     1       0
python genSyn.py    Syn_NMDA_L6NT_SupFS         100     0.1     0  ## Note only sup basket scaling mentioned, but "all GABAergic neurons receive input from 10 L6 neurons..."

python genSyn.py    Syn_AMPA_L6NT_SupLTS        1       1       0  ## Note: only deep LTS scaling val mentioned. Using Sup FS value
python genSyn.py    Syn_NMDA_L6NT_SupLTS        100     0.1     0  ## Note only sup basket scaling mentioned, but "all GABAergic neurons receive input from 10 L6 neurons..."

python genSyn.py    Syn_AMPA_L6NT_L4SS          2       0.5     0
python genSyn.py    Syn_NMDA_L6NT_L4SS          130     0.05    0

python genSyn.py    Syn_AMPA_L6NT_L5Pyr         2       1       0
python genSyn.py    Syn_NMDA_L6NT_DeepPyr       130     0.1     0

python genSyn.py    Syn_AMPA_L6NT_DeepFS        0.8     3       0
python genSyn.py    Syn_NMDA_L6NT_DeepFS        100     0.1     0

python genSyn.py    Syn_AMPA_L6NT_DeepLTS       1       2       0
python genSyn.py    Syn_NMDA_L6NT_DeepLTS       100     0.1     0

python genSyn.py    Syn_AMPA_L6NT_L6NT          2       1       0
#                   Syn_NMDA_L6NT_DeepPyr

python genSyn.py    Syn_AMPA_L6NT_TCR           2       0.75    0
python genSyn.py    Syn_NMDA_L6NT_TCR           130     0.075   0

python genSyn.py    Syn_AMPA_L6NT_nRT           2       0.5     0   ## Note time course of L6NT -> nRT not mentioned in appendix!!
python genSyn.py    Syn_NMDA_L6NT_nRT           150     0.05    0

# 10 From Deep Basket

python genSyn.py    Syn_GABAA_DeepFS_L4SS       6       1.5     -75

python genSyn.py    Syn_GABAA_DeepBask_L5Pyr    6       0.7     -81

python genSyn.py    Syn_GABAA_DeepBask_DeepFS   3       0.2     -75

python genSyn.py    Syn_GABAA_DeepBask_DeepLTS  3       0.7     -75

python genSyn.py    Syn_GABAA_DeepBask_L6NT     6       0.7     -81


# 11 From Deep AxAx (some inc as DeepFS above)

python genSyn.py    Syn_GABAA_DeepAxAx_Pyr      6       1       -81

# 12 From Deep LTS

python genSyn.py    Syn_GABAA_DeepLTS_SupPyr    20     0.01     -81

python genSyn.py    Syn_GABAA_DeepLTS_SupFS     20     0.01     -75

python genSyn.py    Syn_GABAA_DeepLTS_SupLTS    20     0.05     -75

python genSyn.py    Syn_GABAA_DeepLTS_L4SS      20     0.01     -75

python genSyn.py    Syn_GABAA_DeepLTS_L5IB      20     0.05     -81

python genSyn.py    Syn_GABAA_DeepLTS_L5RS      20     0.02     -81

python genSyn.py    Syn_GABAA_DeepLTS_DeepFS    20     0.01     -75

python genSyn.py    Syn_GABAA_DeepLTS_DeepLTS   20     0.05     -75

python genSyn.py    Syn_GABAA_DeepLTS_L6NT      20     0.01     -81


# 13 From TCR

python genSyn.py    Syn_AMPA_TCR_SupPyr         2       0.5     0
python genSyn.py    Syn_NMDA_TCR_SupPyr         130     0.05    0

python genSyn.py    Syn_AMPA_TCR_SupFS          1       0.1     0
python genSyn.py    Syn_NMDA_TCR_SupFS          100     0.01    0

python genSyn.py    Syn_AMPA_TCR_L4SS           2       1       0
python genSyn.py    Syn_NMDA_TCR_L4SS           130     0.1     0

python genSyn.py    Syn_AMPA_TCR_L5Pyr          2       1.5     0
python genSyn.py    Syn_NMDA_TCR_L5Pyr          130     0.15    0

python genSyn.py    Syn_AMPA_TCR_DeepBask       1       1.5     0
python genSyn.py    Syn_NMDA_TCR_DeepBask       100     0.1     0

python genSyn.py    Syn_AMPA_TCR_DeepAxAx       1       1       0
python genSyn.py    Syn_NMDA_TCR_DeepAxAx       100     0.1     0

python genSyn.py    Syn_AMPA_TCR_L6NT           2       1       0
python genSyn.py    Syn_NMDA_TCR_L6NT           130     0.1     0

python genSyn.py    Syn_AMPA_TCR_nRT            2       0.75    0
python genSyn.py    Syn_NMDA_TCR_nRT            150     0.15    0

# 14 From nRT


python genSyn.py    Syn_GABAA_nRT_TCR_f         3.3     1.4     -81    ## TODO: Edit in project!!!!
python genSyn.py    Syn_GABAA_nRT_TCR_s         10      1.4     -81    ## TODO: Edit in project!!!!


python genSyn.py    Syn_GABAA_nRT_nRT_f         9       0.3     -75    ## TODO: Edit in project!!!!
python genSyn.py    Syn_GABAA_nRT_nRT_s         9       44.5    -75    ## TODO: Edit in project!!!!

python genSyn.py    Syn_Elect_nRT_nRT           -1      1       -1

rm -rf overwrite  # file created if user types all at: Overwrite (y/all/n)


