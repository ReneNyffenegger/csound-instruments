f01 0 8193 10 1                    ; Sine
f02 0 8193 7 -1 4096 1 4096 -1     ; Tri
f03 0 8193 10 1 0 0 0 0 0 0 0 0 .1 ; Slow and fast sines

;Depth and delay in ms. Phase in degrees

;                             ------------LFOs------------
;     Strt  Leng  Levl  Delay Depth RateL rateR Phase Wave  Fdbk1 Fdbk2 XFdbk Mix
i01   0.00  1.50  0.50  1.00  3.00  0.67  0.67  90    02   -0.75 -0.75  0.75  1.00
i01   2.00  .     .     .     4.00  .     0.87  125   03   -0.25 -0.25  .     .
e