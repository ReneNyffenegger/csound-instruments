  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
  idur      =  p3
  iamp      =  p4
  ifq       =  cpspch(p5)*16
  ibuf      =  128
  if1       =  0
  imeth     =  1
  ileft     =  sqrt (p6)
  iright    =  sqrt (1 - p6)

  kamp      expseg    iamp, 5/10*idur, iamp, 5/10*idur, .0001
  a1        pluck     kamp, ifq, ibuf, if1, imeth
            outs      a1*ileft,a1*iright
endin

instr 2
  idur      =  p3
  iamp      =  p4
  ifq       =  cpspch(p5)*16
  ibuf      =  128
  if1       =  0
  imeth     =  1
  ipan      =  sqrt (.5)

  kamp      linseg    0, 1/10*idur, iamp, 8/10*idur, iamp, 1/10*idur, 0
  a1        pluck     kamp, ifq, ibuf, if1, imeth
            outs      a1*ipan,a1*ipan

endin
