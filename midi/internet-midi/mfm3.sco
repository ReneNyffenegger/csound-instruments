; JOHN M. ARNOTT II
; FM TONES USING A SIMPLE FM ORCHESTRA AND SPECIFIC FCARDS.
; 1 BEAT/SECOND
t00     60  
; SINE
f01 0 512   10    1  
; EXPONENTIAL DECAY
f02 0 513   5     1     512   .001  1     .001
; ENVELOPE F1 FOR PART C
f03 0 512   6     .8    64    1     64    1     128   .5    128   .2    32    .13   32    .1    32    .05   32    0  
; ENVELOPE F2 FOR PART C
f04 0 512   7     1     120   0 
; ENVELOPE FOR PART D
f05 0 512   7     0     100   1     100   .7    220   .7    98    0  
f0  30
