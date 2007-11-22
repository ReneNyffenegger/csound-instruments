; ************************************************************************
; ACCCI:     01-11-1.ORC
; synthesis: simple(01),
;            LFO modulating amplitude of basic instrument + % random
;            amplitude variation (11)
; coded:     jpg 10/93

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
  ifq3      =  p8
  iperc     =  p9                                 ; random amplitude in percent of iamp
  ifqr      =  p10                                ; frequency of bingo

  a4        randi     (iamp/100)*iperc,ifqr       ; % random amplitude variation

  a3        oscili    a4+iamp, ifq3, 1            ; LFO modulating amplitude

  a2        oscili    a3, 1/idur, if2             ; envelope

  a1        oscili    a2, ifq1, if1               ; waveform
            out       a1
endin
