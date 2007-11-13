sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Variable ramp VCO

ilevl    = p4*32767   ; Output level
ifreq    = cpspch(p5) ; Pitch
ishape   = p6         ; Ramp shape

aramp    oscili  1, ifreq, 1
aramp1   limit  aramp, 0, ishape
aramp2   limit  aramp, ishape, 1
aramp3   = aramp1*(1/ishape) - (aramp2 - ishape)*1/(1 - ishape)
aout     = (aramp3 - .5)*2
out      aout*ilevl

endin