f1 0 8192 10 1

;a0 0 20

;   Sta  Dur  Amp    Pch
;i1  10   2    10000  6.00
;i2  12   4    2000   7.00
;i3  16   4    2000   8.00
;i6  20   2    2000   7.00

;   Sta  Dur  Amp  Pch   WAmp  OutX  OutY  OutZ  OutW
;i5  0    10   1000 6.00  10    1     2     3     4
;i5  2    8     500 7.07  10    17    18    19    20
; 4 Space Planar Rotation
; Plane: 1=X-Y, 2=X-Z, 3=Y-Z, 4=X-W, 5=Y-W, 6=Z-W
;    Sta  Dur  Fqc  Phase  Plane  InX  InY  InZ  InW  OutX  OutY  OutZ  OutW
;i51  0    10   0.08 0      1      1    2    3    4    5     6     7     8
;i51  0    10   0.15 0      6      5    6    7    8    9     10    11    12
;i51  0    10   0.05 0      5      9    10   11   12   13    14    15    16
;
;i51  2    8    0.10 0      2      17   18   19   20   21    22    23    24
;i51  2    8    0.05 0      4      21   22   23   24   25    26    27    28
;i51  2    8    0.06 0      3      25   26   27   28   29    30    31    32
; Mixer
;    Sta  Dur  Amp  InCh1  InCh2
;i100 0    10   1    14     16
;i100 2    8    1    29     31

; Clear Zak
;     Sta  Dur
;i110  0    10

; 3 Space Planar Rotation
; 1=X-Y Plane, 2=X-Z Plane, 3=Y-Z Plane
;    Sta  Dur  Fqc  Phase  Plane  InX  InY  InZ  OutX  OutY  OutZ
;i50  0    4    1.5  0      2      1    2    3    4     5     6

f4 0 1024 -7 .25 128 1.2 128 1 768 1 128 .25
f5 0 1024 -7 1 1024 .5
f6 0 1024 -7 1 1024 1
;   Sta  Dur  Amp    Pch   ModDepth  ModRate  PBendTable
i8  0.0  10.0 6000   6.04  .75 
i8  5.0  10.0 6000   5.00  .75 
i9 10.0  2.0  6000   8.00  3         .5       4
i9  +    2.0  6000   8.04  3         .5       5
i9  .    2.0  6000   8.00  3         .5       6

