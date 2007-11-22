; ************************************************************************
; ACCCI:     02-13-1B.ORC
; timbre:    brass
; synthesis: additive with equal units(02),
;            basic unit with modified envelopes(13)
; source:    #210 Simplified Brass-like Sounds,  Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  irise     =  p6/128
  idec      =  p7/128
  isum      =  p6 + p7

; ratios of maxamps of partials / range
  iratio2   =  .2/67
  iratio3   =  .3/60
  iratio4   =  .4/57
  iratio5   =  .5/55
  iratio6   =  .6/54
  iratio7   =  .7/54

; constants from slope formula
  iconst2   =  .054
  iconst3   =  .049
  iconst4   =  .3
  iconst5   =  .409
  iconst6   =  .511
  iconst7   =  .596

; partials
  ifq2      =  ifq1 * 2
  ifq3      =  ifq1 * 3
  ifq4      =  ifq1 * 4
  ifq5      =  ifq1 * 5
  ifq6      =  ifq1 * 6
  ifq7      =  ifq1 * 7

  ae        linseg    0,irise*100,.99,irise*10,.65,irise*18,.8,idur-isum,.6,idec*44,.3,idec*45,0

  aamp1     =  iamp * ae
  aamp2     =  ((iratio2 * aamp1) - iconst2) * 1000
  aamp3     =  ((iratio3 * aamp1) - iconst3) * 2000
  aamp4     =  ((iratio4 * aamp1) - iconst4) * 1900
  aamp5     =  ((iratio5 * aamp1) - iconst5) * 1250
  aamp6     =  ((iratio6 * aamp1) - iconst6) * 1000
  aamp7     =  ((iratio7 * aamp1) - iconst7) *  850

  a1        oscili    aamp1, ifq1, 1
  a2        oscili    aamp2, ifq2, 1
  a3        oscili    aamp3, ifq3, 1
  a4        oscili    aamp4, ifq4, 1
  a5        oscili    aamp5, ifq5, 1
  a6        oscili    aamp6, ifq6, 1
  a7        oscili    aamp7, ifq7, 1
            out       a1+a2+a3+a4+a5+a6+a7
endin
