  sr        =  44100
  kr        =  4410
  ksmps     =  10

;i1 0 dur file skip speed seed
instr 1
  idepth    =  .9
  id2       =  idepth/2
  ibase     =  (1. - idepth)+id2

  asig      soundin   p4,p5
  aenv      randi     id2, p6, p7
  aenv      =  aenv+ibase
            out       asig*aenv
endin
