; ************************************************************************
; ACCCI:      40-01-1.ORC
; synthesis:  waveshaping(40)
;             linear function table for transfer function(01)
;             variable transfer function(1)
; coded:      jpg 11/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itf       =  p6

  aenv      linen     255, .1, idur, .5           ; envelope
  a1        oscili    aenv, ifqc, 1               ; sinus
  a1        tablei    a1  + 256, itf              ; transfer function
            out       a1 * iamp                   ; scale to amplitude

endin
