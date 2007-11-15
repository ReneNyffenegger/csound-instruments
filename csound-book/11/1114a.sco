;1114A.SCO    MODULATION WITH VARIOUS C/M VALUES 
;               CARRIER=80 HZ
;               (C) RAJMIL FISCHMAN, 1997
;-------------------------------------------------
;OSCILLATOR FUNCTION: SINEWAVE
f 1 0 8192  10    1  
;------------------------------------------------
;           p3  p4      p5  p6     p7  p8    p9
;INST START DUR AMP    FREQ CARR   MOD INDEX FUNC
;------------------------------------------------
i 1114 0      2      15000  80     1      1      2      1 ;I=2, C/M=1
i 1114 3      .      .      80     13     19     .      . ;I=2, C/M=13/19
i 1114 6      .      .      80     1.4142 1      .      . ;I=2, C/M=1.4142
e
