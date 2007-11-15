  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;f1 0 N -1 1 0
;i1 0 dur dev seed speed seed speed

instr 1
  itl       =  ftlen(1)                           ; assume 1,2 of same length
  iop       =  1/p3
  iincr     =  (sr/itl)
  idev      =  p4 * iincr
  iseed1    =  p5
  ispeed1   =  p6
  iseed2    =  p7
  ispeed2   =  p8

  kincr1    randi     idev, ispeed1, iseed1
  kincr1    =  kincr1 + iincr
  kincr2    randi     idev, ispeed2, iseed2
  kincr2    =  kincr2 + iincr
  a1        oscili    32767.0,kincr1,1      
  a2        oscili    32767.0,kincr2,2      
            outs      a1,a2 
endin
