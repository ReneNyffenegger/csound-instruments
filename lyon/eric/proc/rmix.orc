  sr        =  44100
  kr        =  4410
  ksmps     =  10
;f1 0 N -1 file# 0 
;f2 0 N 1 func# 0
;i1 0 dur 

instr 1
  ifile     =  p9
  itl       =  ftlen(ifile)
  iincr     =  (sr/itl)*p4
  igain     =  p5 * .7
  iphase    =  p6
  ia        =  p7
  id        =  p8
  is        =  p3 -(ia+id)

  aenv      linseg    0,ia, igain, is, igain, id, 0
  asig      oscili    aenv,iincr,ifile    ,iphase
            out       asig
endin

; NO ENVELOPE
instr 2
  ifile     =  p6
  itl       =  ftlen(ifile)
  iincr     =  (sr/itl)*p4
  igain     =  p5 * .7
  iphase    =  0.0

  asig      oscili    igain,iincr,ifile   ,iphase
            out       asig
endin
