f01 0 8193  10    1                     ; Sine
f02 0 8193  10    1     0     0     0     0     0     0     0     0     .05 ; Fast and slow sines
f03 0 8193  7     -1    4096  1     4096  -1 ; Triangle

;Delay and Depth in ms

;                                   ------------LFOs------------
;        Strt     Leng     Levl     Delay Depth Max   Min      Wave
i01 0.00      1.50   1.00   10.0   5.00   0.75   0.50   01
i01 2.00      .      .      5.00   7.50   1.00   0.50   03
i01 4.00      .      .      10.0   5.00   0.50   0.10   02
e
