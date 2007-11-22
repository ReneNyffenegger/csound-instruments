; ************************************************************************
; ACCCI:      33-50-1.ORC
; synthesis:  Amplitude Modulation(33)
;             "classical" AM(50)
; coded:      jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4/2                               ; holding amplitude within range specified by p4
  ifqc      =  p5
  ifc       =  p6
  imod      =  p7                                 ; normalized modulation index
  ifqm      =  p8
  ifm       =  p9
  ife       =  51

  amod      oscili    imod*iamp, ifqm, ifm        ; modulator
  a1        =  amod + iamp * (2-imod)             ; mix & scale

  aenv      oscili    a1, 1/idur, ife             ; envelope
  a2        oscili    aenv, ifqc, ifc             ; carrier

            out       a2
endin
