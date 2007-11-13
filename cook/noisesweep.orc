sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1 

instr    1 ; Noise With Filter Sweep.

ileng  = p3
ilevl  = p4*16000
ivcf1  = p5
ivcf2  = p6
iband  = p7

k1       expseg  ivcf1, ileng, ivcf2
k2       linseg  0, .01, 1, ileng-.02, 1, .01, 0
anoise   rand  ilevl
a1       reson  anoise, k1, iband, 2
out      a1*k2

endin

