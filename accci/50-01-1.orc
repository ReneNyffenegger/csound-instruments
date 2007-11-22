; ************************************************************************
; ACCCI:     50-01-1.ORC
; timbre:    bands of noise
; synthesis: subtractive synthesis(50)
;            basic design(01)
;            RAND source(1)
; coded:     jpg 11/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  icfq      =  cpspch(p5)
  ibw       =  p6*icfq

 
  anoise    rand      iamp                        ; white noise
  a1        reson     anoise,  icfq, ibw, 2       ; filter
  a1        linen     a1, .1, idur, .1
            outs      a1, a1

endin

