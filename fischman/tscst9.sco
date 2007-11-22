;TSCST9.SCO
;            (c) Rajmil Fischman, 1997
;-------------------------------------
;CARRIER WAVEFORM
f1  0 8192  10    1  
;MODULATOR WAVEFORM
f2  0 8192  10    1     .8    .7    .6    .5 
;---------------------------------------------------------
;            p3  p4     p5   p6   p7    p8     p9     p10
;INSTR START DUR AMP    CARR ATT  DEC   MOD    CARR   MOD
;                                       FREQ   FUNC   FUNC
;---------------------------------------------------------
i10 0  2      15000  300    .3     .3     300    1      2    
i10 3  2      .      300    .      .      297.03 .      .    
i10 6  2      .      300    .      .      212.13 .      .    
e
