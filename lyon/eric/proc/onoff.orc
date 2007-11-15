  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;f1 0 8192 -1 50 0
; gen1 -L8192 0 0 .1 1 .35 1. .4 0 1. 0 > soundin.50
; note that speed means # of iterations of function
; i1 0 dur file skip speed1 speed2

instr 1
  ispeed1   =  p6/p3
  ispeed2   =  p7/p3
  a1, a2    soundin   p4,p5
  aenv1     oscil     a1, ispeed1, 1
  aenv2     oscil     a2, ispeed2, 1
            outs      aenv1, aenv2
endin
