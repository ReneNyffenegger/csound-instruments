; ************************************************************************
; ACCCI:     01-01-5.SCO
; coded:     jpg 10/93

; GEN functions **********************************************************
; carrier
f1  0 512   10    1  

; envelope for rise shape
f51 0 513   5     .00195      512   1   ;   exponential increase over 512 points


; score ******************************************************************

;  start  idur  iamp    ifq  if1    irise idec if2 iatss iatdec
i1  0  1      8000   440    1      .2     .3     51     1      .01  
i1  2  4      .      .      .      .      .      .      1      .1   
i1  7  .      .      .      .      .      .      .      1      .2 ; noisy cut
i1  12 .      .      .      .      .      .      .      1      1.5 ; noisy cut
i1  17 .      .      .      .      .      .      .      2      .01 ; good effect
i1  22 .      .      .      .      .      .      .      .9     .01    

s
; section 2: idur = 2 sec 
i1  5  1      8000   330    1      .2     .3     51     1      .01  
i1  7  2      .      .      .      .      .      .      1      .1   
i1  10 .      .      .      .      .      .      .      1      .2 ; noisy cut
i1  13 .      .      .      .      .      .      .      1      1.5 ; noisy cut
i1  16 .      .      .      .      .      .      .      2      .01 ; stress
i1  19 .      .      .      .      .      .      .      .9     .01    

e
