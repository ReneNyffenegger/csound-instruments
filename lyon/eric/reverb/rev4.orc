  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;2in 2out
;i1 0 dur file skip iorig cmbgain alpassgain tapgain globalgain

instr 1
  icombgain =  p7
  ialpassgain  =      p8
  itapgain  =  p9
  iglobgain =  p10
  irvt      =  1.7
  ifile     =  p4
  iskip     =  p5
  iorig     =  p6
  irev      =  1.-iorig
  ilp1a     =  1/11.1235
  ilp1b     =  1/14.3716
  ilp1c     =  1/17.691
  ilp2a     =  1/13.5271
  ilp2b     =  1/15.5351
  ilp2c     =  1/19.1173
  ipatk     =  .2
  ipsust    =  p3-ipatk

  a1,a2     soundin   ifile,iskip
  addl1     delayr    .2
  atap1a    deltap    .007
  atap1b    deltap    .011
  atap1c    deltap    .023
  atap1d    deltap    .047
  atap1e    deltap    .061
  atap1f    deltap    .079
  atap1g    deltap    .093
            delayw    a1
  addl2     delayr    .2
  atap2a    deltap    .005
  atap2b    deltap    .013
  atap2c    deltap    .027
  atap2d    deltap    .043
  atap2e    deltap    .071
  atap2f    deltap    .083
  atap2g    deltap    .107
            delayw    a2
  atap1a    =  atap1a*.9
  atap1b    =  atap1b*.8
  atap1c    =  atap1c*.7
  atap1d    =  atap1d*.6
  atap1e    =  atap1e*.5
  atap1f    =  atap1f*.4
  atap1g    =  atap1g*.3
  atap2a    =  atap2a*.9
  atap2b    =  atap2b*.8
  atap2c    =  atap2c*.7
  atap2d    =  atap2d*.6
  atap2e    =  atap2e*.5
  atap2f    =  atap2f*.4
  atap2g    =  atap2g*.3
  at1       =  atap1a+atap1b+atap1c+atap1d+atap1e+atap1f+atap1g
  at2       =  atap2a+atap2b+atap2c+atap2d+atap2e+atap2f+atap2g
  at1       =  at1*itapgain
  at2       =  at2*itapgain
  ap1a      alpass    at1,.5,.0467
  ap1       alpass    ap1a,3,.0731
  ap2a      alpass    at2,.5,.0531
  ap2       alpass    ap2a,3,.0697
  ap1       =  ap1*ialpassgain
  ap2       =  ap2*ialpassgain
  kpenv     linseg    0,ipatk,1,ipsust,1
  acp1      =  kpenv*ap1
  acp2      =  kpenv*ap2
  acomb1a   comb      acp1,irvt,ilp1a
  acomb1b   comb      acp1,irvt,ilp1b
  acomb1c   comb      acp1,irvt,ilp1c
  acomb2a   comb      acp2,irvt,ilp2a
  acomb2b   comb      acp2,irvt,ilp2b
  acomb2c   comb      acp2,irvt,ilp2c
  ac1       =  (acomb1a+acomb1b+acomb1c)*icombgain
  ac2       =  (acomb2a+acomb2b+acomb2c)*icombgain
  arev1     =  at1+ap1+ac1
  arev2     =  at2+ap2+ac2
  aout1     =  (arev1*irev)+(a1*iorig)
  aout2     =  (arev2*irev)+(a2*iorig)
            outs      aout1*iglobgain,aout2*iglobgain
endin
