  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  isinefunc =  1
  iglfunc   =  2
  ionetime  =  1/p3
  iamp      =  p4 * 30000
  kptch     oscil     1.0, ionetime, iglfunc
        ;kfr = cpspch( kptch )
  asig      oscili    iamp, kptch, isinefunc
            out       asig
endin
