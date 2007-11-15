  sr        =  44100
  kr        =  4410
  ksmps     =  10

;i1 0 dur file skip ; raw read
;i2 0 dur file skip gain ; gain read
;i3 0 dur file skip atk dk gain
;raw
instr 1
  asig      soundin   p4,p5
            out       asig
endin
;gain no env
instr 2
  iamp      =  p6
  asig      soundin   p4,p5
  asig      =  asig * iamp
            out       asig
endin
;gain env
instr 3
  iatk      =  p6
  idk       =  p7
  isust     =  p3-(iatk+idk)
  iamp      =  p8
  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  asig      soundin   p4,p5
  asig      =  asig * aenv
            out       asig
endin
instr 100
endin
