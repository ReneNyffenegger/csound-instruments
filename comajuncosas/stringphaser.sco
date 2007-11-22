; stringphaser.sco

f1  0 32768 10    1                     ; Sine wave for delay line modulation
f2  0 8192  9     1     1     .25       ; Cosine wave for gbuzz

;several shapes for the lfo
f10 0 32768 10    1                     ;sine
f11 0 32768 7     0     15360 1     2048  -1    15360 0;saw up
f12 0 32768 7     0     15360 -1    2048  1     15360 0;saw down
f13 0 32768 7     0     8192  1     8192  0     8192  -1    8192  0 ;triangle

; freeverb time constants, as direct (negative) sample, with arbitrary gains
f71 0 16    -2    -1116 -1188 -1277 -1356 -1422 -1491 -1557 -1617 0.8   0.79  0.78  0.77  0.76  0.75  0.74  0.73  
f72 0 16    -2    -556  -441  -341  -225  0.7   0.72  0.74  0.76

; Global instrument for ensemble/phaser effect. p4 sets amount
; of pitch change in chorusing.
f0  3600
i22 0  3600   .9

; Global instrument for reverb.
i99 0  3600   .93    1.2    1      7000   1 
e
; Individual notes.
i19 0  5      3000   6.07
i19 0  5      3000   5.07
i19 0  5      3000   8.07
i19 0  5      3000   8.10
i19 0  5      3000   9.02
i19 4  5      3000   6.05
i19 4  5      3000   5.05
i19 4  5      3000   8.05
i19 4  5      3000   8.08
i19 4  5      3000   9.00
i19 8  5      3000   6.00
i19 8  5      3000   5.00
i19 8  11     3000   8.00
i19 8  5      3000   8.03
i19 8  5      3000   8.07
i19 12 8      3000   6.02
i19 12 8      3000   5.02
i19 12 8      3000   8.06
i19 12 8      3000   8.09
e
