  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2726
  idur1     =  2.12
  idur2     =  .27
  ktimp     line      0, idur1, idur2
  krmsr, krmso, kerr, kcps  lpread                ktimp, "a3_1.lpc"
  asig      soundin   "glass.aif"
  aout      lpreson   asig
  aout      balance   aout, asig
            out       aout
endin
