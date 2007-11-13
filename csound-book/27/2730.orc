  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2730
  krmsr, krmso, kerr, kcps  lpread                .3, "glass_1.lpc"
  asig      adsyn     krmso*.001, 1+kerr, 1, "glass_1.het"
            out       asig
endin
