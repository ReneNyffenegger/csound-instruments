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
  in        =  16384
  in2       =  in/2
  imult     =  in2/32767
  iramp     =  .05
  isust     =  p3-(2*iramp)
  aenv      linseg    0,itk,iamp,isu,iamp,idk,0
  aclean    linseg    0, iramp, 1, isust, 1, iramp, 0
  asig      soundin   p4,p5
  asig      =  asig * igain
  ares1     reson     asig,3000,400,1
  ares2     reson     asig,6000,600,1
  andx      =  in2+(imult*asig)
  aws       tablei    andx,1
  aws       =  aws * aclean
  acomb1    comb      aws, irvt, ilpt1
  acomb2    comb      acomb1, irvt, ilpt2
  alow      tone      acomb2, ihicut
  ahi       atone     alow, ilocut
  arev      reverb    ares1+ares2, 1.0
  amix1     =  (ahi*aenv)
  ad1       delay     amix1, .003
  ad2       delay     amix1, .007
  ad3       delay     amix1, .0103
  aout1     =  amix1 + (.7*ad2) +  arev + (.2*ad3)
  aout2     =  ad3 + (.7*ad1) + arev + (.2*ad2)
            outs      aout1, aout2
endin
