  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2729
  idur1     =  21.2
  idur2     =  .27
  ktimp     line      0, idur1, idur2
  krmsr, krmso, kerr, kcps  lpread                ktimp, "a3_1.lpc"
  asig      adsyn     krmso, 1+kerr, .1, "glass_1.het"
            out       asig*.0003
endin
