sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; DUY 'Shape' ProTools plugin emulator

ilevl    = p4*32767                 ; Output level
icut1    = p5                       ; Low/Mid crossover freq
icut2    = p6                       ; Mid/High crossover freq
itabl1   = p7                       ; Low waveshape table
itabl2   = p8                       ; Mid waveshape table
itabl3   = p9                       ; High waveshape table

ain      soundin  "sample1.wav"

ain      = ain/65536                ; Scale input
alo      tonex  ain, icut1          ; Lowpass filter
atm      tonex  ain, icut2          ; Lowpass filter
amd      atonex  atm, icut1         ; Highpass filter
ahi      atonex  ain, icut2         ; Highpass filter
alo      tablei  alo, itabl1, 1, .5 ; Waveshape low band
amd      tablei  amd, itabl2, 1, .5 ; Waveshape mid band
ahi      tablei  ahi, itabl3, 1, .5 ; Waveshape high band
amix     sum  alo, amd, ahi         ; Sum bands
amix     dcblock  amix              ; Remove any DC offset
out      amix*ilevl                 ; Level and output

endin
