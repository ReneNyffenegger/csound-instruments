;TSCST14.SCO    MODULATION WITH VARIOUS C/M VALUES 
;               CARRIER=80 Hz
;               (c) Rajmil Fischman, 1997
;-------------------------------------------------
;OSCILLATOR FUNCTION: SINEWAVE
f1  0 8192  10    1  
;------------------------------------------------
;           p3  p4      p5  p6     p7  p8    p9
;INST START DUR AMP    FREQ CARR   MOD INDEX FUNC
;------------------------------------------------
i14 0  2      15000  80     1      1      2      1 ;I=2, c/m=1
i14 3  .      .      80     13     19     .      . ;I=2, c/m=13/19
i14 6  .      .      80     1.4142 1      .      . ;I=2, c/m=1.4142
e
