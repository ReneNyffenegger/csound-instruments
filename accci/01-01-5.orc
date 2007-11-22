; ************************************************************************
; ACCCI:      01-01-5.ORC
; synthesis:  simple(01)
;             basic instrument(01),
;             envelope through ENVLPX unit generator(5)
; coded:      jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  p5
  if1       =  p6
  irise     =  p7
  idec      =  p8
  if2       =  p9
  iatss     =  p10
  iatdec    =  p11

  a2        envlpx    iamp, irise, idur, idec, if2, iatss, iatdec
  a1        oscili    a2, ifq, if1
            out       a1
endin