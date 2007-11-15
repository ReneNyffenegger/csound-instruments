  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   50

  ivsound   =  344/(1/kr)                         ;spd of sound in meters/sec
  imindst   =  (p4 == 0 ? 1 : p4)
  imaxdst   =  (p5 == 0 ? 10 : p5)
  idistfn   =  (p6 == 0 ? 5 : p6)
  kdist0    =  imaxdst
  kdist     oscil1i   0,imaxdst-imindst,p3,idistfn
;kvsrce integ   kdist
  kvsrce    =  (kdist0-kdist)/(1/kr)
  kdist0    =  kdist
            display   kdist,p3
            display   kvsrce,p3
  kpitfac   =  ivsound/(ivsound-kvsrce)
            display   kpitfac,p3
  asig      oscili    10000,440*kpitfac,1
            out       asig
endin
