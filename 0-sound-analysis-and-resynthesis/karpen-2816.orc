  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2816
  ifmod     =  1
  ktime1    line      0, p3, 2.28
  ktime2    line      0, p3, 1
  kamp      line      0, p3, 1
            pvbufread   ktime1, "hellorcb.pvx"
  asig      pvcross   ktime2, ifmod, "violin.pvx", kamp, 1-kamp
            out       asig
endin      
