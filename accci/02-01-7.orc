; ************************************************************************
; ACCCI:     02-01-7.ORC
; synthesis: additive with same units via parallel score file calls(02),
;            basic instrument(01)
;            experiments (7)
; source:    #300  Linear  and  Exponential  Decay  Experiments,
;            Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr  1; ****************************************************************
  idur      =  p3
  ifq1      =  p4
  if1       =  p5
  iamp      =  p6
  if2       =  p7

  a2        oscili    iamp, 1/idur, if2           ; if2 chooses lin or exp decay
  a1        oscili    a2, ifq1, if1               ; if1 chooses waveform
            out       a1
endin

