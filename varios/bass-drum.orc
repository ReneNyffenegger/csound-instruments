;ORC
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
instr     1                   ; BASS DRUM coded by Radu Grigorovici
  idur      =  p3
  iamp      =  p4
  kamp1     linseg    p4/8, p3/16, 2*p4/3, 3*p3/16, 5*p4/6, p3/4, p4, p3/4, 5*p4/6, 3*p3/16, p4/2, p3/16, 0
  kamp2     linseg    0, p3/16, p4/2, 3*p3/16, p4/4, p3/4, p4/8, p3/4, p4/16, 3*p3/16, p4/32, p3/16, 0
  kfre      linseg    4000, p3/32, 220, p3-p3/16, 55,     3*p3/32, 20
  kcut      expseg    1, p3, 0.1
  a11       oscili    kamp1, kfre, 1
  a21       rand      kamp2
  a22       butterlp  a21, 1000*kcut
  a31       oscili    kamp1, 35, 1
  a32       =  a31/8
  a4        =  a11+a22+a32
  a5        balance   a4, a11
            outs      a5, a5
endin
