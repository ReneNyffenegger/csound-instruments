  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 100
endin


;f1 0 LENGTH -1 FNUM SKIP
;f2 0 8192 10 1
;i1 START DUR AMP INCR VIBSPEED DEPTH
instr 1
  itl       =  ftlen( 1 )
  iincr     =  (sr/itl)*p5
  ivd       =  iincr * p7
  ispeed    =  p6
  isteady   =  .1
  kvib      oscili    ivd, ispeed, 2              ; 2 = sine
  kincr     =  iincr + kvib
  asig      oscili    p4,kincr,1  
            out       asig
endin
