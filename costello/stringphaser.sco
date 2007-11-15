; stringphaser.sco

f1  0 8192  10    1                     ; Sine wave for delay line modulation
f2  0 8192  9     1     1     .25       ; Cosine wave for gbuzz
f3  0 16384 9     .5    -1    0         ; Inverted half-sine for phaser modulation

; Global instrument for ensemble/phaser effect. p4 sets amount
; of pitch change in chorusing.
i22 0  20     .9  

; Global instrument for reverb.
i99 0  24     .93    1.2    1      7000   1 

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
