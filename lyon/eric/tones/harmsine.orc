  sr        =  44100
  kr        =  44100
  ksmps     =  1

instr 2
  igain     =  1.0
  iatk      =  .02
  idk       =  .02
  isust     =  p3-(iatk+idk)
  gaenv     linseg    0,iatk,igain,isust,igain,idk,0
endin
instr 1
  iamp      =  20000
  ifreq     =  p4
  ifunc     =  p5
  asig      oscili    iamp,ifreq,ifunc
            out       asig*gaenv
endin
