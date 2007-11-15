  sr        =  8192
  kr        =  8192
  ksmps     =  1

; not optimized for obvious reasons
; outdur speed_sh min_val max_val seed_sh v_phase v_speed
instr 1
  ishspeed  =  p4 * p5 
  imin      =  p6  
  imax      =  p7
  ishseed   =  p8
  ivphase   =  p9
  ivspeed   =  p10
  ishamp    =  1.0
  ivamp     =  .2

  ash       randh     ishamp/2., ishspeed, ishseed
  ash       =  ash + (ishamp/2.)
  avib      oscil     ivamp/2., ivspeed, 1, ivphase
  avib      =  avib + (ivamp/2.)
  asum      =  (avib+ash)/(ishamp+ivamp)          ; scale -> 0-1
  afunc     =  imin+((imax-imin)*asum)            ; scale -> min-max
            out       afunc
endin
