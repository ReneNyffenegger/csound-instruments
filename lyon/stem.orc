  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;STEREO IN OF EMONSTER
;i1 0 dur file skip lp1 lp2 lp3 lp4 lp5 lp6 rvt gain
instr          1
  ifile     =  p4 
  iskip     =  p5
  ilp1      =  1./p6
  ilp2      =  1./p7
  ilp3      =  1./p8
  ilp4      =  1./p9
  ilp5      =  1./p10
  ilp6      =  1./p11
  irvt      =  p12
  iatk      =  .01
  idk       =  .05
  isust     =  p3-(iatk+idk)
  igain     =  0.25 * p13
  ia        =  .02
  is        =  p3-(2*ia)

  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  kclean    linseg    0,ia,1,is,1,ia,0
  ain1,ain2 soundin   ifile, iskip
  ain1      =  ain1 * kclean
  ain2      =  ain2 * kclean
  aecho1    comb      ain1, irvt, ilp1
  aecho2    comb      ain2, irvt, ilp2
  aecho1    =  aecho1 + ain1
  aecho2    =  aecho2 + ain2
  aecho3    comb      aecho1, irvt, ilp3
  aecho4    comb      aecho1, irvt, ilp4
  aecho5    comb      aecho2, irvt, ilp5
  aecho6    comb      aecho2, irvt, ilp6
  aout1     =  (aecho1+aecho3+aecho5)*kenv
  aout2     =  (aecho2+aecho4+aecho6)*kenv
            outs      aout1,aout2
endin
