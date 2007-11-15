  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

; read function using phasor
instr 1
  isine     =  1
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  ispeed    =  (1/p3)
  kdx       phasor    ispeed
  kamp      tablei    kdx*ipts, iampfunc
  kfreq     tablei    kdx*ipts, ifreqfunc
  asig      oscil     kamp , kfreq, isine
            out       asig
endin
