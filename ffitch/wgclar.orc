  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  idur      =  p3
  iamp      =  p4
  ifrq      =  cpspch(p5)
  istiff    =  p6
  iatk      =  p7
  idec      =  p8
  inoise    =  p9
  ivibfrq   =  p10
  ivibamp   =  p11
  ivibfun   =  p12
  iminfrq   =  p13
  asig      wgclar    iamp, ifrq, istiff, iatk, idec, inoise, ivibfrq, ivibamp, ivibfun, iminfrq
            out       asig
endin
            
            
instr      2
  idur      =  p3
  iamp      =  p4
  ifrq      =  cpspch(p5)
  istiff    =  p6
  iatk      =  p7
  idec      =  p8
  inoise    =  p9
  ivibfrq   =  p10
  ivibamp   =  p11
  ivibfun   =  p12
  iminfrq   =  p13
  iglis     =  cpspch(p14)
  ifirm     =  p15
  imidnoise =  p16
  ivibfrq2  =  p17
  ivibamp2  =  p18
  kglis     linseg    ifrq, idur, iglis
  kstiff    line      istiff, idur, ifirm
  knoise    linseg    inoise, idur/2, imidnoise, idur/2, inoise
  kvibfrq   line      ivibfrq, idur, ivibfrq2
  kvibamp   line      ivibamp, idur, ivibamp2
  asig      wgclar    iamp, kglis, kstiff, iatk, idec, knoise, kvibfrq, kvibamp, ivibfun, iminfrq
            out       asig
endin

