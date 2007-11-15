  sr        =  44100
  kr        =  4410
  ksmps     =  10


;i1 0 dur res-freq
instr 1
  icf       =  p4
  ibw       =  icf * .01
  iamp      =  32768
  iseed     =  .11111
  anoise    randi     iamp, 20000, iseed
  ares      reson     anoise,icf,ibw,1
            out       ares
endin

