sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Reads and writes same table - quantisation hell!

ilevl    = p4*32767   ; Output level
ipitch   = cpspch(p5) ; Pitch
iofset   = p6         ; ?

a1       oscil 1, ipitch + iofset, 1
a2       phasor  ipitch
         tablew  a1, a2, 1, 1, 0, 2
a3       table  a1, 1, 1, 0, 1
out      a3*ilevl

endin