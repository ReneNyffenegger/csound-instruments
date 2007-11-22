; LUX HOMINUM ARTHUR B. HUNKINS 1995
; PROGRAMMED IN CSOUND
; FIXED START TIMES 
; THIS SCORE NOT PROCESSED BY SCORE11
; FOR USE WITH lux.orc 

f1  0 2048  10    1                     ; hi-res sine
f2  0 2048  9     1     1     0     3     .111  180   5     .004  0 ; hi-res pseudo-triangle 
f3  0 2048  -8    -1    1     -.995 511   1     511   -.995 1     -1 ; single peak hi-res sine 
f4  0 2048  -8    -1    1     -.995 511   1     511   -.995 1     -1    1     -.995 511   1     511   -.995 1     -1 ; double peak hi-res sine
f5  0 512   -8    0     256   .3    256   1     256   3.33  256   11 ; sone curve conversion table 
f6  0 16    -2    .5    1     2     3     4     5     6     7     8     9     10    12 ; mod freq mult fac 
f7  0 32    -2    .5    1.05  2     1.35  1     1.05  .5    .75   2     .95   1     .9    .5    1.15  2     1.25  1 1.3 .5 1.3 2 1.45 1 1.15 ; carrier freq mult fac 1
f8  0 32    -2    1     1.3   .5    .95   2     1     1     .85   .5    .9    2     1.2   1     1.4   .5    1.1   2 1.1 1 1.25 .5 1.4 2 1.45 ; carrier freq mult fac 2
f9  0 32    -2    2     .9    1     1.05  .5    .95   2     .9    1     .95   .5    1.1   2     1.1   1     1.2   .5 1.25 2 1.2 1 1.15 .5 1.15 ; carrier freq mult fac 3
f10 0 32    -2    .5    .85   2     .95   1     1.3   .5    .8    2     1.05  1     .85   .5    .8    2     1.15  1 1.2 .5 1.15 2 1.2 1 1.3 ; carrier freq mult fac 1--triangle 
f11 0 32    -2    1     1     .5    1.15  2     .9    1     1     .5    .8    2     .95   1     1     .5    .95   2 1 1 1.15 .5 1.05 2 1.15 ; carrier freq mult fac 2--triangle 
f12 0 32    -2    2     1.05  1     1.1   .5    1.1   2     .85   1     .9    .5    .95   2     1.1   1     1.15  .5 1.2 2 1.25 1 1.1 .5 1.2 ; carrier freq mult fac 3--triangle 
f13 0 8193  -9    .25   1     0;    first quad  sin

; THE TEMPO INDICATED BELOW (60) MAY BE CHANGED TO ANY SPEED BETWEEN 40-66 

t0      40   

; modify the final (tone color) values for i3 and i4 lines below as follows: 
; if 1-6, any other integer between 1-6 (i3) 
; if 7-12, any other integer between 7-12 (i4) 
; use each integer ONCE ONLY

i1  1  56
i2  25 72
i3  65 72     1                         ; exchange 1 with any exclusive integer 1-6 
i4  105       72     7                  ; exchange 7 with any exclusive integer 7-12 
i3  145       72     2                  ; exchange 2 with any exclusive integer 1-6 
i4  185       72     8                  ; exchange 8 with any exclusive integer 7-12 
i3  225       72     3                  ; exchange 3 with any exclusive integer 1-6 
i4  265       72     9                  ; exchange 9 with any exclusive integer 7-12 
i3  305       72     4                  ; exchange 4 with any exclusive integer 1-6 
i4  345       72     10                 ; exchange 10 with any exclusive integer 7-12 
i3  385       72     5                  ; exchange 5 with any exclusive integer 1-6 
i4  425       72     11                 ; exchange 11 with any exclusive integer 7-12 
i3  465       72     6                  ; exchange 6 with any exclusive integer 1-6 
i4  505       72     12                 ; exchange 12 with any exclusive integer 7-12 
i15 545       72    
i16 585       54    
f0  640
