f01 0 4097 7 0 1024 .5 2048 .95 1024 1 ; Compress - medium
f02 0 4097 9 .25 1 0                   ; Compress - sine curve
f03 0 4097 7 0 1024 .95 3072 1         ; Compress - severe
f04 0 4097 7 0 1024 0 0 1 3072 1       ; Gate 1/4
f05 0 4097 7 0 2048 0 0 1 2048 1       ; Gate 1/2
f06 0 4097 -7 0 3584 1 512 1           ; Limit 7/8
f07 0 4097 -7 0 3072 1 1024 1          ; Limit 3/4
f08 0 4097 7 0 24 .25 1000 .25 3072 1  ; Detail lift
f09 0 4097 7 0 96 1 4000 0             ; Invert
f10 0 65 21 1                          ; Random
f11 0 4097 10 0 0 0 0 0 0 1            ; Granular

;     Strt  Leng  Levl  Curve
i01   0.00  1.47  0.99  03
e