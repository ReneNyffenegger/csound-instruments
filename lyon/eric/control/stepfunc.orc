  sr        =  8192
  kr        =  8192
  ksmps     =  1

;filedur speed jitter min max seed1 seed2 
instr 1
  ispeed    =  p4 * p5 
  idev      =  p6                                 ;
  imin      =  p7
  imax      =  p8
  iseed1    =  p9
  iseed2    =  p10
        
  aspdev    randi     idev*ispeed, ispeed/3.0, iseed1
  aspeed    =  ispeed + aspdev
  arnd      randi     .5, aspeed, iseed2
  arnd      =  arnd + .5
  arnd      =  imin+((imax-imin)*arnd)
            out       arnd
endin