; ************************************************************************
; ACCCI:     01-01-2B.SCO
; source:    #250 Reedy and Plucked Tones, Choral Effect, Risset(1969)
; coded:     jpg 8/93


; GEN functions **********************************************************
; waveforms
f11 0 1024  10    .4    .3    .35   .5    .1    .2    .15   0     .02   .05   .03;  complex     waveform
;  with 10 harmonics
; envelope
f51 0 513   5     .00195      512   1   ;   exponential increase over 512 points

; score ******************************************************************
;  start  idur  iamp  ifq1    idec
i1  1  .5     8000   486    2           ;   plucked sounds
i1  1.5       .25    .      615    1  
i1  1.75      .25    .      648  

i1  2  1      .      486    2  
i1  2  1      .      615    1.5
i1  2  1      .      729  

i1  2.5       .5     .      1944   .9
i1  2.75      .5     .      1728 
i1  3  .25    .      1640   .5
i1  3.25      .25    .      1458 
i1  3.5       .5     .      1640   1 

i1  4  .9     .      1458   1 
i1  4  .8     .      1230 
i1  4  .9     .      731  
e
