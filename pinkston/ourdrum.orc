
  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gasend    init      0                           ;init the gasend

instr   10              ;our drum player
  iamp      table     p4,2                        ;fn2 is amp scaling table
  iamp      =  iamp*20000                         ;pk amp is 20000
  icps      =  cpsoct(3+p5/12)
;icps   =       log2(p5/12)
  ifn       =  p5
  iwetfac   =  p6
  ipan      table     p5-36,1                     ;fn1 has the pan positions      
  p3        =  ftlen(ifn) / sr
  asig      loscil    iamp,icps,ifn
  gasend    =  gasend+iwetfac*asig
  asig      =  asig*(1-iwetfac)
  ilfac     =  sqrt(1-ipan)
  irfac     =  sqrt(ipan)
            outs      asig*ilfac,asig*irfac
endin

instr   99      ;reverb
  averb     nreverb   gasend,p4,p5
            outs      averb,averb
  gasend    =  0
endin