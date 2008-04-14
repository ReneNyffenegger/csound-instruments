  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2809    ; PITCH CHANGE WITH PRESERVED FORMANT
  ifmod     =  2    
  ispecwp   =  p5                                 ; JUST NEEDS TO BE NON-ZERO
  iend      =  p4
  ktime     line      0, p3, iend
  asig      pvoc      ktime, ifmod, "hellorcb.pvx", ispecwp
            out       asig
endin
