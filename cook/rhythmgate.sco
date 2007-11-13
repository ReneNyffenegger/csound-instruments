;16th notes   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
f01 0 16 2    1  1  0  1  1  0  1  1  0  1  1  0  1  0  1  0 ; Gate pattern
f02 0 16 2    1  0  1  0  0  0  1  0  0  1  0  0  1  0  0  0 ; Gate pattern 

; Gate shapes
f10 0 1024 -7 1 1024 1          ; 100% On
f11 0 1024 -7 1 512 1 0 0 512 0 ; 50% On
f12 0 1024 -7 1 1024 0          ; Linear decay
f13 0 1024 -5 1 1024 .0001      ; Exponential decay
f14 0 1024 -7 0 512 1 512 0     ; Linear fade in/out

;     Strt  Leng  Levl  Patt  Gate
i01   0.00  1.50  1.00  02    10
i01   2.00  .     .     .     11
i01   4.00  .     .     01    13
e