sr       = 44100
kr       = 4410
ksmps    = 10
nchnls   = 1

instr    1 ; Variable Pulse VCO

ilevl    = p4*32767   ; Output level
ifreq    = cpspch(p5) ; Pitch
ishape   = p6         ; Pulsewidth

asaw     oscili  1, ifreq, 1
asaw1    limit  asaw, 0, ishape
asaw2    limit  asaw, ishape, 1
aramp    = asaw1*(.5/ishape) + (asaw2 - ishape)*(.5/(1 - ishape))
apulse   table  aramp, 2, 1
out      apulse*ilevl

endin