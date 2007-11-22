; ************************************************************************
; ACCCI:     01-01-3.ORC
; synthesis: simple(01),
;            basic instrument(01)
;            complex waveform created with GEN 10
;            envelope are line functions taken from GEN 07 tables
; source:    #300  Linear  and  Exponential  Decay  Experiments,
;            Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr  1; ****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if1       =  p6
  if2       =  p7

  a2        oscili    iamp, 1/idur, if2           ;if2   chooses lin or exp decay
  a1        oscili    a2, ifq1, if1               ;if1   chooses waveform
            out       a1

endin

