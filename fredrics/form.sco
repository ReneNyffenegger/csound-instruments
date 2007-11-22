;HOWARD FREDRICS
;7:41PM  2/23/1989
;MUS329J
;
;====================================================================;
;                       FORMANT SCORE                          
;====================================================================;
;
; TEMPO IN BEATS/MIN
t00     60      5       60      5       120   
; SIMPLE SINE FUNCTION
f01 0 512   10    1  
; Ramp
f02 0 513   7     0     512   1 
; EXPONENTIAL RISE
;f03     0       513     5       .001    512     1
; QUARTER SINE WAVE IN 128 LOCS + EXTENDED GUARD POINT
;f04     0       129     9       .25     1       0
; QUARTER COSINE
;f05     0       129     9       .25     1       90
; TRIANGULAR WAVE
;f06     0       512     10      1   0 .111   0  .04    0  .02    0 .012
; SAWTOOTH WAVE
;f07     0       512     10      1  .5   .3 .25   .2 .167  .14 .125 .111
; SQUARE WAVE
;f08     0       512     10      1   0   .3   0   .2    0  .14    0 .111
; NARROW PULSE
;f09     0       512     10      1 1  1   1 .7 .5 .3 .1
; EXPONENTIAL RISE AND DECAY
;f10     0       513     5       .1      32      1       480     .01
; REVERSE PYRAMID
;f11     0       513     7       1       256     0       256     1
;=========================================================================;
;                           PARAMETER FIELDS                         
; P1   =       INSTRUMENT #
; P2   =       START TIME
; P3   =       DURATION IN SECONDS     (IDUR)
; P4   =       MAX PEAK AMP OF NOTE    (IPKAMP)
; P5   =       FUNDAMENTAL FREQUENCY   (IFUND)
; P6   =       FORMANT FREQUENCY       (IFORM)
; P7   =       MAX FREQ. MOD. INDEX    (INDEX)
; P8   =       FM M:C RATIO FOR FUND   (IRATIO)
; P9   =       ATTACK TIME IN SEC.     (ITAK)
; P10  =       DECAY TIME IN SEC.      (IDEC)
; P11  =       RELATIVE AMP OF FORMANT (IFORMAMP)
; P12  =       INITIAL P3              (TO BE USED IN CONVERTING ATT & DEC FROM BEATS TO SECS.
; P13  =       DUMMY P-FIELD
;
;ins    strt    dur     amp     fund    form    index   ratio   att     dec     famp    b/s     dummy
;---    ----    ---     ---     ----    ----    -----   -----   ---     ---     ---     ---     -----
i1  0  1      .8     60     1000   5      2      .1     .2     .3     np13   0 
i1  1  .5     .      50     .      .      .      .      .      .      .      pp3  
i1  +  .      .      52   
i1  +  2      .      52     2000   .      .      .5     .      .      2    
e

