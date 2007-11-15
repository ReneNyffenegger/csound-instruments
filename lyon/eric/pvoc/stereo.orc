  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipo      =  1.570796

; read function using phasor
instr 1
  isine     =  1
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  iloc      =  p7
  ileft     =  cos(gipo*iloc)
  iright    =  sin(gipo*iloc)
  ispeed    =  (1/p3)
  kdx       phasor    ispeed
  kamp      tablei    kdx*ipts, iampfunc
  kfreq     tablei    kdx*ipts, ifreqfunc
  asig      oscil     kamp , kfreq, isine
            outs      asig*ileft, asig*iright
endin
