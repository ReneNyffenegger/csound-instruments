sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Gbuzz instrument.

ilevl    = p4*32767                 ; Output level
ipitch    = cpspch(p5)               ; Pitch
ihigh    = int((.5*sr)/ipitch*p6)   ; Highest harmonic < nyquist
ilow     = p7                       ; Lowest harmonic
iharm1   = p8                       ; Start harmonic curve
iharm2   = p9                       ; End harmonic curve

k1       line  iharm1, p3, iharm2   ; Generate line
abuzz    gbuzz  1, ipitch, ihigh, ilow, k1, 1, -1
out      abuzz*ilevl                ; Level and output

endin