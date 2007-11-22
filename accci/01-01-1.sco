; ************************************************************************
; ACCCI:     01-01-1.SCO
; coded:     jpg 8/93

; This instrument demonstrates a substantial number of
; different waveforms & envelopes

; GEN functions **********************************************************
; waveforms
f1  0 2048  10    1                     ; fundamental
f2  0 1024  10    1     .2    .05       ; three harmonics
f3  0 2048  10    1     .2    .08   .07 ; four harmonics
f4  0 2048  10    1     .4    .2    .1    .1    .05 ; six harmonics
f5  0 1024  10    1     .5    .3    .2    .15   .12 ; six harmonics
f6  0 1024  10    1     1     1     .3    .3    .3    1     1     1     1 ; ten harmonics
f7  0 1024  10    1     2     3     4     5     6     5     4     3     2     1 ; eleven harmonics
f8  0 1024  10    1     2     3     5     8     13    1     2     3     5     8     13 ; fibonacci twice
f9  0 1024  10    .8    1.2   1.2   .8    .8    1.2   1.3   .8    .1    .3    0 ; ca. alternating

f10 0 1024  9     1     1     0     1     1     .05 ; phase diff
f11 0 1024  9     10    1     0     11    1     0     12    1     0     13    1     0     14    1     0     
      15    1     0     16    1     0     17    1     0     18    1     0     19    1     0 ; start at 10th
; linear waveforms
f41 0 1024  7     0     128   10    256   10    256   -10   256   -10   128   0 ; 50% pulse(square)
f42 0 1024  7     0     6     1     500   1     12    -1    500   -1    6     0 ; steeper square
f43 0 1024  7     0     6     1     200   1     12    -1    800   -1    6     0 ; 20% pulse
f44 0 1024  7     0     6     1     100   1     12    -1    900   -1    6     0 ; 10% pulse
f45 0 1024  7     0     500   1     24    -1    500   0 ; sawtooth
f46 0 1024  7     0     256   1     256   0     256   -1    256   0 ; triangle

; linear envelopes
f32 0 512   7     0     12    .99   500   0 
f33 0 512   7     0     1     0     49    .2    90    .6    40    .99   25    .9    45    .5    50    .25   50    .12 50 .06
      50    .02   62    0  
f34 0 512   7     0     1     0     49    .2    100   .6    50    .99   150   .2    162   0 
f35 0 512   -7    0     1     0     49    .2    200   .5    100   .2    162   0 ; softer 
f36 0 512   7     0     1     0     79    .5    60    .5    20    .99   120   .4    140   .6    92    0  
f37 0 512   7     0     1     0     149   .4    200   .99   50    .5    50    .24   62    0  

; exponential envelopes: post-normalized (2**10)
f51 0 513   5     1024  512   1         ; plucked
f52 0 513   5     1     12    1024  500   1 ; percussive
f53 0 513   5     1     256   1024  256   1 ; 50/50
f54 0 513   5     1     100   250   100   500   100   750   100   1024  112   1 ; five steps
f55 0 513   5     1     100   1024  100   1     112   1     100   1024  100   1 ; twin peaks
f56 0 513   5     1     1     100   20    12    1024  400   1 ; 1/5th delay
f57 0 513   5     1     1     125   20    12    1024  375   1 ; 1/4th delay
f58 0 513   5     1     500   1024  12    1 ; reverse f52
f59 0 513   5     1     48    1024  300   900   164   1 ; moderate

; score ******************************************************************
;                           wav   env
;   start  idur  iamp ifq1  if1   if2
i1  0  2      8000   440    1      59   ; carriers with percussive env
i1  6  .      .      .      2      .    
i1  12 .      .      .      3      .    
i1  18 .      .      .      4      .    
i1  24 .      .      .      5      .    
i1  30 .      .      .      6      .    
i1  36 .      .      .      7      .    
i1  42 .      .      .      8      .    
i1  48 .      .      .      9      .    

i1  54 .      .      220    10     .   
i1  60 .      .      .      11     .    ; periodicity and pitch

i1  66 .      .      .      41     .    ; linear waveforms
i1  72 .      .      .      42     .   
i1  78 .      .      .      43     .   
i1  84 .      .      .      44     .   
i1  90 .      .      .      45     .   
i1  96 .      .      .      46     .   

s

i1  10 2      8000   330    42     32   ; linear envelopes
i1  16 .      .      .      .      33   
i1  22 .      .      .      .      34   
i1  28 .      .      .      .      35   
i1  34 .      .      .      .      36   
i1  40 .      .      .      .      37   

s

i1  10 2      8000   444    42     51   ; exponential envelopes
i1  16 .      .      .      .      52   
i1  22 .      .      .      .      53   
i1  28 .      .      .      .      54   
i1  34 .      .      .      .      55   
i1  40 .      .      .      .      56   
i1  46 .      .      .      .      57   
i1  52 .      .      .      .      58   
i1  58 .      .      .      .      59   

e
