; ************************************************************************
; ACCCI:     50-11-1.ORC
; timbre:    bands of noise
; synthesis: subtractive synthesis(50)
;            continuous control cf and bw(11)
;            glissandoing noise bands(1)
; source:    Dodge (1985)
; coded:     jpg 11/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  imincfq   =  cpspch(p5)
  imaxcfq   =  cpspch(p6)
  iratio    =  imaxcfq/imincfq
  iminbw    =  p7
  irangebw  =  p8

  kcfq      expon     1, idur, iratio             ; control center frequency
  kcfq      =  kcfq*imincfq

  kbw       oscili    irangebw, 1/idur, 31        ; control bw
  kbw       =  (kbw+iminbw)*kcfq

  anoise    rand      iamp                        ; white noise
  a1        reson     anoise,  kcfq, kbw, 2       ; filter
  a1        linen     a1, .1, idur, .1  
            outs      a1, a1

endin
