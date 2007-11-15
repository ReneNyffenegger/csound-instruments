;1109.SCO  SINEWAVE MODULATING SINEWAVE
;            (C) RAJMIL FISCHMAN, 1997
;----------------------------------------
;sinewave
f 1 0 8192  10    1      

;SECTION 1      CARRIER 400 HZ, MODULATOR 10 HZ
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i 1108 0      2      15000  400    .3     .3     1   
i 1108 3      2      15000  10     .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i 1109 6      2      25000  400    .3     .3     10     1   
s
;SECTION 2      CARRIER 400 HZ, MODULATOR 170 HZ
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i 1108 1      2      15000  400    .3     .3     1   
i 1108 4      2      15000  170    .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i 1109 7      2      25000  400    .3     .3     170    1  
s
;SECTION 3      CARRIER 400 HZ, MODULATOR 385 HZ
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i 1108 1      2      15000  400    .3     .3     1   
i 1108 4      2      15000  385    .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i 1109 7      2      25000  400    .3     .3     385    1  
