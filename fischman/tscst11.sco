;TSCST11.SCO
;             (c) Rajmil Fischman, 1997
;--------------------------------------
;INPUT OSCILLATOR: SINWAVE
f1  0 8192  10    1  
;WAVESHAPING FUNCTIONS
;NO DISTORTION (LINEAR)
f2  0 8192  7     -1    8192  1
;CLOSE TO LINEAR FUNCTION (SECOND HALF OF COSINE)
f3  0 8192  9     0.5   1     270 
;HEAVIER DISTORTION (DISCONTINUOUS FUNCTION)
f4  0 8192  7     -1    2048  -1    0     0.3   2048  0     0     -0.5  2048  0     0     0.8   2048  0.8
;--------------------------------------------------
;            p3   p4    p5   p6     p7    p8   p9
;INSTR START DUR  AMP   FREQ ATTACK DECAY OSC  WSH
;                                         FUNC FUNC
;--------------------------------------------------
i12 0  1      20000  440    .1     .1     1      2    
i12 1.5       1      .      .      .1     .1     1      3    
i12 3  1      .      .      .1     .1     1      4    
e
