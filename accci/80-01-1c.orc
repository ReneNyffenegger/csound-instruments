; ************************************************************************
; ACCCI:     80-01-1C.ORC
; timbre:    flute-like
; synthesis: other instruments(80)
;            twin instruments(1)
; note:      playing only i2: LFO on frequency
; source:    #100 Flute-like Melody, Risset(1969)
; coded:     jpg 8/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr  2; ****************************************************************
  idur      =  p3
  if1       =  p4
  iamp2     =  p5                                 ;FM
  if2       =  p6
  iamp3     =  p7                                 ;AM
  if3       =  p8

  a3        oscili    iamp3, 1/idur, if3          ;k3: AM control
  a2        oscili    iamp2, 1/idur, if2          ;k2: FM control
  a1        oscili    a3, a2, if1                 ;sinus wave
            out       a1 * 10

endin





