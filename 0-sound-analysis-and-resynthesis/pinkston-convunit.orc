;-------------------------------------------------------------------
; Test instrument for impulse response. Should produce an output
; that is exactly the same as the original impulse file.
;-------------------------------------------------------------------

instr   2
  aunit     init      32767                       ;initialize to max amp for "impulse"
  iampscl   =  p4                                 ;scale as needed to avoid SOR
  impfile   =  p5                                 ;use convolve.p5
  awet      convolve  aunit*iampscl,impfile
  aunit     =  0                                  ;zero this after the first sample
            out       awet
endin
