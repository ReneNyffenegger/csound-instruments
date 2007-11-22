  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1  ;pulse sound
  iamp1     =  p4/5
  iamp2     =  p5/5
  ibeg1     =  p7
  iend1     =  p8
  ibeg2     =  p9
  iend2     =  p10
  kfq       linseg    p6, p3*.618, p6*2, p3*.366, p6*.5, p3*.016, p6*.2
  k1        line      ibeg1, p3, iend1
  k2        line      ibeg2, p3, iend2
  kctl      line      iamp1, p3, iamp2 
  kamp      linen     kctl, .003*p3, p3, .02*p3
  a1        oscili    kamp, kfq, 3
  aa2       oscili    kamp, kfq+k1, 3  
  aa3       oscili    kamp, kfq+k1*2, 3
  aa4       oscili    kamp, kfq+k1*3, 3
  aa5       oscili    kamp, kfq+k1*4, 3
  ab2       oscili    kamp, kfq+k2, 3  
  ab3       oscili    kamp, kfq+k2*2, 3
  ab4       oscili    kamp, kfq+k2*3, 3
  ab5       oscili    kamp, kfq+k2*4, 3
            outs      (a1+aa2+aa3+aa4+aa5)*.8, (a1+ab2+ab3+ab4+ab5)*.8
endin


instr 2  ;monk drone
  idec      =  p4
  kden      linseg    2, 29.96, 15, 230.16, 15, 19.88, 2
  kamp      line      p5, p3, p6
  kenv      linen     kamp, idec*p3, p3, idec*p3
  a1        grain     kenv, .69, kden, 0, 0,1, 1, 2, 1
  k2        linseg    1, p3/5, 0, p3/5, 1, p3/5, 0, p3/5, 1, p3/5, 0
  klt       tablei    (1 - k2), 100, 1
  krt       tablei    k2, 100, 1
            outs      a1*klt*.8, a1*krt*.8
endin

instr 3 ;granular block sound
  ifreq1    =  p4
  ifreq2    =  p5
  iamp      =  p6
  ipan      =  p7
  adens     rand      500
  kfreq     line      ifreq1, p3, ifreq2
  k1        linen     iamp, p3*.382, p3, p3*.618
  asig      grain     k1, kfreq, 1000+adens, 0, 1000, .01, 4, 2, .015
  ilt       tablei    (1 - ipan), 100, 1
  irt       tablei    ipan, 100, 1
            outs      asig*ilt*.8, asig*irt*.8
endin

instr 4 ;filt noise
  iamp      =  p5
  icfq      =  p4
  ibw       =  4
  anoise    rand      iamp
  a1        reson     anoise,  icfq, ibw, 2
  a1        linen     a1, .25*p3, p3, .25*p3
            outs      a1*.8, a1*.8
endin

