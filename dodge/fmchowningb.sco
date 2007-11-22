; ===============================
; chowning1.sco
; Sine Wave                             ; ===============================
f1  0 4096  10    1  
; ADSR Trumpet Envelope  - fig 1.11
f2  0 513   7     0     85.33 1     85.33 .75   85.33 .65   170.66      .50   85.33 0
; AR Woodwind Envelope for Carrier - fig 1.12
f3  0 513   7     0     100   1     392   .9    20    0  
; Gated Woodwind Envelope for Modulator - fig 1.13
f4  0 513   7     0     100   1     412   1 
; Exponential decaying envelope for bell-like timbres.
f5  0 513   5     1     512   .001
; Modification of Exponential envelope for drumlike sounds
f6  0 513   5     .7    16    .8    48    1     64    .8    128   .2    256   .001
; Modulator envelope for wood-drum sounds
f7  0 513   7     0     12    1     52    0     460   0 
; Ramp
f8  0 513   7     0     512   1 
; Exponential rise
f9  0 513   5     .001  512   1 
; Triangular Wave
f10 0 512   10    1     0     .111  0     .04   0     .02   0     .012
; Sawtooth Wave
f11 0 512   10    1     .5    .3    .25   .2    .167  .14   .125  .111
; Square Wave
f12 0 512   10    1     0     .3    0     .2    0     .14   0     .111
; Narrow Pulse
f13 0 512   10    1     1     1     1     .7    .5    .3    .1 
; Exponential rise and decay
f14 0 513   5     .1    32    1     480   .01
; Reverse pyramid
f15 0 513   7     1     256   0     256   1 
; ================================================================================================================
;ins    strt    dur     amp     fc      fm      strtndx pkndx   modenv  carenv  modfun  carfun
; ================================================================================================================
; Brass Timbre
i1  0  .5     20000  440    440    0      5      2      2      1      1    
i1  1  1      20000  220    220    0      5      2      2      1      1    
i1  3  .5     20000  110    110    0      5      2      2      1      1    
i1  4  2      20000  55     55     0      5      2      2      1      1    
s
; Bassoon Timbre
i1  0  .5     20000  2000   400    0      1.5    4      3      1      1    
i1  1  1      20000  1000   200    0      1.5    4      3      1      1    
i1  3  .5     20000  500    100    0      1.5    4      3      1      1    
i1  4  2      20000  250    50     0      1.5    4      3      1      1    
s
; Reed Timbre
i1  0  .5     20000  600    400    4      2      4      3      1      1    
i1  1  2      20000  300    200    4      2      4      3      1      1    
i1  4  .5     20000  150    50     4      2      4      3      1      1    
i1  5  3      20000  75     25     4      2      4      3      1      1    
s
; Bell Timbre
i1  0  10     20000  200    280    0      10     5      5      1      1    
i1  11 20     20000  50     70     0      20     5      5      1      1    
s
; Wood-drum Timbre
i1  0  .2     20000  40     27.5   0      25     7      6      1      1    
i1  .5 .2     20000  80     55     0      25     7      6      1      1    
i1  1  .2     20000  160    110    0      25     7      6      1      1    
i1  1.5       .2     20000  320    220    0      25     7      6      1      1    
e
