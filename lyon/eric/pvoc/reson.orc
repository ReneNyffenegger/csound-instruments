  sr        =  44100
  kr        =  4410
  ksmps     =  10

  ginoisp   =  8000
instr 1
  ispeed    =  (1/p3)
  iampfunc  =  p4
  ifreqfunc =  p5
  ipts      =  p6
  iseed     =  p7
  kdx       phasor    ispeed
  kamp      tablei    kdx*ipts, iampfunc
  kfreq     tablei    kdx*ipts, ifreqfunc
        ;anoise randi 10.0,ginoisp,iseed
  anoise    soundin   99,0
  asig      reson     anoise,kfreq,20,1
            out       asig*kamp
endin
