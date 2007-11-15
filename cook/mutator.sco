f01 0 8193  -5    20    8192  10000     ; Exponential convertor
f02 0 8193  9     1     1     180       ; Sine
f03 0 8193  7     0     4096  1     4096  0 ; Triangle
f04 0 1025  7     1     512   1     0     0     512   0 ; Square
f05 0 8193  7     0     8192  1         ; Ramp up
f06 0 8193  10    1     0     0     0     0     0     0     0     0     1 ; Fast and slow sines

;Freq/Depth=0<1, PhseR=0<360 degrees
;                             ------------LFOs-------------
;     Strt  Leng  Gain  Freq  Depth RateL RateR PhseR Waves Rez(0<1)
i01 0.00      1.50   1.25   0.25   0.75   0.36   0.36   180    03     0.90
i01 2.00      .      2.00   0.00   0.50   0.67   0.67   0      05     0.75
e