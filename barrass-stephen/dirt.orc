  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gir       =  100
  gis       =  1000

instr 1

  kamp      linen     10000, 0.01, p3, 0.1
  ao0       oscili    gir, gis*p4,        1
  ao1       oscili    gir, gis*p5+ao0, 1
  ao2       oscili    gir, gis*p6+ao1, 1
  ao3       oscili    gir, gis*p7+ao2, 1
  ao4       oscili    gir, gis*p8+ao3, 1
  ao5       oscili    kamp, gis*p9+ao4, 1

; SEPARATE d3 AND d4 IN SPACE a1,a2,a3,a4   PAN ao5, p6, p7, 2, 1, 1

            outs      ao1, ao2
endin
