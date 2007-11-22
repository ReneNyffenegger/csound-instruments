; ************************************************************************
; ACCCI:        01-42-1.ORC
; synthesis:    simple(01)
;               basic instrument with small scale FM for vibrato (42)
; source:       Dodge(1985)
; coded:        jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifc       =  p6
  iwidth    =  p7
  irate     =  p8
  ifm       =  p9

  amod      oscili    iwidth, irate, ifm          ; LFO modulator
  amod      =  ifqc + amod
  aenv      linen     iamp, .1, idur, .1          ; prevent clicks    
  a1        oscili    aenv, amod, ifc             ; carrier waveform
            out       a1
endin
