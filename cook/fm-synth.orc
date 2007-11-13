sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; 4-Operator FM

a1       init 0       ; Operator 1
a2       init 0       ; Operator 2
a3       init 0       ; Operator 3
a4       init 0       ; Operator 4
aout     init 0       ; Output

ipitch   = cpspch(p4) ; Pitch
ilevel   = p5         ; Operator levels

iratio1  table  0, 50 ; Ratio 1
idet1    table  1, 50 ; Detune 1
iwave1   table  2, 50 ; Waveform 1
itime1   table  3, 50 ; Env time 1
itabl1   table  4, 50 ; Env shape 1
isens1   table  5, 50 ; Env level sensitivity
iratio2  table  6, 50 ; Ratio 2
idet2    table  7, 50 ; Detune 2
iwave2   table  8, 50 ; Waveform 2
itime2   table  9, 50 ; Env time 2
itabl2   table 10, 50 ; Env shape 2
isens2   table 11, 50 ; Env level sensitivity
iratio3  table 12, 50 ; Ratio 3
idet3    table 13, 50 ; Detune 3
iwave3   table 14, 50 ; Waveform 3
itime3   table 15, 50 ; Env time 3
itabl3   table 16, 50 ; Env shape 3
isens3   table 17, 50 ; Env level sensitivity
iratio4  table 18, 50 ; Ratio 4
idet4    table 19, 50 ; Detune 4
iwave4   table 20, 50 ; Waveform 4
itime4   table 21, 50 ; Env time 4
itabl4   table 22, 50 ; Env shape 4
isens4   table 23, 50 ; Env level sensitivity
i01      table  0, 60
i02      table  1, 60
i03      table  2, 60
i04      table  3, 60
i05      table  4, 60
i06      table  5, 60
i07      table  6, 60
i08      table  7, 60
i09      table  8, 60
i10      table  9, 60
i11      table 10, 60
i12      table 11, 60
i13      table 12, 60
i14      table 13, 60
i15      table 14, 60
i16      table 15, 60
i17      table 16, 60
i18      table 17, 60
i19      table 18, 60
i20      table 19, 60
itime1   = (itime1 = 0 ? p3 : itime1)     ; Env time p3 or fixed
itime2   = (itime2 = 0 ? p3 : itime2)     ; Env time p3 or fixed
itime3   = (itime3 = 0 ? p3 : itime3)     ; Env time p3 or fixed
itime4   = (itime4 = 0 ? p3 : itime4)     ; Env time p3 or fixed
kind1    line  0, itime1, 1               ; Time line 1
kind2    line  0, itime2, 1               ; Time line 2
kind3    line  0, itime3, 1               ; Time line 3
kind4    line  0, itime4, 1               ; Time line 4
kenv1    table  kind1, itabl1, 1          ; Env 1
kenv2    table  kind2, itabl2, 1          ; Env 1
kenv3    table  kind3, itabl3, 1          ; Env 1
kenv4    table  kind4, itabl4, 1          ; Env 1
afreq1   = ipitch*iratio1 + a1 + idet1    ; Calculate FM 1
afreq2   = ipitch*iratio2 + a2 + idet2    ; Calculate FM 2
afreq3   = ipitch*iratio3 + a3 + idet3    ; Calculate FM 3
afreq4   = ipitch*iratio4 + a4 + idet4    ; Calculate FM 4
ilevl1   = 1 - (1 - ilevel)*isens1        ; Calculate level sensitivity
ilevl2   = 1 - (1 - ilevel)*isens2        ; Calculate level sensitivity
ilevl3   = 1 - (1 - ilevel)*isens3        ; Calculate level sensitivity
ilevl4   = 1 - (1 - ilevel)*isens4        ; Calculate level sensitivity
aop1     oscil  kenv1*ilevl1, afreq1, iwave1         ; Oscillator 1
aop2     oscil  kenv2*ilevl2, afreq2, iwave2         ; Oscillator 2
aop3     oscil  kenv3*ilevl3, afreq3, iwave3         ; Oscillator 3
aop4     oscil  kenv4*ilevl4, afreq4, iwave4         ; Oscillator 4
a1       = aop1*i01 + aop2*i06 + aop3*i11 + aop4*i16 ; Op-1
a2       = aop1*i02 + aop2*i07 + aop3*i12 + aop4*i17 ; Op-2
a3       = aop1*i03 + aop2*i08 + aop3*i13 + aop4*i18 ; Op-3
a4       = aop1*i04 + aop2*i09 + aop3*i14 + aop4*i19 ; Op-4
aout     = aop1*i05 + aop2*i10 + aop3*i15 + aop4*i20 ; Output
out      aout

endin