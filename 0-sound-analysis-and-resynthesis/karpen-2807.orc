  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2807    ; DOWN AN OCTAVE
  ifmod     =  .5
  ispecwp   =  0
  iend      =  p4
  ktime     line      0, p3, iend
  asig      pvoc      ktime, ifmod, "hellorcb.pvx", ispecwp
            out       asig
endin
