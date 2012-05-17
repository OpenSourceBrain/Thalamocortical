#!/usr/bin/perl

$txt = <<ENDTXT;
                // ----------------- mech  extra1 extra2  lvl-0  lvl-1 2x( lvl-2   lvl-3  lvl-4  lvl-5  lvl-6  lvl-7  lvl-8  lvl-9 )
                conductance_set_levels(lcell, 11, -2.50, 50.00,  0.400, 0.150,    0.150,  0.150, 0.010, 0.010, 0.010, 0.010, 0.010, 0.010) // "naf2","fastNa_shift_naf2","ena"
                conductance_set_levels(lcell, 9,     -0,  -100,  0.400, 0.100,    0.150,  0.150,    -1,    -1,    -1,    -1,    -1,    -1) // "kdr_fs","","ek"
                conductance_set_levels(lcell, 6,     -0,  -100,  0.002, 0.030,    0.060,  0.004, 0.004, 0.004, 0.004, 0.004, 0.004, 0.004) // "ka","","ek"
                conductance_set_levels(lcell, 5,     -0,  -100, 0.0001,0.0001,    0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002) // "k2","","ek"
                conductance_set_levels(lcell, 12, -2.50, 50.00,     -1,1.5E-4,    1.5E-4,1.5E-4,1.0E-5,1.0E-5,1.0E-5,1.0E-5,1.0E-5,1.0E-5) // "napf_spinstell","fastNa_shift_napf_spinstell","ena"
                conductance_set_levels(lcell, 8,     -0,  -100,     -1,  0.01,    0.020,  0.020, 0.020,    -1,    -1,    -1,    -1,    -1) // "kc_fast","","ek"
                conductance_set_levels(lcell, 10,    -0,  -100,    -1,3.75E-3,    7.5E-3,7.5E-3,7.5E-3,7.5E-3,7.5E-3,7.5E-3,7.5E-3,7.5E-3) // "km","","ek"
                conductance_set_levels(lcell, 7,     -0,  -100,     -1,0.0001,    0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002) // "kahp_slower","","ek"
                conductance_set_levels(lcell, 3,     -0,    -0,     -1,0.0005,    0.001,  0.001, 0.001, 0.001, 0.001, 0.006, 0.006, 0.006) // "cal","",""
                conductance_set_levels(lcell, 4,     -0,    -0,     -1,0.0001,    0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002,0.0002) // "cat_a","",""
                conductance_set_levels(lcell, 1,    0.0,   -40,     -1,2.5E-4,    0.0005,0.0005,0.0005,0.0005,0.0005,0.0005,0.0005,0.0005) // "ar","m0_ar","erev_ar"
                conductance_set_levels(lcell, 13, -65.0,    -0,  0.001,2.0E-5,    4.0E-5,4.0E-5,4.0E-5,4.0E-5,4.0E-5,4.0E-5,4.0E-5,4.0E-5) // "pas","e_pas",""
                conductance_set_levels(lcell, 14,    -0,    -0,    0.9,   0.9,       1.8,   1.8,   1.8,   1.8,   1.8,   1.8,   1.8,   1.8) // "cm","",""               
                // ----------------- mech  extra1 extra2  lvl-0  lvl-1,     lvl-2   lvl-3  lvl-4  lvl-5  lvl-6  lvl-7  lvl-8  lvl-9 )
                conductance_set_levels(lcell, 2, 260000,    -0,     -1,  0.02,      0.05,  0.05,  0.05,  0.05,  0.05,  0.05,  0.05,  0.05) // "cad","","phi_cad"
                conductance_set_levels(lcell, 15,    -0,    -0,    100,   250,       250,   250,   250,   250,   250,   250,   250,   250) // "Ra","",""
ENDTXT

print $txt

    $txt =~ s/conductance_set_levels\(lcell,//g;
    $txt =~ s/\)\s\/\//,/g;
    $txt =~ s/\"//g;

print $txt
