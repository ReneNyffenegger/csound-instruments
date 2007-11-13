sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Raises Signal To nth Power.

ipow1    = p4
ipow2    = p5

k1       linseg  ipow1, p3, ipow2
k2       pow  32767, k1, 32767
a1       soundin  "sample1.wav"
a2       = a1/2 + 16384
a3       pow  a2, k1
out      (a3/k2 - 16384)*2

endin

;
