  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     2731
  krmsr, krmso, kerr, kcps  lpread                1, "gong1_1.lpc"
  asig      adsyn     krmso*.001, 1+kerr, 1, "gong1_1.het"
            out       asig
endin
