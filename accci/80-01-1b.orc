; ************************************************************************
; ACCCI:     80-01-1B.ORC
; timbre:    flute-like
; synthesis: other instruments(80)
;            twin instruments(1)
; note:      playing only i1: LFO on amplitude
; source:    #100 Flute-like Melody, Risset(1969)
; coded:     jpg 8/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr  1; ****************************************************************
  idur      =  p3
  if1       =  p5                                 ; oscili 1: waveform
  ifq1      =  p6
  if2       =  p7                                 ; oscili 2: envelope
  ifq3      =  p8
  if3       =  p9                                 ; oscili 3
  iampr     =  p4                                 ; randi
  ifqr      =  p7

; initializing a variable idc to .6 or .74
if if3 = 12 igoto dc1
  idc       =  .6
            goto      start

dc1:
  idc       =  .74
            goto      start

start:
  a4        randi     iampr/100, ifqr             ;small value amp & fq
  a4        =  a4 + iampr                         ;band limited noise

  a3        oscili    a4, ifq3, if3               ;DC bias function, LFO
  a3        =  a3 + idc                           ;amplitude modulation input

  a2        oscili    a3, 1/idur, if2             ;envelope

  a1        oscili    a2, ifq1, if1               ;carrier: 3 waveforms & AM
            out       a1 * 10                     ;scaling up & out
endin


