; FILTER.orc

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
        
instr 1             ; BUZZ SOURCE
  icps      =  cpsoct(p4)                         ; CONVERT FUNDAMENTAL IN OCTAVE NOTATION TO Hz
  iharm     =  int((8000/icps)+.66)               ; NUMBER OF HARMONICS FOR BUZZ (ROUNDED UP)
  ibeat     =  p6*icps                            ; SLIGHT ALTERATION OF icps FOR BEATING IN BUZZ
  iamp      =  p5                                 ; AMPLITUDE
  ibw1      =  p7*icps                            ; BW MAX FOR FILTER1
  ibw2      =  p8*icps                            ; BW MAX FOR FILTER2

  kenv      linseg    0,p3*.5,iamp,p3*.5,0,.01,0  ; AMPLITUDE ENVELOPE
  kenv1     =  kenv/iamp                          ; WITH GUARD POINT
                                             ; EXP ENVELOPE BETWEEN 0-1
; BUZZ SOURCE
  abuzz1    buzz      kenv,icps,iharm,1
  abuzz2    buzz      kenv,ibeat,iharm,1
  asrc      =  abuzz1+abuzz2

; PARALLEL FILTERS FOR BUZZ SOURCE
  afilt1    reson     asrc,icps,ibw1*kenv1,1,0
  afilt2    reson     asrc,icps*2,ibw2+kenv1,1,0

  aout      balance   afilt1+afilt2, asrc
            out       aout
endin

instr 2             ; NOISE SOURCE
  icps      =  cpsoct(p4)                         ; CONVERT FUNDAMENTAL IN OCTAVE NOTATION TO Hz
  iharm     =  int((8000/icps)+.66)               ; NUMBER OF HARMONICS FOR BUZZ (ROUNDED UP)
  ibeat     =  p6*icps                            ; SLIGHT ALTERATION OF icps FOR BEATING IN BUZZ
  iamp      =  p5                                 ; AMPLITUDE
  ibw1      =  p7*icps                            ; BW MAX FOR FILTER1
  ibw2      =  p8*icps                            ; BW MAX FOR FILTER2

  kenv      linseg    0,p3*.5,iamp,p3*.5,0,.01,0  ; AMPLITUDE ENVELOPE
  kenv1     =  kenv/iamp                          ; WITH GUARD POINT
                                             ; EXP ENVELOPE BETWEEN 0-1
; NOISE SOURCE
  asrc      rand      kenv

; PARALLEL FILTERS FOR NOISE SOURCE
  afilt1    reson     asrc,icps,ibw1*kenv1,2,0
  afilt2    reson     asrc,icps*2,ibw2+kenv1,2,0

  aout      balance   afilt1+afilt2, asrc
            out       aout
endin

; TRY:
; DIFFERENT ENVELOPES ON EACH FILTER OR BUZZ
; DIFFERENT RELATIONSHIPS OF CENTER FREQUENCIES BETWEEN RESONS
; RESONS IN SERIES INSTEAD OF PARALLEL
