; ================================================================== ;
; ========  SCORE FOR RISSET'S "FLUTE-LIKE" INSTRUMENT(S)  ========= ;
; ================================================================== ;

f0  15

; WAVEFORMS: INSTRUMENT 1

f1  0 512   9     1     1     0         ; FUNDAMENTAL
f2  0 512   10    1     .2    .08   .07 ; FOUR HARMONICS
f3  0 512   10    1     .4    .2    .1    .1    .05 ; SIX HARMONICS

; AMPLITUDE ENVELOPE FUNCTIONS: INSTRUMENT 1

f4  0 512   7     0     1     0     49    .2    90    .6    40    .99   25    .9    45    .5    50    .25   50    .12 50 .06 50 .02 62 0
f5  0 512   7     0     1     0     49    .2    100   .6    50    .99   150   .2    162   0 
f6  0 512   7     0     1     0     49    .2    200   .5    100   .2    162   0 
f7  0 512   7     0     1     0     79    .5    60    .5    20    .99   120   .4    140   .6    92    0  

; AMPLITUDE ENVELOPE FYNCTIONS: INSTRUMENT 2

f8  0 512   7     0     1     0     149   .4    200   .99   50    .5    50    .24   62    0  

; PITCH ENVELOPE FUNCTIONS: INSTRUMENT 2

f9  0 512   7     0     1     .895  511   .99
f10 0 512   7     0     1     .99   511   .99

; DC BIAS FUNCTIONS

f12 0 512   9     1     .26   0 
f13 0 512   9     1     .3    0  
