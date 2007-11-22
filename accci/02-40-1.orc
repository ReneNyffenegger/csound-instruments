; ************************************************************************
; ACCCI:        02-40-1.ORC
; timbre:       machine-like, starship
; synthesis:    additive(02),
;               continuous pitch control by LFO (40)
; source:       new
; coded:        jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  iamp1     =  p4/6
  ifq1      =  p5
  irate     =  1/p6
  ioff2     =  p7
  ioff3     =  p8
  ioff4     =  p9
  ioff5     =  p10
  ioff6     =  p11

  ae        oscili    ifq1, irate, 35             ; pitch contour
  a6        oscili    iamp1, ae,       11         ;
  a5        oscili    iamp1, ae+ioff2, 11         ;
  a4        oscili    iamp1, ae+ioff3, 11         ;  6 parallel oscillators
  a3        oscili    iamp1, ae+ioff4, 11         ;     with medium frequency
  a2        oscili    iamp1, ae+ioff5, 11         ;         offsets
  a1        oscili    iamp1, ae+ioff6, 11         ;
            out       a1+a2+a3+a4+a5+a6

endin

