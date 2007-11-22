  sr        =  44100
  kr        =  4410
  ksmps     =  10.0
  nchnls    =  1

instr     1
  aw1       oscili    p4,cpspch(p5),p7
  aw2       oscili    1,cpspch(p6),p8
  aw3       =  (aw1) * (aw2)
            out       aw3
endin
