;1110.SCO
;            (C) RAJMIL FISCHMAN, 1997
;---------------------------------------
;SINEWAVE CARIER WAVEFORM
f 1 0 4096  10    1  
;5 HARMONIC MODULATOR WAVEFORM
f 2 0 4096  10    1     .95   .86   .77   .68
;--------------------------------------------------
;            p3  p4    p5   p6  p7  p8   p10   p11
;INSTR START DUR AMP   CARR ATT DEC MOD  CARR  MOD
;                      FREQ         FREQ FUNC  FUNC
;--------------------------------------------------
;CARRIER: 440 HZ      MODULATOR: 110 HZ
i 1110 0      2      15000  440    .3     .3     110    1      2    
;CARRIER: 440 Hz      MODULATOR: 134 Hz
i 1110 3      2      15000  440    .3     .3     134    1      2    
