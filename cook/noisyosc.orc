sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Noisy Oscillator?

ileng    = p3
ilevl    = p4*32767
ipitch   = cpspch(p5)
ioffst   = p6

a1       oscil  1, ipitch + ioffst, 1
a2       oscil  1, ipitch, 1
         tablew  a1, a2, 1, 1, 0, 2
a3       tablei  a1, 1, 1, 0, 1
out      a3*ilevl

endin