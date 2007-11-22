;=======================================================================;
; AMBUZZ          Score for Amplitude Modulation Buzz by Molyneux       ;
;=======================================================================;
; p6     =        rate of modulation                                    ;
; p7     =        modulation depth %                                    ;
; p8     =        function for mod rate                                 ;
; p9     =        function for mod depth                                ;
; p10    =        amount of portamento in oct.decimal                   ;
; p11    =        function for portamento                               ;
;=======================================================================;
; sine
f1  0 512   10    1  
; linear rise
f2  0 513   7     0     513   1 
; linear fall
f3  0 513   7     1     513   0 
; exponential rise
f4  0 513   5     .001  513   1 
; exponential fall
f5  0 513   5     1     512   .00001      1     .00001
; sine function for buzz unit
f6  0 8192  10    1  
; function for modulator rate
f7  0 513   5     .001  62    .9    150   .65   200   .97   51    .78   50    1  
; function for modulator depth
f8  0 513   5     .5    163   .39   200   .97   150   .61
; function for portamento
f9  0 513   7     0     105   .4    31    .25   105   .65   31    .50   105   .90   31    .75   105   1 
;=======================================================================;
; AMBUZZ     p4      p5     p6     p7     p8   p9   p10      p11        ;
;            amp     pch    mrate  mdpth  mrfn mdfn portdev  portfn     ;
;=======================================================================;
i1  0  2.0    20000  9.08   110    0.40   4      4      -0.09  4
i1  3  0.8    20000  11.10  624    0.40   5      5      0.00   3 
i1  5  0.8    6900   8.09   624    0.40   5      5      -0.25  2
i1  7  0.7    8600   9.02   836    0.40   5      5      -0.08  2
i1  9  1.0    11000  9.03   1642   0.40   5      5      0.34   2 
e
