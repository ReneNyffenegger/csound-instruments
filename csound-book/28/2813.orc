  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2813    ; LOWPASS FILTERED SPECTRUM
  ifreqscale   =      1
  ispecwp   =  0
  iend      =  p4
  ispecfn   =  p5   
  ktime     line      0, p3, iend
  asig      vpvoc     ktime, ifreqscale, "violin.pvc", ispecwp, ispecfn
            out       asig
endin
