instr   1
  iamp      =  p4
  icps      =  cpspch(p5)
  asig      oscili    iamp,icps,1                 ;function 1 has the waveshape
  asig      linen     asig,.05,p3,.1
            out       asig
endin
