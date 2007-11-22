  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;This is a stereo sine wave generator instrument
;The left channel has the fundamental, the right has the 4th partial
;Designed by the 329J class at UT Austin on 9-4-2003

instr   1
  idur      =  p3
  iamp      =  p4                                 ;p4 is a raw amplitude
  ipitch    =  cpspch(p5)                         ;p5 is the pitch in pch format
  irise     =  p6
  idec      =  p7
  isine     =  p8                                 ;p8 has the oscil wave table

  kenv      linen     iamp, irise, idur, idec
  asig1     oscili    kenv, ipitch, isine
  asig2     oscili    kenv, ipitch*4, isine
            outs      asig1,asig2
endin
