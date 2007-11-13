  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     2808    ; TIME VARYING PITCH CHANGE
  ispecwp   =  0
  iend      =  p4
  ktime     line      0, p3, iend
  kfreq     line      .5, p3, 2                   ; COVERING TWO OCTAVES OVER THE DURATION:
  asig      pvoc      ktime, kfreq, "hellorcb.pvx", ispecwp
            out       asig
endin
