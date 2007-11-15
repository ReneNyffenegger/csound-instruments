  sr        =  44100
  kr        =  4410
  ksmps     =  10

instr 1
;file skip gain
  aenv      oscili    p6,1/p3,1
  asig      soundin   p4,p5
            out       asig*aenv
endin
