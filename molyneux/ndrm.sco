;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;       SCORE FOR  NOISY  DRUM ORCHESTRA FILE          ;
;    P3 = DURATION                           ;
;    P4 = AMPLITUDE                          ;
;    P5 = PITCH IN PCH                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    SINE WAVE
f1  0.00    512   10    1  
;    LINEAR RISE
f2  0.00    513   7     0     512   1     1     1   
;    LINEAR DECAY
f3  0.00    513   7     1     512   0     1     0   
;    EXPONENTIAL RISE
f4  0.00    513   5     0.001 512   1     1     1   
;    EXPONENTIAL DECAY
f5  0.00    513   5     1     512   0.001 1     0.001
;
;    INSTRUMENT CARDS
;
i1  0.00      5.00   16000  12.00  -1.00
e
