; ************************************************************************
; ACCCI:     88-01-2.ORC
; timbre:    none
; synthesis: calculation of a function, writing as soundfile to disk
; source:    endless.orc, M.I.T.(1993)
; note:      F(kx) = exp(-4.8283*(1-cos(2*pi*(kx-255.5)/511)))
; coded:     jpg 9/93


  sr        =  1
  kr        =  1
  ksmps     =  1
  nchnls    =  1


instr 1; *****************************************************************
  ipi       =  3.14159
  isize     =  p3-1                               ; since sr=1, p3 has number of locs to generate
  kx        init      0

  aval      =  exp(-4.8283*(1-cos(2*ipi*(kx-(isize*.5))/isize)))
  kx        =  kx+1
            display   aval,p3*.5
            display   aval,p3
            out       aval * 32000                ; 1 < aval < -1  use whole range of amps

endin

