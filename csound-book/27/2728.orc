  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     2728
  idur1     =  2.7
  idur2     =  2.12
  ktimp     line      0, idur1, idur2
  krmsr, krmso, kerr, kcps  lpread                ktimp, "glass_1.lpc"
  asig      adsyn     krmso, 1+kerr, .1, "a3_1.het"
            out       asig*.0002
endin
