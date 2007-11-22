;AMPLITUDE MODULATION SCORE FILE 
; SINE WAVE
f1  0.0     512   10    1  
; LINEAR RISE
f2  0.0     513   7     0     513   1 
; LINEAR FALL
f3  0.0     513   7     1     513   0 
; EXPONENTIAL RISE
f4  0.0     513   5     .001  513   1 
; EXPONENTIAL FALL
f5  0.0     513   5     1     513   .001
; FUNCTION FOR BUZZ UNIT
f6  0.0     8192  10    1  
; FUNCTION FOR MODULATOR RATE
f7  0.0     513   5     .001  62    .9    150   .65   200   .97   51    .78   50    1  
; FUNCTION FOR MODULATOR DEPTH
f8  0.0     513   5     .5    163   .39   200   .97   150   .61
;    FUNCTION FOR PORTAMENTO
f9  0.0     513   7     0     105   .4    31    .25   105   .65   31    .50   105   .90   31    .75   105   1 

;      INSTRUMENT CARDS

i1  0.00      4.50   10000  8000   6000   0.3    7      8      9    
s
i1  0.00      4.50   10000  3000   10000  0.3    7      8      9    
i1  2.53      4.50   10000  8000   10000  1.0    7      8      9    
i1  4.05      4.50   10000  9000   10000  0.3    7      8      9    
i1  4.97      4.50   10000  10000  10000  1.0    7      8      9    
s
i1  0.00      4.50   10000  4000   3200   1.0    7      8      9    
s
i1  0.00      4.50   10000  1000   8000   1.0    7      8      9    
e
