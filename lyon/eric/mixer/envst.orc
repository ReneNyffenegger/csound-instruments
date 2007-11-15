  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 100
endin
;i1 0 dur file skip amp func_number
;i2 0 dur file skip sust1 down up
;i3 0 dur file skip atk dk
instr 1
  iamp      =  p6
  ifunc     =  p7
  iot       =  1/p3
  kenv      oscili    iamp,iot,ifunc
  a1,a2     soundin   p4,p5
            outs      a1*kenv,a2*kenv
endin

instr 2
  isust1    =  p6
  idown     =  p7
  isust2    =  p8
  iup       =  p9
  isust3    =  p3-(p6+p7+p8+p9)
  kenv      linseg    1,isust1,1,idown,0,isust2,0,iup,1,isust3,1
  a1,a2     soundin   p4,p5
            outs      a1*kenv,a2*kenv
endin
instr 3
  iup       =  p6
  idown     =  p7
  isust     =  p3-(iup+idown)
  iamp      =  1
  kenv      linseg    0,iup,iamp,isust,iamp,idown,0
  a1,a2     soundin   p4,p5
            outs      a1*kenv,a2*kenv
endin
instr 4
  a1,a2     soundin   p4,p5
            outs      a1,a2
endin
