; ************************************************************************
; ACCCI:     01-01-2A.ORC
; timbre:    from reed towards plucked chord, effect of changing envelopes
; synthesis: simple(01), basic instrument(01)
; source:    #250 Reedy and Plucked Tones, Choral Effect, Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if2       =  p6                                 ; controlling timbre with different envelopes

  a2        oscili    iamp, 1/idur, if2
  a1        oscili    a2,   ifq1,   11            ; 11 = complex weighted
            outs      a1, a1

endin

