  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2804
  ifreqscale   =      1    
  ispecwp   =  0
  ibeg      =  0    
  iend      =  p4
  ktime     linseg    0, .1, .1, p3-.2, iend-.1, .1, iend
  asig      pvoc      ktime, ifreqscale, "marimba.pvx", ispecwp
            out       asig
endin
