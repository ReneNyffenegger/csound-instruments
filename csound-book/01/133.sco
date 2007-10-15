;Function  1 uses the GEN10 subroutine to compute a sine wave
;Function  2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
;Function  3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope
;Function  8 uses the GEN05 subroutine to compute an exponential ADSR envelope function
;Function  9 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx
;Function 10 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx
;Function 11 uses the GEN01 subroutine to read in an AIF audio file "piano.aif"
;Function 12 uses the GEN01 subroutine to read in an AIF audio file "marimba.aif"
;Function 13 uses the GEN01 subroutine to read in an AIF audio file "brass.aif.aif"
;Function 14 uses the GEN01 subroutine to read in an AIF audio file "violin.aif"
;Function 15 uses the GEN05 subroutine to compute an exponential ADSR envelope function
;Function 16 uses the GEN07 subroutine to compute a linear triangle function for AM
;Function 17 uses the GEN07 subroutine to compute a square function for AM

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f3  0 4097 20   2  1
f5  0 0    1   "hellorcb.aif"   0   4   0 
f8  0 1024 5   .01  32  1   288   .8   512  .7   192  .01
f9  0 513  5    .001 128 .8  128 .6  256  1
f10 0 513  5   .01  64   1   64   .5   64  .99  64   .6  64  .98  64  .7  64 .97  32  .8  32 1
f11 0 0   1   "piano.aif" 0 4 0
f12 0 0   1   "marimba.aif" 0 4 0
f13 0 0   1   "brass.aif" 0 4 0
f14 0 0   1   "violin.aif" 0 4 0
f15 0 512  5    1   64  .7   136  .65    312  .001
f16 0 513   7   0   256 1   256     0    
f17 0 513   7   0   10  1  246  1   10   0  246    0    
f18 0 513   7   0   10  1  502 0
f19 0 1024 -8 .1    512 .9 512 .1

;ins    st      dur ampdb   frq     fc1     fc2 resgn
;======================================================================
i 133       0       .1  90      440     1000    20   1
i.      +       .   <       <       <       .    <
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   60      55      60      20   30
i.      .       .   <       <       <       <    <
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       .   .       .       .       .    .
i.      .       5   80      880     2000    200  5
