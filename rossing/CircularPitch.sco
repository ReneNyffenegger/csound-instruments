; GENERATE 240 SECONDS OF ENDLESS GLISSANDO WITH A 120 SECOND CYCLE TIME
; FUNCTION 03 READS SOUNDIN.10 THE BELL SHAPED CURVE SPECIFIED BY RISSET IN DODGE

f01 0 512   10    1                     ;SINE WAVE
f02 0 513   7     0     512   1         ;EXPON CURVE
f03 0 4096  1     10    0     6     0   ;SOUNDIN.10 - BELL SHAPED CURVE
f04 0 513   5     1     512   .0009766  ;EXPON CURVE         

; p1      p2    p3    p4       p5          p6
;instr   strt   dur   amp    ifreq    phasor period 
i01 0  120    10000  5000   120

e
