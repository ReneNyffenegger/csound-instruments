; ************************************************************************
; ACCCI:     01-12-1.ORC
; synthesis: simple(01), basic instrument + random amp variation(12)
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
  iperc     =  p8                                 ; random amplitude in percent of iamp
  ifqr      =  p9                                 ; frequency of new random numbers

  a3        randi     (iamp/100)*iperc, ifqr      ; % of amplitude variation

  a2        oscili    a3+iamp, 1/idur, if2        ; envelope

  a1        oscili    a2, ifq1, if1               ; waveform
            out       a1
endin
