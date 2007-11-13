f01 0 8193 10 1                ; Sine
f02 0 8193 7 -1 4096 1 4096 -1 ; Triangle
f03 0 8193 10 1 0 0 0 0 0 .14  ; Fast and slow sines

;Delay and Depth in ms  Phase in degrees

;                             ------------LFOs------------
;     Strt  Leng  Levl  Delay Depth RateL RateR Phase Wave  FdbkL FdbkR Mix
i01   0.00  1.50  0.90  0.25  5.75  0.67  0.67  90    02   -0.75  0.75  1.00
i01   2.00  .     0.75  .     3.75  .     .     0     01    0.90  0.90  .
i01   4.00  .     0.90  2.00  0.00  .     .     .     .    -0.66 -0.66  .
e