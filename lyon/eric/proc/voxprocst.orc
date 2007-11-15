  sr        =  44100
  kr        =  4410
;sr=22050
;kr=2205

  ksmps     =  10
  nchnls    =  2

;i1 0 dur file skip atk dk gain 
;f1 0 16384 13 1 1 .2 1. .5 .1 .1 .1 .1 .05 .01 .1 .2 .3 .5 .2 .1 .05
instr 1
  iamp      =  30000
  itk       =  p6
  idk       =  p7
  ilp1      =  14
  ilp2      =  14.713
  ilpt1     =  1./ilp1
  ilpt2     =  1./ilp2
  irvt      =  .6
  igain     =  p8
  ilocut    =  400
  ihicut    =  3000
  isu       =  p3-(itk+idk)
  isiin     =  16384
  in2       =  isiin/2
  imult     =  in2/32767
  iramp     =  .05
  isust     =  p3-(2*iramp)
  aenv      linseg    0,itk,iamp,isu,iamp,idk,0
  aclean    linseg    0, iramp, 1, isust, 1, iramp, 0
  a1,a2     soundin   p4,p5
  a1        =  a1 * igain
  a2        =  a2 * igain
  ares1     reson     a1,3000,400,1
  ares2     reson     a2,6000,600,1
  andx1     =  in2+(imult*a1)
  andx2     =  in2+(imult*a2)
  aws1      tablei    andx1,1
  aws2      tablei    andx2,1
  aws1      =  aws1 * aclean
  aws2      =  aws2 * aclean
  acomb1    comb      aws1, irvt, ilpt1
  acomb2    comb      aws2, irvt, ilpt2
  alow1     tone      acomb1, ihicut
  ahi1      atone     alow1, ilocut
  alow2     tone      acomb2, ihicut
  ahi2      atone     alow2, ilocut
  arev      reverb    ares1+ares2, 1.0
  amix1     =  (ahi1*aenv)
  amix2     =  (ahi2*aenv)
  ad1       delay     amix2, .003
  ad2       delay     (amix1+amix2)/2., .007
  ad3       delay     amix1, .0103
  aout1     =  amix1 + (.7*ad2) + arev + (.2*ad3)
  aout2     =  amix2 + (.7*ad1) + arev + (.2*ad2)
            outs      aout1, aout2
endin
