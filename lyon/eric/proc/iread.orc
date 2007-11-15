  sr        =  44100
  kr        =  4410
  ksmps     =  10
;f1 0 N -1 file# 0 
;f2 0 N 1 func# 0
;i1 0 dur 

instr 1
  ifile     =  1
  ifunc     =  2
  itl       =  ftlen(ifile)
  iop       =  1/p3
  iincr     =  (sr/itl)

  kincr     oscili    iincr, iop, ifunc
  asig      oscili    1.0,kincr,ifile     
            out       asig
endin
