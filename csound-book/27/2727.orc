  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2727
  idur1     =  .27
  idur2     =  2.12
  ktimp     line      0, idur1, idur2
  krmsr, krmso, kerr, kcps  lpread                ktimp, "glass_1.lpc"
  asig      soundin   "a3.aif"
  aout      lpreson   asig
  aout      balance   aout, asig
            out       aout
endin
