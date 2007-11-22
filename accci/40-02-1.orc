; ************************************************************************
; ACCCI:      40-02-1.ORC
; timbre:     clarinet-like
; synthesis:  waveshaping(40)
;             basic instrument with duration dependent envelope(02)
; source:     Risset(1969)
;             #150 Serial Excerpt with Clarinet-like Sounds by Nonlinearity
; coded:      jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)

  idec      =  .64                                ; idec for idur > .75
if idur >.75 igoto start
  idec      =  idur - .085                        ; idec for idur <= .75

start:
  aenv      linen     255, .085, idur, idec       ; envelope
  a1        oscili    aenv, ifqc, 1               ; sinus
  a1        tablei    a1  + 256, 31               ; transfer function
            out       a1 * iamp                   ; scale to amplitude
endin