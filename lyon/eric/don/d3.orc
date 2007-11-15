  sr        =  44100
  kr        =  882
  ksmps     =  50

instr 100
  gkf1      =  1
  gkf2      =  1
  gkf3      =  1
endin
; f1 0 8192 10 1 ; sine
instr 1 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk1       =  k1 + ibasef + iminf
endin
instr 2 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk2       =  k1 + ibasef + iminf
endin
instr 3 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk3       =  k1 + ibasef + iminf
endin
instr 4 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk4       =  k1 + ibasef + iminf
endin
instr 5 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk5       =  k1 + ibasef + iminf
endin
instr 6 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk6       =  k1 + ibasef + iminf
endin
instr 7 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk7       =  k1 + ibasef + iminf
endin
instr 8 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk8       =  k1 + ibasef + iminf
endin
instr 9 ; New instrument for each control function
  ispeed    =  p4
  iminf     =  p5
  imaxf     =  p6
  iseed     =  p7
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  k1        randh     ibasef2, ispeed, iseed
  gk9       =  k1 + ibasef + iminf
endin

instr 10 ; signal generator
  iatk      =  .1
  idk       =  .1
  isust     =  p3-(iatk+idk)
  iamp      =  2000.
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  gk4       =  (gk4 * gkf1)
  gk5       =  (gk5 * gkf3)
  gk6       =  (gk6 * gkf2)
  kf1       =  gk1+gk5
  kf2       =  gk2+gk4
  kf3       =  gk3+gk6

  a1        oscil     gk7, kf1, 1
  a2        oscil     gk8, kf2, 1
  a3        oscil     gk9, kf3, 1
  gkf1      downsamp  a1
  gkf2      downsamp  a2
  gkf3      downsamp  a3
  aout      =  kenv*(a1+a2+a3)
            out       aout
endin
