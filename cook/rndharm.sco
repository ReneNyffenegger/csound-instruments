f01 0 1024 10 1 ; Sine
;Envelope shapes
f02 0 1024 5 1 1024 .001        ; Exponential decay
f03 0 1024 7 1 1024 0           ; Linear decay
f04 0 1024 20 2                 ; Hanning
f05 0 1024 20 6                 ; Gaussian
f06 0 1024 7 0 12 1 1000 1 12 0 ; Level

;     Strt  Leng  Levl  Pitch Rate  Shape Detune
i01   0.00  4.00  0.25  10.00 8.00  04    0.00
i01   .     .     .     10.00 12.0  .     ~
i01   .     .     .     10.00 16.0  .     ~
i01   .     .     .     10.00 24.0  .     ~
i01   .     .     .     10.00 32.0  .     ~
i01   .     .     .     10.00 48.0  .     2.00
e
