; ************************************************************************
; ACCCI:     01-40-1.ORC
; synthesis: simple(01),
;            basic instrument with continuous pitch control mechanism:
;            optional LFO modulation of frequency(40)
; coded:     jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr  1; ****************************************************************
  idur      =  p3
  if1       =  p4                                 ; chooses waveform
  iamp2     =  p5                                 ; determines frequency of note event together with if2
  irate     =  p6/idur                            ; repetition rate of LFO
  if2       =  p7                                 ; chooses frequency control function
  iamp3     =  p8                                 ; amplitude of note
  if3       =  p9                                 ; chooses envelope shape

  a3        oscili    iamp3, 1/idur, if3          ; envelope
  a2        oscili    iamp2, irate, if2           ; LFO modulation of pitch
  a1        oscili    a3, a2, if1                 ; waveform
            out       a1

endin
