  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2818
  ifmod     =  1
  iamp1     =  1
  iamp2     =  2
  ifreq1    =  1
  ifreq2    =  1
  ktime     line      0, p3, 1
  kinterp   line      0, p3, 1
            pvbufread   ktime, "violin.pvx"
  asig      pvinterp  ktime, ifmod, "marimba.pvx", ifreq1, ifreq2, iamp1, iamp2, kinterp, kinterp
            out       asig
endin
