sr       = 44100
kr       = 44100
ksmps    = 1
nchnls   = 1

instr    1 ; 4 Sub Octaves (Sub harmonics) Based on an orc by Paul M Winkler

ilevl    = p4*32767                      ; Output level
ioct1    = p5                            ; Octave 1 level
ioct2    = p6                            ; Octave 2 level
ioct3    = p7                            ; Octave 3 level
ioct4    = p8                            ; Octave 4 level
imix     = p9                            ; Mix: 0=Input 1=Octaves
inorm    = 1/(p5 + p6 + p7 + p8)         ; Normalizing factor
kcount   init 0                          ; Initialize counter
kloop    init 0                          ; Initialize loop

ain      soundin  "sample1.wav"

kin      downsamp  ain                   ; Convert to kr
ktrig    trigger  kin, 0, 0              ; Detect zero crossings
if       ktrig == 0 goto output          ; Do nothing if no zero cross
kcount   = kcount + 1                    ; Increment counter
kloop    wrap  kcount, 0, 16             ; Wrap counter at 16
01:
if       kloop != 01 goto 02             ; If count is not 1 skip to 2
aoct1    = -1                            ; Set bit 1
aoct2    = -1                            ; Set bit 2
aoct3    = -1                            ; Set bit 3
aoct4    = -1                            ; Set bit 4
goto     output                          ; Goto output
02:
if       kloop != 02 goto 03
aoct1    = +1
aoct2    = -1
aoct3    = -1
aoct4    = -1
goto     output
03:
if       kloop != 03 goto 04
aoct1    = -1
aoct2    = +1
aoct3    = -1
aoct4    = -1
goto     output
04:
if       kloop != 04 goto 05
aoct1    = +1
aoct2    = +1
aoct3    = -1
aoct4    = -1
goto     output
05:
if       kloop != 05 goto 06
aoct1    = -1
aoct2    = -1
aoct3    = +1
aoct4    = -1
goto     output
06:
if       kloop != 06 goto 07
aoct1    = +1
aoct2    = -1
aoct3    = +1
aoct4    = -1
goto     output
07:
if       kloop != 07 goto 08
aoct1    = -1
aoct2    = +1
aoct3    = +1
aoct4    = -1
goto     output
08:
if       kloop != 08 goto 09
aoct1    = +1
aoct2    = +1
aoct3    = +1
aoct4    = -1
goto     output
09:
if       kloop != 09 goto 10
aoct1    = -1
aoct2    = -1
aoct3    = -1
aoct4    = +1
goto     output
10:
if       kloop != 10 goto 11
aoct1    = +1
aoct2    = -1
aoct3    = -1
aoct4    = +1
goto     output
11:
if       kloop != 11 goto 12
aoct1    = -1
aoct2    = +1
aoct3    = -1
aoct4    = +1
goto     output
12:
if       kloop != 12 goto 13
aoct1    = +1
aoct2    = +1
aoct3    = -1
aoct4    = +1
goto     output
13:
if       kloop != 13 goto 14
aoct1    = -1
aoct2    = -1
aoct3    = +1
aoct4    = +1
goto     output
14:
if       kloop != 14 goto 15
aoct1    = +1
aoct2    = -1
aoct3    = +1
aoct4    = +1
goto     output
15:
if       kloop != 15 goto 16
aoct1    = -1
aoct2    = +1
aoct3    = +1
aoct4    = +1
goto     output
16:
aoct1    = +1
aoct2    = +1
aoct3    = +1
aoct4    = +1
output:
aoct1    = aoct1*ioct1                   ; -1 octave level
aoct2    = aoct2*ioct2                   ; -2 octave level
aoct3    = aoct3*ioct3                   ; -3 octave level
aoct4    = aoct4*ioct4                   ; -4 octave level
aocts    sum  aoct1, aoct2, aoct3, aoct4 ; Sum octaves
aocts    = aocts*inorm                   ; Normalize
aout     = aocts*imix + ain*(1 - imix)   ; Mix input and octaves
out      aout*ilevl                      ; Level and output

endin
