; SAMPLE SCORE #3
; TEMPO = 25 BEATS/MIN
t00     60                              ;25
; SIMPLE SINE FUNCTION
f01 0 512   10    1  
; RAMP
f02 0 513   7     0     512   1 
; EXPONENTIAL RISE
f03 0 513   5     .001  512   1 
; QUARTER SINE WAVE IN 128 LOCS + EXTENDED GUARD POINT
f04 0 129   9     .25   1     0   
; QUARTER COSINE
f05 0 129   9     .25   1     90  
; TRIANGULAR WAVE
f06 0 512   10    1     0     .111  0     .04   0     .02   0     .012
; SAWTOOTH WAVE
f07 0 512   10    1     .5    .3    .25   .2    .167  .14   .125  .111
; SQUARE WAVE
f08 0 512   10    1     0     .3    0     .2    0     .14   0     .111
; NARROW PULSE
f09 0 512   10    1     1     1     1     .7    .5    .3    .1 
; EXPONENTIAL RISE AND DECAY
f10 0 513   5     .1    32    1     480   .01
; REVERSE PYRAMID
f11 0 513   7     1     256   0     256   1 
; TRILL SQUARE
f12 0 513   7     0     1     .01   1     1     254   1     1     .01   2     0   
;CELLO EXPONENTIAL RISE FOR AMP
f13 0 513   5     .001  51    1     102   .2    359   1 
;CELLO EXPONENTIAL RISE FOR INDEX
f14 0 513   5     .001  102   1     102   .6    308   1 
;CELLO INV EXPONENTIAL RISE FOR AMP
f15 0 513   5     .001  51    1     308   .2    153   .01
;BELL EXPONENTIAL RISE FOR AMP
f16 0 513   5     .001  25    1     77    .6    210   .6    100   .7    100   .4
;BELL EXPONENTIAL RISE FOR AMP
f17 0 513   5     .001  25    1     77    .4    210   .4    150   .5    50    .2 
f0  20
e
