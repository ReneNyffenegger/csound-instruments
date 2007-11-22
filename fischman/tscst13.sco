;TSCST13.SCO   MODULATION WITH VARIOUS INDEX VALUES 
;              CARRIER=150 HZ, MODULATOR=212 HZ 
;              (c) Rajmil Fischman, 1997
;--------------------------------------------------

;OSCILLATOR FUNCTION: SINEWAVE
f1  0 8192  10    1  
;           p3  p4    p5   p6   p7   p8    p9
;INST START DUR AMP   FREQ CARR MOD  INDEX FUNC
i14 0  2      15000  150    1      2.12   0      1 ;I=0
i14 3  .      .      .      .      .      1      . ;I=1
i14 6  .      .      .      .      .      2      . ;I=2
i14 9  .      .      .      .      .      3      . ;I=3
i14 12 .      .      .      .      .      4      . ;I=4
e
