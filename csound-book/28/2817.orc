  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2817
  iamp1     =  1
  iamp2     =  0 
  ifmod     =  1
  ktime1    line      0, p3, 2.26
  ktime2    line      2.26, p3, 0
            pvbufread   ktime1, "hellorcb.pvx"
  asig      pvcross   ktime2, 1, "hellorcb.pvx", iamp1, iamp2
            out       asig
endin
