;TSCST7.SCO  SINEWAVE MODULATING SINEWAVE
;            (c) Rajmil Fischman, 1997
;----------------------------------------
;SINEWAVE
f1  0 8192  10    1      

;SECTION 1      CARRIER 400 hz, MODULATOR 10 hz
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i8  0  2      15000  400    .3     .3     1   
i8  3  2      15000  10     .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i9  6  2      25000  400    .3     .3     10     1   
s
;SECTION 2      CARRIER 400 hz, MODULATOR 170 hz
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i8  1  2      15000  400    .3     .3     1   
i8  4  2      15000  170    .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i9  7  2      25000  400    .3     .3     170    1  
s
;SECTION 3      CARRIER 400 HZ, MODULATOR 385 Hz
;----------------------------------------------
;            p3  p4     p5    p6     p7    p8
;INSTR START DUR AMP    FREQ  ATTACK DECAY FUNC
;----------------------------------------------
i8  1  2      15000  400    .3     .3     1   
i8  4  2      15000  385    .3     .3     1   
;---------------------------------------------------
;            p3  p4     p5    p6     p7    p8   p9
;INSTR START DUR AMP    CARR  ATTACK DECAY MOD  MOD
;                       FREQ               FREQ FUNC
;---------------------------------------------------
i9  7  2      25000  400    .3     .3     385    1  
e
