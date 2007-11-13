sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Random stepped wave generator.

ilevl    = p4*32767   ; Output level
ipitch   = cpspch(p5) ; Pitch
imode    = p6         ; Mode: 0=Stepped 1=Interpolated

kdclick  linseg  0, .02, 1, p3-.04, 1, .02, 0
k1       randi  1, 01
k2       randi  1, 02
k3       randi  1, 03
k4       randi  1, 04
k5       randi  1, 05
k6       randi  1, 06
k7       randi  1, 07
k8       randi  1, 08
a1       oscil  1*k1, ipitch, imode
a2       oscil  1*k2, ipitch, imode, .125
a3       oscil  1*k3, ipitch, imode, .250
a4       oscil  1*k4, ipitch, imode, .375
a5       oscil  1*k5, ipitch, imode, .500
a6       oscil  1*k6, ipitch, imode, .625
a7       oscil  1*k7, ipitch, imode, .750
a8       oscil  1*k8, ipitch, imode, .875
aout     sum  a1, a2, a3, a4, a5, a6, a7, a8
out      aout*kdclick*ilevl

endin
