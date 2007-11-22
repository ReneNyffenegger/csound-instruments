; ************************************************************************
; ACCCI:     88-01-1.ORC
; timbre:    none
; synthesis: calculation of a function, writing as soundfile to disk
; source:    #513  Part 1 for Endless Glissando , Risset(1969)
; coded:     jpg 9/93


  sr        =  513
  kr        =  513
  ksmps     =  1
  nchnls    =  1


instr 1; *****************************************************************

  a1        linseg    1,p3,513
  a1        =  a1-1
  a1        =  (a1-256)/512
  a1        =  2*3.14159*a1
  a1        =  1-cos(a1)
  a1        =  -4.8283*a1
  a1        =  exp(a1)
  a1        oscil     a1*32000,1,31               ; 513 points:   1 512 1
            display   a1,1                        ; display over one second
            out       a1

endin

