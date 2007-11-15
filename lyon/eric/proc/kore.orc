  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  incr      =  (sr/ftlen(p4))*p6
  iamp      =  p7*5000.
  aenv      linseg    0,.01,iamp,p3-.02,iamp,.01,0
  asig      oscili    aenv, incr, p4, p5
            outs1     asig
endin

instr 2
  incr      =  (sr/ftlen(p4))*p6
  iamp      =  p7*5000.
  aenv      linseg    0,.01,iamp,p3-.02,iamp,.01,0
  asig      oscili    aenv, incr, p4, p5
            outs2     asig
endin
