; **********************************************************************
; ACCCI:     01-10-1.SCO
; coded:     jpg 10/93

; **********************************************************************
; GEN functions
; waveforms
f1  0 2048  10    1                     ; fundamental
f2  0 2048  10    1     .2    .08   .07 ; four harmonics
f3  0 2048  10    1     .4    .2    .1    .1    .05 ; six harmonics

; envelopes
f4  0 512   7     0     1     0     49    .2    90    .6    40    .99   25    .9    45    .5    50    .25   50    .12 50 .06
      50    .02   62    0  
f5  0 512   7     0     1     0     49    .2    100   .6    50    .99   150   .2    162   0 
f6  0 512   7     0     1     0     49    .2    200   .5    100   .2    162   0 
f7  0 512   7     0     1     0     79    .5    60    .5    20    .99   120   .4    140   .6    92    0  
f8  0 512   7     0     1     0     149   .4    200   .99   50    .5    50    .24   62    0  


; **********************************************************************
; score                                   LFO
; instr 1  idur     iamp  ifq1 if1  if2   ifq3
i1  1  1.5    800    1109   1      5      4 ; 3 different waveforms
i1  3  1.5    800    1109   2      5      4    
i1  5  1.5    800    1109   3      5      4    

s

i1  1  1.5    800    1109   1      4      4 ; 5 different envelopes
i1  3  1.5    800    .      .      5      4    
i1  5  1.5    800    .      .      6      4    
i1  7  1.5    800    .      .      7      4    
i1  9  1.5    800    .      .      8      4    

s

i1  1  1.5    800    1109   1      8      1 ; 5 different LFO rates
i1  3  1.5    800    .      .      8      2    
i1  5  1.5    800    .      .      8      3    
i1  7  1.5    800    .      .      8      4    
i1  9  1.5    800    .      .      8      5    

e


