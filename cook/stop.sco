f01 0 32768 1 "sample1.wav" 0 4 0 ; Stereo sample
f02 0 8193 7 1 8192 0                                              ; Linear
f03 0 8193 5 1 8192 .0001                                          ; Exponential
f04 0 8193 17 0 7 1024 6 2048 5 3072 4 4096 3 5120 2 6144 1 7168 0 ; Stepped
f05 0 8193 13 1 1 0 -1 0 0 0 0 0 0 0 -.1                           ; 'Curvy'

;     Strt  Leng  Levl  Delay Time  Curve
i01   0.00  1.50  1.00  0.75  0.75  02
i01   2.00  .     .     0.00  1.50  04
i01   4.00  .     .     1.00  0.50  03
e