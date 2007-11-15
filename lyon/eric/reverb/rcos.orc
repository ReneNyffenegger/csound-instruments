  sr        =  8192
  kr        =  8192

  ksmps     =  1

; raised cosine generator
;f1 0 8192 10 1
;i1 0 1.0

instr 1
  ibase     =  .05
  iamp      =  1.0-ibase
  asig      oscili    .5,1/p3,1,.75
  asig      =  ((asig + .5) * iamp)+ibase
            out       asig*32767.
endin

instr 2
  asig      oscili    1.0, 1/p3,2
            out       asig
endin
