; ************************************************************************
; ACCCI:     33-10-2.SCO
; coded:     jpg 2/94


; GEN functions **********************************************************
; for both oscillators
f1  0 512   10    1                     ; one sinus
f2  0 512   10    5     4     3     2     1 ; five harmonics


; score ******************************************************************

;    idur iamp  ifqm  ifm istsec      
i1  0  5      8000   200    1      0    ; audio range: split frequencies
i1  +  2      .      100    .      3    ;  "
i1  .  2      .      50     .      2    ;  "
i1  .  2      .      10     .      1    ; sub audio: vibrato effect
i1  .  2      .      5      .      0    ;               "

s  
; section 2: five harmonics modulator

i1  2  2      8000   200    2      3    ; more inharmonics; noise
i1  +  .      .      100    .      3    
i1  .  3      .      50     .      2    
i1  .  4      .      10     .      1    ; vibrato effect
i1  .  5      .      5      .      0    
e