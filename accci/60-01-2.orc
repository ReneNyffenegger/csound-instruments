; ************************************************************************
; ACCCI:      60-01-2.ORC
; synthesis:  phase vocoder(60)
;             testfiles(01)
;             4 partials, .2 seconds(2)
; coded:      jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  iamp      =  p4/4

  a1        oscili    iamp, 1000, 11
  a2        oscili    iamp, 2200, 11
  a3        oscili    iamp, 4400, 11
  a4        oscili    iamp, 8000, 11

  a1        =  a1+a2+a3+a4
            out       a1
endin

