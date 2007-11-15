  sr        =  44100
  kr        =  4400
  ksmps     =  10

instr 4
  isndfunc  =  4
  ienvfunc  =  p5
  iphase    =  p7
  incr      =  ( sr / p6 ) * p4
  iop3      =  1.0 / p3
  aenv      oscili    1.0, iop3, ienvfunc
  asig      oscili    aenv, incr, isndfunc, iphase
            out       asig
endin
