
f1  0 512   9     1     1     0         ;SINE LO-RES
f2  0 512   5     4096  512   1         ;EXP ENV
f3  0 512   9     10    1     0     16    1.5   0     22    2     0     23    1.5   0 ;INHARM WAVE
f4  0 512   9     1     1     0         ;SINE
f8  0 512   5     256   512   1         ;EXP ENV
f9  0 512   5     1     512   1         ;CONSTANT VALUE OF 1
f10 0 512   7     0     50    1     50    .5    300   .5    112   0 ;ADSR
f11 0 2048  10    1                     ;SINE WAVE HI-RES
f13 0 1024  7     0     256   1     256   0     256   -1    256   0 ;TRIANGLE
f14 0 512   7     1     17    1     0     0     495 ;PULSE FOR S&H CLK OSC
f15 0 512   7     0     512   1     0   ;RAMP UP;;;LEFT=>RIGHT
f16 0 512   7     1     512   0     0   ;RAMP DOWN;;;RIGHT=>LEFT
f17 0 1024  7     .5    256   1     256   .5    256   0     256   .5 ;TRIANGLE WITH OFFSET
f18 0 512   5     1     512   256       ;REVERSE EXP ENV
f20 0 1024  10    1     0     0     0     .7    .7    .7    .7    .7    .7 ;APPROACHING SQUARE

;============================================
;
;    CASCADE HARMONICS
;
;=============================================
;instr    start   dur     freq    amp     offset
;p1  p2   p3   p4   p5   p6

i8  80 80     93     375    .03         ;.075

f0  30
e
