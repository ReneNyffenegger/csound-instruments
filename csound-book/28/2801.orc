  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2801
  ifreqscale   =      1
  ispecwp   =  0
  ktime     line      0, p3, 1
  apv       pvoc      ktime, ifreqscale, "violin.pvc", ispecwp
            out       apv
endin
