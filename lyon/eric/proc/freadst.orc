  sr        =  44100
  kr        =  22050
  ksmps     =  2
  nchnls    =  2

;f1 0 N -1 file# 0 
;f2 0 N -1 file# 0 
;f3 0 N 1 func# 0
;i1 0 dur 

instr 1
  ifunc     =  3
  itl       =  ftlen(1)
  iop       =  1/p3
  iincr     =  (sr/itl)

  kincr     oscili    iincr, iop, ifunc
  asig1     oscili    1.0,kincr,1
  asig2     oscili    1.0,kincr,2                
            outs      asig1, asig2
endin

;different function controls each channel
instr 2
  ifile     =  p4
  iskip     =  p5
  idepth    =  p6                                 ; assumes input function ranges 0-1.0
  imax      =  idepth * 2.0
  iop       =  1.0/p3
  a1,a2     soundin   ifile,iskip
  kfunc1    oscili    idepth, iop, 1
  kfunc2    oscili    idepth, iop, 2
        
  addl1     delayr    imax
  atap1     deltapi   kfunc1
            delayw    a1
  addl2     delayr    imax
  atap2     deltapi   kfunc2
            delayw    a2

            outs      atap1,atap2
endin

instr 3
  ifunc     =  1                                  ; function containing mono signal
  itl       =  ftlen(ifunc)
  iop       =  1/p3
  iincr     =  (sr/itl)
  iamp      =  p4 
  kincr1    oscili    iincr, iop, 2
  kincr2    oscili    iincr, iop, 3
  asig1     oscili    iamp,kincr1,ifunc
  asig2     oscili    iamp,kincr2,ifunc          
            outs      asig1, asig2
endin

instr 4
  itl       =  ftlen(1)
  iop       =  1/p3
  iincr     =  (sr/itl)
  iamp      =  p4 
  kincr1    oscili    iincr, iop, 3
  kincr2    oscili    iincr, iop, 4
  asig1     oscili    iamp,kincr1,1
  asig2     oscili    iamp,kincr2,2              
            outs      asig1, asig2
endin
