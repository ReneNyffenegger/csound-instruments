  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2803
  ifreqscale   =      1
  ispecwp   =  0
  ibeg      =  0    
  iend      =  p4                                 ; p4 = DURATION OF INPUT_SOUND
  ktime     expon     (iend*.5), p3, iend
  asig      pvoc      ktime, ifreqscale, "hellorcb.pvx", ispecwp
            out       asig
endin
