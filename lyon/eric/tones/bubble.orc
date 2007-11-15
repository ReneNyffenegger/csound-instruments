  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  isinefunc =  1
  iwfunc    =  2
  ifreq     =  p4
  igain     =  p5 * 10000
  iindex    =  p6*ifreq
  imod      =  ifreq*p7

  iamp1     =  igain*.6
  iamp2     =  igain
  iamp3     =  igain*.2
  iamp4     =  igain * .35
  iamp5     =  igain * .05
  ied1      =  .005
  ieds      =  (p3-ied1)/7.0

  aenv      linseg    0, ied1, iamp1, ieds, iamp2, ieds, iamp1, ieds, iamp3, ieds, iamp4, ieds, iamp3, ieds, iamp5, ieds, 0.0

  kindex    linseg    0, p3/2, iindex, p3/2, 0
  amod      oscil     iindex, imod, isinefunc
  afr       =  ifreq+amod

  asig      oscil     aenv, afr, iwfunc

            out       asig
endin
