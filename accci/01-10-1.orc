; ************************************************************************
; ACCCI:     01-10-1.ORC
; synthesis: simple(01),
;            LFO modulating amplitude of basic instrument(10)
; coded:     jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr  1; ****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5                                 ; frequency of note event
  if1       =  p6                                 ; choose waveform
  if2       =  p7                                 ; choose envelope shape
  ifq3      =  p8                                 ; LFO frequency

  a3        oscili    iamp, ifq3, 1               ; vibrato

  a2        oscili    a3, 1/idur, if2             ; envelope

  a1        oscili    a2, ifq1, if1               ; waveform
            out       a1 * 10             
endin

