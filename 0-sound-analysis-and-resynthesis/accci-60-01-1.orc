; ************************************************************************
; ACCCI:      60-01-1.ORC
; synthesis:  phase vocoder(60)
;             testfiles(01)
;             4 partials, 1 second(1)
; coded:      jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  iamp      =  p4
  ifq       =  p5

  a1        oscil     iamp, ifq, 11
            out       a1
endin

