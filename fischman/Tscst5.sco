;TSCST5.SCO   NOISE AND TRAIN OF PULSES GENERATORS
;             (c) Rajmil Fischman, 1997
;------------------------------------------------
;SINEWAVE
f1  0 8192  10    1  
;NOISE with RAND
;------------------------------------------
;            p3   p4    p5     p6     p7      
;INSTR START DUR  AMP   UNUSED ATTACK DECAY      
;------------------------------------------
i5  0  2      9000   0      .1     .1  
s
;TRAIN of PULSES with BUZZ
;------------------------------------------
;            p3   p4    p5     p6     p7      
;INSTR START DUR  AMP   FREQ   ATTACK DECAY      
;------------------------------------------
i6  1.5       2      30000  75     .1     .1      
e
