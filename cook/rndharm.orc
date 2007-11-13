sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Random Harmonic Sequence Generator

ilevl    = p4*32767   ; Output level
ipitch   = cpspch(p5) ; Pitch
irate    = p6         ; Rate
itabl    = p7         ; Envelope shape
idet     = p8         ; Detune

iseed    = rnd(1)                           ; Generate random seed value
krnd     randh  16, irate, iseed            ; Generate random steps
krnd     = int(krnd + 17)                   ; Quantise steps
kscale   = (32 - krnd)/32                   ; Reduce level of high harmonics
kenv     oscil  kscale, irate, itabl        ; Generate envelope table
aosc     oscil  kenv, ipitch*krnd + idet, 1 ; Generate pitches
out      aosc*ilevl                         ; Level and output

endin
