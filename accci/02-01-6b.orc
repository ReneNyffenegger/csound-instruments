; ************************************************************************
; ACCCI:     02-01-6B.ORC
; timbre:    bell
; synthesis: additive with same units(02)
;            basic instrument(01)
;            additive bell with EXPON 
; coded:     jpg 8/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4/11                              ; scale iamp to the number of oscillators
  ifqc      =  p5

  ae1       expon     iamp,         idur,       1
  ae2       expon     (iamp* .67), (idur*.9  ), 1
  ae3       expon     iamp,        (idur*.65 ), 1
  ae4       expon     (iamp*1.8 ), (idur*.55 ), 1
  ae5       expon     (iamp*2.67), (idur*.325), 1
  ae6       expon     (iamp*1.67), (idur*.35 ), 1
  ae7       expon     (iamp*1.46), (idur*.25 ), 1
  ae8       expon     (iamp*1.33), (idur*.2  ), 1
  ae9       expon     (iamp*1.33), (idur*.15 ), 1
  ae10      expon     iamp,        (idur*.1  ), 1
  ae11      expon     (iamp*1.33), (idur*.075), 1

  a1        oscili    ae1, (ifqc* .56), 11
  a2        oscili    ae2, (ifqc* .56+1),11
  a3        oscili    ae3, (ifqc* .92), 11
  a4        oscili    ae4, (ifqc* .92+1.7),11
  a5        oscili    ae5, (ifqc*1.19), 11
  a6        oscili    ae6, (ifqc*1.7 ), 11
  a7        oscili    ae7, (ifqc*2   ), 11
  a8        oscili    ae8, (ifqc*2.74), 11
  a9        oscili    ae9, (ifqc*3   ), 11
  a10       oscili    ae10,(ifqc*3.76), 11
  a11       oscili    ae11,(ifqc*4.07), 11

            out       a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11

endin
