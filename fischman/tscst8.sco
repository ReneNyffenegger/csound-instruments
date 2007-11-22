;TSCST8.SCO
;            (c) Rajmil Fischman, 1997
;---------------------------------------
;SINEWAVE CARIER WAVEFORM
f1  0 4096  10    1  
;5 HARMONIC MODULATOR WAVEFORM
f2  0 4096  10    1     .95   .86   .77   .68
;--------------------------------------------------
;            p3  p4    p5   p6  p7  p8   p10   p11
;INSTR START DUR AMP   CARR ATT DEC MOD  CARR  MOD
;                      FREQ         FREQ FUNC  FUNC
;--------------------------------------------------
;CARRIER: 440 Hz      MODULATOR: 110 Hz
i10 0  2      15000  440    .3     .3     110    1      2    
;CARRIER: 440 Hz      MODULATOR: 134 Hz
i10 3  2      15000  440    .3     .3     134    1      2    
e
