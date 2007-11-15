  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr 1
  ga1,ga2   soundin   p4,p5
  ga1       =  ga1 * .2                           ;
  ga2       =  ga2 * .2
endin

instr 2
  ires      =  p4
  ibw       =  p5*ires
  idel1     =  p6
  idel2     =  p7
  imindel   =  p8
  imaxdel   =  p9
  iminfb    =  p10
  imaxfb    =  p11
  idelsp    =  p12
  ifbsp     =  p13
  iseed1    =  p14
  iseed2    =  p15
  iseed3    =  p16
  iseed4    =  p17

  imax      =  imaxdel * 2.
  ideg      =  (imaxdel-imindel)/2.0
  ideb      =  ideg + imindel
  ifeg      =  (imaxfb-iminfb)/2.0
  ifeb      =  ifeg + iminfb

  idelgain  =  .7
  kdel1     randi     ideg, idelsp, iseed1
  kdel1     =  kdel1 + ideb
  kfe1      randi     ifeg, ifbsp, iseed2
  kfe1      =  kfe1 + ifeb
  kdel2     randi     ideg, idelsp, iseed3
  kdel2     =  kdel2 + ideb
  kfe2      randi     ifeg, ifbsp, iseed4
  kfe2      =  kfe2 + ifeb

  ares1     reson     ga1, ires, ibw, 1
  ares2     reson     ga2, ires, ibw, 1
  ares1de   delay     ares1, idel1
  ares2de   delay     ares2, idel2
  ares2     =  ares2 + (ares1de *idelgain)        ;
  ares1     =  ares1 + (ares2de *idelgain)        ;

  addl1     delayr    imax
  atap1     deltapi   kdel1
  ares1     =  ares1 + (atap1*kfe1)
            delayw    ares1
  addl2     delayr    imax
  atap2     deltapi   kdel2
  ares2     =  ares2 + (atap2*kfe2)
            delayw    ares2
            outs      ares1, ares2

endin