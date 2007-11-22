; ************************************************************************
; ACCCI:      40-60-1.ORC
; timbre:
; synthesis:  waveshaping(40)
;             polynomial function table for transfer function(60)
;             general purpose waveshaper(1)
; coded:      jpg 11/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

; sinus and table waveshaper should be the same value
; amplitude input of waveshaping oscillator is int(table length/2)
; p6 'xamp' of GEN 13  is also int(table length/2)
; odd function, always odd harmonics.. check Chebychev function type

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  cpspch(p5)
  itf       =  p6

  a1        oscili    4096, ifqc, 1               ; sinus
  a1        tablei    a1, itf                     ; transfer function
        ; now:  -1 < a1 < 1

  aenv      linen     iamp, .085, idur, .04       ; envelope
            out       a1*aenv
endin
