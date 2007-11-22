  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   50

  ivsound   =  344/kr                             ;spd of sound in meters/k
  imindst   =  (p4 == 0 ? 1 : p4)
  imaxdst   =  (p5 == 0 ? 10 : p5)
  idistfn   =  (p6 == 0 ? 5 : p6)
  idist0    table     0,idistfn
  kdist0    init      imindst+(imaxdst-imindst)*idist0
  kdist     oscil1i   0,imaxdst-imindst,p3,idistfn
  kdist     =  imindst+kdist
  kvsrce    =  abs(kdist0)-abs(kdist)
  kdist0    =  kdist
  kpitfac   =  ivsound/(ivsound-kvsrce)
            display   kpitfac,p3
  asig      oscili    20000/kdist,1760*kpitfac,1
  asig      oscili    asig,15,2                   ;pulse it
  asig      linen     asig,.5,p3,.5
            out       asig
endin


instr   51
  ivsound   =  344/kr                             ;spd of sound in meters/k
  ixmax     =  p4
  iymax     =  p5
  ixfn      =  p6
  iyfn      =  p7
  ix        table     0,ixfn
  iy        table     0,iyfn
  ix        =  ix*ixmax
  iy        =  iy*iymax
  imaxd     =  sqrt(ixmax*ixmax+iymax*iymax)
  kdist0    init      sqrt(ix*ix + iy*iy)
  kx        oscil1i   0,ixmax,p3,ixfn
  ky        oscil1i   0,iymax,p3,iyfn
  kdist     =  sqrt(kx*kx + ky*ky)                ;go pythagorus!!
  kvsrce    =  abs(kdist0)-abs(kdist)             ;spd of source in meters/k
  kdist0    =  kdist                              ;remember last distance
  kpitfac   =  ivsound/(ivsound-kvsrce)
  asig      oscili    30000/kdist,1760*kpitfac,1
  asig      oscili    asig,15,2                   ;pulse it
  asig      linen     asig,.5,p3,.5
            out       asig
endin

