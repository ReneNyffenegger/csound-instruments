  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

  gisinfunc =  1

instr 1
  isinefunc =  1
  icomplexfunc =      2
  ifreq     =  p4
  iamp      =  p5 *32768.
  iamp2     =  p6
  icm1      =  p7
  icm2      =  p8
  imodf1    =  ifreq * icm1
  imodf2    =  ifreq * icm2
  imatk1    =  p9
  imdk1     =  p3-imatk1
  imatk2    =  p10
  imdk2     =  p3-imatk2
  idepth1   =  p11 * ifreq
  idepth2   =  p12 * ifreq
  iatk1     =  p13
  idk1      =  p14
  irl1      =  p3-(iatk1+idk1)
  ip3o2     =  p3/2.
  ip1       =  ifreq * .99
  ip2       =  ifreq * 1.1
  ip3       =  ifreq
  ip4       =  ifreq * .95
  kpitch    linseg    ip1,.01,ip2,.01,ip3,p3-.05,ip3,.03,ip4
  amainenv  linseg    0,iatk1,iamp,idk1,iamp2,irl1,0
  kmenv1    linseg    0,imatk1,1,imdk1,0
  kmenv2    linseg    0,imatk2,1,imdk2,0
  kindex    linseg    idepth1,ip3o2,idepth2,ip3o2,idepth1
  amod1     oscil     kmenv1*kindex, imodf1, isinefunc
  amod2     oscil     kmenv2*kindex, imodf2, isinefunc
  afreq     =  kpitch + amod1 + amod2
  asig      oscil     amainenv, afreq, icomplexfunc
            out       asig
endin

instr 2
  ifreq1    =  p4
  ifreq2    =  p5
  iamp      =  p6 * 8192.
  ibw       =  p7 * ifreq1
  iatk      =  p8
  idk       =  p3 - iatk
  kenv      linseg    0, iatk, iamp, idk, 0
  asin1     oscil     kenv, ifreq1, 2
  asin2     oscil     asin1, ifreq2, 2
  amix      =  asin1 + asin2
  ares      reson     amix, ifreq1, ibw, 1
            out       ares
endin

instr 3
  ifreq1    =  p4
  ifreq2    =  p5
  ifreq3    =  p6
  ivs1      =  p7
  ivs2      =  p8
  ivs3      =  p9
  iamp1     =  p10 * 3000.
  iamp2     =  p11 * 3000.
  iatk      =  p12
  idk       =  p13
  ivd1      =  p14*ifreq1
  ivd2      =  p15*ifreq2
  ivd3      =  p16*ifreq3
  irl       =  p3-(iatk+idk)
  kvib1     oscil     ivd1, ivs1, gisinfunc
  kvib2     oscil     ivd2, ivs2, gisinfunc
  kvib3     oscil     ivd3, ivs3, gisinfunc
  kfreq1    =  ifreq1 + kvib1
  kfreq2    =  ifreq2 + kvib2
  kfreq3    =  ifreq3 + kvib3
  kenv      linseg    0, iatk, iamp1, idk, iamp2, irl, 0
  asig1     oscil     kenv, kfreq1, 3
  asig2     oscil     kenv, kfreq2, 4
  asig3     oscil     kenv, kfreq3, 5
  amix      =  asig1+asig2+asig3
            out       amix
endin
