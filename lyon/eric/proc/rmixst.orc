  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;f1 0 N -1 file# 0 
;f2 0 N 1 func# 0
;i1 0 dur 
  gipo      =  1.570796
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
endin

; NO ENVELOPE
; file gain incr pos
instr 2
  igain     =  p5 * .7
  ifile     =  p4
  iloc      =  p7
  iphase    =  0.0
  itl       =  ftlen(ifile)
  iincr     =  (sr/itl)*p6

  ileft     =  (cos(gipo*iloc))*igain
  iright    =  (sin(gipo*iloc))*igain

  asig      oscili    igain,iincr,ifile   ,iphase
            outs      asig*ileft, asig*iright
endin
