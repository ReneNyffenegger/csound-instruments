; headspins.sco
; s.barrass july 95
;
f1  0 2049  11    8                     ; buzz
f90 0 128   -5    100   126   30    1   ; loudness exponential 
f91 0 1025  10    1                     ; sin

; source
; start up each sound source
;i1  start     dur  channel    ftable pitch
;    1..24 1..16 octave.class
;
;======================================================= 

i1  0  3      1      1      6.00 

;i1  0    3    2    1    7.01

; spin each sound source around
;instr    start     dur  channel   dist angle     height 

i3  0  0.3    1      30     0      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      >      0    
i3  +  .      .      .      360    0  
